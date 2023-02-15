Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E3697BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjBOMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBOMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:38:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8ACC2D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:38:12 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C193666020BD;
        Wed, 15 Feb 2023 12:38:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676464691;
        bh=maGtHjzFaF1HAyDrKAFsw2fGzDZFcLB2DcMRG1RYFPw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fgAsH4Dmr4t5TkVVZhkYYaTmyWw0+dCCh2JEsZQzy+pU9LTIM9jqQp5O8LhaxS9uG
         k1fKruqe9BrPK4ZiPpSjPUuGNhMSy5vw1NF8Kb/ChG8ESRuMKeclQlBEc8KglYPUnO
         JloDcCTT9SHC0QyzNS0VpemIanGuyf8YPxdkEt7VnhsC6IV6dF4z11bXCCEDlDUaXM
         poBOHanlSR7QTZ4RPUKP1QiCAqfCx04vNNUgYsdubQ6TGkg2CtsISftg2Q7f3jqqGu
         QE7fPILS00rO8fmsONJZ6mHlQRmnUdJj107nFqZikcqKd7i2iy6H0XVjQj6k/3yW8u
         XPfwverVPELMQ==
Message-ID: <dd3a6b7f-7d42-40f9-dc35-1f6266c8b87c@collabora.com>
Date:   Wed, 15 Feb 2023 13:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream
 not declared
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230215094643.823156-1-lucas.tanure@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215094643.823156-1-lucas.tanure@collabora.com>
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

Il 15/02/23 10:46, Lucas Tanure ha scritto:
> Add sound/pcm.h header to include struct snd_pcm_substream used in
> snd_soc_dapm_update_dai function.
> 
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


