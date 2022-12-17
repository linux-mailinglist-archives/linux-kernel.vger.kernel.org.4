Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A464F77F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQEMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLQEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:12:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC0D124
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:12:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso8039782pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH65Lzu8yLs0gJVkepUjZHRstDYH/hcDoJoKZUFbNI0=;
        b=VZZXRW4I9PQi2pbj5Y12OzivoOtSdKGKXyCQxQ5m8NjibG+fHEtUA2GpOjdmFdZa64
         9D61uvDRarEr0gMPekNM40CsY+NrmD7+B17uPqk/8GZSIX1Y2RmlVAoZvYdzkoNVtmel
         WmYMFCrlJ/c2Qtd5viIPTqjrXsTJydcvKWbqI3Y3HUpiZsW4dwLAzdWRuzNryaUkSgqM
         YxxXX6VvD6PAeUuuXFdKuN5wPsuRNmtEpyqaiXskTWr9Jvj5wsvZYaIzDcxnnJf6w7T1
         yuZsRB9wsDNH1/1sttcJAkuO1RoTImQx6aznupM1NL9+lcffPNaM75Q/pmY2sIHsHPvU
         RTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH65Lzu8yLs0gJVkepUjZHRstDYH/hcDoJoKZUFbNI0=;
        b=7s29CBRAYoDG/S+D5yK4ojhxFo0l+jRnpIVYtNysaPr6UoBmM3QdunbwKKnZUjBm03
         rmHBp2CZZI2pZj+g5Sm+oxoL1TY/hM1S361Wp5B3+zS6WOly72e+UGDFf0wpIy4sBb1U
         pClE5e/+nGLtreKV0drvBx9r4Sw8DlfzptY/gM1xs6P/kn6E5sO1Q3uLlg6TWp9XZOpT
         YBNf3ZtXMQ21GV43D4bfuTGsCR0FzhHUliH+b+RF8GxDeJD1tHosld2PSkQo8YY4uYjn
         vRAZ210k185EvXBky7bDBC3uIJuKYIxIp+OHPnu/ZRrAAV/JsVKw7J31EnWfM/TUot7Z
         Spfg==
X-Gm-Message-State: AFqh2kpWn40xv6GoA8ez8RQVvV77ZXIN31tGIY5Nx61VsB2fdDu9I54K
        JHnal1TmBm0pCjDoMCXJu1zi1A==
X-Google-Smtp-Source: AMrXdXtScOu3J4nT9043wO0QBOelq5bzdWwUG+cutNdvKhhdIobOxSwAaEVxgtNIm61fBcfABSBw6g==
X-Received: by 2002:a17:902:a612:b0:18c:cde:fdda with SMTP id u18-20020a170902a61200b0018c0cdefddamr801217plq.37.1671250358215;
        Fri, 16 Dec 2022 20:12:38 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b00189adf6770fsm2383636pli.233.2022.12.16.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 20:12:37 -0800 (PST)
Date:   Fri, 16 Dec 2022 20:12:37 -0800 (PST)
X-Google-Original-Date: Fri, 16 Dec 2022 20:12:29 PST (-0800)
Subject:     Re: [PATCH v3 00/12] Allwinner A31/A83T CSI/ISP/MIPI CSI-2 media fixes
In-Reply-To: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
CC:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, yong.deng@magewell.com,
        paul.kocialkowski@bootlin.com, mchehab@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thomas.petazzoni@bootlin.com, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, Conor Dooley <conor@kernel.org>,
        nathan@kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     paul.kocialkowski@bootlin.com
Message-ID: <mhng-31391bb7-1a92-42f1-a1bb-8a41a9431ccb@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022 06:19:54 PST (-0800), paul.kocialkowski@bootlin.com wrote:
> This series resolves reported smatch warnings against the recently-introduced
> Allwinner A31/A83T CSI, ISP and MIPI CSI-2 drivers.
>
> Smatch was ran again on the updated tree and no longer shows any error or
> warning.

Thanks.  These also fix a handful of warnings I'm seeing when building 
with clang.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

> Changes since v2:
> - Added isp params pending buffer fix;
> - Added fixes tags where needed;
> - Reworded cosmetic commits;
> - Changed sunxi-isp to the proper sun6i-isp.
>
> Changes since v1:
> - Added fixes for static struct declarations;
> - Fixed ISP commit titles by replacing bridge with proc.
>
> Paul
>
> Paul Kocialkowski (12):
>   media: sun6i-csi: bridge: Fix return code handling in stream off path
>   media: sun6i-csi: bridge: Error out on invalid port to fix warning
>   media: sunxi-csi: bridge: Declare subdev ops as static
>   media: sun6i-csi: capture: Remove useless ret initialization
>   media: sun6i-mipi-csi2: Clarify return code handling in stream off
>     path
>   media: sun8i-a83t-mipi-csi2: Clarify return code handling in stream
>     off path
>   media: sun6i-isp: proc: Fix return code handling in stream off path
>   media: sun6i-isp: proc: Error out on invalid port to fix warning
>   media: sun6i-isp: proc: Declare subdev ops as static
>   media: sun6i-isp: capture: Fix uninitialized variable use
>   media: sun6i-isp: params: Fix incorrect indentation
>   media: sun6i-isp: params: Unregister pending buffer on cleanup
>
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c | 8 ++++----
>  .../media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c    | 2 +-
>  .../platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c      | 5 ++---
>  .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c     | 5 ++---
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c | 4 ++--
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c  | 6 ++++--
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 8 ++++----
>  7 files changed, 19 insertions(+), 19 deletions(-)
