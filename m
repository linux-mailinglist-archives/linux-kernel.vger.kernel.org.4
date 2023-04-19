Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1556E73DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjDSHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjDSHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:19:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73346B1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:19:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a5so22638856ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681888778; x=1684480778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmiDYKhnrGjE/iF5nCOixO+clc1Eq1u8ptfYIu/KICs=;
        b=FXhTvMr4107+hdjyt0ToXeLPTOb1YahvG2e0E3ikdac2kVMt/N/DlkfsO5eGIgS0wu
         9D2g1KHaciwUtbz1qjbfl4BNU9Vv5RWDPdWFMdu3PcJGlWQQoReRyWfjTOJB7Jf/fdLC
         H25gSffdJY0zuuyr2edOD9NrdBQJzsOinBRx6+7loRrWQlcjrJiva9f+YVhg7iQ8Auxa
         fhtYSPrliv8U4mAE5UvRy59C5TS9+L4lcgtuw/aZeq7/4pevhI7Yc8eS5tNBvhNxrzR2
         zlVDjXFMy7ZOlKRC4cZ9HjeYTBX/O/moTdb5GKM5ZfnIDCFBcEHYh8OQzE0OGIAijewf
         VtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888778; x=1684480778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmiDYKhnrGjE/iF5nCOixO+clc1Eq1u8ptfYIu/KICs=;
        b=g4lZAcmzuXjx/nXEHs8H+zf9ivrbU2a4H3r29EMncGY07R7P/bkWUMcrpgbozLZgmj
         jhIbAe+EZRKdraq/bBgPRXiTxLNSxcN0sBDdr53lLgs37WdRFAxQXC3A/ykDelyagQRn
         QezYfHSK92oExDTGdcdusFGABCkPXmYhNcERh9ytMa2osVfNOg0aEPhc+JPXZ5PTuopw
         DF+0Y4XdZBAja2BonxZktoCAIhFuQxtzku2TdOIfSgMpuwU5FszcAJiIXSMl6Qa82l+T
         ZoRW9Sa6nXsOB5B40/WtFW8vpDVf7PxIhfjbksgPoB44qvikWlVU1hVjoD3gffxgzO4M
         cYMw==
X-Gm-Message-State: AAQBX9eTkAGk4mqhgqiTCVGy9cUPtnAuvWswGMTyjbVJ6xz3pp0Zilpq
        ZjQnLXNHuDqIlNxfkHlkEtfsecOI4x+5FmozOjKsiA==
X-Google-Smtp-Source: AKy350aeS8MlXw3mwInKS7I8rAM3DRXtOBDggcnQYsJa42CBmO7gh7SSzIT0lzlGEgXcGwh7qDFvWQwDa0h45Do5AR4=
X-Received: by 2002:a17:906:57c6:b0:87f:e5af:416e with SMTP id
 u6-20020a17090657c600b0087fe5af416emr6733144ejr.7.1681888778038; Wed, 19 Apr
 2023 00:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com> <20230418190101.696345-3-pranavpp@google.com>
In-Reply-To: <20230418190101.696345-3-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 09:19:27 +0200
Message-ID: <CAMGffE=UcmXeXb9DY5ApgCoE0tBtT=XaSB4n276FBwFYzrRYZQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] scsi: pm80xx: Enable init logging
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshat Jain <akshatzen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 9:01=E2=80=AFPM Pranav Prasad <pranavpp@google.com>=
 wrote:
>
> From: Akshat Jain <akshatzen@google.com>
>
> Enable init logging to debug drive discovery issues.
>
> Signed-off-by: Akshat Jain <akshatzen@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 2 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index d8dc629c0efb..041cdc41af80 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -44,7 +44,7 @@
>  #include "pm80xx_hwi.h"
>
>  static ulong logging_level =3D PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGIN=
G |
> -                                                        PM8001_EVENT_LOG=
GING;
> +                               PM8001_EVENT_LOGGING | PM8001_INIT_LOGGIN=
G;
>  module_param(logging_level, ulong, 0644);
>  MODULE_PARM_DESC(logging_level, " bits for enabling logging info.");
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index ce6a442d2418..61c1bf3d98a0 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4837,7 +4837,7 @@ static void mpi_set_phy_profile_req(struct pm8001_h=
ba_info *pm8001_ha,
>         payload.tag =3D cpu_to_le32(tag);
>         payload.ppc_phyid =3D
>                 cpu_to_le32(((operation & 0xF) << 8) | (phyid  & 0xFF));
> -       pm8001_dbg(pm8001_ha, INIT,
> +       pm8001_dbg(pm8001_ha, DISC,
>                    " phy profile command for phy %x ,length is %d\n",
>                    le32_to_cpu(payload.ppc_phyid), length);
>         for (i =3D length; i < (length + PHY_DWORD_LENGTH - 1); i++) {
> --
> 2.40.0.634.g4ca3ef3211-goog
>
