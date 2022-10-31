Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C36613791
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiJaNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiJaNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:13:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BCB75;
        Mon, 31 Oct 2022 06:13:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6DA3F6602827;
        Mon, 31 Oct 2022 13:13:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667222015;
        bh=CG2d+WzUhOf+xwwimNowiCEmXfcCjdwlQpdt1QFnrw0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ALpTCbRz5+TfhPJiEcFADghgwPSDUJqdl6lsQxpMINEUCgkwVwoWKisouofsZmI1r
         jw7xyLP3mgy30YhKODpyCmsLq6w/S5B12leKOKA/kK8fxuqt1lkz6/9dsaUOX2RiHC
         8jxcgiVwFkVql6sqCTFaXigx1aUuJXPIa/BlkIHZFwSK0Kp4RLIHCt7vgEp3zbXwOp
         gwS4MkVkakrvhaAJjivJT3EOzpSRmTTS4+sPMDOQcwQc9O78ZxNMAfsc1eHAjDeKsm
         XGgJ7jx+x6Wj4JaRA9VC/bAfPiNlZ8al544ADEC4kXd1wgai/9iXfVfkgcOlbrk8HZ
         ClHqu8IV/fEiA==
Message-ID: <00629a19-d42d-3ca1-7b97-f56dd424501f@collabora.com>
Date:   Mon, 31 Oct 2022 14:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 11/20] arm64: dts: Update cache properties for mediatek
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221031092025.533051-1-pierre.gondois@arm.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221031092025.533051-1-pierre.gondois@arm.com>
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

Il 31/10/22 10:20, Pierre Gondois ha scritto:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Hello Pierre,
mt8186.dtsi is also affected, can you please add that one to the mix?

Thanks!

Regards,
Angelo

