Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B06E73DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjDSHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjDSHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:20:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2902D71
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:20:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so616748766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681888838; x=1684480838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJcntuwwe2SP29QWBZhBcUE5jivh5ClCO9WQk/TRMmk=;
        b=eYMfDmP4ThJnbPeg97Erxq5LuciJLYHyv6fZD5bSBwZmUZGclXvNJfAyamiq5bMTTi
         yJ7ZJeyMhMcc7b7ASLaBq068mGqb7gHgcNIIyFNmBByvdnJRPh9ASh6Cao4jgPSJGu3R
         VbeKrNqkRNk5NA6sKkYVfzz1pbciauMWUSkTu9y24BkGzMw7agg5lFulxPWl4UOzHUbn
         7yOb95XPRf8eADQxHOI73LO8GkFlJAOtdZeGXWVHqoOTvXub7RrMLoA/ZTcZyHZ1sv6v
         CrtSgqrReBQlb1QE4qAnWHqVaYECN44NJHHvnGlDQqT5C+STHHTsOjtjVKD92auhEFtd
         TnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888838; x=1684480838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJcntuwwe2SP29QWBZhBcUE5jivh5ClCO9WQk/TRMmk=;
        b=dkhL7Ngx02hHsCHXVrbMyb4iVq7rBn4bOvVfzNrNklN6Cjv5LGtAUffT9dDpTUFOlt
         wkVGmYv54CsNdKZaqPuZ7bDOfBxUUGqDsOoae096WjodAzz/AXv23Jt4+m/r1RdzjqG3
         z1b/rXdtAHWQbuTPBkhMQEJ3Gl1SvfuERh1SWhZzQ2WXonhKqD6bBa4y79shHBC3FW6O
         t5vBm/xNxQVW7SkOXFBKDP5fpk6z9yfl1rfTlAbCe/tx3MBeCdLRIRjjbLvGcw+Ehx63
         Vqfh7UVYn5VXRY6LhebNz7SLRL0gMciiednIZ02gVWHPpktbIQyvngEiegahSu4xdS/O
         3T/Q==
X-Gm-Message-State: AAQBX9dQiEuhk6IcU8BFlTJaizuOsnU9JfwillQfCPuZNd64Svp+EISa
        IksAEa+OXnWdplxOHuKjKYvuA2oDiq9Wsizokv3b6A==
X-Google-Smtp-Source: AKy350Yn5BfRcOoKw3PIsnnxn6m9JY7DXzourrCIPe14OWIurxS8EmQGkRXuRBcrHpgdbk2euUOOGty2XXQBJK8zHXk=
X-Received: by 2002:a50:9e2a:0:b0:504:8548:ab47 with SMTP id
 z39-20020a509e2a000000b005048548ab47mr2115175ede.0.1681888838611; Wed, 19 Apr
 2023 00:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com> <20230418190101.696345-4-pranavpp@google.com>
In-Reply-To: <20230418190101.696345-4-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 09:20:27 +0200
Message-ID: <CAMGffEnEaKCPCnMH1kJHbWZqomOLZNQvXs7vjBGEq-1PQQxFAw@mail.gmail.com>
Subject: Re: [PATCH 3/6] scsi: pm80xx: Print port_id in HW events
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
> Log port_id and phy_id along with the PHY_UP event.
>
> Signed-off-by: Akshat Jain <akshatzen@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 58 ++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index 61c1bf3d98a0..c5bf65d0ad14 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3426,30 +3426,35 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>
>         case HW_EVENT_SAS_PHY_UP:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_SAS_PHY_UP phyid:%#x\n", phy_id);
> +                          "HW_EVENT_SAS_PHY_UP phyid:%#x port_id:%#x\n",
> +                          phy_id, port_id);
>                 hw_event_sas_phy_up(pm8001_ha, piomb);
>                 break;
>         case HW_EVENT_SATA_PHY_UP:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_SATA_PHY_UP phyid:%#x\n", phy_id);
> +                          "HW_EVENT_SATA_PHY_UP phyid:%#x port_id:%#x\n"=
,
> +                          phy_id, port_id);
>                 hw_event_sata_phy_up(pm8001_ha, piomb);
>                 break;
>         case HW_EVENT_SATA_SPINUP_HOLD:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x\n", phy_i=
d);
> +                          "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x port_id:%=
#x\n",
> +                          phy_id, port_id);
>                 sas_notify_phy_event(&phy->sas_phy, PHYE_SPINUP_HOLD,
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_PHY_DOWN:
> -               pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_DOWN phyid:%#x=
\n",
> -                          phy_id);
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x\n",
> +                          phy_id, port_id);
>                 hw_event_phy_down(pm8001_ha, piomb);
>                 phy->phy_attached =3D 0;
>                 phy->phy_state =3D PHY_LINK_DISABLE;
>                 break;
>         case HW_EVENT_PORT_INVALID:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_PORT_INVALID phyid:%#x\n", phy_id);
> +                          "HW_EVENT_PORT_INVALID phyid:%#x port_id:%#x\n=
",
> +                          phy_id, port_id);
>                 sas_phy_disconnected(sas_phy);
>                 phy->phy_attached =3D 0;
>                 sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
> @@ -3468,8 +3473,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                         GFP_ATOMIC);
>                 break;
>         case HW_EVENT_PHY_ERROR:
> -               pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_ERROR phyid:%#=
x\n",
> -                          phy_id);
> +               pm8001_dbg(pm8001_ha, EVENT,
> +                          "HW_EVENT_PHY_ERROR phyid:%#x port_id:%#x\n",
> +                          phy_id, port_id);
>                 sas_phy_disconnected(&phy->sas_phy);
>                 phy->phy_attached =3D 0;
>                 sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_ERROR, GFP_A=
TOMIC);
> @@ -3484,31 +3490,31 @@ static int mpi_hw_event(struct pm8001_hba_info *p=
m8001_ha, void *piomb)
>                 break;
>         case HW_EVENT_LINK_ERR_INVALID_DWORD:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x\n",
> -                          phy_id);
> +                          "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x por=
t_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_INVALID_DWORD, port_id, phy_id,=
 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_DISPARITY_ERROR:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x\n=
",
> -                          phy_id);
> +                          "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x p=
ort_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_DISPARITY_ERROR,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_CODE_VIOLATION:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x\n"=
,
> -                          phy_id);
> +                          "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x po=
rt_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_CODE_VIOLATION,
>                         port_id, phy_id, 0, 0);
>                 break;
>         case HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%=
#x\n",
> -                          phy_id);
> +                          "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%=
#x port_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH,
>                         port_id, phy_id, 0, 0);
> @@ -3527,7 +3533,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 break;
>         case HW_EVENT_INBOUND_CRC_ERROR:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x\n", phy_=
id);
> +                          "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x port_id:=
%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_INBOUND_CRC_ERROR,
>                         port_id, phy_id, 0, 0);
> @@ -3547,8 +3554,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 break;
>         case HW_EVENT_LINK_ERR_PHY_RESET_FAILED:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x\=
n",
> -                          phy_id);
> +                          "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x =
port_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_LINK_ERR_PHY_RESET_FAILED,
>                         port_id, phy_id, 0, 0);
> @@ -3559,8 +3566,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 break;
>         case HW_EVENT_PORT_RESET_TIMER_TMO:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x\n",
> -                          phy_id);
> +                          "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_=
id:%#x\n",
> +                          phy_id, port_id);
>                 if (!pm8001_ha->phy[phy_id].reset_completion) {
>                         pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PH=
Y_DOWN,
>                                 port_id, phy_id, 0, 0);
> @@ -3578,8 +3585,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 break;
>         case HW_EVENT_PORT_RECOVERY_TIMER_TMO:
>                 pm8001_dbg(pm8001_ha, EVENT,
> -                          "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x\n"=
,
> -                          phy_id);
> +                          "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x po=
rt_id:%#x\n",
> +                          phy_id, port_id);
>                 pm80xx_hw_event_ack_req(pm8001_ha, 0,
>                         HW_EVENT_PORT_RECOVERY_TIMER_TMO,
>                         port_id, phy_id, 0, 0);
> @@ -3613,8 +3620,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
>                 pm8001_dbg(pm8001_ha, MSG, "EVENT_BROADCAST_ASYNCH_EVENT\=
n");
>                 break;
>         default:
> -               pm8001_dbg(pm8001_ha, DEVIO, "Unknown event type 0x%x\n",
> -                          eventType);
> +               pm8001_dbg(pm8001_ha, DEVIO,
> +                          "Unknown event portid:%d phyid:%d event:0x%x s=
tatus:0x%x\n",
> +                          port_id, phy_id, eventType, status);
>                 break;
>         }
>         return 0;
> --
> 2.40.0.634.g4ca3ef3211-goog
>
