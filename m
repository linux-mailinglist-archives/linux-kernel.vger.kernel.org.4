Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1B697F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBOPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBOPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:07:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D100C44BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:07:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ECC8F6602160;
        Wed, 15 Feb 2023 15:07:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676473647;
        bh=KTPFBnoyRnHfUK2VFcUPfWiPaILRCFPZqJiHcvoKHKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EaWB6Lx1rezf8HJn3U/YC93m6pmk+GckaT8t4JiGFU//hFUeftfzhlWLQvYRzoe3x
         MxO7Jplknd8Wa/4eNG8C8EFXc/nNzS1Ce1mMuBoRYH88kWGD6WZC4qRrBuL706rF+z
         nBS2bh7UCjHIZo3c9kBl8wnksIP+ypKVB83sPfh2+HMIHJLRQ4IE9xvciNGsfY2Tu5
         78u8LCyu6KMil30KSo5bLeei88/9b/PCtmz2tUnJpISSedy+s5H0/XfnCRmXpbAVxV
         5rIqEhvvdql1uVV4XR3C69XYlo/hIDpueJsP2V4SBXEdjhzfhSooRZnyqOpfScyrC1
         0ZxMxfhZ7UPIA==
Message-ID: <aa953275-8d93-9acd-70cf-a108c154947f@collabora.com>
Date:   Wed, 15 Feb 2023 16:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] ASoC: soc-dapm.h: fixup warning struct
 snd_pcm_substream not declared
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230215132851.1626881-1-lucas.tanure@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215132851.1626881-1-lucas.tanure@collabora.com>
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

Il 15/02/23 14:28, Lucas Tanure ha scritto:
> Add struct snd_pcm_substream forward declaration
> 
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>

Effectively, a forward declaration is a better fit for this case.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
