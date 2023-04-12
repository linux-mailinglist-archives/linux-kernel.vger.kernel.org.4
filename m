Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AE6DF895
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDLOeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDLOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:34:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A587D86;
        Wed, 12 Apr 2023 07:33:56 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1842f69fe1fso13861986fac.11;
        Wed, 12 Apr 2023 07:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310035; x=1683902035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHl7bFM+hPA2OAnoHzAjdjShunlEKsH84bFgDDDCRpc=;
        b=xhAHiVeC9HI9sRrjwuiJUyNpxQV/Lb1ZdoUyj7mlpYlPS5dpf0bXU+UjxhRRMtfURh
         XWm7g3n4uoaN1r+ECZXH0eolY2jZfAVqO1994B+25QDNjJFRUU5VuyT4GFDJ34B3Tmfl
         mlZWO/NyLZOG0kA3btDjBPkZMxIGJ5pU5wX5bDJp/m27jZFpVoozhQ129RtVvQn/JBFI
         oV4DqrEL0E+ImYeeKgDPYE/Mnw7B3FP25ScpHs2PyqO1gjvVfWJe8EwmM9LnIhVtN67G
         3zWPekfZNYlGsurpvM5XyzLlcV3rtuYuEmka5yHvUubT5h7ngg1UtyttB7F83ItK+j9W
         pCrA==
X-Gm-Message-State: AAQBX9eN8KVkffb3oIkpGBE2nNeXNPziV+SNEtpnCt1hM+CZG0qNvu6V
        yK6HRgmoTu1Kpu/oGtqusw==
X-Google-Smtp-Source: AKy350Y5754AlFvbTw8HbhL/YBBNUAcozSrM0fpRgg+uHdIxHIl4b6t9mmHuBl24joivOlLZa12tOw==
X-Received: by 2002:a05:6870:82aa:b0:184:4d7f:b89a with SMTP id q42-20020a05687082aa00b001844d7fb89amr5696550oae.10.1681310035298;
        Wed, 12 Apr 2023 07:33:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f25-20020a9d5e99000000b006a415acb87fsm1054183otl.21.2023.04.12.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:33:54 -0700 (PDT)
Received: (nullmailer pid 2324854 invoked by uid 1000);
        Wed, 12 Apr 2023 14:33:54 -0000
Date:   Wed, 12 Apr 2023 09:33:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Message-ID: <168131003355.2324791.7234116759532739020.robh@kernel.org>
References: <20230406182000.956275-1-cristian.ciocaltea@collabora.com>
 <20230406182000.956275-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406182000.956275-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 21:20:00 +0300, Cristian Ciocaltea wrote:
> Convert the PWM fan bindings to DT schema format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt     | 68 +------------
>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 97 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

