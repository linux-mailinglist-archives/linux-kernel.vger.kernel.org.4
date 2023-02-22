Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6069F257
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjBVJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjBVJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:57:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38384EC8;
        Wed, 22 Feb 2023 01:57:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A0B9B660215E;
        Wed, 22 Feb 2023 09:57:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677059870;
        bh=iupWZw710RJlsDfuH6ZphQSX1uucYuxWxs1WrmnL4w8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kYas5w6Jegs2D/xpl1OhhLiy3FMEDgo+bWugL3ObzJ6yUfY8RVjdpWT0v3PMM8ROa
         FbQt7XjJu6chr4H7X5bPZ3pBh1oKjYp0XDSyCIGhG/dx8hniNm4UAXzi6+iq+OFVQ9
         ehdh4DPCjknbUjVL0u5Yn13Yhp+dLjY9TOw/P0lYAg16ZiWStTX1dPy9HWD7QPVx5D
         WCwh3HvdC8/AzDe3fPs1Lzh7mTUqtH7No8/JHuysZpSHJvNEKcB4eZGh56xXNIBvWB
         6lzBLMfag4WOstlYU8BPcGljCfPOPI8VM1Vuk+axO/gYCVpo3ss4n/AtA5AzGjFIsI
         f+O0O8yI0VFrw==
Message-ID: <254cfbb5-c8b8-0abc-e6bc-5007fe757004@collabora.com>
Date:   Wed, 22 Feb 2023 10:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/6] Add support for Qualcomm's legacy IOMMU v2
Content-Language: en-US
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 11:11, AngeloGioacchino Del Regno ha scritto:
> This series adds support for handling "v2" firmware's IOMMU, found
> on at least MSM8956 and MSM8976 (some other SoCs also need the same
> but I honestly don't remember which ones precisely).
> 
> This is strictly required to get functional IOMMUs on these SoCs.
> 
> I'm sorry for not performing a much needed schema conversion on
> qcom,iommu.txt, but I really didn't have time to do that :-(
> 
> This series was tested on Sony Xperia X and X Compact (MSM8956):
> ADSP, LPASS, Venus, MSS, MDP and GPU are happy :-)
> 
> 

Hello,
this series is really old and got sent and resent many times.
The first time I've sent this one was .. I think in 2019, then, at the
end of 2022, I had some time to actually respin it and send another
three versions. It's been 3 long years :-)
The third version got the last comments addressed.

Since this didn't get any more feedback for 3 months, I'm worried that it
will be forgotten again, hence:

Is there any more feedback? Anything else to fix?
If not, can this be picked, please?

Thank you.

Best regards,
Angelo


> Changes in v3:
>   - Removed useless FSRRESTORE reset and definition as pointed
>     out in Robin Murphy's review
>   - Fixed qcom,iommu.txt changes: squashed MSM8976 compatible
>     string addition with msm-iommu-v2 generics addition
> 
> Changes in v2:
>   - Added back Marijn's notes (sorry man!)
>   - Added ARM_SMMU_CB_FSRRESTORE definition
>   - Changed context bank reset to properly set FSR and FSRRESTORE
> 
> AngeloGioacchino Del Regno (6):
>    dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
>    iommu/qcom: Use the asid read from device-tree if specified
>    iommu/qcom: Properly reset the IOMMU context
>    iommu/qcom: Index contexts by asid number to allow asid 0
>    dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976
>      compatibles
>    iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
> 
>   .../devicetree/bindings/iommu/qcom,iommu.txt  |  9 +++
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
>   2 files changed, 70 insertions(+), 17 deletions(-)
> 


