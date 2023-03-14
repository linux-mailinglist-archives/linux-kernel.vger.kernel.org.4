Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5A6B8B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCNGqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCNGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:46:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505794765
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:46:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n2so18600058lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhbXxJ4vpNqee73M6/vRlz+kqj3z39OL4xPkGR3We6k=;
        b=GoWSTZrQsLS4XERhO2xMfwRPzK1whV8/7rN0TtUVHDXr6O3pyEMAtvwjGOv+9k0X0b
         fY3z2pXoNlajopNs9VcuylCpda5CLsWW/4neKFcFVm2ODY+63VagW6eessvxkCtqesVQ
         VB+eCpTKR6i+TCPxyzXgoNWVwFnzIK34Ql+ePGeI4WNemHqDOofhVWXoMv/jIm8te4Xk
         6CjPrigAmIAWdgkr+k7dMYjGOs5FsqyEH+1sodzPTVFrCx4V9Q4rlrZ4lh1S720e91Ji
         BPH46ULT+WyKwZC7wq7xK0Hn7Z21UlMVjiRKiPJxDaMbD14Lr+ybYHCaNVj8Xj1D4MZ5
         KrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhbXxJ4vpNqee73M6/vRlz+kqj3z39OL4xPkGR3We6k=;
        b=E9g+QcGEViVVmTv0TryiQgRvvxLQkhuTCydRxyKv1K3yhfofOs7ZSC9lYF7WQfr046
         pYILuMjXIDOOAm0bLTw7pwqsigvFk8Bot7qN0VPDA58SEHX13qD5yAtByvhVeJ5S3TZ5
         XQyZe6/tfcYYK/utryMaJmHVYt1ei2XaMs+2KLR9T/QYT29hu7nnxJJZg33WsfGEutLD
         TRw2vb5PJB9jcBCCWrGH0DMqUcN8bjCrPK4+LhDc19hocMKfOYFJlxer/9+dIwYoac/R
         w7n8Kai/PfLeBrXarrHd3j/pvQR4QELDyTiJVSVn9+zXYPizrseyk9iwzxFGphUjcFnt
         HuNw==
X-Gm-Message-State: AO0yUKVdMBDA3dO3kVXaq+pFFbqXvuzGmZ/Nv9+yoakx/BXth7yVziyq
        ZnnkfnE19Chl/lYkcGKVQqd69A==
X-Google-Smtp-Source: AK7set+h2ndOB4p0HTaSRJEa23fwejgd1QQBXJIK8545r8GXILzHRgIM69D8cqAOd6eDDgave0Vz3Q==
X-Received: by 2002:ac2:4191:0:b0:4e8:401a:3e2b with SMTP id z17-20020ac24191000000b004e8401a3e2bmr448737lfh.5.1678776370465;
        Mon, 13 Mar 2023 23:46:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004db45096c99sm272438lfc.85.2023.03.13.23.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:46:09 -0700 (PDT)
Message-ID: <4ac7e2e0-9b19-c911-7297-3510e55d6cfd@linaro.org>
Date:   Tue, 14 Mar 2023 07:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
 <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
 <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 03:41, Yong Wu (吴勇) wrote:
> Hi Krzysztof,
> 
> Thanks very much for your help review.
> 
> On Wed, 2023-03-08 at 11:35 +0100, Krzysztof Kozlowski wrote:
>> On 07/03/2023 09:05, Yong Wu wrote:
>>> From: "Chengci.Xu" <chengci.xu@mediatek.com>
>>>
>>> Add descriptions for mt8188 IOMMU which also use ARM Short-
>>> Descriptor
>>> translation table format.
>>>
>>> In mt8188, there are two smi-common HW and IOMMU, one is for
>>> vdo(video
>>> output), the other is for vpp(video processing pipe). They connects
>>> with different smi-larbs, then some setting(larbid_remap) is
>>> different.
>>> Differentiate them with the compatible string.
>>>
>>> Something like this:
>>>
>>>   IOMMU(VDO)          IOMMU(VPP)
>>>       |                   |
>>> SMI_COMMON_VDO      SMI_COMMON_VPP
>>>
>>> ---------------     ----------------
>>>   |     |    ...      |     |    ...
>>> larb0 larb2  ...    larb1 larb3  ...
>>>
>>> We also have an IOMMU that is for infra master like PCIe.
>>> And infra master don't have the larb and ports.
>>>
>>> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
>>> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Indeed, I missed broken checkpatch/DCO chain.
> 
> Just confirm what this means.
> 
> Do you mean MAINTAINERS need to be updated since we add a prefix
> "mediatek," for the header file?

No it means, run checkpatch.

Best regards,
Krzysztof

