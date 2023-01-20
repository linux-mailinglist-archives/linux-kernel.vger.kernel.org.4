Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8E675317
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjATLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjATLLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:11:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C139290;
        Fri, 20 Jan 2023 03:11:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41E5A660230B;
        Fri, 20 Jan 2023 11:11:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674213062;
        bh=k6CDrFMFNBBTo0iy9o/fuYF/D5i8QlRkB7/+jV9nrOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nR+3UleAsemunHhYoEqXI5W7peTA3EirkVKy8eb6C+4stfe002V6194laqGu7APx1
         Vq9FjWlC9bupqdQXvEZSuubvETGn5mVVAiGo6JeGHEI5HjZpq6MT4jVHnak7WngAFL
         YF6GHS9RY5/nqHCkgKb2388iTWbVBhGhyB9L1emHwn7UWjM2+na5qPs7Zlg51LMpBQ
         o0rW2bDLmAu8JFLLVDi9Hf80IfUnlwNrO5xvkse0ZyS3nEXk9V9wuy/waegO3ba95E
         AGTnlCQBFIcsl5vN0wL2kZiePJT9uhgIe18rh6jeRhoX5q3FakFtEUmdb4bxIcNUrb
         +NruoKUBw4hqg==
Message-ID: <91627ce5-1eb0-1a8d-3e73-4966cb7a817f@collabora.com>
Date:   Fri, 20 Jan 2023 12:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v30 00/11] Add MediaTek SoC(vdosys1) support for mt8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113104434.28023-1-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230113104434.28023-1-nancy.lin@mediatek.com>
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

Il 13/01/23 11:44, Nancy.Lin ha scritto:
> The hardware path of vdosys1 with DPTx output need to go through by several modules, such as, OVL_ADAPTOR and MERGE.
> 
> Add mmsys and mutex modules support by the patches below:
> 
> Changes in v30:

Matthias, can you please pick this one?

It reached -> v30 <-.... I think that's way beyond being enough versions :-P

P.S.: We have MT8195 support and Tomato Chromebook support, but the display
       doesn't work because of the VDOSYS1 soc+drm[1] not being there...
       I'd really like to get this machine fully upstreamed.

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=707095

Also, CK, please can you coordinate with Matthias so that we get both series
merged in now?

Thanks,
Angelo

> - rebase to next-20230113
> - fix reviewer comment in v29
>    - fix mmysy binding doc for vdosys1
> 

