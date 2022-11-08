Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C488620D75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKHKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKHKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:36:16 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956845A27
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:36:02 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k1so13190580vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIwMGfWyNQ7s5l6wql3uvlBpgJdlvAeJW6d0366qQQs=;
        b=c/tDJvrT2wHv4vJWmTx3PQDFAb+Y/XJPBG2EIptwqdCWhYX5CAktQnHNOx40Ot5Hmj
         YVogdQ9uwLEYZlZs9fS18niOIAsddaAjWEtKbbTiy4+k+7WbFQWRqOa+z0XprQfI2pTy
         embv6SCWU66djSMx502aQWrD5bB8ckF5PZvik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIwMGfWyNQ7s5l6wql3uvlBpgJdlvAeJW6d0366qQQs=;
        b=wYbw+rpIzOlVTOfZNLGb9/nPyypl1BPJadeQGLeSJeCGsnLizx1DzQBiG+b2Rhbd1o
         sRqo4n9aiM9J5iFAmDtT9hw4Gemr/L94GujHIlc5Sur57N96l1dWEIGeCUab79FRjgZg
         Qj1HdpVknF+TL5/eBV7gYGRuBU2hjUjIlCc4e5kMXF7cTYXlX+CZ6+uMNuzI+dPV02KL
         A7Nx4yJXlYJO4e99E+SlXXgqqVuj1cTCXZ8IKghr+wQt5UxEmtRdAcB70SNClo+Z+S7O
         h08K24CGgvgE8c32XPxDpj3R9AcZ54hZLbtaRPb/rwpi6cgtUTjddkI+54+RaHQ9V9AT
         lpMg==
X-Gm-Message-State: ACrzQf1dy/pUI03ddfdAaoPT6v169xn11Sc67D9ABrDaTPdpPA5j/E9+
        8l0cDa+H6/Tnslam/ug7JW8ohAkZ6Lfxfh+Risxr6Q==
X-Google-Smtp-Source: AMsMyM5jLCmjiXZ4jvSVXS8J/qTXmQOOIgSjI3NrNmXTmWAuW0AmzL7SRcukaw4oeCm789X2QNm3ZTTOWYDLc8Q7zvc=
X-Received: by 2002:a05:6102:3c83:b0:3ac:7ce4:1bc0 with SMTP id
 c3-20020a0561023c8300b003ac7ce41bc0mr27570121vsv.65.1667903761637; Tue, 08
 Nov 2022 02:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107160437.740353-1-nfraprado@collabora.com>
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Nov 2022 18:35:50 +0800
Message-ID: <CAGXv+5FRdA+OaA-tEE6Aa1avb1YtacqcE5e=A6ZpBFsCaLQRJw@mail.gmail.com>
Subject: Re: [PATCH 0/9] ASoC: mediatek: Register machine drivers to module
 device table
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

On Tue, Nov 8, 2022 at 12:05 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
>
> Some ASoC machine drivers for MediaTek platforms were not being
> registered to the module device table, preventing them to be
> automatically loaded when built as modules. This series adds the missing
> registration to the drivers.
>
>
> N=C3=ADcolas F. R. A. Prado (9):
>   ASoC: mediatek: mt2701-cs42448: Register to module device table
>   ASoC: mediatek: mt2701-wm8960: Register to module device table
>   ASoC: mediatek: mt6797-mt6351: Register to module device table
>   ASoC: mediatek: mt8183-da7219: Register to module device table
>   ASoC: mediatek: mt8183-mt6358: Register to module device table
>   ASoC: mediatek: mt8186-da7219: Register to module device table
>   ASoC: mediatek: mt8186-rt5682: Register to module device table
>   ASoC: mediatek: mt8192-mt6359: Register to module device table
>   ASoC: mediatek: mt8195-mt6359: Register to module device table

Thanks! This was on my TODO list. Whole series is

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
