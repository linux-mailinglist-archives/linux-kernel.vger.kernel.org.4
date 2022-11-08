Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D1620E46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiKHLJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiKHLJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:09:41 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6B211
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:09:40 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id x20so4672091ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcl801rNi7Jh6Jo/hu/Jbz9lZkngLXNu9cMkPtXUrh8=;
        b=ZHUwRUHMlsd+uune7sAXQUqlyoGj17Cph+iZZ0v3cRtb0ZZfwNsfvleGyTzasdKFXI
         QQ5BmiwQJoxP5/GrJF2+TxE0RkhKKX1mgOBOPP/3neMswl6d8ENmV8rZJebfekhajTuV
         xhwoyHRDFghPMry1bA8wATRGJyA8JkSuwUaNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcl801rNi7Jh6Jo/hu/Jbz9lZkngLXNu9cMkPtXUrh8=;
        b=l1l1ENDmG1RkuRj2wCh3XdnlrTXLpdPDlAuORQA9lPIX7AWRqSTRLCfao3L3i62sAH
         epY7o0mbwWJ6XdDuiY/y6ERYlkkN7se2dzEKssGODEkL5Yze/VZjSe7Wc4PC/j2zepQC
         fkCv2Sv0yDvL21ae1F4A335E6GcostZOkkYXTqldlJ9Te4qDNKXPYtOonIcCSm2aRntZ
         jnqVnAG9Z6ifh0RJxyT3aXZ80Hlljfxb6QbwRI8cYHRawB2NZmfB4k7Jc5ERUzjHhaGu
         qg9a8InO3XncGgaR2W0TzYSDMXYz5HMG0vhcoKHFNd+PgJiO6dr53vNfNxqGT1Sg7/Sh
         nIfQ==
X-Gm-Message-State: ACrzQf3Dvfw/m3X5+U7VJWXkeUYJjfaj6TBrkE3kxYAcOaILktKCx7VF
        r4IOPf0FMAiQ0A5WMoW1mb7/CbETBxcvpxM7qt03mg==
X-Google-Smtp-Source: AMsMyM6sjG+3Ik/dtstkJiPnbQ2Nxhh/biLDiEKU7uJHUe6uWGF9l33bHbxbqAeo3fH4zVwtXXQY39IBCfY5SWIe9D0=
X-Received: by 2002:ab0:a95:0:b0:3ad:bbe7:e134 with SMTP id
 d21-20020ab00a95000000b003adbbe7e134mr16528144uak.43.1667905779999; Tue, 08
 Nov 2022 03:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107160437.740353-1-nfraprado@collabora.com>
 <20221107160437.740353-10-nfraprado@collabora.com> <2f2bdebf-8566-7740-733a-79c6e1938c84@collabora.com>
In-Reply-To: <2f2bdebf-8566-7740-733a-79c6e1938c84@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Nov 2022 19:09:29 +0800
Message-ID: <CAGXv+5EE6OjKcki+40nKLs6wz6iRybpoxD1X4gJ+Z1CDHomtvg@mail.gmail.com>
Subject: Re: [PATCH 9/9] ASoC: mediatek: mt8195-mt6359: Register to module
 device table
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 4:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/11/22 17:04, N=C3=ADcolas F. R. A. Prado ha scritto:
> > Register the compatibles for this module on the module device table so
> > it can be automatically loaded when a matching device is found on the
> > system.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

The module was automatically loaded.
