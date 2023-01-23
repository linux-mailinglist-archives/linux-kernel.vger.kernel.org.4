Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03C677B09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjAWMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjAWMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:34:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF9322A0C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:33:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so30081288ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7PdZNkVZQyBUiPCTrzhXWzp946FKR6kqjCXzmeEkJQ=;
        b=u8iw0yyOzLckrMJpcvLnoQLXQ5fch+bLWKRrztkri0Ze5LgyE4ym21FjyM7MquyC3c
         jula37vfW1S3CrffrJsp47NkR/eg/HjoID9SkKCLuUuZiQ5Aznb0PuhI1JYXC28IBDBU
         ysIyILT1yYIJLrqPAMmJnuyzGPlfCOiD/QfUdQVw0tYH2l/BuFH2aye01ZkZ+fVPd1/h
         Z60xTq5e8d955/YXVgPo3VSWxHeBv6ndg6rfD25DkoSM2+G0VjJTxNsSqQfFn0aRolvU
         nTrweq/ru1REa8V/0R6fv75HBz5PWXayyT8WjTrL2DnVGX6l4+NvWSHf7wbSIkS7MYby
         JIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7PdZNkVZQyBUiPCTrzhXWzp946FKR6kqjCXzmeEkJQ=;
        b=1igdciAz2mLqu+03yc3D+dmxq8aQth+ZLlWefQ+5/+GfdIGQdiob9AVV3pVrfr0f/E
         RabKG/JFp3quU+UT12K6g656DGDGUVXngP/Cov403p2c8UAvekzkzolr5s87FtIiuGk9
         hASNEe5P6z49spyn1XEg1g3Rx3WHrHLOSWw9zSmJwZpvoDbLFE8BR298MT0QjulFmjsl
         UdX+Aog2hJO3GbZ26pMCnltI8uAGGxkV9JhAuDA1yj1KqR4DaKM5moS/pE2d55nisMws
         NO0lCsLgx1Mp2184qnuEy37hhQ7wC8GUBjeKkSF/dSfZgZkdRHR85jc/rITPB4SI7A+/
         NC3w==
X-Gm-Message-State: AFqh2kr45J+ja00BbYP/eDaoYw1UbdlZ3AmL7FWQ3miKLfGYO3oCLszs
        z+fy3ZCH3Uw3YV0I29+0yJZXXg==
X-Google-Smtp-Source: AMrXdXuVRMUs1FacslZSphud2cMRR+YrHqiKKzSaHDMGsuKiFwB565nFwqsqDBiYRdAaCcpDI2G+QQ==
X-Received: by 2002:a17:907:1c08:b0:86f:de0b:b066 with SMTP id nc8-20020a1709071c0800b0086fde0bb066mr26424926ejc.76.1674477225613;
        Mon, 23 Jan 2023 04:33:45 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007c0b28b85c5sm21991031ejt.138.2023.01.23.04.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:33:45 -0800 (PST)
Message-ID: <e2fbecf6-aeb9-b754-46c0-2273cfa6d0a0@linaro.org>
Date:   Mon, 23 Jan 2023 13:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] MAINTAINERS: Update qcom CPR maintainer entry
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Niklas Cassel <nks@flawful.org>
References: <20230123104305.44641-1-niklas.cassel@wdc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123104305.44641-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 11:43, Niklas Cassel wrote:
> From: Niklas Cassel <nks@flawful.org>
> 
> I do no longer have access to qcom CPR hardware, nor the documentation for
> said hardware.
> 
> Based on past and recent activity, I propose Bjorn and Konrad as the new
> qcom CPR maintainers.
> 
> Signed-off-by: Niklas Cassel <nks@flawful.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f781f936ae35..fe2606727966 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17261,7 +17261,8 @@ F:	drivers/clk/qcom/
>  F:	include/dt-bindings/clock/qcom,*
>  
>  QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
> -M:	Niklas Cassel <nks@flawful.org>
> +M:	Bjorn Andersson <andersson@kernel.org>
> +M:	Konrad Dybcio <konrad.dybcio@linaro.org>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
