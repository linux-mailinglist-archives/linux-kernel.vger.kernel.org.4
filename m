Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6F658A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiL2Idl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Idg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:33:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA801C1D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:33:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn6so8883375ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DbYkte6+L+Cr8TE5Lz9IdM41YLyTWgT3D+LkTXTvZc=;
        b=TM3kkB2j9ZQ0cQ2arKZaxphmUkIs22Q9WkBAIkTuiKaDBevRBs8R1Y1J25gLpxCBO3
         9RoNxVQfx0Wf6mQoCb2rYpc24Y3e0SeHC/2WniaZ2sXKKGa/jepvCZPF2pu5FvmJpruA
         0si/6FqDOiHl0NgPrVl7VvHE/2MyVFjn9RxahsIY4SZXkWbcsuSv/jpQJmfEuWKB70NJ
         KkQso0FRKJ0k9RjSm581fLNzNccCy5dz5XIsWtHaFCMb1WxsEAYW1v1Ypou92BV4XZ3s
         ZdZG3QOxBHGPq4lNsSBqKgEc4+Ugdrq+QXCN9C43WgVQgMUc/VQFjiXr2ow3gTHHR705
         Nabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DbYkte6+L+Cr8TE5Lz9IdM41YLyTWgT3D+LkTXTvZc=;
        b=ktWdSBEdEUs4gvWhS6BzPFi4UM933pS3gaZoK8zcJlTawNdpGoia+UhZZLovPRpI7h
         uS1T0RHZuSCkrnylr6y659XUX2kzBvayMA6RxH446RFbij3Hi4ysWTNslkmBzODeeNUh
         OECgqM1NGySqH80VmQYYmhlWlJkDKT4YEJJ8bLTnKR1Xa2EwNe2eUg+COpiNgyCYctda
         EngAfz9I+hSjCao/Mse4gpLxCsEWkjzwCxyovTVTnA+xiaBsGmoZwaHAEVJ9xV1fbiOu
         RCDwcQPndyTThCBr/GmD2JjzOJbn3d8bfQ3d6nCi8zUBJcxZXKooIQ0GqiL2PwCAhnv8
         EkgQ==
X-Gm-Message-State: AFqh2kpIXkV4EqP9XPi1OxsJ9asaW5tq4Int/kzc+ft+fD9Ii3abXc7V
        Kx/ccOmbjV7Ejln0uoZHFI1+YA==
X-Google-Smtp-Source: AMrXdXtlKNE7qMglk70f1cqT2C2029qOJIrB/AnaeaV/ZtmCr4Qj8LKT0y3U9qFMd56bJL2UbmZyyw==
X-Received: by 2002:a2e:934c:0:b0:27f:b265:d6c3 with SMTP id m12-20020a2e934c000000b0027fb265d6c3mr5390937ljh.29.1672302813136;
        Thu, 29 Dec 2022 00:33:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p22-20020a2eb7d6000000b002796fb63dbdsm2267177ljo.13.2022.12.29.00.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:33:32 -0800 (PST)
Message-ID: <2aae081d-25bb-4e93-da31-d19d51d0b4fc@linaro.org>
Date:   Thu, 29 Dec 2022 09:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: fsl,xcvr: Add compatible string
 for i.MX93 platform
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221229063009.2396716-1-chancel.liu@nxp.com>
 <20221229063009.2396716-2-chancel.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229063009.2396716-2-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 07:30, Chancel Liu wrote:
> Add compatible string "fsl,imx93-xcvr" for i.MX93 platform.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

