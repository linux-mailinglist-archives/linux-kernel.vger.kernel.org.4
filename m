Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0E64D993
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLOKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:31:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C52CC81
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:31:15 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 689146602C5F;
        Thu, 15 Dec 2022 10:31:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671100274;
        bh=WIDaz+drK8oF/b9fCu9/41JRPOIXp254wSJ84sWVcpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GtPBVrT9VvU5Nf3Fdnb3oE7wiZTu+ZLYId5RN1LJmUrey5rm8QajhLVbf0Z38uf90
         B2b4hDi8Xje+fO3bI86h+8/hGSeGrnNh3jGocVQw+MTAu2wTLDVhktrCS8UKLhIg/j
         L92zjN95nh15jDys2iegzxct6Jz+nHv5cc5iKMD9xs4FD2fFPu6JDuBDn42qxvaVh9
         ooXV3i2nIUFqrUBnXacnYDOxtRsCI3ZzbRT2kfD2uOYB6Xa0sPrC/6eXmuZ73MvNww
         4leYuWdo1YbTervvIs0+KgdF/UQVrmvAO3nr1EDhyIXsI9ebdnD2IUIJg/fQjIYyB5
         NfG5hvkMkT1Ng==
Message-ID: <7e8edf6f-9971-c704-4299-be9f7098d1cd@collabora.com>
Date:   Thu, 15 Dec 2022 11:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ASoC: SOF: mediatek: mt8195: remove a redundant
 comparison of sram
Content-Language: en-US
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>
References: <20221215061046.16934-1-yc.hung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221215061046.16934-1-yc.hung@mediatek.com>
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

Il 15/12/22 07:10, YC Hung ha scritto:
> DSP SRAM is not used for audio shared buffer between host and DSP so
> TOTAL_SIZE_SHARED_SRAM_FROM_TAIL is zero. Remove the definition and
> redundant comparison to fix coverity "unsigned compared against 0".
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angeloigoacchino.delregno@collabora.com>


