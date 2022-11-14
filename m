Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50128627B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiKNKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:54:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D66468;
        Mon, 14 Nov 2022 02:54:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B20F76601E4C;
        Mon, 14 Nov 2022 10:54:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668423282;
        bh=5RCv+9s4hD9rM0U7ey7QcmHhKUXJv0zWQbwP4P1/eks=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GtqAwvHKhgKgWI3ewuKyRKW/vPBpLlRSDT3EX08GVI76bTBlbcheO61x5bIrqrGhW
         mFrbYZvoKvMZEEhqZmZaqMuiA8+U0JyOkdo2YonZaFrLnoRcLSmUE41q7KbYwQzYtn
         k77wCRLgTviavyVPqKAGtKWEoLqwZnBrWG+VO5y7STBZv6DdZEKyfqUhHMDewnYJD7
         QdSVhVC7c9dQGVIbiaucjDTr2MYxCSzW4QZTjvHP2oLwq1RNnEEweKL15/CU8XS9wn
         iEAZBwsTylg9sG+D6ZBPo/zbaa82e/3bzTaLKISQwabsM/7beb71d2jJQh+FA3fBIw
         zd50wrzs+ziGQ==
Message-ID: <b01091e0-993e-5dbb-ad69-c80d253fef76@collabora.com>
Date:   Mon, 14 Nov 2022 11:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/7] dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
 <20221111135525.204134-2-angelogioacchino.delregno@collabora.com>
 <c0dca253-77a0-2a0a-8a03-2a727512eedb@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c0dca253-77a0-2a0a-8a03-2a727512eedb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/11/22 09:23, Krzysztof Kozlowski ha scritto:
> On 11/11/2022 14:55, AngeloGioacchino Del Regno wrote:
>> Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
>> contexts where required.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
> 
> This is already a v2:
> https://lore.kernel.org/all/20220527212901.29268-1-konrad.dybcio@somainline.org/
> 
> and your v2 was a v3...
> 

I honestly didn't remember that this got sent again 5 months ago... besides,
I have to send a new version anyway because of a code fix, should I name it v3?

Regards,
Angelo
