Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9B617A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKCJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKCJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:50:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5FF20;
        Thu,  3 Nov 2022 02:49:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30DF56602910;
        Thu,  3 Nov 2022 09:49:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667468998;
        bh=4CpuV+XdMGlw8IhY60YU6dU/4TY7hgL/Dy2jeBCaZis=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NO+0Sni1GND37CMVheasUORCY5dOko3seUNX6BnzeVMjaaCQPvGQVAuaxg7fJ/HpD
         t/sZhatvKR7Ny+tcUfNxdJswJQJ3CNb+d2zGnkFH+XI+9VdXV3ftkfAOkZaU/21G8x
         v3wTS0lrLw0bNbxMfr3yRfR1WXLSHYQK8GBfcKZQW6O+FCs4KW44H2WN1Rpt4lcOIY
         CLZRCrfjcnQk9rUHv/K1mVjf3fRNJ2SLaL3lDZAWRD1zZ9rLyR/lHIAEJ/OAxIJ/9W
         qVBgV0++lH8h0DGSk45FOO9CEXacxc2dAYPXzN/pYDPFpRS1hMPdNKgeKqizB+dzmb
         hnVx3c2dlebgA==
Message-ID: <e219b620-a119-74ba-34d7-e678a08b83df@collabora.com>
Date:   Thu, 3 Nov 2022 10:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 4/5] arm64: dts: mediatek: asurada: Enable audio
 support
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221102190611.283546-1-nfraprado@collabora.com>
 <20221102190611.283546-5-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221102190611.283546-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/22 20:06, Nícolas F. R. A. Prado ha scritto:
> Enable audio support for the Asurada platform. This consists of the
> machine sound card, the rt1015p codec for the speakers, the rt5682 codec
> for the headset, and the dmic codec for the internal microphone.
> 
> Newer revisions of spherion and hayato use the rt5682s codec for the
> headset instead, so the codecs and card compatible are added through
> separate dtsi files to prepare for that.
> 
> HDMI audio support is left out for now since the DisplayPort chip
> required isn't enabled yet.
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


