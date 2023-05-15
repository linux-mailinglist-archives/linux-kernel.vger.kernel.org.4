Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1F702B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjEOLcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbjEOLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:32:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41D19B3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:32:08 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1A3366031D7;
        Mon, 15 May 2023 12:32:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684150327;
        bh=AfyjFdjKjOCsPrPBTSHo8RI+xoq5WDytfUyvMtnaIrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PuyAgI2m2fSpbJePSFPJHVUqvlOk15FKOWfxYw03phWt40OAgmitzNTl05Z1lYs4i
         AmDpJyWcCv9jeK5VVLA8L4B+YHKwKnP58T8SH4994nft0B8IVDFQl1jtccCPUPMZ4g
         T9xVKHROuR8QtIyjcNjT4zqDEBURn1iPzbwaYs9A6lRZcJtPVl+JQSfhrQqCJklqCv
         sKjlZkSRK5LiuZ/dfHRS2PAEwxvDUTqbWYyPUE1e3Uc8keL15pUpGTPvUFWYBB7Qqv
         Rz0K1wP+NXKfaYR/Y4gyINKR03OU9YnQCHYmrVT5SuP5qyZq6KzCVIaVRZ2Qzxd63K
         b2PqC9dmLd/pg==
Message-ID: <c9f2a2d2-c7cd-4b46-0133-c6b44c69650d@collabora.com>
Date:   Mon, 15 May 2023 13:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH linux-next v4 1/4] time/sched_clock: Export
 sched_clock_register()
Content-Language: en-US
To:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230421034649.15247-1-walter.chang@mediatek.com>
 <20230421034649.15247-2-walter.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230421034649.15247-2-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/04/23 05:46, walter.chang@mediatek.com ha scritto:
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> 
> clocksource driver may use sched_clock_register()
> to resigter itself as a sched_clock source.
> Export it to support building such driver
> as module, like timer-mediatek.c
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>

You're the sender, so you shall sign off all of the patches. Please do.

I can't give you a Reviewed-by tag because of that.

Regards,
Angelo


