Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76C5ED735
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiI1IMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiI1ILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:11:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1AB40F0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:11:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 660DC6601FE2;
        Wed, 28 Sep 2022 09:11:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664352700;
        bh=nnLUK+aN6Lt3FvJaNIA3WC4W8c8pNG0EQHNGq3Mu/Eg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O3rsUcKN4/2DqQzIu/etACkLMGpcdqodkMhxuEPdRuji9Ulo/oURMEXpCsZlypIcL
         mphHF3ZtniQUis/9JfVp1PCZtT1mJTt5Vc2PBcUxSuFL8FnuvB+alC5Sv5PclBNnwA
         PsCaHE+IrViPcwWiT0zSSgPtP2tD1Su/qddiYf+HDrufIb8OnHPSSn5LM8eLbbAjSC
         u8PpT7aSZGXT1b5622YetAgmKFHSn2vDgQD+5khKfrGy5mE83NOWNZNhUURhAUG1BI
         UnNbipsBop4kwijBPWi3Gd/WGrFvr0pIlhRKVreQH1YcXRtPAi/wNdgYfHoLdm2qbc
         gYqFK7NFeHTiQ==
Message-ID: <ea20ff46-11fe-12c4-3e2a-5058f9065c60@collabora.com>
Date:   Wed, 28 Sep 2022 10:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: mediatek: mt8195: update audio tuner settings
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220927151141.11846-1-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927151141.11846-1-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 17:11, Trevor Wu ha scritto:
> Audio tuner is used to handle clock drift between 26M and APLL domain.
> 
> It's expected when abs(chg_cnt) equals to upper bound, tuner updates pcw
> setting automatically, and then abs(chg_cnt) decreases.
> In the stress test, we found abs(chg_cnt) possibly equals to 2 at the
> unexpected timing. This results in wrong pcw updating.
> Finally, abs(chg_cnt) will always be larger than upper bound,
> 
> As a result, we update the upper bound to 3 to handle the corner case.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


