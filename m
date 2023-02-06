Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097168C787
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBFUUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjBFUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:20:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8722BEE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:19:52 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id dt8so10814796oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsphjXkBI0H4ZtiynXrY+CUNXqadHKIdr07YXKhwtfE=;
        b=YXK1qFlepuupaxVP9x9mjLfXiDnmGMOvZsuRb0hoTLfq5WG6ZXqiDa04ySEr2vqpk9
         ZF65v0IvW9FA7g3tVwvxFIQ//7YLS+08w79hN02qd/UcUDeqgusRse2b+IKqUwjYGobi
         1Aqq41lrZGlOd8hnLM/ydHHLA668W8RjuI9tMa3D4Mf8gLTAtnCHvQiz7cnMclU3oRqs
         HFT7q48YHsHn5tyDUfC5M9amABgZLO0nsTF+YPdrhwrgEHA5JlxGYGrETDEyAz8Obl5P
         wytUHzUpnxshM3KdrkPqE9nkqskrkN2xl6g9mUR2ZaVMidRaaT0zCMVZp2IYz3VmHDOO
         chRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsphjXkBI0H4ZtiynXrY+CUNXqadHKIdr07YXKhwtfE=;
        b=uo+0FoAdk5HCUzeLQhvXuO7/nEfNfps7kel9IgJ57WSBW6Is4TMu0QJWzFuDWAjz6L
         RhpXZvemPR/hom5pnTrBvn1cIKuEDYvIOtXtbtdum/7qQXsd33xalT4Fe3ABmsj6WzAG
         kUWHapfatwWDjhSdjXG1j3bYpZLwYCE8Lsugrt57ZTqHTcwbDcofJapVetH7QpSNpXar
         VjbFXtCbAvfLTNSG1e23tBNKdyxIUwaFIBKtZDPMKE8YSky7IKG9RzQvuo5BeipzKMRc
         g26uTmqAW54mliR5qDGPfe9jzb1djSzisYCnoARVhS6l+0N2Qv24QxO3ZwVgd1qShwlL
         S/7g==
X-Gm-Message-State: AO0yUKXOG2uVriaxpwxOHGTAd/fit0w4qbxBCKwESzOP7iX7nUjYaksT
        jGqxMgcwuTDH1QVkbqncEENU/W/nFvZvPLgra2Q=
X-Google-Smtp-Source: AK7set+WPrOO0zrrwk4j2nVGXXhYKvVx98ndm/QUyGFVed5o9F7zj7oMb9r+YqcaGbMDbsjcmb6ZpDLGQB7AfbYBIAU=
X-Received: by 2002:a05:6808:6242:b0:378:4edd:a89c with SMTP id
 dt2-20020a056808624200b003784edda89cmr1267118oib.46.1675714788680; Mon, 06
 Feb 2023 12:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20230204032735.22509-1-rdunlap@infradead.org>
In-Reply-To: <20230204032735.22509-1-rdunlap@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Feb 2023 15:19:37 -0500
Message-ID: <CADnq5_Ma+0pPtUP5CRpQUyh2NwMyz91D1-L-J5OwRAf9Ty5PXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add complete header search path
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Signed-off-by : Sung Joon Kim" <sungkim@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Feb 3, 2023 at 10:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The path for the "mod_info_packet.h" header file is
> incomplete, so add its location to the header search path
> in the amdgpu Makefile.
>
> See on ARCH=3Dalpha (275 times in one build).
>
> In file included from ../drivers/gpu/drm/amd/amdgpu/amdgpu.h:90,
>                  from ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:43:
> ../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:62:10: fat=
al error: mod_info_packet.h: No such file or directory
>    62 | #include "mod_info_packet.h"
>       |          ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> Fixes: 5b49da02ddbe ("drm/amd/display: Enable Freesync over PCon")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Signed-off-by: Sung Joon Kim <sungkim@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgp=
u/Makefile
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -34,6 +34,7 @@ ccflags-y :=3D -I$(FULL_AMD_PATH)/include/
>         -I$(FULL_AMD_PATH)/acp/include \
>         -I$(FULL_AMD_DISPLAY_PATH) \
>         -I$(FULL_AMD_DISPLAY_PATH)/include \
> +       -I$(FULL_AMD_DISPLAY_PATH)/modules/inc \
>         -I$(FULL_AMD_DISPLAY_PATH)/dc \
>         -I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
>         -I$(FULL_AMD_PATH)/amdkfd
