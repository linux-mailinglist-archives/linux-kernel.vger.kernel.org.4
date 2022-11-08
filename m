Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA85620E15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiKHLEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiKHLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:04:03 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1148754
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:04:02 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z189so13290792vsb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaBdxRjUZjWiYi/UU6XdULmnAXVS96JTxTikA1au8DU=;
        b=ZkzY5ETtu0PETYIEUH10nOly3VcuJtkSlDZS4QtrJ3TMoZG09BAH7UKvNhtr6bh4EI
         KgjB+YXYUVdVddL2B+f84CKvmXVF8qoy/AF5DZ8jppLG+33w9qiiQBCNQkLY2IoGfkiV
         BkKz2ggOccQfHZpvxNc4nAQm22PLy6uKIt+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaBdxRjUZjWiYi/UU6XdULmnAXVS96JTxTikA1au8DU=;
        b=TOruQDeHcjW59Z4RX/wnr4GZIvOZLVzb1LiQ8Dbp1tDk2uKT/FbuFvuD+FduHvwpQ0
         /2pd6qnUjh5t7MGAQhSwfwf8xEUAVHaSLz/TDjo0wNPpaFCCxo7+1UX1eBMfD5hnRZNm
         vUFHHmi0gPsclJYQG+E3nvCSoet0ocx8VMOLH/1TC0pfX2Jl1ItYvQkGhPy9hmJQoAMx
         JwZvIZ7s44mzU7hsROpM3mDCRyyl5gGIF2yy+klWSNj6xQXl6mDcDscaLhAPkRHmEQZF
         ys4cGQooywoUBUVGusdnz61pmn4K5P6odNBZbUYf5YipnoeBMHkEso4FofcakbfzYV5t
         /pFQ==
X-Gm-Message-State: ACrzQf242llWSuTW+d1RmkJYBa6lrVpuz26Y+l+yeDRvGUs/5E0oPB+m
        9T+XJ3D7+fGr5huxqwGxoPEECFTH2isH0UQP5FIMVg==
X-Google-Smtp-Source: AMsMyM6t0mPbG4ToZz5l/tO1gDfCULSYa4MknrJDh9MS6I1IEkQHqfasxxjvZuxONegx0VxazFgJwfSXzMjsEheapQg=
X-Received: by 2002:a05:6102:3c83:b0:3ac:7ce4:1bc0 with SMTP id
 c3-20020a0561023c8300b003ac7ce41bc0mr27621104vsv.65.1667905441651; Tue, 08
 Nov 2022 03:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107160437.740353-1-nfraprado@collabora.com>
 <20221107160437.740353-9-nfraprado@collabora.com> <b5b61326-298c-9845-eec0-15542f096225@collabora.com>
In-Reply-To: <b5b61326-298c-9845-eec0-15542f096225@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Nov 2022 19:03:50 +0800
Message-ID: <CAGXv+5EwsqE+npF4QYpwWMLb55JMGaXANxo87dyDpYwBxD-E4g@mail.gmail.com>
Subject: Re: [PATCH 8/9] ASoC: mediatek: mt8192-mt6359: Register to module
 device table
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
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

On Tue, Nov 8, 2022 at 4:44 PM AngeloGioacchino Del Regno
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
