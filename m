Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732BE66BA75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjAPJeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjAPJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:34:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1117147;
        Mon, 16 Jan 2023 01:34:11 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 041256602BBC;
        Mon, 16 Jan 2023 09:34:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673861649;
        bh=l4d/nOWEMwXLposanFY9XKP6QnAoGbIqo4G/neYks9o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LgGE1XHpi12/cbaHd5nS1YmPfwt0H+LxxnXyHY+5nqqHsehK2yXFaPdVk6nGpimSG
         mIPiCaYJ1Pe1ChCC8RFscpBoly3H9be/v3SGuoy/1CrTWeQOZi5TgcuYpyyRje2FuY
         VW+KvDQ/ymHou8l/HqxR8mlvsYEnzv4fzcF/4dia1o5KZc6Eg40MJ7Mk4kuKQSbhKr
         SnkJ7IBTD8gBvQ+95Km5vI7c0QjmRBQkfQtbpP9AsDDFbtQHEkwTgyyjyB5avUPiNp
         ZvHdzzu5gquJiT1UzeJkgGjVHNJdeKNEfJqqz4XP2kYuS9aDwzBwDo/EA1VoZTgNLz
         IH7T9Qyp18pVQ==
Message-ID: <0a129474-a3c4-eaf8-26be-1d1acf5c3513@collabora.com>
Date:   Mon, 16 Jan 2023 10:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND,v5 11/13] ASoC: mediatek: common: add soundcard driver
 common code
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230116034131.23943-1-trevor.wu@mediatek.com>
 <20230116034131.23943-12-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230116034131.23943-12-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/01/23 04:41, Trevor Wu ha scritto:
> Add common code to support of_node of codec parsing, so codec phandle
> can be assigned by sound-dai in dts.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


