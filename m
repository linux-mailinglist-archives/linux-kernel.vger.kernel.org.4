Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047863A952
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiK1NUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiK1NTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:19:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41801DA7A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:17:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A89086600011;
        Mon, 28 Nov 2022 13:17:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669641476;
        bh=2uXRwe0i//JyPghl6Zfj5I4f4NSH8kMwVmZpxa1n7FY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jADSdHpHmCcKmFVAN5qk55NzAn6vTVxeC+UP+4CqVe7eRb+dKH62Vpa8ytwUq0+aq
         9uq75z/bLl/EaFjeMFBrX1ubdQP3XegPiLOu4+BDHfXOqx0qM2xRu9OsGsqc4Q1lcV
         IpDpHDOJgT6Lm1rHjkMhKLkIEJme6Ep3IpdXH/pGjhIdrcfoGrxRnss93TN6uKIWfT
         scFJCZZNE3Xffb/KGzfkQ32slVx5Vrt8pxZTFFe7JEaUQVmAvYeX0NYAnP8VNoXh7m
         Ty2ohY0M9DZFCoitf+DAiyJ/bc24IzRF7OldfEukrDbRX2t8+UHJ6ulQxMtbXPVfNc
         GJX+UgMEOVIFw==
Message-ID: <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com>
Date:   Mon, 28 Nov 2022 14:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
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

Il 28/11/22 11:49, Ricardo Ribalda ha scritto:
> If the device does not come straight from reset, we might receive an IRQ
> before we are ready to handle it.
> 
> Fixes:

I agree. That's a coding mistake... but...

This commit needs a Fixes tag, as this is indeed a fix.... kexec isn't anything
new, so all kernel versions are affected by this bug.

Moreover, I can see this pattern repeated across *all* MediaTek AFE drivers:
while at it, can you please replicate this change on all of them, each with
their appropriate Fixes tag?

That would make this fix complete.

Thanks!
Angelo


