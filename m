Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D256E0769
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjDMHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDMHMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:12:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4110DA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:12:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-947abd74b10so569740466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681369929; x=1683961929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrU1/6FGBsaWkU0MemRZM16XuJhnrKXnokW32u+b/8E=;
        b=NNBai9c0FfGQ7Pqe1/1ahr3+l0IvNDRecIXEod0aoafOJmtm47IKfbefuklf/CZyT0
         NkCUCcCjeIUXuqQtYmUejBgEUOAoZqpgRMfBAC7sExW40nFvhG0BF7O3vs2zG+Q2HunD
         O9Zmmvn3405rHnETAvL4NrZz1nlDp4jLSfx90cd5cEa6W/PN/i1KMvwfJTDr7u7UTtZO
         1WNg32cOqnc2ZcpAvs/vB5mW7JT4zHOD2IzspUH8qcG4TLzjJHqPR9qGf+fT/HDXw+BK
         QfvYHQ7svNAKr/AhWI7b8wnUTSP/Npfnhe+kYmbYpXuCwKHPDs3hUWokJVQ0YowTszwv
         7sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681369929; x=1683961929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrU1/6FGBsaWkU0MemRZM16XuJhnrKXnokW32u+b/8E=;
        b=RwEXprKRSKuq6oYc/nrPGn6AeOjw8tJA9eVAO/dzBn9Oi1jaITopwjsq054/P4kLoX
         lIb2cUxw/H3SXO9tSKZ783H/shxcaFPw6I/UzWM4rivznhY3AkaiHRe9TAXCj0LlfNJG
         rJCAdvgTlMEu8ZpY+qHkdQgnO9iyYVR80EVocSanRNcTtxry/lIm3cwePHU2Rof/Pl3T
         ZuhZoj1dkpmfhWhNVOGAptPPTxCcOByaxNt5D0fSoeWkVpt+ojLO+CLgbX0DtjID9nUd
         Mq8aazANzcDmXxeWNSdesArjde5CviZMXdC+QFhizmCZi2LErMUqfpqKXcHmfyss1brS
         nZQQ==
X-Gm-Message-State: AAQBX9f2Jkg30WjzDBrL6/mJuHi8adKfU30ghxTMxjpbILkEW+Eiy5NX
        kuVhaOzzrtsaQAU7vjrJtOuD1yquWfFeR9sxeU5StQ==
X-Google-Smtp-Source: AKy350ZftQl1aqhbZHw5kLHiPZlGEfdDqLKFlBkihfsQ7Brgi/yfddSGyZ0OzqKGnS96WZjPEBlMLh+/FI8meNL4qEM=
X-Received: by 2002:a50:cd55:0:b0:504:fcf5:63ee with SMTP id
 d21-20020a50cd55000000b00504fcf563eemr686408edj.0.1681369929622; Thu, 13 Apr
 2023 00:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230411230650.1760757-1-pranavpp@google.com>
In-Reply-To: <20230411230650.1760757-1-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 13 Apr 2023 09:11:58 +0200
Message-ID: <CAMGffEmrHRJjRLiMAsq0K43JcN571Es9xg=wtr=CO-j1ts_SRA@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: Log device registration
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 1:09=E2=80=AFAM Pranav Prasad <pranavpp@google.com>=
 wrote:
>
> From: Akshat Jain <akshatzen@google.com>
>
> Log combination of phy_id and device_id in device registration
> response.
>
> Signed-off-by: Akshat Jain <akshatzen@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm800=
1_hwi.c
> index ec1a9ab61814..73cd25f30ca5 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -3362,8 +3362,9 @@ int pm8001_mpi_reg_resp(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>         pm8001_dev =3D ccb->device;
>         status =3D le32_to_cpu(registerRespPayload->status);
>         device_id =3D le32_to_cpu(registerRespPayload->device_id);
> -       pm8001_dbg(pm8001_ha, MSG, " register device is status =3D %d\n",
> -                  status);
> +       pm8001_dbg(pm8001_ha, INIT,
> +                  "register device status %d phy_id 0x%x device_id %d\n"=
,
> +                  status, pm8001_dev->attached_phy, device_id);
>         switch (status) {
>         case DEVREG_SUCCESS:
>                 pm8001_dbg(pm8001_ha, MSG, "DEVREG_SUCCESS\n");
> @@ -4278,7 +4279,7 @@ int pm8001_chip_dereg_dev_req(struct pm8001_hba_inf=
o *pm8001_ha,
>         memset(&payload, 0, sizeof(payload));
>         payload.tag =3D cpu_to_le32(1);
>         payload.device_id =3D cpu_to_le32(device_id);
> -       pm8001_dbg(pm8001_ha, MSG, "unregister device device_id =3D %d\n"=
,
> +       pm8001_dbg(pm8001_ha, INIT, "unregister device device_id %d\n",
>                    device_id);
>
>         return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> --
> 2.40.0.577.gac1e443424-goog
>
