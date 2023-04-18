Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3206E6E53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjDRVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjDRVfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:35:52 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB88619E;
        Tue, 18 Apr 2023 14:35:51 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1881333ac06so495281fac.2;
        Tue, 18 Apr 2023 14:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853750; x=1684445750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiHSmFYNeiiWUCdJJE7awZ5CHROEiUdBDPkAp1lTJfE=;
        b=YpkErjYYs0M+7NrFsOXrvp+U2ecTjS0jRsCPBM7RicbUaOip6otSPYiIHO++IjxTwr
         8dJMVzbGf7Z1bD6O4m1KXU3rdMa9fPgNv3TsCQcsw2iJ2Lrm8VtT7WBKkllfkg4d82DO
         2dALoRFRy5U6PBSs0OH/RkkFL1LPK00ta1DImWlDpegfmwG7CFMKRTTxFJZax3Ua02lJ
         fXfKG/FcCTRcO3sLkI8xYWYrNfCfBRzHWnrq23MMBCuCpVsCWmjGFmHvGn6YtF40DdjY
         yC/8yfIc0nVfsEulz4ipul/D7F8Y56w4HGjBD3CrB0aJSLk9iVTWKNzBCmCbIWmDTqjk
         6AMg==
X-Gm-Message-State: AAQBX9c27pfbYIEnQ8Oxu9NoMwWt6YjIDK7Ts2MbiBYIls4HBEBvasAA
        LWh+VH1lmwrJUF5q3xlfkkJLxqA+oQ==
X-Google-Smtp-Source: AKy350b0ZSpKu/WLBKWeRVPeqxp22rfWdezk+dC0nuELJwJCvQMHKkxlU6SbBCluwnUHFd3X49U/OA==
X-Received: by 2002:a05:6870:9723:b0:188:1096:246f with SMTP id n35-20020a056870972300b001881096246fmr1619351oaq.29.1681853750572;
        Tue, 18 Apr 2023 14:35:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a4a9488000000b00524f381f681sm6317500ooi.27.2023.04.18.14.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:35:49 -0700 (PDT)
Received: (nullmailer pid 2372989 invoked by uid 1000);
        Tue, 18 Apr 2023 21:35:48 -0000
Date:   Tue, 18 Apr 2023 16:35:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: watchdog: drop duplicated GPIO watchdog
 bindings
Message-ID: <20230418213548.GA2370489-robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <16d3bb91-af02-2504-1a8b-7805a2d30bb4@roeck-us.net>
 <abefdf2e-076c-6f0e-46e3-74dae3d068c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abefdf2e-076c-6f0e-46e3-74dae3d068c1@linaro.org>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 07:26:27PM +0200, Krzysztof Kozlowski wrote:
> On 16/04/2023 18:04, Guenter Roeck wrote:
> > On 4/15/23 02:51, Krzysztof Kozlowski wrote:
> >> Two conversions to DT schema of GPIO watchdog binding happened and came
> >> through different trees.  Merge them into one:
> >> 1. Combine maintainers,
> >> 2. Use more descriptive property descriptions and constraints from
> >>     gpio-wdt.yaml,
> >> 3. Switch to unevaluatedProperties:false, to allow generic watchdog
> >>     properties.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > 
> > For the series:
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > On a side note, the e-mail addresses in patchwork are messed up for
> > patches sent by you. As result, I can not reply to your e-mails after
> > pulling a patch from patchwork. This means that some replies get lost
> > if I did not keep the original e-mail.
> > 
> > That is how it looks like after I pull one of your patches from patchwork:
> > 
> > To:
> > +=?unknown-8bit?q?Wim_Van_Sebroeck_=3Cwim=40linux-watchdog=2Eorg=3E=2C_Gu?==?unknown-8bit?q?enter_Roeck_=3Clinux=40roeck-us=2Enet=3E=2C_Rob_Herring_?==?unknown-8bit?q?=3Crobh+dt=40kernel=2Eorg=3E=2C_Krzysztof_Kozlowski_=3Ckrz?==?unknown-8bit?q?yszt
> 
> (Trimmed cc list)
> 
> Thanks for letting me know, I wonder what's the problem. I am sending
> with send-email exactly the same way every day, but somehow this series
> have such header in Patchwork:
> https://patchwork.kernel.org/project/linux-watchdog/patch/20230415095112.51257-1-krzysztof.kozlowski@linaro.org/
> 
> Which I do not see in:
> 1. lore:
> https://lore.kernel.org/all/20230415095112.51257-1-krzysztof.kozlowski@linaro.org/
> 
> 2. Previous patches on Patchwork:
> https://patchwork.kernel.org/project/linux-watchdog/patch/20230310223012.315897-1-krzysztof.kozlowski@linaro.org/
> 
> Lore (1 above) points to possible unescaped UTF character for
> rafal@milecki.pl, but I wonder why send-email did not handle it.

Looks to me like Content-Type header is missing. Usually, I get a prompt 
from git-send-email with what encoding to use if it needs to use UTF8.

Rob
