Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C869D16E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBTQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:40:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020FE3AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AFC2B80D43
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE69C4339C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676911196;
        bh=i3CakrJQFkm65YXyhehgRdoeBRtU8OyX2oDLK++gsBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bI9ADxHVdLO03aK8NOrCaGWY2YoFDs2a3EPlDq7AUHL2O6K+8RwisxFqgxrnMmS+i
         iJnIQ7FxYw4Cgz99zyEZLICxZFiaHASQr1NihMYu157vqCNyU8OLvUES3VLfjGEtV5
         jht3flOOJONEVxcZ4AsTmv+cQIf3xLrDCBtPqcGxAfD0gPwC88qLErhgKxqYGOauzG
         QFAFX1hsUvChb24nl09j+j/lDG5fGA7scrkqO7UZJAEanVjEumJTi7ypx83vv8RUNF
         984mIeGuYr9NWw42x39qMT+OUg+BacEQrnskRhE9wEXVjR5l1jH6jTAVTZzxGUDPE/
         j38UGWkWI7lhg==
Received: by mail-lf1-f45.google.com with SMTP id s22so2310856lfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:39:56 -0800 (PST)
X-Gm-Message-State: AO0yUKWESGPsmyhjdqjmuFw802rg4LRloY1sJacCeocYPCKkvz0oBiYl
        zsYci9fEOADH1dY36Own6GOVkXyOT3v4T9e9MQ==
X-Google-Smtp-Source: AK7set+2kJBOAKEpxRGpK8KOJwvlu/ZWPTWd/d0PjSOJYzKrSDyF+z8L7LKeT5FGF52CAVPsomQ/d58pI0EpLGJYPGE=
X-Received: by 2002:ac2:5495:0:b0:4d5:ca32:68a2 with SMTP id
 t21-20020ac25495000000b004d5ca3268a2mr881249lfk.7.1676911194865; Mon, 20 Feb
 2023 08:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20230219233439.3157-1-chunkuang.hu@kernel.org> <437c0c5c-9a71-253e-eb2d-39e167e35099@collabora.com>
In-Reply-To: <437c0c5c-9a71-253e-eb2d-39e167e35099@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 21 Feb 2023 00:39:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8wQxEHGiPrWc+JuNWKzEfk4=Fe17P3tCrY2jW-dQCYPA@mail.gmail.com>
Message-ID: <CAAOTY_8wQxEHGiPrWc+JuNWKzEfk4=Fe17P3tCrY2jW-dQCYPA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove unused helper funciton
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2023=E5=B9=B42=E6=9C=8820=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:3=
1=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 20/02/23 00:34, Chun-Kuang Hu ha scritto:
> > cmdq_pkt_create(), cmdq_pkt_destroy(), and cmdq_pkt_flush_async()
> > are not used by all client drivers (MediaTek drm driver and
> > MediaTek mdp3 driver), so remove them.
> >
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> My next cleanup step would be to migrate both the MediaTek DRM driver
> and MDP3 to use the common functions present in mtk-cmdq-helper.
> Function mtk_drm_cmdq_pkt_create() is (almost) a clone of cmdq_pkt_create=
().

It's good to hear that you have plan to refine cmdq_pkt_create(). I
have one plan and wish you may consider in your patch. The plan is to
remove cl in struct cmdq_pkt because cl is used for channel
information and the client would have the channel information, so it's
not necessary to store the channel information in every packet. In
cmdq_pkt_jump() and cmdq_pkt_finalize() use cl to get
cmdq_get_shift_pa(), I think it's not necessary to get shift pa every
cmdq_pkt_jump() and every cmdq_pkt_finalize(), so client could
cmdq_get_shift_pa() once and pass this information to cmdq_pkt_jump()
and cmdq_pkt_finalize().

Regards,
Chun-Kuang.

>
> NACK.
>
> Regards,
> Angelo
