Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E46CCF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC2B3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC2B3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:29:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8310CE;
        Tue, 28 Mar 2023 18:29:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c29so18190060lfv.3;
        Tue, 28 Mar 2023 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680053360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2ZBooKTdQvtfMVgnhuwabyGyb9Yl38IXe8xsUOWjvo=;
        b=d4fhJHyxuZd/FESgSXv9Frj/cenBy44pnYyeOw6RdevGJ5hGaZW/JaUKicQuOjfQOE
         lCFsXByYHdquLzahDpeA9QnmeJRC/76MAFuAQBWNxTkCto6ZEbFMlFaTXVgxVwCLvJdr
         vI0Ew3Yq1RMj9N4S9cwC8mTDEFH0zAEZCs1SLQBKU9qjVSCR1jTJhsatv1aViAD00iVo
         5YXTcgKAzr9Kcd6PIErZ9uEOVZDoIbNeOJM0b2DPfQ+y/r384xf9aCRghXNbB+zEh20p
         iQIQDm99H0+EKSe+VgCyRu49TSaD23kIXzf1smy0JdsLYMj4ED/HwuUZvcoUApeH1UJl
         GxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680053360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2ZBooKTdQvtfMVgnhuwabyGyb9Yl38IXe8xsUOWjvo=;
        b=vbVxTqAHVM7uXdDHxB26MQC0H6/yrWtBZRS+W1DdEiS1Afl2b8BShr2P6qITFZhErX
         M5dHIzpia/7/ql5vRzSTisCR9Ha2IO5EVjowsTqIlz1QQXUmaOBczum5w7o5ogh0Dglh
         3Mb7GGGNGOyzE9HdInzErrFkBwBkQJFix/D1MSGzS4DpIv2N1jNt90U7SjHbWkcgJ9ZG
         +yiH/dQXAhhMt/1NWyB4UlW3OawAfT3HFSR7Q3xcsgo4c3Med+iT0zvuEROJBO5dtBoN
         sJg9xiEqlxHkVtdGQdZHoxa7IGREVz7GXFQstLY9Oegdu6OGlnMyw4ncR5ASFu/djaMK
         GoJA==
X-Gm-Message-State: AAQBX9elGQd3PGVYPbzbk/4WkljT/4TEsOL1JMIC7ngY3dHJtnrnxmic
        Msz76v1Cflw+rzvc/x1WQUTiZP3ArEQKDQ3KMw==
X-Google-Smtp-Source: AKy350ZzQ6gSicsuEON4vupXM9weznZXLCWciRrzvubMbpNb8S+dfZUJ6rBtuCKYkjhWaPvZQDMOOlwbKf0pYa1EDys=
X-Received: by 2002:ac2:5322:0:b0:4eb:93a:41f0 with SMTP id
 f2-20020ac25322000000b004eb093a41f0mr3975535lfh.4.1680053359417; Tue, 28 Mar
 2023 18:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230328103000.10757-1-powen.kao@mediatek.com>
In-Reply-To: <20230328103000.10757-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 29 Mar 2023 09:29:07 +0800
Message-ID: <CAGaU9a8DyCrUWxYRC=SZ0Qv95qXZPr-dBZGhGfp3xNxB=V4eSA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a module parameter
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Powen,

On Tue, Mar 28, 2023 at 6:38=E2=80=AFPM Po-Wen Kao <powen.kao@mediatek.com>=
 wrote:
>
> A dedicated queue for dev commands is not mandatory, hence let
> UFS_MCQ_NUM_DEV_CMD_QUEUES become module parameter `dev_cmd_queues`
> to allow sharing first hw queue for dev commands.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 35 +++++++++++++++++++++++++++-------
>  drivers/ufs/core/ufshcd-priv.h |  2 +-
>  drivers/ufs/core/ufshcd.c      |  2 +-
>  3 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
