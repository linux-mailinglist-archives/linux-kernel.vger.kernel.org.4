Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE10620E03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiKHLBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiKHLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:01:26 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF6450B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:01:26 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id t85so8623022vkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8DK9DM/Joeyp25Jhq2KddrijoW7OgJ/0JO/zDAQJYg=;
        b=TF3AHNNgNmarMWCmKT2AxYiRqmkKw+uexQPQmFLX5fXEDsnWkPR86A+jxYLcTD1Lsa
         MIjNCE8srNStKLl3eDfGlhooKcjNJP2Q8pPuHKMBBLMAhTkYGn/V7O6NediSHfb3erH5
         R5hsTLUAHena8ne63j8sqGMVTwkpNmKgs4OnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8DK9DM/Joeyp25Jhq2KddrijoW7OgJ/0JO/zDAQJYg=;
        b=Zw97ZcaKbW2GkAS+Q1ecZt/BuudwfccqPNBDyOeiUtq3cl0tfreqN0KwszYnT6oYch
         sUy4iV7G0xa30v6qdgBtsfYHuHMHOk1jYM2DU8Nzh7pLoVm0XebvTvamhz4b9NW2ilUu
         94KQn4jwtzl55wW4ksp9pf/bm2+vwQBOnvJamWM/9IK4H1WLoTs5kfyuy+3OepqCwbNM
         jTHaJ2AMWw4v/M0WiiDklEuoGWIhCTafj5tMlOuZdCa4apC9A220ob0raFkzm/Wputzz
         3IIvv+qJPG27CQOp+CGo/4hjWvJDrKuiRxO0ptpw4P0hhY8XeRtXL5pRnoGoXjJUQVzy
         rwnw==
X-Gm-Message-State: ACrzQf0oJ0WCVEcCZQplZzQbdGIoih6aO6ABCTfBZaoeyNdXXTNL8sUa
        SP0Jaccvxh1I3v7hkouYzCQyYMHA4e+Oczad5CHntA==
X-Google-Smtp-Source: AMsMyM5djY2N0rMudnF2ERzIwk+3mqJ8PLMEwSyNwM/8eFgA1p1IJVrnAU5RggXbDYPpgI1QKxXoiTWAh6dBFuguGZU=
X-Received: by 2002:a1f:9116:0:b0:3a2:362b:fea9 with SMTP id
 t22-20020a1f9116000000b003a2362bfea9mr27061022vkd.11.1667905283579; Tue, 08
 Nov 2022 03:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20221107160437.740353-1-nfraprado@collabora.com> <20221107160437.740353-6-nfraprado@collabora.com>
In-Reply-To: <20221107160437.740353-6-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Nov 2022 19:01:12 +0800
Message-ID: <CAGXv+5Gyo_VvioV5HWabvQgX3xkM8nj3Ty8AossQgq89qmg00A@mail.gmail.com>
Subject: Re: [PATCH 5/9] ASoC: mediatek: mt8183-mt6358: Register to module
 device table
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
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

On Tue, Nov 8, 2022 at 12:06 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Register the compatibles for this module on the module device table so
> it can be automatically loaded when a matching device is found on the
> system.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
