Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8016E73D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDSHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjDSHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:18:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6D2D71
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:17:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fw30so26378554ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681888670; x=1684480670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFvKyaHMANQ4s9e2g5olWLh3w6JZhJRx0VG71h2yN1M=;
        b=O3GeSm8ppsQyRnsOXpkqBXhHcWwQRioQbUhPgtXiEYbj+MPlq4oBACsFpJYFBLphf9
         7q+/NRdnImD2kwNkcJtz0Jsmw1iT0FW0KEqmU4QNBYNBM7pDzg3B0HKYxTp6JUDCfWs5
         xAdvthiq+axqqmaGzAwkgvZyYqy8Vx7BhCJ6zUtoMGQjtcbUepPdcaGuOK/1bCX+kQr4
         si4PDExpkx56TaGPnXgzNUI6o/WJuZqTW1hZyYOHaKsTDiqFFO1rknVnt+nO7n1I5Rt7
         Et4Z66zWaSP+TtEaQtvc2wfEf13lRocc7GqgpG2YwOLU7+gOFGYIlhuMghr98BLiPn2W
         1Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888670; x=1684480670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFvKyaHMANQ4s9e2g5olWLh3w6JZhJRx0VG71h2yN1M=;
        b=Rl/zqhKAmBrtTBJMEqOk7lK4mbqhwiAjs59hSHZhRBuFXYfMX4JGnkZKpgCKQtaG51
         kMRi18zFzMPsab7IF89wYXhK63p2Dh+9erXZQWBKtmOw7pZCP2lC8dMqk0wQDU1/6LAB
         OMOvbKA9Ujm9RCBH3N9W+UiiKwjen142IO0lbh4Dd3d5EhvUH3sas6/JoNPEOU6laoBF
         PPLvOE9SaxDMEK6NDboT0H/H3ef5UOe7pRJoV3vCTYRPE+GBtpNRvweU665uJ6u5RRWI
         GnTxPl49xDDGvrX1iyMXJZ+HXDTlJyBC0aTKIxJpQuYrhOrfo4ivYaqvsGzVKqskQ/8w
         yXKg==
X-Gm-Message-State: AAQBX9doYV5Hw01LS6fxYy3tM9TAMmsyULQmI9eD/BemUtyD8dTDly24
        w4txBGCve+3Q1NmpMNsyQkZ8g02v4gw149cS/nL7Q+zFCJYMlaNa
X-Google-Smtp-Source: AKy350aDC7yrMRJ+cEZ8JXpk6kYAS92X8XeuuaXzNIJm753wMdv6xhPjYK2LugTiNGMZJQPIHTQMiAhtCewrAeZ9e8o=
X-Received: by 2002:a17:906:490b:b0:94e:ee60:ee61 with SMTP id
 b11-20020a170906490b00b0094eee60ee61mr5717725ejq.7.1681888669644; Wed, 19 Apr
 2023 00:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com> <20230418190101.696345-2-pranavpp@google.com>
In-Reply-To: <20230418190101.696345-2-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 09:17:38 +0200
Message-ID: <CAMGffEmyVPFr5LGR4DsF4SAvuYyA=s4Y3kZdzrxHePtbNF7xzw@mail.gmail.com>
Subject: Re: [PATCH 1/6] scsi: pm80xx: Log some HW events by default
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
        autolearn=ham autolearn_force=no version=3.4.6
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
> Log the following hw_event logs under EVENT log severity
> to help debug disk issues:
>   HW_EVENT_LINK_ERR_INVALID_DWORD
>   HW_EVENT_LINK_ERR_DISPARITY_ERROR
>   HW_EVENT_LINK_ERR_CODE_VIOLATION
>   HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH
>   HW_EVENT_LINK_ERR_PHY_RESET_FAILED
>   HW_EVENT_INBOUND_CRC_ERROR
>   HW_EVENT_PHY_ERROR
>   HW_EVENT_SAS_PHY_UP
>   HW_EVENT_SATA_PHY_UP
>   HW_EVENT_SATA_SPINUP_HOLD
>   HW_EVENT_PHY_DOWN
>   HW_EVENT_PORT_INVALID
>   HW_EVENT_MALFUNCTION
>   HW_EVENT_PORT_RESET_TIMER_TMO
>   HW_EVENT_PORT_RECOVERY_TIMER_TMO
>   HW_EVENT_HARD_RESET_RECEIVED
>   HW_EVENT_ID_FRAME_TIMEOUT
>   HW_EVENT_PORT_RECOVER
>
> Signed-off-by: Akshat Jain <akshatzen@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c |  3 +-
>  drivers/scsi/pm8001/pm8001_sas.h  |  1 +
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 72 ++++++++++++++++++++-----------
>  3 files changed, 50 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index 7e589fe3e010..d8dc629c0efb 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -43,7 +43,8 @@
>  #include "pm8001_chips.h"
>  #include "pm80xx_hwi.h"
>
> -static ulong logging_level =3D PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGIN=
G;
> +static ulong logging_level =3D PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGIN=
G |
> +                                                        PM8001_EVENT_LOG=
GING;
>  module_param(logging_level, ulong, 0644);
>  MODULE_PARM_DESC(logging_level, " bits for enabling logging info.");
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm800=
1_sas.h
> index dc1f4d958e03..953572fc0d9e 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -71,6 +71,7 @@
>  #define PM8001_DEV_LOGGING     0x80 /* development message logging */
>  #define PM8001_DEVIO_LOGGING   0x100 /* development io message logging *=
/
>  #define PM8001_IOERR_LOGGING   0x200 /* development io err message loggi=
ng */
> +#define PM8001_EVENT_LOGGING   0x400 /* HW event logging */
>
>  #define pm8001_info(HBA, fmt, ...)                                     \
>         pr_info("%s:: %s %d: " fmt,                                     \
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index 9584cadc4201..ce6a442d2418 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3425,26 +3425,31 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>         switch (eventType) {
>
>         case HW_EVENT_SAS_PHY_UP:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_START_STATUS\n")=
;
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_SAS_PHY_UP phyid:%#x\n", phy_id);
>                 hw_event_sas_phy_up(pm8001_ha, piomb);
>                 break;
>         case HW_EVENT_SATA_PHY_UP:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_SATA_PHY_UP\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_SATA_PHY_UP phyid:%#x\n", phy_id);
>                 hw_event_sata_phy_up(pm8001_ha, piomb);
>                 break;
>         case HW_EVENT_SATA_SPINUP_HOLD:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_SATA_SPINUP_HOLD\n")=
;
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x\n", phy_i=
d);
>                 sas_notify_phy_event(&phy->sas_phy, PHYE_SPINUP_HOLD,
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_PHY_DOWN:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_DOWN\n");
> +               pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_DOWN phyid:%#x=
\n",
> +                          phy_id);
>                 hw_event_phy_down(pm8001_ha, piomb);
>                 phy->phy_attached =3D 0;
>                 phy->phy_state =3D PHY_LINK_DISABLE;
>                 break;
>         case HW_EVENT_PORT_INVALID:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_INVALID\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PORT_INVALID phyid:%#x\n", phy_id);
>                 sas_phy_disconnected(sas_phy);
>                 phy->phy_attached =3D 0;
>                 sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
> @@ -3463,7 +3468,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_PHY_ERROR:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_ERROR\n");
> +               pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_ERROR phyid:%#=
x\n",
> +                          phy_id);
>                 sas_phy_disconnected(&phy->sas_phy);
>                 phy->phy_attached =3D 0;
>                 sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_ERROR, GFP_A=
TOMIC);
> @@ -3477,34 +3483,39 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_LINK_ERR_INVALID_DWORD:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_LINK_ERR_INVALID_DWORD\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x\n",
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_INVALID_DWORD, port_id, phy_id,=
 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_DISPARITY_ERROR:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_LINK_ERR_DISPARITY_ERROR\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x\n=
",
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_DISPARITY_ERROR,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_CODE_VIOLATION:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_LINK_ERR_CODE_VIOLATION\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x\n"=
,
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_CODE_VIOLATION,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%=
#x\n",
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_MALFUNCTION:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_MALFUNCTION\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_MALFUNCTION phyid:%#x\n", phy_id);
>                 break;
>         case HW_EVENT_BROADCAST_SES:
>                 pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_BROADCAST_SES\n");
> @@ -3515,25 +3526,29 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_INBOUND_CRC_ERROR:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_INBOUND_CRC_ERROR\n"=
);
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x\n", phy_=
id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_INBOUND_CRC_ERROR,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_HARD_RESET_RECEIVED:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_HARD_RESET_RECEIVED\=
n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_HARD_RESET_RECEIVED phyid:%#x\n", ph=
y_id);
>                 sas_notify_port_event(sas_phy, PORTE_HARD_RESET, GFP_ATOM=
IC);
>                 break;
>         case HW_EVENT_ID_FRAME_TIMEOUT:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_ID_FRAME_TIMEOUT\n")=
;
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_ID_FRAME_TIMEOUT phyid:%#x\n", phy_i=
d);
>                 sas_phy_disconnected(sas_phy);
>                 phy->phy_attached =3D 0;
>                 sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_LINK_ERR_PHY_RESET_FAILED:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_LINK_ERR_PHY_RESET_FAILED\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x\=
n",
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_PHY_RESET_FAILED,
>                         port_id, phy_id, 0, 0);
> @@ -3543,7 +3558,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_PORT_RESET_TIMER_TMO:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RESET_TIMER_TMO=
\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x\n",
> +                          phy_id);
>                 if (!pm8001_ha->phy[phy_id].reset_completion) {
>                         pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PH=
Y_DOWN,
>                                 port_id, phy_id, 0, 0);
> @@ -3560,8 +3577,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 }
>                 break;
>         case HW_EVENT_PORT_RECOVERY_TIMER_TMO:
> -               pm8001_dbg(pm8001_ha, MSG,
> -                          "HW_EVENT_PORT_RECOVERY_TIMER_TMO\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x\n"=
,
> +                          phy_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_PORT_RECOVERY_TIMER_TMO,
>                         port_id, phy_id, 0, 0);
> @@ -3575,11 +3593,15 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                 }
>                 break;
>         case HW_EVENT_PORT_RECOVER:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RECOVER\n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PORT_RECOVER phyid:%#x port_id:%#x\n=
",
> +                          phy_id, port_id);
>                 hw_event_port_recover(pm8001_ha, piomb);
>                 break;
>         case HW_EVENT_PORT_RESET_COMPLETE:
> -               pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RESET_COMPLETE\=
n");
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_i=
d:%#x\n",
> +                          phy_id, port_id);
>                 if (pm8001_ha->phy[phy_id].reset_completion) {
>                         pm8001_ha->phy[phy_id].port_reset_status =3D
>                                         PORT_RESET_SUCCESS;
> --
> 2.40.0.634.g4ca3ef3211-goog
>
