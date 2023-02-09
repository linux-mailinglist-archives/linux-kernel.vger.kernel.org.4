Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A6690363
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjBIJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBIJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:21:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93326627A0;
        Thu,  9 Feb 2023 01:20:52 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2093366020BC;
        Thu,  9 Feb 2023 09:20:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675934448;
        bh=XK89DpHTkrbWesh1OFAIn18zG/r2PRgD+/v++LschwY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lqtvD/mTT0Ly2chZp849w/RLuviHsFeOJD1cgW9SpALvw1pwRE8yT88jAUe2ufll4
         6AWlK77SBPAlnFztsCo9KFtM87fQTk1BcnhfYQfRponS3JVsPEpgsCy4Q9h3ivveI+
         LDmYQ5fL/rA2f4/vt9vHT4x2Z6ABhoBwABrXfRC6FT9Zbi12hasLs7uBhkL4FmZmGU
         5+yYxapS1gsYEQ2Mbs5gRHvt1+VTnABTwUboGxPgRv30vUFMx6Qtejs/lC1CKSNv7W
         uLkCvo1z3CZ936nCMnQqbqlbNLcj2vtMjQwD+Gxs/gkckCtgohqkcYYB/UcOmMszSp
         F/6dOiDm357Pg==
Message-ID: <7784f5a2-3cfc-9999-0ad6-cb9cfc1f2822@collabora.com>
Date:   Thu, 9 Feb 2023 10:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/9] dt-bindings: gpu: mali-bifrost: Add a compatible for
 MediaTek MT8186
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     airlied@gmail.com, tomeu.vizoso@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, steven.price@arm.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        Fei Shao <fshao@chromium.org>, Nick Fan <Nick.Fan@mediatek.com>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FZqrGzzG8FrmLVzMd7=a23ZJPYGSy5yhYWgH+BFHNmxw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FZqrGzzG8FrmLVzMd7=a23ZJPYGSy5yhYWgH+BFHNmxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 09:49, Chen-Yu Tsai ha scritto:
> On Wed, Feb 8, 2023 at 6:37 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Get GPU support on MT8186 by adding its compatible.
> 
> I'd skip MT8186 for now. We have to work out some binning details for the
> OPP, in particular how to deal with both Panfrost (or Mali) and SVS adding
> the OPP table. We were just looking at the Mali driver today.
> 

Dealing with binning is fairly easy... I have something already done for
that one, but I'm not sure that it would be the best option.
My solution makes use of opp-supported-hw by "standard means", but perhaps
let's have a separated conversation about it?

I don't think that skipping this would give any benefit though, because
that is only adding a compatible and whatever binning support would have
to be generic and 99% not bound to any mediatek specific compatible.

Angelo

> ChenYu

