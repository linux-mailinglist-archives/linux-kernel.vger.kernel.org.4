Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F8715B34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjE3KOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE3KOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:14:02 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376B12D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:13:46 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-456de5aa485so1253540e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685441626; x=1688033626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ0BJZ8SmdZjdj+zn8FxFAZpMTTsRd9o+hpEFn6fp34=;
        b=RBBWzQ8HEW+9Ib3a8FhJhb7FYys7zwdEFNmdgcI7F5skhmV2LX9SyfMfN2P/VqSG4B
         XHHINCDVjtKyi6EFACg4gOn0kT9la/m1FLdlFjCItqtAC7lLcbtZg0M7ZXJE/s0fPYcE
         WnkkEu9TcEkazWD+Lx00lIhvQUkPQFzDILi20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685441626; x=1688033626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ0BJZ8SmdZjdj+zn8FxFAZpMTTsRd9o+hpEFn6fp34=;
        b=i9A2Yu6jd13Al/cJ/59Fa0+ejFFKLXaAMZ/nO14oCnJiinf49B2FngEIENbsfABotD
         P0tj66W/Q+HLaN2vkOYNL0+Jo09VsQZ5q/elLfm5Ygqd94oBRrgpygjzvkrRRubT6zwh
         NrGWupRGGp4MiB2stnzoZVQwNzPb69g9RzAnNrXKEddxNglt2eZA0B6vWTPdrR9W1PWY
         5Sujv4oyP2hO+FYr3Bv0ddPH9uFpjpMuT+ZHhp+r1CvUk1YMfF7yHz1fqQS8VLI3A4EF
         eIDq6BoyCheajDyvhPQ1BEf9V6G0YmIBf8jEI8Q+x8d/ZCLpGzJfiMd1h81eruelswPf
         oRkw==
X-Gm-Message-State: AC+VfDz8ajsFSEz4LYNdUNKVpFo8T1+mbAcmrV0GrEsBzmRVWhOvHtFv
        59E+aDOF3MzYSZClTnw7BeY+g/SyNzF2SceB2TNOyQ==
X-Google-Smtp-Source: ACHHUZ7bdeDqEKSO8uuf8TcSdZrCbpL1tSVPRVUVUmGf74rTT2eVhIui40uKYx4bjCTsIWoYlRWwreTsGzdE2XuIez0=
X-Received: by 2002:a1f:5fd2:0:b0:43f:8928:151c with SMTP id
 t201-20020a1f5fd2000000b0043f8928151cmr392643vkb.11.1685441625957; Tue, 30
 May 2023 03:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
In-Reply-To: <20230525021219.23638-1-yunfei.dong@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 30 May 2023 18:13:34 +0800
Message-ID: <CAGXv+5HLXiD10UV+Z-CTDrHQC16RFMYi6hsiGs3B0m4kgXkCZA@mail.gmail.com>
Subject: Re: [PATCH v5,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:12=E2=80=AFAM Yunfei Dong <yunfei.dong@mediatek.=
com> wrote:
>
> Need to change kernel driver to open decode and encode debug log at curre=
nt period,
> it's very unreasonable. Adding debugfs common interface to support decode=
 and encode,
> using echo command to control debug log level and getting useful informat=
ion for each
> instance.
>
> patch 1 add dbgfs common interface.
> patch 2~5 support decode.
> patch 6~7 support encode
> patch 8 add help function

I find the interface kind of weird. A lot of debugfs usage in other places
just dumps out the current state. Here you are writing to it to ask it to
do a snapshot, and then you read it later. This ends up requiring manual
management of a buffer, instead of using seq_file, which is commonly used
for virtual files.

ChenYu

> ---
> changed with v4:
> - rebase to the top of media stage header.
>
> changed with v3:
> - add help function for patch 8
> - remove append '\0' and enlarge buffer size for patch 4
>
> changed with v2:
> - using pr_debug and dev_dbg instead of pr_info for patch 2.
> - fix word fail: informatiaoin -> information for patch 3.
> - used to print each instance format information for patch 5.
>
> changed with v1:
> - add new patch 4 and 5.
> - using cmd 'cat vdec' to show debug information instead of pr_info direc=
tly.
> ---
> Yunfei Dong (8):
>   media: mediatek: vcodec: Add debugfs interface to get debug
>     information
>   media: mediatek: vcodec: Add debug params to control different log
>     level
>   media: mediatek: vcodec: Add a debugfs file to get different useful
>     information
>   media: mediatek: vcodec: Get each context resolution information
>   media: mediatek: vcodec: Get each instance format type
>   media: mediatek: vcodec: Change dbgfs interface to support encode
>   media: mediatek: vcodec: Add encode to support dbgfs
>   media: mediatek: vcodec: Add dbgfs help function
>
>  .../media/platform/mediatek/vcodec/Makefile   |   6 +
>  .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 216 ++++++++++++++++++
>  .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  72 ++++++
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   4 +
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   2 +
>  .../mediatek/vcodec/mtk_vcodec_util.c         |   8 +
>  .../mediatek/vcodec/mtk_vcodec_util.h         |  26 ++-
>  8 files changed, 335 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbg=
fs.c
>  create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbg=
fs.h
>
> --
> 2.25.1
>
