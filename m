Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5305B2FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiIIHe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiIIHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:34:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226BDB40D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:34:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A06196601F9D;
        Fri,  9 Sep 2022 08:34:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662708859;
        bh=5VvwnbXofTSVecEzap842tdZGEPaG2MhXLhAO0Qr1uE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lW89EY4aJ1eVZPFDlLcJbiY7aMi1pW1MfbFb5qV7LHA2vwyz0wB8tM3jLVkG9iJSu
         L9t1WVM5JudnYNeflvKwmC9G1+DE7J4PPfHe3YGyXWoMIUmix6Ql8vFOPzeSVj5E1e
         OLTqNqhyHrlK73YknZY5XTiZB4izUpq0RDvK/KCX+DAnIAbN92o+ARW5pTZ9doiTlG
         V4363hwwUO/ftJ/EGyIJl6dMrzZi0Voce20DxA82Ne0jMmVUUFvnz/OH0DSwNcpXYR
         S8mvOP/zztacZn5lUcS/niCQqsrIbc3L8vFbT6WCHQoBYCOs3bdnsI1E8k2ukwQCwG
         KAh7F/sL9KYZA==
Message-ID: <fb1d20f2-2ea4-613c-a79b-f2d309943540@collabora.com>
Date:   Fri, 9 Sep 2022 09:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 10/10] ASoC: mediatek: mt8186: Remove clock share parsing
 from DT
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-11-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-11-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 18:11, Nícolas F. R. A. Prado ha scritto:
> Now that the clock sharing for i2s ports can be configured from the
> sound machine driver, remove the logic that was used to parse the
> properties from the devicetree.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


