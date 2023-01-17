Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5091B66E662
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjAQSrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjAQSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:42:27 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577194C6E8;
        Tue, 17 Jan 2023 10:13:31 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15b9c93848dso24572671fac.1;
        Tue, 17 Jan 2023 10:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAQembbfAly4IRjGr3cDZDww9N/iI2dr1CRggFoPOeA=;
        b=1W93M83LETR7b+sCCg/n7ungV5daeInt+aUq3Zfzd+OfpJ5dGEk+7wx4TMIThzx3r/
         nrQd7NFqfhw469CXWU+4ZwSYwZNLT7uUr4OlQho+60IbDvc1kBZKGjX0TBCWRTirsdt0
         iqWu1Bw6OFqH1TF5+TmZ/KCfVQZ1/hdrHP2NcZwbZS5SsTbkcoBHdDSdUzPBzeOS7m1y
         JuCMvCjBGdLJHY0qT1cmeZxXO22jPeNcWdM2cQgWxCeVluf229WhIiaWWdEpmpfg1d9L
         rAHWOb5Fz1jOq5R4SWuOWIxx4DPxywnZO2p1TTqKt+Tr3D+FkZFKB/wYg818kn2YlEoR
         XAgQ==
X-Gm-Message-State: AFqh2kr/RRr/3TGMuBc7ldyZHYRtFpotvZNqVr6yohxIeR9t6l7HMs+P
        AN6NixOTckBJUBeLvOi/7Q==
X-Google-Smtp-Source: AMrXdXtoKW0M+JEa5UDfl75nd/xbDorgIheGi98GezD8LwsaKaQtMEYFIlehYZ4gKtpGPhhQwY1v9w==
X-Received: by 2002:a05:6870:9e92:b0:15e:fe0a:db84 with SMTP id pu18-20020a0568709e9200b0015efe0adb84mr7695952oab.27.1673979210329;
        Tue, 17 Jan 2023 10:13:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c15-20020a4ae24f000000b004f28d09a880sm7028866oot.13.2023.01.17.10.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:13:29 -0800 (PST)
Received: (nullmailer pid 3398763 invoked by uid 1000);
        Tue, 17 Jan 2023 18:13:29 -0000
Date:   Tue, 17 Jan 2023 12:13:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Message-ID: <167397920868.3398730.2074338668546770210.robh@kernel.org>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 11:33:45 +0100, Krzysztof Kozlowski wrote:
> Merge Qualcomm MSM timer bindings into watchdog, because the timer
> compatibles are already included here and the hardware is quite similar.
> 
> While converting the MSM timer bindings, adjust clock-frequency
> property to take only one frequency, instead of two, because:
> 1. DT schema does not allow to frequencies,
> 2. The Linux timer driver reads only first frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add tag.
> 2. Correct clock-frequency description (Rob).
> ---
>  .../bindings/timer/qcom,msm-timer.txt         | 47 ------------------
>  .../bindings/watchdog/qcom-wdt.yaml           | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
