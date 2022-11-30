Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F863CCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiK3Arn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiK3Ari (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:47:38 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8F647D;
        Tue, 29 Nov 2022 16:47:35 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142faa7a207so19186999fac.13;
        Tue, 29 Nov 2022 16:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNiqiri9nFpKzrKuVQqnj4uEx0ZZPy/8Wd/yapUcPHA=;
        b=iVJIkPo+PKrej0JrPya6GDXFtgzuUBcSMArAbISXIZPkGbCdU2Dd8wFGi2pt3fS3l9
         Amf2kIKIh8DMEAfxwjIL4zIYEJOsDnDaoOqUWK2TLW0zVmpBeVGsrKpdHDP2xTF06uaV
         vpL0H3gq2lCVFUSbT6zXggJ/297kkL2Xe4K0EPag89igljO3do4JiLnWwYd12E2DHYM4
         QJGv/HMIzray1CQv0+IR+BOV9VvHY8tGajDlJNNhJVVjTwjhYw6rVgbP6scH/l2Jk7Vk
         f7ETsVQYmz5Xue9leKAR7OEQHSr6vwpJHzZpejnnWn+ri8Sd5d2pst3nO5UpQJbDxwxb
         9jiQ==
X-Gm-Message-State: ANoB5pn+jMuhipwIDjyzbQ9JxrKe/pAMA5iF8URVlnIgGb8+ln4jYGbT
        1XA6itO/eD9qXS9vr2HpP6oPjjNsmw==
X-Google-Smtp-Source: AA0mqf686UvYntLIUvR2dA8nW8z/MLqJFaXXfST7UBHHfJNWi4XCsfAzNdGquGwI3qWRHhQ2lDVBMg==
X-Received: by 2002:a05:6870:1e88:b0:143:8c30:7231 with SMTP id pb8-20020a0568701e8800b001438c307231mr10591066oab.94.1669769254860;
        Tue, 29 Nov 2022 16:47:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b19-20020a056870391300b00142fa439ee5sm154693oap.39.2022.11.29.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:47:34 -0800 (PST)
Received: (nullmailer pid 608003 invoked by uid 1000);
        Wed, 30 Nov 2022 00:47:33 -0000
Date:   Tue, 29 Nov 2022 18:47:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     linux@roeck-us.net, luka.perkov@sartura.hr,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org
Subject: Re: [PATCH] dt-bindings: watchdog: Convert GPIO binding to
 json-schema
Message-ID: <166976923958.607658.11097663400108799383.robh@kernel.org>
References: <20221125112904.48652-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125112904.48652-1-robert.marko@sartura.hr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Nov 2022 12:29:04 +0100, Robert Marko wrote:
> Convert the DT binding for GPIO WDT to JSON schema.
> 
> Cc: luka.perkov@sartura.hr
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../devicetree/bindings/watchdog/gpio-wdt.txt | 28 ----------
>  .../bindings/watchdog/gpio-wdt.yaml           | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
