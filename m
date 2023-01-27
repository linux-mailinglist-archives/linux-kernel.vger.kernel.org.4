Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D767E8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjA0Ozo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjA0Ozm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:55:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C63BD95
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCD261CC6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4ADC4339B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674831340;
        bh=HvNrME+MM8yn4e0AkTN+4TlH0dGTPBFUw82z5J9q42o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BdOJeA81z8ETj4H1loxExyGMkjmJU71jtbn48u+zJKPN3npJkLLrD1DTEzUDyITfh
         HDqTrjXvFpiXuIEuPBw7xP+bQB9UR3OKcBZE0Wj/jO/o2DOm/GpsZdFzd+ezW+6aVY
         f7vkv2VfyHsdtcELdVnqBZgKL0QiRw8bCP2POSD0+CpoJrqlBwp8PfKmahn0PF+jjF
         HYYg55akVUd+tMg51h5/kAo8OV5jd8bVZJki/YUmBOxUtU7/k6Lgfiay4apwLTfT9S
         0QvmA/4vc5njTRfs5fd7yf1UrbXlYNPr4ZVd1HvysynF6AuxpKgStRD4NXfSxBX4CW
         6qEPoZsjkkPcg==
Received: by mail-lf1-f54.google.com with SMTP id d30so8510643lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:55:40 -0800 (PST)
X-Gm-Message-State: AFqh2koyxEkIzimx10vLgg7g2CsXDeaL8lK+zOak3gI+eNky8r0YwWIS
        7ggFm23OT8o7HeTNH4zjg8bjntkwhYS1P4ftYQ==
X-Google-Smtp-Source: AMrXdXt+OmlRKcer++n7fCu4l2zdWFvwQbkW53r+2SZjCqH0XMEpiXMeFESigK5NF723T8csDUcyNE8hgDt/kcl9nxk=
X-Received: by 2002:a05:6512:1105:b0:4cb:f29:e2b0 with SMTP id
 l5-20020a056512110500b004cb0f29e2b0mr3003381lfg.404.1674831338572; Fri, 27
 Jan 2023 06:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20221205095115.2905090-1-ruanjinjie@huawei.com> <378232f4-5c2e-ad56-c4ec-4d9f72f08755@collabora.com>
In-Reply-To: <378232f4-5c2e-ad56-c4ec-4d9f72f08755@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 22:55:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9aQnkWvLjaoxRsHStpfeK5v72XkNd7aCw-MbCLVQewUA@mail.gmail.com>
Message-ID: <CAAOTY_9aQnkWvLjaoxRsHStpfeK5v72XkNd7aCw-MbCLVQewUA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_drm_crtc: Add checks for devm_kcalloc
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     ruanjinjie <ruanjinjie@huawei.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, seanpaul@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruanjinjie:

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B412=E6=9C=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:5=
3=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 05/12/22 10:51, ruanjinjie ha scritto:
> > As the devm_kcalloc may return NULL, the return value needs to be check=
ed
> > to avoid NULL poineter dereference.
> >
> > Fixes: 31c5558dae05 ("drm/mediatek: Refactor plane init")
> > Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
