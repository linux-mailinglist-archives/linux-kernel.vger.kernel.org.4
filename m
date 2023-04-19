Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC96E73F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjDSHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjDSHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:24:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BF93F6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:24:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz19so22142580ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681889041; x=1684481041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT8Jk+Q1oe4Or0rVlwyWbkhZaKRcjvjsHJPUOPgMY7A=;
        b=eZOiRWA9Iw5i704gEkABxvCumIn63JFENnqRll0Q5cJN7ReAM2eokQkl5HB8GvM3O6
         pXDtBuOcxyRoSBTZ9hvaCx9+pVlEh5Ctomdo0G9azOZ978+7QqUQdjpA2OYd5UzX1+4P
         1v2A4yLBXLFK/n+ZPeLV/CGEZs3yB0l/iBdeM03kIhCd2j1LPKOet87Vq/qHr8lT9y4C
         Ld3BFKev0wvy/tpStzuC1+BVrIsq6HpR1iLNs1vP2EgdIx6mL4SZQcfRxQoWn+PX4WnG
         /LO1HvGd175i3dTC+LdWcTN1+rTuVQhfGEWtURBtUmimH3ev9HPynm0Fgahz5E1QSref
         PAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889041; x=1684481041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT8Jk+Q1oe4Or0rVlwyWbkhZaKRcjvjsHJPUOPgMY7A=;
        b=QH8epJuZzJoSXKh+aZUX1c9cDfck2obSi7AwYuuqLaOuP5CiqQHjH0Q4ljGoaiB5eF
         xZzbXBgDSdp3XFPcsCW743a4haSrjhgbwRWwBecdBjjJdRqZa47b03NSb3k30gJH/UcW
         5ogroz+TW7xHzT7+H4NoCgiYENAb0Plv5b0dfV7WXRciY6Lm20LS3Wuqsog37iECvGUm
         isyLIN72ajXA44oupdVm4QhyrMhcVq2KZIu10cAcKyI5F269AJGKQHDaZXruAnUNgV0j
         ujjSsZsLwRiMiKdkyqVE2PoLalInEaClh+tggZYzkw0f1tJDwDC99yI01IZvVn2k7Yha
         g1ZQ==
X-Gm-Message-State: AAQBX9crRebvrmuhe9il2fDpXEJa6figk9p13yyZQmY0B4VSKfH77m7/
        cQelCoPD2Xov9fAFcnhJN9cZN0UoJ3XK7OKeb/ODEA==
X-Google-Smtp-Source: AKy350bAS4psUzmugDKa6JnijhbwC5HyRinp9RUV8fy4gFjAR7dGN1DKBmVuFLVVmv8wGe0/jJIHL4VgcY16oftwd24=
X-Received: by 2002:a17:906:3e09:b0:93d:1b82:3c13 with SMTP id
 k9-20020a1709063e0900b0093d1b823c13mr6676209eji.7.1681889041594; Wed, 19 Apr
 2023 00:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com> <20230418190101.696345-7-pranavpp@google.com>
In-Reply-To: <20230418190101.696345-7-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 09:23:50 +0200
Message-ID: <CAMGffE=GTV+bkUB-nfKBTdvrGB77W7c_HjHUd60PAe0d+h9OVA@mail.gmail.com>
Subject: Re: [PATCH 6/6] scsi: pm80xx: Update PHY state after hard reset
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
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
> From: Changyuan Lyu <changyuanl@google.com>
>
> Update phy_attached, phy_state, and port_state to correct values
> after a hard rest. Without this patch, after a successful hard reset,
typo, s/rest/reset
> phy_attached is still 0, as a result, any following hard reset will
> cause a PHY START to be issued first.
>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index 85908068b8d7..39a12ee94a72 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3417,6 +3417,7 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>         u8 port_id =3D (u8)(lr_status_evt_portid & 0x000000FF);
>         u8 phy_id =3D
>                 (u8)((phyid_npip_portstate & 0xFF0000) >> 16);
> +       u8 portstate =3D (u8)(phyid_npip_portstate & 0x0000000F);
>         u16 eventType =3D
>                 (u16)((lr_status_evt_portid & 0x00FFFF00) >> 8);
>         u8 status =3D
> @@ -3449,7 +3450,6 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 break;
>         case HW_EVENT_PHY_DOWN:
>                 hw_event_phy_down(pm8001_ha, piomb);
> -               phy->phy_attached =3D 0;
>                 phy->phy_state =3D PHY_LINK_DISABLE;
>                 break;
>         case HW_EVENT_PORT_INVALID:
> @@ -3567,14 +3567,15 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                 break;
>         case HW_EVENT_PORT_RESET_TIMER_TMO:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_=
id:%#x\n",
> -                          phy_id, port_id);
> +                          "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_=
id:%#x portstate:%#x\n",
> +                          phy_id, port_id, portstate);
>                 if (!pm8001_ha->phy[phy_id].reset_completion) {
>                         pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PH=
Y_DOWN,
>                                 port_id, phy_id, 0, 0);
>                 }
>                 sas_phy_disconnected(sas_phy);
>                 phy->phy_attached =3D 0;
> +               port->port_state =3D portstate;
>                 sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
>                         GFP_ATOMIC);
>                 if (pm8001_ha->phy[phy_id].reset_completion) {
> @@ -3608,14 +3609,17 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                 break;
>         case HW_EVENT_PORT_RESET_COMPLETE:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_i=
d:%#x\n",
> -                          phy_id, port_id);
> +                          "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_i=
d:%#x portstate:%#x\n",
> +                          phy_id, port_id, portstate);
>                 if (pm8001_ha->phy[phy_id].reset_completion) {
>                         pm8001_ha->phy[phy_id].port_reset_status =3D
>                                         PORT_RESET_SUCCESS;
>                         complete(pm8001_ha->phy[phy_id].reset_completion)=
;
>                         pm8001_ha->phy[phy_id].reset_completion =3D NULL;
>                 }
> +               phy->phy_attached =3D 1;
> +               phy->phy_state =3D PHY_STATE_LINK_UP_SPCV;
> +               port->port_state =3D portstate;
>                 break;
>         case EVENT_BROADCAST_ASYNCH_EVENT:
>                 pm8001_dbg(pm8001_ha, MSG, "EVENT_BROADCAST_ASYNCH_EVENT\=
n");
> --
> 2.40.0.634.g4ca3ef3211-goog
>
