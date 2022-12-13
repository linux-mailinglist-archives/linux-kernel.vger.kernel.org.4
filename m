Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8764B8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiLMPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiLMPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:41:27 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0709CFD04;
        Tue, 13 Dec 2022 07:41:27 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-144bd860fdbso13071318fac.0;
        Tue, 13 Dec 2022 07:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMZg5m2kkmC+J3c6NdCBMZTHPMMEoYm6FhJ/PsvVvOI=;
        b=YE/ob5cQyXmFmqnu5vme5W4yopcMTrkX5uGXLZJdMuPlSC6RLM0r+C7XfkA1ZPlbWd
         WU7VWc7Eq/kXfnXTQuJtAOkCCWlPuMv/deFBi2H65DzGrTgzreg/gYhVpGxsNDd4tLPh
         IJd1/8rMCkjg9WMOZSU2BnWH1tZqwtGLA0XsGsks24+iyaLf9bZXN0OA6LcJbcXr4tjo
         sC42pXZZSDsHVmgk02NTU93VBJHf5vMS05cHStuTgefcb1sg2HNFEIULXZWS8DSXs3LK
         AWHwRTc0Mo8T0iKEH0OGuHx1gHkbjLVLvBuj5cwN8aGrAG+hITlvfy8++gGWPFJN3Y2G
         aXeQ==
X-Gm-Message-State: ANoB5pkrZDUDaQSCpfj50O3N5IgKx69f/kCn1DF3Hx4Qve3fR2PpxUU0
        6cnHI1a1bs2zsjTF3V9zzg==
X-Google-Smtp-Source: AA0mqf5pAu6L6NzuDrAbImuADylEbpTZYnNgBqq6NbglCSwQzMlRUfHMHKfWl3YisslKdA0lRgFr+Q==
X-Received: by 2002:a05:6871:450c:b0:144:870e:5859 with SMTP id nj12-20020a056871450c00b00144870e5859mr10243145oab.57.1670946086171;
        Tue, 13 Dec 2022 07:41:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n39-20020a056870972700b0013bc40b09dasm1569186oaq.17.2022.12.13.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:41:25 -0800 (PST)
Received: (nullmailer pid 1478210 invoked by uid 1000);
        Tue, 13 Dec 2022 15:41:25 -0000
Date:   Tue, 13 Dec 2022 09:41:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dt-bindings: watchdog: qcom-wdt: allow interrupts
Message-ID: <20221213154125.GB1426116-robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:35:25PM +0100, Krzysztof Kozlowski wrote:
> Both of type of watchdogs described in the binding (the KPSS watchdog
> and APSS WDT timer) have interrupts.  Allow interrupts and describe them
> for KPSS watchdog to fix warnings like:
> 
>   watchdog@17c10000: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/watchdog/qcom-wdt.yaml           | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
