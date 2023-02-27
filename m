Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0101F6A3DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjB0JDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjB0JCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:02:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696E1E9D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:53:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27FFE660230B;
        Mon, 27 Feb 2023 08:52:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677487937;
        bh=1cjR+Xq8SfKyd+hm/j5K52t9SjZ2Kqz/fBguJHl9Mrw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XIyPZGUS8NuNQhjSRdzFXQH7V5W3pLmlbZbKtXq601AbToU/PdBQ459erH1nO1gTi
         A++sXxNeBe8oO7PVeH0oiUeeAfPQ9nfqdPlZOgd/yxYiTQXPqCuDF4YEfsbu9VhplK
         mVir1CDVv66TueYNfAJlivi/XeEo2hPpbj+b0Xkh4O1TkNqMbQOIpun0gRHR4/LtEF
         AmvwOZQjuQHKoyMDobuourF4wxH8j0Ip3eHkexHUXpuk3PFEgE5CVgAODAn8NQJl2K
         UcujQrVARxpKEYvU2gOI+lOcy51hjCyZHxPZX5RgKb0gb4Sh8piRU5OBTFqoq5hV+q
         5cNu18kR8a16g==
Message-ID: <14138157-aff8-2a60-ec97-12495f30dd8f@collabora.com>
Date:   Mon, 27 Feb 2023 09:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] ASoC: mt8192: Fix range for sidetone positive gain
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-4-9a85f90368e1@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-4-9a85f90368e1@kernel.org>
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

Il 24/02/23 15:03, Mark Brown ha scritto:
> The Sidetone_Positive_Gain_dB control reports a range of 0..100 as valid
> but the put() function rejects anything larger than 24. Fix this.
> 
> There are numerous other problems with this control, the name is very non
> idiomatic and it should be a TLV, but it's ABI so probably we should leave
> those alone.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


