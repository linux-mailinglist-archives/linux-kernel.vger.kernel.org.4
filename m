Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF14616977
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiKBQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:42:04 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F132ED4F;
        Wed,  2 Nov 2022 09:37:06 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l127so3367168oia.8;
        Wed, 02 Nov 2022 09:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IPGxGLkD8As1GeJY5oeoH1phDYt4Av4JKr4840Jm8Y=;
        b=ADowVvC+MoMKVj+hjspVatZ+eNLYar0xS00x12LMbMAAois4xhSU5XSoXdEhxAwLU7
         +rMDxCVwYs3YYOhS8u31mO0lJVoyYffsj+7vbDB11OxeJ+V86iKw8YvfUXDv0f1vQYJj
         cSWiE677XhIu0lVvQ0meBk08/KVW0IKgkXKZcRkRc1XSq2v/1B2Z/cuOyyB1ZSIAyYQ/
         Y/1fOhks5NG0kWua8IeWBvhZGaDBtfmXJZ7wI5PdXSeDHOqTE3vOL7EofRGSPKO2GFaa
         Crf+xY65nxAL5GDW91CFrubKjYaRbVzBNyT3SfZEw2QWrrIowHXoYHPUcw5PyBj9SJ8k
         s5uw==
X-Gm-Message-State: ACrzQf1j0+uWg+3xm+EJyy0z7YSP0ap6PHQZ8uOVlN6OI9ESvS2A2R0Q
        yuK5W8/GotShedP6gAuZJg==
X-Google-Smtp-Source: AMsMyM6PfkexEnFF5ueqQBi7Z38vRQ66nOVbGxRwh7cGgAQdHJAYlhuoFPMkoiRF/71lDerNONVVNw==
X-Received: by 2002:a05:6808:118c:b0:34f:9fc9:ce15 with SMTP id j12-20020a056808118c00b0034f9fc9ce15mr5868351oil.220.1667407025923;
        Wed, 02 Nov 2022 09:37:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n1-20020a4ad401000000b00425806a20f5sm4603995oos.3.2022.11.02.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:37:05 -0700 (PDT)
Received: (nullmailer pid 4012210 invoked by uid 1000);
        Wed, 02 Nov 2022 16:37:07 -0000
Date:   Wed, 2 Nov 2022 11:37:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.or, linux-arm-kernel@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: mediatek: add compatible
 string for MT7986 SoC
Message-ID: <166740702669.4012151.14909545026991021834.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 22:16:53 +0000, Daniel Golle wrote:
> Add compatible string 'mediatek,mt7986-thermal' for V3 thermal unit
> found in MT7981 and MT7986 SoCs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
