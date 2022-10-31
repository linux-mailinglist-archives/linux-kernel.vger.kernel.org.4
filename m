Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED14613702
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJaMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiJaMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:53:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FFF5B8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:53:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AD83660283B;
        Mon, 31 Oct 2022 12:53:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667220810;
        bh=hnFiepKNZT31pHoNxZvk70yYkyK1gU+Ahp8W5ZKMecw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RkgywlvEu9GgCTMy0DeWfPbgud/Rw5Zt22obwpyyjFikMVzBCryRBfo7kSzx4snG/
         tfgDysNpfzC8g6tBB/u3zFCbIrQ6I3fZbqyBtjyp1yLo/DST4/beoAKRSCCd6nGSXt
         DX7xSPqmnrAGz6fJjgwelH4dhmKC41LbeLCwtLdEalhZUEzbxvO8tPq8J4FrcPc8od
         afCQKzoHVT3NKT2xLvsokdR4lxVvYFcSCI+tQf4uEP0EOteQQyUduqRDpA7EdsVfwL
         M5EXDPOgFSfy88Aa8O62XaRF5c54LIYUpYjww7W932S2V74rjyQZrASEYrEPzerfGI
         7dk8e5TZbBCLg==
Message-ID: <704a7ac0-531c-38a2-69e6-36c190aee1cf@collabora.com>
Date:   Mon, 31 Oct 2022 13:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028205540.3197304-7-nfraprado@collabora.com>
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

Il 28/10/22 22:55, Nícolas F. R. A. Prado ha scritto:
> Add support for the dbvdd and ldo1-in supplies.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


