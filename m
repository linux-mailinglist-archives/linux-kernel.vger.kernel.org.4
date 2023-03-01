Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE26A6A59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCAKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCAKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:00:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94528136E2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:00:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAD6E660036A;
        Wed,  1 Mar 2023 10:00:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664856;
        bh=HC6KSnhiLwT/rwuATmwOy2gOfI8Nwvc1BwEcPTsflsY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kA9Lh9yAHXIMWB4LLmy61Nhboafh+GLDlvQ6Tnaa991cs5bMbOWMyYw5pF9TDryWm
         NFgxQVWLzohrtBdJzYuC9E8RBD/4gjW8pjTJkFzpCE/HqBurRx0Tn/RYW274io3hOW
         jsT0ueuezgh1W21LGC/EX/SkKANAC1w73jFF2jIiX+Of3ndtJxsc3fmpP+K3RwTYtk
         v72/1a45iIU0IbnHxiXH0oL2foXHeZX5VJlFCchLbEtiQ+x4cwY4+QKpX524VH9QcG
         zKY/LAgBJ8mSHTakJ3+xvRCRlclZWHfVCEBfTJ41Ek6xUSmP4BwZNP9MQMjiN37wAe
         /1dV80eowfUoQ==
Message-ID: <3d2f385e-dc85-8033-cf77-e5f0634c5be0@collabora.com>
Date:   Wed, 1 Mar 2023 11:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: mediatek: add missing initialization
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230301040835.6322-1-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230301040835.6322-1-trevor.wu@mediatek.com>
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

Il 01/03/23 05:08, Trevor Wu ha scritto:
> In etdm dai driver, dai_etdm_parse_of() function is used to parse dts
> properties to get parameters. There are two for-loops which are
> sepearately for all etdm and etdm input only cases. In etdm in only
> loop, dai_id is not initialized, so it keeps the value intiliazed in
> another loop.
> 
> In the patch, add the missing initialization to fix the unexpected
> parsing problem.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

I agree about this fix, but this commit is not fine as it is:
Please split it in two commits and add the appropriate Fixes tag to each
for backports.

Regards,
Angelo

