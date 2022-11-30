Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90D63D3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiK3LGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiK3LGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:06:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541B2C120
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:06:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC84F6602B30;
        Wed, 30 Nov 2022 11:06:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669806372;
        bh=Vjz1D7fPn+LzVWFAgAbnGfbzxs0NBWSFhZrWPMUaMg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hzb39mNuGctzT/7k70YPp1QxYuB+wbssfrnCGJrdEACeyOXdM7cr0I6i+M4tpCkhu
         3wpsWoiq2PBwE4XqBX6eM9kkrvZwY/FWTogxWcShwDX7TPwPw9LCkHbahD9V60p+4H
         nUKw7F8JLfz8jSdqtxVOgfYHjVxOv090WgVtrl1cqYEDx4aGFYUCiKeNyIzbirR6o9
         KKH/ovphqjoPyng3IQRPm+SwMW8qLqDfDsFIWlMMf62LSf1YCK4U/IQulKE2u8AQsU
         7m3KVhrNO4/7kdmmbLMoBkd+LlHVmrhdAnyU8+gcqBhiHUqWkHK5cB1/2149/tTn00
         1cgJwO13MMoSg==
Message-ID: <90661309-5947-38f2-e4c7-67066658f448@collabora.com>
Date:   Wed, 30 Nov 2022 12:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: SOF: mediatek: add shutdown callback
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20221127-mtk-snd-v1-0-b7886faa612b@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221127-mtk-snd-v1-0-b7886faa612b@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/11/22 21:04, Ricardo Ribalda ha scritto:
> If we do not shutdown the peripheral properly at shutdown, the whole system
> crashes after kexec() on the first io access.
> 
> Let's implement the appropriate callback.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

