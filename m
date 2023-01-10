Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF64663CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAJJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjAJJUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:20:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF107544D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:20:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C51C66602D6F;
        Tue, 10 Jan 2023 09:20:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673342427;
        bh=g8LJ5B4rMDQV97cEiwnSy/f5QYjiF15lfCvnnH5n72k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MIjZ3lECCLCdFrjMcSHZqxDoDQhX+9fOc+uBgiIaeRF4QS4av3YE5Ulo2EP8kbeg7
         dwg4uQpknuzd1yNOWl9cHdRqjHuYx93ZhI20G8xOh1DH+wa0wcyTluVjkPNU9OUfqg
         1UdQKLDThtscSBOUrifp0bBug9gZpkxstJywG5V3MbxIneyaYCX8Wht7bW1Rpg+Gbu
         V4mHYQPVATOD60tn2zIW20C1/pl6vUFNz4jzLVJ+oCn0IzsY3lT3cLUaKJddc9vshX
         V8TXLUkKtfU3nHRUDT3Ivb0b6V5iLdljH2nM0YhacL0tijeiG/hEE3j7wOKRPSv3Gs
         MAzaJXyOuQsqw==
Message-ID: <3b6c19a9-66ac-a18c-cb3b-144066077bd1@collabora.com>
Date:   Tue, 10 Jan 2023 10:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to
 send initial code time
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1673330093-6771-1-git-send-email-xinlei.lee@mediatek.com>
 <1673330093-6771-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1673330093-6771-3-git-send-email-xinlei.lee@mediatek.com>
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

Il 10/01/23 06:54, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Since the panel spec stipulates that the time from lcm_reset to DSI to
> send the initial code should be greater than 6ms and less than 40ms,
> so reduce the delay before sending the initial code and avoid panel
> exceptions.

Please change the commit title to describe what you're doing.

drm/panel: boe-tv101wum-nl6: Remove extra delay in init commands


....and the commit description should also contain something like

Reduce the delay after LCM reset by removing an extra delay in the
initialization commands array. The required delay of at least 6ms after
reset is guaranteed by boe_panel_prepare().

Regards,
Angelo

