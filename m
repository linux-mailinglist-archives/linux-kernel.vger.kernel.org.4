Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17816E9F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjDTWvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjDTWvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:51:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDA4210
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:51:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4edb26f762dso968709e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031107; x=1684623107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7QDRXKQ5hEltVWkohh/QXgJnh9OCjsLGfPd++gOLfA=;
        b=LR8pUUbhaGDkE+APTpcOJs7zvaHbRrsVVMz2qJfsgX7rM0XgeZvqz+HoDdyw4ZxdPx
         5T/GSSKeOaMPLWoBvds284aCFAi3vXuAaEQNvFANBN/3rxp00gODiZQyGFXJauu/RNp6
         EV6nAFiDKsjMrrunm3fqOGHih/lN8RIkij0mDU7QoI5mELo7k/Kng3njtzPOev6Ay8x+
         UngncmNIUqS4Hfv8yOYRn5yUIfH7TaQKXdfHaVWD1Dg0dZjYy5gO37+PZ/3oBCGPHh14
         +sTsPNMhX3r7dICW1+mvHbmSH7D/mpOGMFmWFE1PkURs5Go0uuYbDLuq44LyW3mq6Ui2
         hO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031107; x=1684623107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7QDRXKQ5hEltVWkohh/QXgJnh9OCjsLGfPd++gOLfA=;
        b=cNhURqNSQdo4QLX+kDEP1GB3iKfZ9iSARyrxiitIeG9FafdVwZDau5NMr5ejJjwbwJ
         Quu9kI3uDD4ZrGCx2StKO13DJZZ7tux85LtE8/G23I7qLnAeRbQCY9q6retCIwgEWYDl
         atNHlYezow7w25m78VrTdfJ+aITyum68nwtgMFVBcwzqf2E37+bsPCDm3ABnkx+D/UuR
         091rCLc57igNLE3v1CIcktUnY24bvuBqp14Sft3Yd62zfaQrLlAOu+z19+IeBLCvVTit
         h6BPSWUvmscELFNoUeTpXeBOv0sSbaL+foXqgmNW+9q7oR60LzJ2HPK/sdtM5tj6vFuf
         nzqA==
X-Gm-Message-State: AAQBX9dNw/n8umc1ztLTT3kHO5tLJ8TLyDrW15XbIFJZ+x3sdU3jSTlz
        /U1BFCcJkVGAbcJpD2T9yRZj+Q==
X-Google-Smtp-Source: AKy350brXa4fPcfhE4CuqDFqBnzK8W8G0OiORNrCpAz3eFIlV9t2VCSeZ7cFZTuLt/qlGi7mNq743A==
X-Received: by 2002:ac2:53a8:0:b0:4ec:8812:d6ba with SMTP id j8-20020ac253a8000000b004ec8812d6bamr754618lfh.15.1682031107371;
        Thu, 20 Apr 2023 15:51:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e7412000000b002a8bb20e534sm387643ljc.108.2023.04.20.15.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:51:46 -0700 (PDT)
Message-ID: <837ae9c8-c92a-6cff-501e-eecb6ef0e3b1@linaro.org>
Date:   Fri, 21 Apr 2023 01:51:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 12/13] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-12-5def73f50980@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-12-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 01:31, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Add the SM6350 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

