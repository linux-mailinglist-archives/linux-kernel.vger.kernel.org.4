Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF64A74B543
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGGQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGGQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:49:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B6170C;
        Fri,  7 Jul 2023 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688748539; x=1689353339; i=ps.report@gmx.net;
 bh=csl0iN16S1kj209ggK5Nbq3nfKA/lS3+hLfRHOD42FQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=rel/qP9zUqwkWQ1rI/CKKkuxavS4MXgXeT3Pmj6HYlByuLKEg4XYb4+nGGS6XbStlTl+N7g
 FRTlX16/X/KjsH7GxzUombvAc5BxwQi9riP4kXiD6TR5Z4YdpMznDwo/CHkvTLubNqFF1ILfo
 eTbJDoWw9AH9rAbwapBJgQ/WiiVcmT16gEvPxnd8g7NZk4C7eoPwhj1fHhs1KysC3bHdv+pE+
 I1VBq+s0NYKFypgsrdwSJsmfPVWNov7Vd5hdCJIRonIK31fbeCCgUheUv1Mo9CW6alaaKNkvb
 ygUTPII8PnWB7mUFZSUihRha6iNYGONvTWOst4C65K01K5rE8yUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.208.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1qeaXw1nVL-00MxCE; Fri, 07
 Jul 2023 18:48:59 +0200
Date:   Fri, 7 Jul 2023 18:48:58 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, Markus Marb <marm@hms-networks.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        socketcan@hms-networks.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers
Message-ID: <20230707184858.5ee50636@gmx.net>
In-Reply-To: <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
References: <20230522200144.15949-1-ps.report@gmx.net>
 <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WLAw1z4Lk46sw3hRK3zkK1+W1000QxAWn/FwenDGXOz++yUcgIF
 isqqNz5ZzDVV7r67loJr27w6+mIoNyzvDKymgLMKE4vcFrZzOsux2CISCK3SguEpLdG1qVM
 Mfk693cynK4aByPOeDgu2tOfo8GsjDebmZBkVajkaHDPurv6VtIZ3J7sBsRaKrwYTq7KWRV
 jjv1tUMuw/Kcr50hiacpg==
UI-OutboundReport: notjunk:1;M01:P0:X4OzaeCQKso=;12e33clPknig22kyOs7h5tmps72
 EATGaIrDNZ+IcRxFaYBdGvqUTG/pxVZbF61K1VwFGEEmu2K3qfv/sEGTLFVjlKfS0ywArxq8G
 EHLm3K0gIwWOJ9/C/DDmRh6U0iDz0OlrZYY9wRbXqmaYWlC+U2ZgKZ1LbScJr+bdCyAqBUIUU
 Unt4CvQeJsdT5AgdPSN4k2yCLWRFJ6NlgaurTSHNswSCccebqo0qPYwKQ4nVdDfRV+KCV8A50
 9csbmjAa+hEZHdC6vgBlZvXBfM+ESdFUGMQ0MZHU3ht8ykqThosHuxQIbah3O/nVd8bE09u7Y
 ENAFt507cNOyeVv08Mybb1PJkVGS4j+W9d/5TsRlXRukE5GWC74pYiajt+dYxt4bGR1cVl+JY
 phANwVAuYy/RR2q4f7EDetVZun7gsRNyKaOxy3SHI1oXA829kg+E0VE6rAX1CtZnmmWQ39R58
 cTH+qaLxZft/U+e1fgFFPOZK9wbBP/GYnRKXXUdratUBaw5+6oFUdO32m0TLpMTu+jb8LAuiT
 DeQ0YLg3rjrJpHez1lJ/vvdSRFmQu00+I3GeQh3vPYg7PX2RafArfF6NJGa3GSCjoH2aNvK4+
 q+noKCcV7IN1ps3MC83hW3nhnKTO48bXZTHmWsHf8IVZCxM60QqhzoeS0ExvRgnE8HEXGEbBE
 eh+lwpSZ0oTWao3PkYs1uTMBlHk+Q8Ch8Qi4DCh5opzzPt3+c1Fl0ooZ1Yget/1eJQpm3p9nf
 /gDcrOiXT+eOLm+h/xzUgHdJsYd5pLTjjoyNpAw04Wk5vwSUIUDt2d5JMHi5EI+rJPUnmq7By
 PGIizOL8ZeVgfgp3vBNOpPoEsRMRQdncR8jSsycVoheE9ynCH9ar0k+MPIWrfcok0t9/T+M3A
 1sbBJ8FtNsGLbp3kVLbs8kNi7p7gbK8Zf02CFY2FVNRd7d2G6kLN+Axc2ed//KOIe512jX1Ep
 6Stc+voHRlv3o09WUBCyUGJEDQo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

- removed Florian Ferg <flfe@hms-networks.de> from CC
- added Markus Marb <marm@hms-networks.de> to CC

On Wed, 31 May 2023 16:25:50 +0900, Vincent Mailhol <vincent.mailhol@gmail.=
com> wrote:

> Hi Florian,
>=20
> Here is another batch of comments.
>=20
> On Tue. 23 May 2023 at 05:02, Peter Seiderer <ps.report@gmx.net> wrote:
> > From: Florian Ferg <flfe@hms-networks.de>
> >
> > This patch adds the driver for the IXXAT USB-to-CAN interfaces. There
> > is an adapter for the older communication layer cl1 and another
> > adapter for the newer communication layer cl2.
> >
> > Signed-off-by: Florian Ferg <flfe@hms-networks.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> > Changes v1 -> v7 (Florian Ferg <flfe@hms-networks.de>):
> >   - for detailed history see
> >     https://codeberg.org/psreport/socketcan-linux-ix-usb-can
> >
> > Changes v7 -> v8 (Marc Kleine-Budde <mkl@pengutronix.de>)
> >   - port to recent net-next
> >
> > Changes v8 -> v9 (Peter Seiderer <ps.report@gmx.net>)
> >   Addressed review comments by Vincent Mailhol:
> >   - update copyright headers (use SPDX identifier 'GPL-2.0-only'
> >     instead of 'GPL-2.0', remove full GPL boilerplate)
> >   - reorder includes (lexicographic order)
> >   - remove IXXAT_USB_MODES defines (move modes directly in the
> >     declaration of structs)
> >   - remove bittiming defines (move directly in declaration of structs)
> >   - remove _EP1_IN/_EP1_OUT defines (move directly in declaration of st=
ructs)
> >   - remove rcv_size/snd_size vars (use sizeof(*cmd) and sizeof(cmd->res=
) directly)
> >   - use GENMASK/FIELD_PREP (IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK/IXXAT_USB=
_CAN_BTR1_TIME_SEG2_MASK)
> >   - update dev_err/netdev_err (use %pe, remove 'Error:' prefix)
> >   - use U32_MAX instead of 0x00000000FFFFFFFF
> >   - do not increase the rx_bytes count when receiving a remove frame
> >   - ixxat_can_msg_cl1/ixxat_can_msg_cl2 use union __le32 status
> >   - do not increase the statistics for error frames
> >   - do not use parenthesis in log messages
> >   - remove double brackets (sparse workaround for struct init)
> >   - fill netdev->ethtool_ops with default
> >   - fill netdev->dev_port
> >   - use FIELD_GET/FIELD_PREP instead of IXXAT_USB_DECODE_DLC/IXXAT_USB_=
ENCODE_DLC
> >   - use driver_info intead of open coded ixxat_usb_get_adapter
> >  Addressed checkpatch.pl warnings:
> >   - change MODULE_LICENSE to 'GPL' - checkpatch.pl WARNING: Prefer "GPL=
" over "GPL v2"
> > ---
> >  drivers/net/can/usb/Kconfig                   |   17 +
> >  drivers/net/can/usb/Makefile                  |    1 +
> >  drivers/net/can/usb/ixxat_usb/Makefile        |    2 +
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  100 ++
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  176 +++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 1277 +++++++++++++++++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  511 +++++++
> >  7 files changed, 2084 insertions(+)
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
> >
> > diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> > index 58fcd2b34820..b50706f2a5e6 100644
> > --- a/drivers/net/can/usb/Kconfig
> > +++ b/drivers/net/can/usb/Kconfig
> > @@ -62,6 +62,23 @@ config CAN_GS_USB
> >           choose Y for built in support,
> >           M to compile as module (module will be named: gs_usb).
> >
> > +config CAN_IXXAT_USB
> > +       tristate "IXXAT USB-to-CAN interfaces"
> > +       help
> > +         This driver adds support for IXXAT USB-to-CAN devices.
> > +
> > +         The driver provides support for the following devices:
> > +           - IXXAT USB-to-CAN compact
> > +           - IXXAT USB-to-CAN embedded
> > +           - IXXAT USB-to-CAN professional
> > +           - IXXAT USB-to-CAN automotive
> > +           - IXXAT USB-to-CAN FD compact
> > +           - IXXAT USB-to-CAN FD professional
> > +           - IXXAT USB-to-CAN FD automotive
> > +           - IXXAT USB-to-CAN FD MiniPCIe
> > +           - IXXAT USB-to-CAR
> > +           - IXXAT CAN-IDM101
> > +
> >  config CAN_KVASER_USB
> >         tristate "Kvaser CAN/USB interface"
> >         help
> > diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> > index 8b11088e9a59..52b4cc66ff30 100644
> > --- a/drivers/net/can/usb/Makefile
> > +++ b/drivers/net/can/usb/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_ESD_USB) +=3D esd_usb.o
> >  obj-$(CONFIG_CAN_ETAS_ES58X) +=3D etas_es58x/
> >  obj-$(CONFIG_CAN_F81604) +=3D f81604.o
> >  obj-$(CONFIG_CAN_GS_USB) +=3D gs_usb.o
> > +obj-$(CONFIG_CAN_IXXAT_USB) +=3D ixxat_usb/
> >  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb/
> >  obj-$(CONFIG_CAN_MCBA_USB) +=3D mcba_usb.o
> >  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> > diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/u=
sb/ixxat_usb/Makefile
> > new file mode 100644
> > index 000000000000..125d2705979f
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_CAN_IXXAT_USB) +=3D ixxat_usb2can.o
> > +ixxat_usb2can-y =3D ixxat_usb_cl1.o ixxat_usb_cl2.o ixxat_usb_core.o
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/ne=
t/can/usb/ixxat_usb/ixxat_usb_cl1.c
> > new file mode 100644
> > index 000000000000..cfd95ff722cd
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + */
> > +
> > +#include <linux/can/dev.h>
> > +#include <linux/kernel.h>
> > +#include <linux/usb.h>
> > +
> > +#include "ixxat_usb_core.h"
> > +
> > +#define IXXAT_USB_CLOCK 8000000 =20
>=20
>=20
> Nitpick, use the MEGA suffix for linux/units.h
>=20
>   #define IXXAT_USB_CLOCK (8 * MEGA /* Hz */)
>=20

O.k.

> > +#define IXXAT_USB_BUFFER_SIZE_RX 512
> > +#define IXXAT_USB_BUFFER_SIZE_TX 256
> > +
> > +#define IXXAT_USB_BTMODE_TSM_CL1 0x80
> > +
> > +#define IXXAT_USB_CAN_CMD_INIT 0x325
> > +
> > +#define IXXAT_USB_CAN_BTR0_BRP_MASK GENMASK(5, 0)
> > +#define IXXAT_USB_CAN_BTR0_SJW_MASK GENMASK(7, 6)
> > +
> > +#define IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK GENMASK(3, 0)
> > +#define IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK GENMASK(6, 4)
> > +
> > +static const struct can_bittiming_const usb2can_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D 1,
> > +       .tseg1_max =3D 16,
> > +       .tseg2_min =3D 1,
> > +       .tseg2_max =3D 8,
> > +       .sjw_max =3D 4,
> > +       .brp_min =3D 1,
> > +       .brp_max =3D 64,
> > +       .brp_inc =3D 1,
> > +};
> > +
> > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const struct can_bittiming *bt =3D &dev->can.bittiming;
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_init_cl1_cmd *cmd;
> > +       u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STAN=
DARD;
> > +       u8 btr0 =3D FIELD_PREP(IXXAT_USB_CAN_BTR0_BRP_MASK, bt->brp - 1=
) |
> > +               FIELD_PREP(IXXAT_USB_CAN_BTR0_SJW_MASK, bt->sjw - 1);
> > +       u8 btr1 =3D FIELD_PREP(IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK, bt->p=
rop_seg + bt->phase_seg1 - 1) |
> > +               FIELD_PREP(IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK, bt->phase=
_seg2 - 1); =20
>=20
> Remove those opmode, btr0 and btr1 variables and directly assign the
> values to cmd->opmode, cmd->btr0 and cmd->btr1.
>=20
> The issue here is that the use of these variables get scattered for no re=
ason.
>=20
> For example, opmode is initialised just above...
>=20

O.k.

> > +       cmd =3D kmalloc(sizeof(*cmd), GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> > +               btr1 |=3D IXXAT_USB_BTMODE_TSM_CL1;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > +               opmode |=3D IXXAT_USB_OPMODE_ERRFRAME;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               opmode |=3D IXXAT_USB_OPMODE_LISTONLY; =20
>=20
> ... then specific flags get assigned here in the middle of the function .=
..
>=20
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(sizeof(*cmd) - sizeof(cmd->res));
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->mode =3D opmode; =20
>=20
> ... and finally, you assign it here.
>=20
> Instead of having the pieces of code scattered in three places, you could=
 do:
>=20
>           cmd->mode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STAN=
DARD;
>           if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>                   cmd->opmode |=3D IXXAT_USB_OPMODE_ERRFRAME;
>           if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>                    cmd->opmode |=3D IXXAT_USB_OPMODE_LISTONLY;
>=20
> in one single block of code. This is easier to read because now I do
> not have to look at different places to understand what the function
> does with that opmode.
>=20
> This comment applies to other functions as well. There are many uses
> of intermediate variables which could easily be omitted.
>=20
> > +       cmd->btr0 =3D btr0;
> > +       cmd->btr1 =3D btr1;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, sizeof(*cmd), =
&cmd->res,
> > +                                sizeof(cmd->res));
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +const struct ixxat_usb_adapter usb2can_cl1 =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &usb2can_bt,
> > +       .btd =3D NULL,
> > +       .modes =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_BERR_REPORTING=
 |
> > +               CAN_CTRLMODE_LISTENONLY,
> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               1 | USB_DIR_IN,
> > +               2 | USB_DIR_IN,
> > +               3 | USB_DIR_IN,
> > +               4 | USB_DIR_IN,
> > +               5 | USB_DIR_IN,
> > +       },
> > +       .ep_msg_out =3D {
> > +               1 | USB_DIR_OUT,
> > +               2 | USB_DIR_OUT,
> > +               3 | USB_DIR_OUT,
> > +               4 | USB_DIR_OUT,
> > +               5 | USB_DIR_OUT,
> > +       },
> > +       .ep_offs =3D 0,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/ne=
t/can/usb/ixxat_usb/ixxat_usb_cl2.c
> > new file mode 100644
> > index 000000000000..268544f52f1e
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + */
> > +
> > +#include <linux/can/dev.h>
> > +#include <linux/kernel.h>
> > +#include <linux/usb.h>
> > +
> > +#include "ixxat_usb_core.h"
> > +
> > +#define IXXAT_USB_CLOCK 80000000 =20
>=20
> Nitpick, use the MEGA suffix for linux/units.h
>=20

O.k.

>   #define IXXAT_USB_CLOCK (80 * MEGA /* Hz */)
>=20
> > +#define IXXAT_USB_BUFFER_SIZE_RX 512
> > +#define IXXAT_USB_BUFFER_SIZE_TX 512
> > +
> > +#define IXXAT_USB_CAN_CMD_INIT 0x337
> > +
> > +static const struct can_bittiming_const usb2can_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D 1,
> > +       .tseg1_max =3D 256,
> > +       .tseg2_min =3D 1,
> > +       .tseg2_max =3D 256,
> > +       .sjw_max =3D 128,
> > +       .brp_min =3D 2,
> > +       .brp_max =3D 513, =20
>=20
> 513 is really uncommon. Are you sure this isn't 512?
>=20

Question for socketcan@hms-networks.de and/or Markus Marb?

> > +       .brp_inc =3D 1,
> > +};
> > +
> > +static const struct can_bittiming_const usb2can_btd =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D 1,
> > +       .tseg1_max =3D 256,
> > +       .tseg2_min =3D 1,
> > +       .tseg2_max =3D 256,
> > +       .sjw_max =3D 128,
> > +       .brp_min =3D 2,
> > +       .brp_max =3D 513, =20
>=20
> Idem.
>=20
> > +       .brp_inc =3D 1,
> > +};
> > +
> > +static const struct can_bittiming_const canidm_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D 1,
> > +       .tseg1_max =3D 256,
> > +       .tseg2_min =3D 1,
> > +       .tseg2_max =3D 128,
> > +       .sjw_max =3D 128,
> > +       .brp_min =3D 1,
> > +       .brp_max =3D 512,
> > +       .brp_inc =3D 1
> > +};
> > +
> > +static const struct can_bittiming_const canidm_btd =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D 1,
> > +       .tseg1_max =3D 32,
> > +       .tseg2_min =3D 1,
> > +       .tseg2_max =3D 16,
> > +       .sjw_max =3D 8,
> > +       .brp_min =3D 1,
> > +       .brp_max =3D 32,
> > +       .brp_inc =3D 1
> > +};
> > +
> > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const struct can_bittiming *bt =3D &dev->can.bittiming;
> > +       const struct can_bittiming *btd =3D &dev->can.data_bittiming;
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_init_cl2_cmd *cmd;
> > +       u32 btmode =3D IXXAT_USB_BTMODE_NAT;
> > +       u8 exmode =3D 0;
> > +       u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STAN=
DARD;
> > +
> > +       cmd =3D kmalloc(sizeof(*cmd), GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> > +               btmode =3D IXXAT_USB_BTMODE_TSM;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > +               opmode |=3D IXXAT_USB_OPMODE_ERRFRAME;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               opmode |=3D IXXAT_USB_OPMODE_LISTONLY;
> > +       if (dev->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_=
ISO)) {
> > +               exmode |=3D IXXAT_USB_EXMODE_EXTDATA | IXXAT_USB_EXMODE=
_FASTDATA;
> > +
> > +               if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
> > +                       exmode |=3D IXXAT_USB_EXMODE_ISOFD;
> > +       }
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(sizeof(*cmd) - sizeof(cmd->res));
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->opmode =3D opmode;
> > +       cmd->exmode =3D exmode;
> > +       cmd->sdr.mode =3D cpu_to_le32(btmode);
> > +       cmd->sdr.bps =3D cpu_to_le32(bt->brp); =20
>=20
> The BPS (bitrate per second) and the BRP (bitrate prescaler) are two
> different things. I am not sure how this is supposed to work.
>

I believe a 'simple' name mismatch, the documentation
'VCI V4 C-CanFD Software Design Guide English.pdf' chapter
'6.2.1 CANBTB' states:

	dwBPS [out] Transmitting rate in bits per second. If in field dwMode the
		bit CAN_BTMODE_RAW is set, the hardware specific value for the
		baud rate prescaler register is expected here. If not, the bit
		rate in bits per second is expected.

And some lines above 'CAN_BTMODE_RAW: Native mode', seems to correspond
with 'u32 btmode =3D IXXAT_USB_BTMODE_NAT;' here..., would prefer to keep
the register name of the documentation, can add an comment here...


> > +       cmd->sdr.ts1 =3D cpu_to_le16(bt->prop_seg + bt->phase_seg1);
> > +       cmd->sdr.ts2 =3D cpu_to_le16(bt->phase_seg2);
> > +       cmd->sdr.sjw =3D cpu_to_le16(bt->sjw);
> > +       cmd->sdr.tdo =3D 0;
> > +
> > +       if (exmode) {
> > +               cmd->fdr.mode =3D cpu_to_le32(btmode);
> > +               cmd->fdr.bps =3D cpu_to_le32(btd->brp);
> > +               cmd->fdr.ts1 =3D cpu_to_le16(btd->prop_seg + btd->phase=
_seg1);
> > +               cmd->fdr.ts2 =3D cpu_to_le16(btd->phase_seg2);
> > +               cmd->fdr.sjw =3D cpu_to_le16(btd->sjw);
> > +               cmd->fdr.tdo =3D cpu_to_le16(btd->brp * (btd->phase_seg=
1 + 1 +
> > +                                                      btd->prop_seg));
> > +       }
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, sizeof(*cmd), =
&cmd->res,
> > +                                sizeof(cmd->res));
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +const struct ixxat_usb_adapter usb2can_cl2 =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &usb2can_bt,
> > +       .btd =3D &usb2can_btd,
> > +       .modes =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> > +               CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
> > +               CAN_CTRLMODE_FD_NON_ISO, =20
>=20
> Does your device allow you to send and receive Classical CAN frames
> with DLC greater than 8? c.f. CAN_CTRLMODE_CC_LEN8_DLC
>=20
>   https://elixir.bootlin.com/linux/v6.3/source/include/uapi/linux/can/net=
link.h#L103
>=20

Will test it (or try to find it out from the available documentation, but a=
ddress
it with an add-on patch in case)...

> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               1 | USB_DIR_IN,
> > +               2 | USB_DIR_IN,
> > +               3 | USB_DIR_IN,
> > +               4 | USB_DIR_IN,
> > +               5 | USB_DIR_IN
> > +       },
> > +       .ep_msg_out =3D {
> > +               1 | USB_DIR_OUT,
> > +               2 | USB_DIR_OUT,
> > +               3 | USB_DIR_OUT,
> > +               4 | USB_DIR_OUT,
> > +               5 | USB_DIR_OUT,
> > +       },
> > +       .ep_offs =3D 1,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > +
> > +const struct ixxat_usb_adapter can_idm =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &canidm_bt,
> > +       .btd =3D &canidm_btd,
> > +       .modes =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> > +               CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
> > +               CAN_CTRLMODE_FD_NON_ISO,
> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               2 | USB_DIR_IN,
> > +               4 | USB_DIR_IN,
> > +               6 | USB_DIR_IN,
> > +               8 | USB_DIR_IN,
> > +               10 | USB_DIR_IN,
> > +       },
> > +       .ep_msg_out =3D {
> > +               1 | USB_DIR_OUT,
> > +               3 | USB_DIR_OUT,
> > +               5 | USB_DIR_OUT,
> > +               7 | USB_DIR_OUT,
> > +               9 | USB_DIR_OUT,
> > +       },
> > +       .ep_offs =3D 0,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/n=
et/can/usb/ixxat_usb/ixxat_usb_core.c
> > new file mode 100644
> > index 000000000000..8787d27a3886
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> > @@ -0,0 +1,1277 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + */
> > +
> > +#include <linux/can/dev.h>
> > +#include <linux/ethtool.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/module.h>
> > +#include <linux/usb.h>
> > +
> > +#include "ixxat_usb_core.h"
> > +
> > +MODULE_AUTHOR("Marcel Schmidt <socketcan@hms-networks.de>");
> > +MODULE_DESCRIPTION("CAN driver for IXXAT USB-to-CAN / CAN FD adapters"=
);
> > +MODULE_LICENSE("GPL");
> > +
> > +/* Table of devices that work with this driver */
> > +static const struct usb_device_id ixxat_usb_table[] =3D {
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_COMPACT_PRODUCT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl1, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_EMBEDDED_PRODUCT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl1, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_PROFESSIONAL_PRODUCT_=
ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl1, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_AUTOMOTIVE_PRODUCT_ID=
),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl1, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_COMPACT_PRODUCT_ID=
),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl2, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PROFESSIONAL_PRODU=
CT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl2, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_AUTOMOTIVE_PRODUCT=
_ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl2, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PCIE_MINI_PRODUCT_=
ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl2, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAR_PRODUCT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&usb2can_cl2, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM101_PRODUCT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&can_idm, },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM200_PRODUCT_ID),
> > +         .driver_info =3D (kernel_ulong_t)&can_idm, },
> > +       { } /* Terminating entry */
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, ixxat_usb_table);
> > +
> > +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
> > +                        struct ixxat_usb_dal_res *res)
> > +{
> > +       req->size =3D cpu_to_le32(sizeof(*req));
> > +       req->port =3D cpu_to_le16(0xffff); =20
>=20
> U16_MAX. Alternatively, if this value has a semantic meaning, declare
> it as a #define. Something like that:
>=20
>   #define IXXAT_USB_PORT_UNDEF U16_MAX
>=20
> > +       req->socket =3D cpu_to_le16(0xffff); =20
>=20
> Same.
>=20
> > +       req->code =3D cpu_to_le32(0);
> > +
> > +       res->res_size =3D cpu_to_le32(sizeof(*res));
> > +       res->ret_size =3D cpu_to_le32(0);
> > +       res->code =3D cpu_to_le32(0xffffffff); =20
>=20
> Same but with U32_MAX.

O.k. (without the semantic defines as not used anywhere else in the code)

>=20
> > +}
> > +
> > +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *r=
eq, =20
>                                                                   ^^^^^^^=
^^
>=20
> If you declare some of the arguments as const, follow the logic until
> the end. As far as I can see, req is constant.

O.k. (in case you meant 'void * const req' - const pointer)

Otherwise with 'const void *req' - pointer to const value - gives a compile
warning later on (seems usb_control_msg is not yet const ready):

  drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c:76:67: warning: passing ar=
gument 7 of =E2=80=98usb_control_msg=E2=80=99 discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
     76 |           ret =3D usb_control_msg(dev, scp, rq, rto, port, 0, req=
, req_size,
        |                                                             ^~~

>=20
>   int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, const
> void *req,
>=20
> > +                      const u16 req_size, void *res, const u16 res_siz=
e)
> > +{
> > +       const int to =3D msecs_to_jiffies(IXXAT_USB_MSG_TIMEOUT);
> > +       const u8 rq =3D 0xff; =20
>=20
> Here you have req as a parameter and rq as a variable. The names are
> too similar (both are an abbreviation of request) and this can be
> misleading. Try to be consistent within your different functions.
> Instead of "req", use for example "cmd".

O.k.

>=20
> > +       const u8 rti =3D USB_TYPE_VENDOR | USB_DIR_IN;
> > +       const u8 rto =3D USB_TYPE_VENDOR | USB_DIR_OUT;
> > +       int i;
> > +       int pos =3D 0;
> > +       int rcp =3D usb_rcvctrlpipe(dev, 0);
> > +       int scp =3D usb_sndctrlpipe(dev, 0);
> > +       int ret =3D 0;
> > +       struct ixxat_usb_dal_res *dal_res =3D res;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
> > +               ret =3D usb_control_msg(dev, scp, rq, rto, port, 0, req=
, req_size,
> > +                                     to);
> > +               if (ret < 0)
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (ret < 0) {
> > +               dev_err(&dev->dev, "TX command failure: %pe\n", ERR_PTR=
(ret));
> > +               goto fail;
> > +       }
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
> > +               const int rs =3D res_size - pos;
> > +               void *rb =3D res + pos;
> > +
> > +               ret =3D usb_control_msg(dev, rcp, rq, rti, port, 0, rb,=
 rs, to);
> > +               if (ret < 0) {
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +                       continue;
> > +               }
> > +
> > +               pos +=3D ret;
> > +               if (pos < res_size)
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (pos !=3D res_size)
> > +               ret =3D -EBADMSG;
> > +
> > +       if (ret < 0) {
> > +               dev_err(&dev->dev, "RX command failure: %pe\n", ERR_PTR=
(ret));
> > +               goto fail;
> > +       }
> > +
> > +       ret =3D le32_to_cpu(dal_res->code);
> > +
> > +fail:
> > +       return ret;
> > +}
> > +
> > +static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u32 =
ts_now)
> > +{
> > +       u32 *ts_dev =3D &dev->time_ref.ts_dev_0;
> > +       ktime_t *kt_host =3D &dev->time_ref.kt_host_0;
> > +       u64 timebase =3D (u64)U32_MAX - (u64)(*ts_dev) + (u64)ts_now;
> > +
> > +       *kt_host =3D ktime_add_us(*kt_host, timebase);
> > +       *ts_dev =3D ts_now;
> > +}
> > +
> > +static void ixxat_usb_get_ts_tv(struct ixxat_usb_device *dev, u32 ts,
> > +                               ktime_t *k_time)
> > +{
> > +       ktime_t tmp_time =3D dev->time_ref.kt_host_0;
> > +
> > +       if (ts < dev->time_ref.ts_dev_last)
> > +               ixxat_usb_update_ts_now(dev, ts);
> > +
> > +       dev->time_ref.ts_dev_last =3D ts;
> > +       tmp_time =3D ktime_add_us(tmp_time, ts - dev->time_ref.ts_dev_0=
);
> > +
> > +       if (k_time)
> > +               *k_time =3D tmp_time;
> > +}
> > +
> > +static void ixxat_usb_set_ts_now(struct ixxat_usb_device *dev, u32 ts_=
now)
> > +{
> > +       dev->time_ref.ts_dev_0 =3D ts_now;
> > +       dev->time_ref.kt_host_0 =3D ktime_get_real();
> > +       dev->time_ref.ts_dev_last =3D ts_now;
> > +}
> > +
> > +static int ixxat_usb_get_dev_caps(struct usb_device *dev,
> > +                                 struct ixxat_dev_caps *dev_caps)
> > +{
> > +       int i;
> > +       int err;
> > +       struct ixxat_usb_caps_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd); =20
>=20
> As a global comment, those *_size variables do not have a strong
> purpose. Using directly sizeof(*cmd) in the code is unambiguous and
> concise enough. This comment applies to other functions as well.
>=20
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size; =20
>=20
> Here, one thing you could do is:
>=20
> #define IXXAT_USB_RCV_SIZE(cmd) (sizeof(*cmd) + sizeof(cmd->req))

Did you mean:

#define IXXAT_USB_RCV_SIZE(cmd) (sizeof(*cmd) - sizeof(cmd->req))

>=20
> and then use IXXAT_USB_RCV_SIZE(cmd) in place of rcv_size in your code.
>=20

O.k.

> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +       u16 num_ctrl;
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVCAPS);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       if (err)
> > +               goto fail;
> > +       dev_caps->bus_ctrl_count =3D cmd->caps.bus_ctrl_count;
> > +       num_ctrl =3D le16_to_cpu(dev_caps->bus_ctrl_count);
> > +       if (num_ctrl > ARRAY_SIZE(dev_caps->bus_ctrl_types)) {
> > +               err =3D -EINVAL;
> > +               goto fail;
> > +       }
> > +
> > +       for (i =3D 0; i < num_ctrl; i++)
> > +               dev_caps->bus_ctrl_types[i] =3D cmd->caps.bus_ctrl_type=
s[i];
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_get_dev_info(struct usb_device *dev,
> > +                                 struct ixxat_dev_info *dev_info)
> > +{
> > +       int err;
> > +       struct ixxat_usb_info_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd);
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size;
> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVINFO);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       if (err)
> > +               goto fail; =20
>=20
> This goto label is used only once. You can directly return here:
>=20
>           if (err) {
>                   kfree(cmd);
>                   return err;
>           }
>=20

Seems to be a matter of taste (or style) because of the
duplicated 'kfree(cmd)' call below..., but will change it
in the next patch version...

> > +       if (dev_info) {
> > +               memcpy(dev_info->device_id, &cmd->info.device_id,
> > +                      sizeof(cmd->info.device_id));
> > +               memcpy(dev_info->device_name, &cmd->info.device_name,
> > +                      sizeof(cmd->info.device_name));
> > +               dev_info->device_fpga_version =3D cmd->info.device_fpga=
_version;
> > +               dev_info->device_version =3D cmd->info.device_version;
> > +       }
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;

And here:

	kfree(cmd);
	return 0;

> > +}
> > +
> > +static int ixxat_usb_start_ctrl(struct ixxat_usb_device *dev, u32 *tim=
e_ref)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_start_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd);
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size;
> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_START);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +       cmd->time =3D 0;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       if (err)
> > +               goto fail;
> > +
> > +       if (time_ref) =20
>=20
> I do not think this if () is needed. All the callers of
> ixxat_usb_start_ctrl() pass a valid pointer.
>=20

O.k.

> > +               *time_ref =3D le32_to_cpu(cmd->time); =20
>=20
> I do not get the logic. cmd is not modified by ixxat_usb_send_cmd(),
> right? So, here, cmd->time would still be zero. Am I missing
> something?

With

	struct ixxat_usb_start_cmd {
        	struct ixxat_usb_dal_req req;
        	struct ixxat_usb_dal_res res;
        	__le32 time;
	} __packed;

here and

	rcv_size =3D sizeof(*cmd) - sizeof(cmd->req);

the call to

	ixxat_usb_send_cmd(..., &cmd->res, rcv_size);

will write/receive to res and time...

>=20
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_stop_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_stop_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->action =3D cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_power_ctrl(struct usb_device *dev, u8 mode)
> > +{
> > +       int err;
> > +       struct ixxat_usb_power_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_POWER);
> > +       cmd->mode =3D mode;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_reset_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_dal_cmd *cmd;
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_RESET);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static void ixxat_usb_stop_queue(struct ixxat_usb_device *dev) =20
>=20
> The name is misleading. This does way more than just stopping the
> queue. You should use some keywords such as kill or free in this
> function name.
>=20
> Also, considering you do not have a ixxat_usb_start_queue(), it may be
> better to move netif_stop_queue(netdev) out of this function and call
> it separately.
>=20

Did take a look at it (and at what other driver do), but need more time
to investigate...

> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       u32 i;
> > +
> > +       netif_stop_queue(netdev);
> > +       usb_kill_anchored_urbs(&dev->rx_submitted);
> > +       usb_kill_anchored_urbs(&dev->tx_submitted);
> > +       atomic_set(&dev->active_tx_urbs, 0);
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               if (dev->tx_contexts[i].echo_index !=3D IXXAT_USB_MAX_T=
X_URBS) {
> > +                       can_free_echo_skb(netdev, i, NULL);
> > +                       dev->tx_contexts[i].echo_index =3D IXXAT_USB_MA=
X_TX_URBS;
> > +               }
> > +       }
> > +}
> > +
> > +static int ixxat_usb_restart(struct ixxat_usb_device *dev)
> > +{
> > +       int err;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       u32 t;
> > +
> > +       ixxat_usb_stop_queue(dev);
> > +       err =3D ixxat_usb_stop_ctrl(dev); =20
>=20
> ixxat_usb_stop_ctrl() kills all the anchored urbs...
>=20
> > +       if (err)
> > +               goto fail;
> > +
> > +       err =3D ixxat_usb_start_ctrl(dev, &t); =20
>=20
> ... however, ixxat_usb_start_ctrl() does not seem to reallocate those
> urbs. Am I missing something? Was this restart function actually
> tested?
>=20
> Also, for a restart, you do not need to release and reallocate your
> ressources. Just sending the stop and start commands to the device
> should be sufficient.
>=20

Same for this, need more time to investigate (and test)...

> > +       if (err)
> > +               goto fail;
> > +
> > +       dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +       netif_wake_queue(netdev);
> > +
> > +fail:
> > +       return err; =20
>=20
> If the fail label does only a return, no need for it. Just return the
> error instead of doing a goto jump.
>=20

O.k.

> > +}
> > +
> > +static int ixxat_usb_set_mode(struct net_device *netdev, enum can_mode=
 mode)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       if (mode !=3D CAN_MODE_START)
> > +               return -EOPNOTSUPP;
> > +
> > +       return ixxat_usb_restart(dev);
> > +}
> > +
> > +static int ixxat_usb_get_berr_counter(const struct net_device *netdev,
> > +                                     struct can_berr_counter *bec)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       *bec =3D dev->bec;
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_canmsg(struct ixxat_usb_device *dev,
> > +                                  struct ixxat_can_msg *rx)
> > +{
> > +       const u32 ixx_flags =3D le32_to_cpu(rx->base.flags);
> > +       const u8 dlc =3D FIELD_GET(IXXAT_USB_MSG_FLAGS_DLC, ixx_flags);
> > +       struct canfd_frame *cf;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct sk_buff *skb;
> > +       u8 flags =3D 0;
> > +       u8 len;
> > +       u8 min_size;
> > +
> > +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) {
> > +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_FDR)
> > +                       flags |=3D CANFD_BRS;
> > +
> > +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_ESI)
> > +                       flags |=3D CANFD_ESI;
> > +
> > +               len =3D can_fd_dlc2len(dlc);
> > +       } else {
> > +               len =3D can_cc_dlc2len(dlc);
> > +       }
> > +
> > +       min_size =3D sizeof(rx->base) + len;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Invalid can data message size\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_OVR) {
> > +               netdev->stats.rx_over_errors++;
> > +               netdev->stats.rx_errors++;
> > +               netdev_err(netdev, "Message overflow\n");
> > +       }
> > +
> > +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL)
> > +               skb =3D alloc_canfd_skb(netdev, &cf);
> > +       else
> > +               skb =3D alloc_can_skb(netdev, (struct can_frame **)&cf);
> > +
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       cf->can_id =3D le32_to_cpu(rx->base.msg_id);
> > +       cf->len =3D len;
> > +       cf->flags |=3D flags;
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_EXT)
> > +               cf->can_id |=3D CAN_EFF_FLAG;
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR) {
> > +               cf->can_id |=3D CAN_RTR_FLAG;
> > +       } else {
> > +               if (dev->adapter =3D=3D &usb2can_cl1)
> > +                       memcpy(cf->data, rx->cl1.data, len);
> > +               else
> > +                       memcpy(cf->data, rx->cl2.data, len);
> > +
> > +               netdev->stats.rx_bytes +=3D cf->len;
> > +       }
> > +
> > +       ixxat_usb_get_ts_tv(dev, le32_to_cpu(rx->base.time), &skb->tsta=
mp);
> > +
> > +       netdev->stats.rx_packets++;
> > +
> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_status(struct ixxat_usb_device *dev,
> > +                                  struct ixxat_can_msg *rx)
> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct can_frame *can_frame;
> > +       struct sk_buff *skb;
> > +       enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> > +       u32 raw_status;
> > +       u8 min_size =3D sizeof(rx->base) + sizeof(raw_status);
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Invalid can status message size\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               raw_status =3D le32_to_cpu(rx->cl1.status);
> > +       else
> > +               raw_status =3D le32_to_cpu(rx->cl2.status);
> > +
> > +       if (raw_status !=3D IXXAT_USB_CAN_STATUS_OK) {
> > +               if (raw_status & IXXAT_USB_CAN_STATUS_BUSOFF) {
> > +                       dev->can.can_stats.bus_off++;
> > +                       new_state =3D CAN_STATE_BUS_OFF;
> > +                       can_bus_off(netdev);
> > +               } else {
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERRLIM) {
> > +                               dev->can.can_stats.error_warning++;
> > +                               new_state =3D CAN_STATE_ERROR_WARNING;
> > +                       }
> > +
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERR_PAS) {
> > +                               dev->can.can_stats.error_passive++;
> > +                               new_state =3D CAN_STATE_ERROR_PASSIVE;
> > +                       }
> > +
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_OVERRUN)
> > +                               new_state =3D CAN_STATE_MAX;
> > +               }
> > +       }
> > +
> > +       if (new_state =3D=3D CAN_STATE_ERROR_ACTIVE) {
> > +               dev->bec.txerr =3D 0;
> > +               dev->bec.rxerr =3D 0;
> > +       }
> > +
> > +       if (new_state !=3D CAN_STATE_MAX)
> > +               dev->can.state =3D new_state;
> > +
> > +       skb =3D alloc_can_err_skb(netdev, &can_frame);
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       switch (new_state) {
> > +       case CAN_STATE_ERROR_ACTIVE:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_ACTIVE;
> > +               break;
> > +       case CAN_STATE_ERROR_WARNING:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_TX_WARNING;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
> > +               break;
> > +       case CAN_STATE_ERROR_PASSIVE:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
> > +               break;
> > +       case CAN_STATE_BUS_OFF:
> > +               can_frame->can_id |=3D CAN_ERR_BUSOFF;
> > +               break;
> > +       case CAN_STATE_MAX:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> > +               break;
> > +       default:
> > +               netdev_err(netdev, "Unhandled can status %d\n",
> > +                          new_state);
> > +               break;
> > +       }
> > +
> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_error(struct ixxat_usb_device *dev,
> > +                                 struct ixxat_can_msg *rx)
> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct can_frame *can_frame;
> > +       struct sk_buff *skb;
> > +       u8 raw_error;
> > +       u8 min_size =3D sizeof(rx->base) + IXXAT_USB_CAN_ERROR_LEN;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Invalid can error message size\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (dev->can.state =3D=3D CAN_STATE_BUS_OFF)
> > +               return 0;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1) {
> > +               raw_error =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_CODE];
> > +               dev->bec.rxerr =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_COU=
NTER_RX];
> > +               dev->bec.txerr =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_COU=
NTER_TX];
> > +       } else {
> > +               raw_error =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_CODE];
> > +               dev->bec.rxerr =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_COU=
NTER_RX];
> > +               dev->bec.txerr =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_COU=
NTER_TX];
> > +       }
> > +
> > +       if (raw_error =3D=3D IXXAT_USB_CAN_ERROR_ACK)
> > +               netdev->stats.tx_errors++;
> > +       else
> > +               netdev->stats.rx_errors++;
> > +
> > +       skb =3D alloc_can_err_skb(netdev, &can_frame);
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       switch (raw_error) {
> > +       case IXXAT_USB_CAN_ERROR_ACK:
> > +               can_frame->can_id |=3D CAN_ERR_ACK;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_BIT:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_BIT;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_CRC:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[3] |=3D CAN_ERR_PROT_LOC_CRC_SEQ;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_FORM:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_FORM;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_STUFF:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_STUFF;
> > +               break;
> > +       default:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_UNSPEC;
> > +               break;
> > +       }
> > +
> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static void ixxat_usb_decode_buf(struct urb *urb)
> > +{
> > +       struct ixxat_usb_device *dev =3D urb->context;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct ixxat_can_msg *can_msg;
> > +       int err =3D 0;
> > +       u32 pos =3D 0;
> > +       u8 *data =3D urb->transfer_buffer; =20
>=20
> Do not use an opaque pointer. Directly assign it to can_msg:
>=20
>           struct ixxat_can_msg *can_msg =3D urb->transfer_buffer;
>=20

O.k.

> > +
> > +       while (pos < urb->actual_length) {
> > +               u32 time;
> > +               u8 size;
> > +               u8 type;
> > +
> > +               can_msg =3D (struct ixxat_can_msg *)&data[pos];
> > +               if (!can_msg || !can_msg->base.size) { =20
>                       ^^^^^^^^
>=20
> I do not think that can_msg can be NULL here.
>=20
> I see some redundancy here. If can_msg->base.size is zero, then then
> next check (size < sizeof(can_msg->base) would also fail, right? I see
> no need to make this a special case. Try to do the size sanitation in
> a single if.
>=20

O.k.

> > +                       err =3D -ENOTSUPP; =20
>=20
> As discussed previously, -EBADMSG or -EMSGSIZE (as you prefer).
>=20
> > +                       netdev_err(netdev, "Unsupported usb msg: %pe\n",
> > +                                  ERR_PTR(err));
> > +                       break; =20
>=20
> This will print twice in the log (here and after the fail tag). Only
> one log message should be enough.
>=20
> Maybe you can remove the error message and instead goto fail? Thanks
> to the %pe, you would get:
>=20
>   Buffer decoding failed: -EBADMSG
>=20
> in the log which I think is sufficient.
>=20

O.k.

> > +               }
> > +
> > +               size =3D can_msg->base.size + 1;
> > +               if (size < sizeof(can_msg->base) ||
> > +                   (pos + size) > urb->actual_length) {
> > +                       err =3D -EBADMSG;
> > +                       netdev_err(netdev,
> > +                                  "Invalid usb message size: %pe\n",
> > +                                  ERR_PTR(err));
> > +                       break; =20
>=20
> Same as above: try to print only one log message.
>=20

O.k.

> > +               }
> > +
> > +               type =3D le32_to_cpu(can_msg->base.flags);
> > +               type &=3D IXXAT_USB_MSG_FLAGS_TYPE;
> > +               time =3D le32_to_cpu(can_msg->base.time);
> > +
> > +               switch (type) {
> > +               case IXXAT_USB_CAN_DATA:
> > +                       err =3D ixxat_usb_handle_canmsg(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_STATUS:
> > +                       err =3D ixxat_usb_handle_status(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_ERROR:
> > +                       err =3D ixxat_usb_handle_error(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_TIMEOVR:
> > +                       ixxat_usb_get_ts_tv(dev, time, NULL);
> > +                       break;
> > +               case IXXAT_USB_CAN_INFO:
> > +               case IXXAT_USB_CAN_WAKEUP:
> > +               case IXXAT_USB_CAN_TIMERST:
> > +                       break;
> > +               default:
> > +                       netdev_err(netdev,
> > +                                  "Unhandled rec type 0x%02x : ignored=
\n",
> > +                                  type);
> > +                       break;
> > +               }
> > +
> > +               pos +=3D size;
> > +       }
> > +
> > +fail:
> > +       if (err)
> > +               netdev_err(netdev, "Buffer decoding failed: %pe\n", ERR=
_PTR(err));
> > +}
> > +
> > +static int ixxat_usb_encode_msg(struct ixxat_usb_device *dev,
> > +                               struct sk_buff *skb, u8 *obuf)
> > +{
> > +       int size;
> > +       struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> > +       struct ixxat_can_msg can_msg =3D { 0 };
> > +       struct ixxat_can_msg_base *msg_base =3D &can_msg.base;
> > +       u32 flags =3D 0;
> > +       u32 msg_id =3D 0;
> > +
> > +       if (cf->can_id & CAN_RTR_FLAG)
> > +               flags |=3D IXXAT_USB_MSG_FLAGS_RTR;
> > +
> > +       if (cf->can_id & CAN_EFF_FLAG) {
> > +               flags |=3D IXXAT_USB_MSG_FLAGS_EXT;
> > +               msg_id =3D cf->can_id & CAN_EFF_MASK;
> > +       } else {
> > +               msg_id =3D cf->can_id & CAN_SFF_MASK;
> > +       }
> > +
> > +       if (can_is_canfd_skb(skb)) {
> > +               flags |=3D IXXAT_USB_FDMSG_FLAGS_EDL;
> > +
> > +               if (!(cf->can_id & CAN_RTR_FLAG) && (cf->flags & CANFD_=
BRS))
> > +                       flags |=3D IXXAT_USB_FDMSG_FLAGS_FDR;
> > +
> > +               flags |=3D FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC, can_fd_l=
en2dlc(cf->len));
> > +       } else {
> > +               flags |=3D FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC, cf->len);
> > +       }
> > +
> > +       msg_base->flags =3D cpu_to_le32(flags);
> > +       msg_base->msg_id =3D cpu_to_le32(msg_id);
> > +       msg_base->size =3D sizeof(*msg_base) + cf->len - 1;
> > +       if (dev->adapter =3D=3D &usb2can_cl1) {
> > +               msg_base->size +=3D sizeof(can_msg.cl1);
> > +               msg_base->size -=3D sizeof(can_msg.cl1.data);
> > +               memcpy(can_msg.cl1.data, cf->data, cf->len);
> > +       } else {
> > +               msg_base->size +=3D sizeof(can_msg.cl2);
> > +               msg_base->size -=3D sizeof(can_msg.cl2.data);
> > +               memcpy(can_msg.cl2.data, cf->data, cf->len);
> > +       }
> > +
> > +       size =3D msg_base->size + 1;
> > +       memcpy(obuf, &can_msg, size);
> > +       return size;
> > +}
> > +
> > +static void ixxat_usb_read_bulk_callback(struct urb *urb)
> > +{
> > +       struct ixxat_usb_device *dev =3D urb->context;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +       int err;
> > +
> > +       if (!netif_device_present(netdev))
> > +               return;
> > +
> > +       switch (urb->status) {
> > +       case 0: /* success */
> > +               break;
> > +       case -EPROTO:
> > +       case -EILSEQ:
> > +       case -ENOENT:
> > +       case -ECONNRESET:
> > +       case -ESHUTDOWN:
> > +               return;
> > +       default:
> > +               netdev_err(netdev, "Rx urb aborted %d\n", urb->status);
> > +               goto resubmit_urb;
> > +       }
> > +
> > +       if (urb->actual_length > 0)
> > +               if (dev->state & IXXAT_USB_STATE_STARTED)
> > +                       ixxat_usb_decode_buf(urb);
> > +
> > +resubmit_urb:
> > +       usb_fill_bulk_urb(urb, udev, usb_rcvbulkpipe(udev, dev->ep_msg_=
in),
> > +                         urb->transfer_buffer, adapter->buffer_size_rx,
> > +                         ixxat_usb_read_bulk_callback, dev);
> > +
> > +       usb_anchor_urb(urb, &dev->rx_submitted);
> > +       err =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +       if (!err)
> > +               return;
> > +
> > +       usb_unanchor_urb(urb);
> > +
> > +       if (err =3D=3D -ENODEV)
> > +               netif_device_detach(netdev);
> > +       else
> > +               netdev_err(netdev,
> > +                          "Failed to resubmit read bulk urb: %pe\n", E=
RR_PTR(err));
> > +}
> > +
> > +static void ixxat_usb_write_bulk_callback(struct urb *urb)
> > +{
> > +       struct ixxat_tx_urb_context *context =3D urb->context;
> > +       struct ixxat_usb_device *dev;
> > +       struct net_device *netdev;
> > +
> > +       if (WARN_ON(!context))
> > +               return;
> > +
> > +       dev =3D context->dev;
> > +       netdev =3D dev->netdev;
> > +
> > +       if (!netif_device_present(netdev))
> > +               return;
> > +
> > +       if (!urb->status) {
> > +               netdev->stats.tx_packets++;
> > +               netdev->stats.tx_bytes +=3D can_get_echo_skb(netdev, co=
ntext->echo_index, NULL);
> > +       } else {
> > +               netdev_err(netdev, "Tx urb aborted: %pe\n", ERR_PTR(urb=
->status));
> > +               can_free_echo_skb(netdev, context->echo_index, NULL);
> > +       }
> > +
> > +       context->echo_index =3D IXXAT_USB_MAX_TX_URBS;
> > +       atomic_dec(&dev->active_tx_urbs);
> > +
> > +       if (!urb->status)
> > +               netif_wake_queue(netdev);
> > +}
> > +
> > +static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
> > +                                       struct net_device *netdev)
> > +{
> > +       int err;
> > +       int size;
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +       struct ixxat_tx_urb_context *context =3D NULL;
> > +       struct net_device_stats *stats =3D &netdev->stats;
> > +       struct urb *urb;
> > +       u8 *obuf;
> > +       u32 i;
> > +
> > +       if (can_dropped_invalid_skb(netdev, skb))
> > +               return NETDEV_TX_OK;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               if (dev->tx_contexts[i].echo_index =3D=3D IXXAT_USB_MAX=
_TX_URBS) {
> > +                       context =3D dev->tx_contexts + i;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (WARN_ON_ONCE(!context))
> > +               return NETDEV_TX_BUSY;
> > +
> > +       urb =3D context->urb;
> > +       obuf =3D urb->transfer_buffer;
> > +
> > +       size =3D ixxat_usb_encode_msg(dev, skb, obuf);
> > +
> > +       context->echo_index =3D i;
> > +
> > +       urb->transfer_buffer_length =3D size;
> > +       usb_anchor_urb(urb, &dev->tx_submitted);
> > +       can_put_echo_skb(skb, netdev, i, 0);
> > +       atomic_inc(&dev->active_tx_urbs);
> > +
> > +       err =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +       if (err) {
> > +               can_free_echo_skb(netdev, i, NULL);
> > +               usb_unanchor_urb(urb);
> > +               atomic_dec(&dev->active_tx_urbs);
> > +
> > +               context->echo_index =3D IXXAT_USB_MAX_TX_URBS;
> > +
> > +               if (err =3D=3D -ENODEV) {
> > +                       netif_device_detach(netdev);
> > +               } else {
> > +                       stats->tx_dropped++;
> > +                       netdev_err(netdev,
> > +                                  "Submitting tx-urb failed: %pe\n", E=
RR_PTR(err));
> > +               }
> > +       } else {
> > +               if (atomic_read(&dev->active_tx_urbs) >=3D IXXAT_USB_MA=
X_TX_URBS)
> > +                       netif_stop_queue(netdev);
> > +       }
> > +
> > +       return NETDEV_TX_OK;
> > +}
> > +
> > +static int ixxat_usb_setup_rx_urbs(struct ixxat_usb_device *dev)
> > +{
> > +       int i;
> > +       int err =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_RX_URBS; i++) {
> > +               struct urb *urb;
> > +               u8 *buf;
> > +
> > +               urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +               if (!urb) {
> > +                       err =3D -ENOMEM;
> > +                       netdev_err(netdev, "No memory for URBs: %pe\n",
> > +                                  ERR_PTR(err));
> > +                       break;
> > +               }
> > +
> > +               buf =3D kmalloc(adapter->buffer_size_rx, GFP_KERNEL);
> > +               if (!buf) {
> > +                       usb_free_urb(urb);
> > +                       err =3D -ENOMEM;
> > +                       netdev_err(netdev,
> > +                                  "No memory for USB-buffer: %pe\n", E=
RR_PTR(err));
> > +                       break;
> > +               }
> > +
> > +               usb_fill_bulk_urb(urb, udev,
> > +                                 usb_rcvbulkpipe(udev, dev->ep_msg_in)=
, buf,
> > +                                 adapter->buffer_size_rx,
> > +                                 ixxat_usb_read_bulk_callback, dev);
> > +
> > +               urb->transfer_flags |=3D URB_FREE_BUFFER;
> > +               usb_anchor_urb(urb, &dev->rx_submitted);
> > +
> > +               err =3D usb_submit_urb(urb, GFP_KERNEL);
> > +               if (err) {
> > +                       usb_unanchor_urb(urb);
> > +                       kfree(buf);
> > +                       usb_free_urb(urb);
> > +
> > +                       if (err =3D=3D -ENODEV)
> > +                               netif_device_detach(netdev);
> > +
> > +                       break;
> > +               }
> > +
> > +               usb_free_urb(urb);
> > +       }
> > +
> > +       if (i =3D=3D 0)
> > +               netdev_err(netdev, "Couldn't setup any rx-URBs\n");
> > +
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_setup_tx_urbs(struct ixxat_usb_device *dev)
> > +{
> > +       int i;
> > +       int ret =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               struct ixxat_tx_urb_context *context;
> > +               struct urb *urb;
> > +               u8 *buf;
> > +
> > +               urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +               if (!urb) {
> > +                       ret =3D -ENOMEM;
> > +                       netdev_err(netdev, "No memory for URBs: %pe\n",
> > +                                  ERR_PTR(ret));
> > +                       break;
> > +               }
> > +
> > +               buf =3D kmalloc(adapter->buffer_size_tx, GFP_KERNEL);
> > +               if (!buf) {
> > +                       usb_free_urb(urb);
> > +                       ret =3D -ENOMEM;
> > +                       netdev_err(netdev,
> > +                                  "No memory for USB-buffer: %pe\n", E=
RR_PTR(ret));
> > +                       break;
> > +               }
> > +
> > +               context =3D dev->tx_contexts + i;
> > +               context->dev =3D dev;
> > +               context->urb =3D urb;
> > +
> > +               usb_fill_bulk_urb(urb, udev,
> > +                                 usb_sndbulkpipe(udev, dev->ep_msg_out=
), buf,
> > +                                 adapter->buffer_size_tx,
> > +                                 ixxat_usb_write_bulk_callback, contex=
t);
> > +
> > +               urb->transfer_flags |=3D URB_FREE_BUFFER;
> > +       }
> > +
> > +       if (i =3D=3D 0) {
> > +               netdev_err(netdev, "Couldn't setup any tx-URBs\n");
> > +               usb_kill_anchored_urbs(&dev->rx_submitted);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static void ixxat_usb_disconnect(struct usb_interface *intf)
> > +{
> > +       struct ixxat_usb_device *dev;
> > +       struct ixxat_usb_device *prev_dev;
> > +
> > +       /* unregister the given device and all previous devices */
> > +       for (dev =3D usb_get_intfdata(intf); dev; dev =3D prev_dev) {
> > +               prev_dev =3D dev->prev_dev;
> > +               unregister_netdev(dev->netdev);
> > +               free_candev(dev->netdev);
> > +       }
> > +
> > +       usb_set_intfdata(intf, NULL);
> > +}
> > +
> > +static int ixxat_usb_start(struct ixxat_usb_device *dev)
> > +{
> > +       int err;
> > +       int i;
> > +       u32 time_ref =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +
> > +       err =3D ixxat_usb_setup_rx_urbs(dev);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D ixxat_usb_setup_tx_urbs(dev);
> > +       if (err)
> > +               return err;
> > +
> > +       /* Try to reset the controller, in case it is already initializ=
ed
> > +        * from a previous unclean shutdown
> > +        */
> > +       ixxat_usb_reset_ctrl(dev);
> > +
> > +       if (adapter->init_ctrl) {
> > +               err =3D adapter->init_ctrl(dev);
> > +               if (err)
> > +                       goto fail;
> > +       }
> > +
> > +       if (!(dev->state & IXXAT_USB_STATE_STARTED)) {
> > +               err =3D ixxat_usb_start_ctrl(dev, &time_ref);
> > +               if (err)
> > +                       goto fail;
> > +
> > +               ixxat_usb_set_ts_now(dev, time_ref);
> > +       }
> > +
> > +       dev->bec.txerr =3D 0;
> > +       dev->bec.rxerr =3D 0;
> > +
> > +       dev->state |=3D IXXAT_USB_STATE_STARTED;
> > +       dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +       return 0;
> > +
> > +fail:
> > +       if (err =3D=3D -ENODEV)
> > +               netif_device_detach(dev->netdev);
> > +
> > +       netdev_err(dev->netdev, "Couldn't submit control: %pe\n", ERR_P=
TR(err));
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               usb_free_urb(dev->tx_contexts[i].urb);
> > +               dev->tx_contexts[i].urb =3D NULL;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_open(struct net_device *netdev)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +       int err;
> > +
> > +       /* common open */
> > +       err =3D open_candev(netdev);
> > +       if (err)
> > +               goto fail;
> > +
> > +       /* finally start device */
> > +       err =3D ixxat_usb_start(dev);
> > +       if (err) {
> > +               netdev_err(netdev, "Couldn't start device: %pe\n", ERR_=
PTR(err));
> > +               close_candev(netdev);
> > +               goto fail;
> > +       }
> > +
> > +       netif_start_queue(netdev);
> > +
> > +fail:
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_stop(struct net_device *netdev)
> > +{
> > +       int err =3D 0;
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       ixxat_usb_stop_queue(dev);
> > +       if (dev->state & IXXAT_USB_STATE_STARTED) {
> > +               err =3D ixxat_usb_stop_ctrl(dev);
> > +               if (err)
> > +                       netdev_warn(netdev, "Error %d: Cannot stop devi=
ce\n",
> > +                                   err);
> > +       }
> > +
> > +       dev->state &=3D ~IXXAT_USB_STATE_STARTED;
> > +       close_candev(netdev);
> > +       dev->can.state =3D CAN_STATE_STOPPED;
> > +       return err;
> > +}
> > +
> > +static const struct net_device_ops ixxat_usb_netdev_ops =3D {
> > +       .ndo_open =3D ixxat_usb_open,
> > +       .ndo_stop =3D ixxat_usb_stop,
> > +       .ndo_start_xmit =3D ixxat_usb_start_xmit
> > +};
> > +
> > +static const struct ethtool_ops ixxat_usb_ethtool_ops =3D {
> > +       .get_ts_info =3D ethtool_op_get_ts_info,
> > +};
> > +
> > +static int ixxat_usb_create_dev(struct usb_interface *intf,
> > +                               const struct ixxat_usb_adapter *adapter,
> > +                               u16 ctrl_index)
> > +{
> > +       struct usb_device *udev =3D interface_to_usbdev(intf);
> > +       struct ixxat_usb_device *dev;
> > +       struct net_device *netdev;
> > +       int err;
> > +       int i;
> > +
> > +       netdev =3D alloc_candev(sizeof(*dev), IXXAT_USB_MAX_TX_URBS);
> > +       if (!netdev) {
> > +               dev_err(&intf->dev, "Cannot allocate candev\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       dev =3D netdev_priv(netdev);
> > +       dev->udev =3D udev;
> > +       dev->netdev =3D netdev;
> > +       dev->adapter =3D adapter;
> > +       dev->ctrl_index =3D ctrl_index;
> > +       dev->state =3D IXXAT_USB_STATE_CONNECTED;
> > +
> > +       i =3D ctrl_index + adapter->ep_offs;
> > +       dev->ep_msg_in =3D adapter->ep_msg_in[i];
> > +       dev->ep_msg_out =3D adapter->ep_msg_out[i];
> > +
> > +       dev->can.clock.freq =3D adapter->clock;
> > +       dev->can.bittiming_const =3D adapter->bt;
> > +       dev->can.data_bittiming_const =3D adapter->btd;
> > +
> > +       dev->can.do_set_mode =3D ixxat_usb_set_mode;
> > +       dev->can.do_get_berr_counter =3D ixxat_usb_get_berr_counter;
> > +
> > +       dev->can.ctrlmode_supported =3D adapter->modes;
> > +
> > +       netdev->netdev_ops =3D &ixxat_usb_netdev_ops;
> > +       netdev->ethtool_ops =3D &ixxat_usb_ethtool_ops;
> > +
> > +       netdev->flags |=3D IFF_ECHO;
> > +       netdev->dev_port =3D ctrl_index;
> > +
> > +       init_usb_anchor(&dev->rx_submitted);
> > +       init_usb_anchor(&dev->tx_submitted);
> > +
> > +       atomic_set(&dev->active_tx_urbs, 0);
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++)
> > +               dev->tx_contexts[i].echo_index =3D IXXAT_USB_MAX_TX_URB=
S;
> > +
> > +       dev->prev_dev =3D usb_get_intfdata(intf);
> > +       usb_set_intfdata(intf, dev);
> > +
> > +       SET_NETDEV_DEV(netdev, &intf->dev);
> > +       err =3D register_candev(netdev);
> > +       if (err) {
> > +               dev_err(&intf->dev, "Failed to register can device: %pe=
\n",
> > +                       ERR_PTR(err));
> > +               goto free_candev;
> > +       }
> > +
> > +       if (dev->prev_dev)
> > +               (dev->prev_dev)->next_dev =3D dev;
> > +
> > +       err =3D ixxat_usb_get_dev_info(udev, &dev->dev_info);
> > +       if (err) {
> > +               dev_err(&intf->dev,
> > +                       "Failed to get device information: %pe\n", ERR_=
PTR(err));
> > +               goto unreg_candev;
> > +       }
> > +
> > +       netdev_info(netdev, "%s: Connected Channel %u (device %s)\n",
> > +                   dev->dev_info.device_name, ctrl_index,
> > +                   dev->dev_info.device_id);
> > +
> > +       return 0;
> > +
> > +unreg_candev:
> > +       unregister_candev(netdev);
> > +free_candev:
> > +       usb_set_intfdata(intf, dev->prev_dev);
> > +       free_candev(netdev);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_probe(struct usb_interface *intf,
> > +                          const struct usb_device_id *id)
> > +{
> > +       struct usb_device *udev =3D interface_to_usbdev(intf);
> > +       struct usb_host_interface *host_intf =3D intf->altsetting;
> > +       const struct ixxat_usb_adapter *adapter;
> > +       struct ixxat_dev_caps dev_caps;
> > +       u16 i;
> > +       int err;
> > +
> > +       usb_reset_configuration(udev);
> > +
> > +       adapter =3D (const struct ixxat_usb_adapter *)id->driver_info;
> > +
> > +       for (i =3D 0; i < host_intf->desc.bNumEndpoints; i++) {
> > +               const u8 epaddr =3D host_intf->endpoint[i].desc.bEndpoi=
ntAddress;
> > +               int match;
> > +               u8 j;
> > +
> > +               /* Check if usb-endpoint address matches known usb-endp=
oints */
> > +               for (j =3D 0; j < IXXAT_USB_MAX_CHANNEL; j++) {
> > +                       u8 ep_msg_in =3D adapter->ep_msg_in[j];
> > +                       u8 ep_msg_out =3D adapter->ep_msg_in[j];

Fixed the typo ep_msg_in vs. ep_msg_out (as done in the upstream driver
ix_usb_can_2.0.366-REL)...

> > +
> > +                       if (epaddr =3D=3D ep_msg_in || epaddr =3D=3D ep=
_msg_out) {
> > +                               match =3D 1;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (!match)
> > +                       return -ENODEV;
> > +       }
> > +
> > +       err =3D ixxat_usb_power_ctrl(udev, IXXAT_USB_POWER_WAKEUP);
> > +       if (err)
> > +               return err;
> > +
> > +       msleep(IXXAT_USB_POWER_WAKEUP_TIME);
> > +
> > +       err =3D ixxat_usb_get_dev_caps(udev, &dev_caps);
> > +       if (err) {
> > +               dev_err(&intf->dev,
> > +                       "Failed to get device capabilities: %pe\n", ERR=
_PTR(err));
> > +               return err;
> > +       }
> > +
> > +       err =3D -ENODEV;
> > +       for (i =3D 0; i < le16_to_cpu(dev_caps.bus_ctrl_count); i++) {
> > +               u16 dev_bustype =3D le16_to_cpu(dev_caps.bus_ctrl_types=
[i]);
> > +               u8 bustype =3D IXXAT_USB_BUS_TYPE(dev_bustype);
> > +
> > +               if (bustype =3D=3D IXXAT_USB_BUS_CAN)
> > +                       err =3D ixxat_usb_create_dev(intf, adapter, i);
> > +
> > +               if (err) {
> > +                       /* deregister already created devices */
> > +                       ixxat_usb_disconnect(intf);
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static struct usb_driver ixxat_usb_driver =3D {
> > +       .name =3D IXXAT_USB_DRIVER_NAME,
> > +       .probe =3D ixxat_usb_probe,
> > +       .disconnect =3D ixxat_usb_disconnect,
> > +       .id_table =3D ixxat_usb_table,
> > +};
> > +
> > +module_usb_driver(ixxat_usb_driver);
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/n=
et/can/usb/ixxat_usb/ixxat_usb_core.h
> > new file mode 100644
> > index 000000000000..56c6f3b938d8
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
> > @@ -0,0 +1,511 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + */
> > +
> > +#ifndef IXXAT_USB_CORE_H
> > +#define IXXAT_USB_CORE_H
> > +
> > +#define IXXAT_USB_DRIVER_NAME "ixxat_usb2can" =20
>=20
> Remove and use KBUILD_MODNAME instead.
>=20

O.k.

> > +#define IXXAT_USB_CTRL_NAME "ixxat_usb"
> > +
> > +#define IXXAT_USB_VENDOR_ID 0x08d8
> > +
> > +/* supported device ids: CL1 */
> > +#define USB2CAN_COMPACT_PRODUCT_ID 0x0008
> > +#define USB2CAN_EMBEDDED_PRODUCT_ID 0x0009
> > +#define USB2CAN_PROFESSIONAL_PRODUCT_ID 0x000A
> > +#define USB2CAN_AUTOMOTIVE_PRODUCT_ID 0x000B
> > +
> > +/* supported device ids: CL2 */
> > +#define USB2CAN_FD_COMPACT_PRODUCT_ID 0x0014
> > +#define USB2CAN_FD_PROFESSIONAL_PRODUCT_ID 0x0016
> > +#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID 0x0017
> > +#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID 0x001B
> > +#define USB2CAR_PRODUCT_ID 0x001C
> > +#define CAN_IDM101_PRODUCT_ID 0xFF12
> > +#define CAN_IDM200_PRODUCT_ID 0xFF13
> > +
> > +#define IXXAT_USB_BUS_CAN 1
> > +
> > +#define IXXAT_USB_BUS_TYPE(type) ((u8)(((type) >> 8) & 0x00FF)) =20
>=20
> Do:
>=20
>   #define IXXAT_USB_BUS_TYPE_MASK 0xff00
>=20
> and then use FIELD_GET(IXXAT_USB_BUS_TYPE_MASK, type) instead.
>=20

O.k.

> > +#define IXXAT_USB_STATE_CONNECTED BIT(0)
> > +#define IXXAT_USB_STATE_STARTED BIT(1)
> > +
> > +#define IXXAT_USB_MAX_CHANNEL 5
> > +#define IXXAT_USB_MAX_TYPES 32
> > +#define IXXAT_USB_MAX_RX_URBS 4
> > +#define IXXAT_USB_MAX_TX_URBS 10
> > +#define IXXAT_USB_MAX_COM_REQ 10
> > +
> > +#define IXXAT_USB_MSG_TIMEOUT 50
> > +#define IXXAT_USB_MSG_CYCLE 20
> > +
> > +#define IXXAT_USB_POWER_WAKEUP 0
> > +#define IXXAT_USB_POWER_WAKEUP_TIME 500
> > +
> > +#define IXXAT_USB_OPMODE_STANDARD BIT(0)
> > +#define IXXAT_USB_OPMODE_EXTENDED BIT(1)
> > +#define IXXAT_USB_OPMODE_ERRFRAME BIT(2)
> > +#define IXXAT_USB_OPMODE_LISTONLY BIT(3)
> > +
> > +#define IXXAT_USB_EXMODE_EXTDATA BIT(0)
> > +#define IXXAT_USB_EXMODE_FASTDATA BIT(1)
> > +#define IXXAT_USB_EXMODE_ISOFD BIT(2)
> > +
> > +#define IXXAT_USB_BTMODE_NAT BIT(0)
> > +#define IXXAT_USB_BTMODE_TSM BIT(1)
> > +
> > +#define IXXAT_USB_STOP_ACTION_CLEARALL 3
> > +
> > +#define IXXAT_RESTART_TASK_CYCLE_TIME 20
> > +
> > +#define IXXAT_USB_CAN_DATA 0x00
> > +#define IXXAT_USB_CAN_INFO 0x01
> > +#define IXXAT_USB_CAN_ERROR 0x02
> > +#define IXXAT_USB_CAN_STATUS 0x03
> > +#define IXXAT_USB_CAN_WAKEUP 0x04
> > +#define IXXAT_USB_CAN_TIMEOVR 0x05
> > +#define IXXAT_USB_CAN_TIMERST 0x06
> > +
> > +#define IXXAT_USB_CAN_STATUS_OK 0x00000000
> > +#define IXXAT_USB_CAN_STATUS_OVERRUN 0x00000002
> > +#define IXXAT_USB_CAN_STATUS_ERRLIM 0x00000004
> > +#define IXXAT_USB_CAN_STATUS_BUSOFF 0x00000008
> > +#define IXXAT_USB_CAN_STATUS_ERR_PAS 0x00002000
> > +
> > +#define IXXAT_USB_CAN_ERROR_LEN 5
> > +
> > +#define IXXAT_USB_CAN_ERROR_CODE 0
> > +#define IXXAT_USB_CAN_ERROR_COUNTER_RX 3
> > +#define IXXAT_USB_CAN_ERROR_COUNTER_TX 4
> > +
> > +#define IXXAT_USB_CAN_ERROR_STUFF 1
> > +#define IXXAT_USB_CAN_ERROR_FORM 2
> > +#define IXXAT_USB_CAN_ERROR_ACK 3
> > +#define IXXAT_USB_CAN_ERROR_BIT 4
> > +#define IXXAT_USB_CAN_ERROR_CRC 6
> > +
> > +#define IXXAT_USB_MSG_FLAGS_TYPE 0x000000FF
> > +#define IXXAT_USB_MSG_FLAGS_DLC 0x000F0000
> > +#define IXXAT_USB_MSG_FLAGS_OVR 0x00100000
> > +#define IXXAT_USB_MSG_FLAGS_RTR 0x00400000
> > +#define IXXAT_USB_MSG_FLAGS_EXT 0x00800000
> > +
> > +#define IXXAT_USB_FDMSG_FLAGS_EDL 0x00000400
> > +#define IXXAT_USB_FDMSG_FLAGS_FDR 0x00000800
> > +#define IXXAT_USB_FDMSG_FLAGS_ESI 0x00001000
> > +
> > +#define IXXAT_USB_CAN_CMD_START 0x326
> > +#define IXXAT_USB_CAN_CMD_STOP 0x327
> > +#define IXXAT_USB_CAN_CMD_RESET 0x328
> > +
> > +#define IXXAT_USB_BRD_CMD_GET_DEVCAPS 0x401
> > +#define IXXAT_USB_BRD_CMD_GET_DEVINFO 0x402
> > +#define IXXAT_USB_BRD_CMD_POWER 0x421
> > +
> > +/**
> > + * struct ixxat_can_msg_base - IXXAT CAN message base (CL1/CL2)
> > + * @size: Message size (this field excluded)
> > + * @time: Message timestamp
> > + * @msg_id: Message ID
> > + * @flags: Message flags
> > + *
> > + * Contains the common fields of an IXXAT CAN message on both CL1 and =
CL2
> > + * devices
> > + */
> > +struct ixxat_can_msg_base {
> > +       u8 size;
> > +       __le32 time; =20
>=20
> Is this an hardware timestamp? If so, you can populate
> skb_shared_hwtstamps->hwtstamp (c.f. function skb_hwtstamps()). Then
> ixxat_usb_ethtool_ops needs to be updated accordingly to inform the
> userland that you do support hardware timestamps.

According to the documentation yes, will investigate on next patch iteratio=
n...

>=20
> > +       __le32 msg_id;
> > +       __le32 flags;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg_cl1 - IXXAT CAN message (CL1)
> > + * @data: Message data (standard CAN frame)
> > + *
> > + * Contains the fields of an IXXAT CAN message on CL1 devices
> > + */
> > +struct ixxat_can_msg_cl1 {
> > +       union {
> > +               u8 data[CAN_MAX_DLEN];
> > +               __le32 status;
> > +       } __packed;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg_cl2 - IXXAT CAN message (CL2)
> > + * @client_id: Client ID
> > + * @data: Message data (CAN FD frame)
> > + *
> > + * Contains the fields of an IXXAT CAN message on CL2 devices
> > + */
> > +struct ixxat_can_msg_cl2 {
> > +       __le32 client_id;
> > +       union {
> > +               u8 data[CANFD_MAX_DLEN];
> > +               __le32 status;
> > +       } __packed;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg - IXXAT CAN message
> > + * @base: Base message
> > + * @cl1: Cl1 message
> > + * @cl2: Cl2 message
> > + *
> > + * Contains an IXXAT CAN message
> > + */
> > +struct ixxat_can_msg {
> > +       struct ixxat_can_msg_base base;
> > +       union {
> > +               struct ixxat_can_msg_cl1 cl1;
> > +               struct ixxat_can_msg_cl2 cl2;
> > +       };
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_dev_caps - Device capabilities
> > + * @bus_ctrl_count: Stores the bus controller counter
> > + * @bus_ctrl_types: Stores the bus controller types
> > + *
> > + * Contains the device capabilities
> > + */
> > +struct ixxat_dev_caps {
> > +       __le16 bus_ctrl_count;
> > +       __le16 bus_ctrl_types[IXXAT_USB_MAX_TYPES];
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_canbtp Bittiming parameters (CL2)
> > + * @mode: Operation mode
> > + * @bps: Bits per second
> > + * @ts1: First time segment
> > + * @ts2: Second time segment
> > + * @sjw: Synchronization jump width
> > + * @tdo: Transmitter delay offset
> > + *
> > + * Bittiming parameters of a CL2 initialization request
> > + */
> > +struct ixxat_canbtp {
> > +       __le32 mode;
> > +       __le32 bps;
> > +       __le16 ts1;
> > +       __le16 ts2;
> > +       __le16 sjw;
> > +       __le16 tdo;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_dev_info IXXAT usb device information
> > + * @device_name: Name of the device
> > + * @device_id: Device identification ( unique device id)
> > + * @device_version: Device version ( 0, 1, ...)
> > + * @device_fpga_version: Version of FPGA design
> > + *
> > + * Contains device information of IXXAT USB devices
> > + */
> > +struct ixxat_dev_info {
> > +       char device_name[16];
> > +       char device_id[16];
> > +       __le16 device_version;
> > +       __le32 device_fpga_version;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_time_ref Time reference
> > + * @kt_host_0: Latest time on the host
> > + * @ts_dev_0: Latest time stamp on the device
> > + * @ts_dev_last: Last device time stamp
> > + *
> > + * Contains time references of the device and the host
> > + */
> > +struct ixxat_time_ref {
> > +       ktime_t kt_host_0;
> > +       u32 ts_dev_0;
> > +       u32 ts_dev_last;
> > +};
> > +
> > +/**
> > + * struct ixxat_tx_urb_context URB content for transmission
> > + * @dev: IXXAT USB device
> > + * @urb: USB request block
> > + * @echo_index: Echo index
> > + * @dlc: Data length code
> > + * @count: Counter =20
>=20
> Those two fields appear in the   but are not part of the
> actual struct.
>=20

O.k.

> > + *
> > + * Contains content for USB request block transmissions
> > + */
> > +struct ixxat_tx_urb_context {
> > +       struct ixxat_usb_device *dev;
> > +       struct urb *urb;
> > +       u32 echo_index;
> > +};
> > +
> > +/**
> > + * struct ixxat_usb_device IXXAT USB device
> > + * @can: CAN common private data
> > + * @adapter: USB network descriptor
> > + * @udev: USB device
> > + * @netdev: Net_device
> > + * @active_tx_urbs: Active tx urbs
> > + * @tx_submitted: Submitted tx usb anchor
> > + * @tx_contexts: Buffer for tx contexts
> > + * @rx_submitted: Submitted rx usb anchor
> > + * @state: Device state
> > + * @ctrl_index: Controller index
> > + * @ep_msg_in: USB endpoint for incoming messages
> > + * @ep_msg_out: USB endpoint for outgoing messages
> > + * @prev_dev: Previous opened device
> > + * @next_dev: Next opened device in list
> > + * @time_ref: Time reference
> > + * @dev_info: Device information
> > + * @bec: CAN error counter
> > + *
> > + * IXXAT USB-to-CAN device
> > + */
> > +struct ixxat_usb_device {
> > +       struct can_priv can;
> > +       const struct ixxat_usb_adapter *adapter;
> > +       struct usb_device *udev;
> > +       struct net_device *netdev;
> > +
> > +       atomic_t active_tx_urbs;
> > +       struct usb_anchor tx_submitted;
> > +       struct ixxat_tx_urb_context tx_contexts[IXXAT_USB_MAX_TX_URBS];
> > +       struct usb_anchor rx_submitted;
> > +
> > +       u32 state;
> > +       u16 ctrl_index;
> > +
> > +       u8 ep_msg_in;
> > +       u8 ep_msg_out;
> > +
> > +       struct ixxat_usb_device *prev_dev;
> > +       struct ixxat_usb_device *next_dev;
> > +
> > +       struct ixxat_time_ref time_ref;
> > +       struct ixxat_dev_info dev_info;
> > +
> > +       struct can_berr_counter bec;
> > +};
> > +
> > +/**
> > + * struct ixxat_usb_dal_req IXXAT device request block
> > + * @size: Request size
> > + * @port: Request port
> > + * @socket: Request socket
> > + * @code: Request code
> > + *
> > + * IXXAT device request block
> > + */
> > +struct ixxat_usb_dal_req {
> > +       __le32 size;
> > +       __le16 port;
> > +       __le16 socket;
> > +       __le32 code;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_dal_res IXXAT device response block
> > + * @res_size: Expected response size
> > + * @ret_size: Actual response size
> > + * @code: Return code
> > + *
> > + * IXXAT device response block
> > + */
> > +struct ixxat_usb_dal_res {
> > +       __le32 res_size;
> > +       __le32 ret_size;
> > +       __le32 code;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_dal_cmd IXXAT device command
> > + * @req: Request block
> > + * @req: Response block
> > + *
> > + * IXXAT device command
> > + */
> > +struct ixxat_usb_dal_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_caps_cmd Device capabilities command
> > + * @req: Request block
> > + * @res: Response block
> > + * @caps: Device capabilities
> > + *
> > + * Can be sent to a device to request its capabilities
> > + */
> > +struct ixxat_usb_caps_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       struct ixxat_dev_caps caps;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_init_cl1_cmd Initialization command (CL1)
> > + * @req: Request block
> > + * @mode: Operation mode
> > + * @btr0: Bittiming register 0
> > + * @btr1: Bittiming register 1
> > + * @padding: 1 byte padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a CL1 device to initialize it
> > + */
> > +struct ixxat_usb_init_cl1_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 mode;
> > +       u8 btr0;
> > +       u8 btr1;
> > +       u8 padding;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_init_cl2_cmd Initialization command (CL2)
> > + * @req: Request block
> > + * @opmode: Operation mode
> > + * @exmode: Extended mode
> > + * @sdr: Stadard bittiming parameters
> > + * @fdr: Fast data bittiming parameters
> > + * @_padding: 2 bytes padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a CL2 device to initialize it
> > + */
> > +struct ixxat_usb_init_cl2_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 opmode;
> > +       u8 exmode;
> > +       struct ixxat_canbtp sdr;
> > +       struct ixxat_canbtp fdr;
> > +       __le16 _padding;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_start_cmd Controller start command
> > + * @req: Request block
> > + * @res: Response block
> > + * @time: Timestamp
> > + *
> > + * Can be sent to a device to start its controller
> > + */
> > +struct ixxat_usb_start_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       __le32 time;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_stop_cmd Controller stop command
> > + * @req: Request block
> > + * @action: Stop action
> > + * @res: Response block
> > + *
> > + * Can be sent to a device to start its controller
> > + */
> > +struct ixxat_usb_stop_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       __le32 action;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_power_cmd Power command
> > + * @req: Request block
> > + * @mode: Power mode
> > + * @_padding1: 1 byte padding
> > + * @_padding2: 2 byte padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a device to set its power mode
> > + */
> > +struct ixxat_usb_power_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 mode;
> > +       u8 _padding1;
> > +       __le16 _padding2; =20
>=20
> Nitpick: you can also do:
>=20
>           u8 _padding[3];
>=20

O.k.

> This comment is an FYI, if you prefer not to fix, also OK.
>=20
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_info_cmd Device information command
> > + * @req: Request block
> > + * @res: Response block
> > + * @info: Device information
> > + *
> > + * Can be sent to a device to request its device information
> > + */
> > +struct ixxat_usb_info_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       struct ixxat_dev_info info;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_adapter IXXAT USB device adapter
> > + * @clock: Clock frequency
> > + * @bt: Bittiming constants
> > + * @btd: Data bittiming constants
> > + * @modes: Supported modes
> > + * @buffer_size_rx: Buffer size for receiving
> > + * @buffer_size_tx: Buffer size for transfer
> > + * @ep_msg_in: USB endpoint buffer for incoming messages
> > + * @ep_msg_out: USB endpoint buffer for outgoing messages
> > + * @ep_offs: Endpoint offset (device depended)
> > + *
> > + * Device Adapter for IXXAT USB devices
> > + */
> > +struct ixxat_usb_adapter {
> > +       const u32 clock;
> > +       const struct can_bittiming_const *bt;
> > +       const struct can_bittiming_const *btd;
> > +       const u32 modes;
> > +       const u16 buffer_size_rx;
> > +       const u16 buffer_size_tx;
> > +       const u8 ep_msg_in[IXXAT_USB_MAX_CHANNEL];
> > +       const u8 ep_msg_out[IXXAT_USB_MAX_CHANNEL]; =20
>=20
> Do you really need those ep_msg_in and ep_msg_out arrays? The list of
> end points is advertized by the device. You also have the
> usb_find_common_endpoints() to help you to find which end point to
> use.
>=20

Different adapters seem to support different endpoints lists (for different
channels), there is coded to check against this ep_msg_in/ep_mgs_out list...

> At the end, you only use one pair of endpoints:
> ixxat_usb_device->ep_msg_in and ixxat_usb_device->ep_msg_out. Why
> storing the other endpoints if used?
>=20
> > +       const u8 ep_offs;
> > +       int (*init_ctrl)(struct ixxat_usb_device *dev);
> > +};
> > +
> > +extern const struct ixxat_usb_adapter usb2can_cl1;
> > +extern const struct ixxat_usb_adapter usb2can_cl2;
> > +extern const struct ixxat_usb_adapter can_idm;
> > +
> > +/**
> > + * ixxat_usb_setup_cmd() - Setup a device command
> > + * @req: Request block
> > + * @res: Response block
> > + *
> > + * This function sets the default values in the request and the respon=
se block
> > + * of a device command
> > + */
> > +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
> > +                        struct ixxat_usb_dal_res *res);
> > +
> > +/**
> > + * ixxat_usb_send_cmd() - Send a command to the device
> > + * @dev: USB device
> > + * @port: Command port
> > + * @req: Command request buffer
> > + * @req_size: Command request size
> > + * @res: Command response buffer
> > + * @res_size: Command response size
> > + *
> > + * This function sends a specific command to the device
> > + *
> > + * Return: Negative error code or zero on success
> > + */
> > +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *r=
eq,
> > +                      const u16 req_size, void *res, const u16 res_siz=
e);
> > +
> > +#endif /* IXXAT_USB_CORE_H */
> > --
> > 2.40.1
> > =20

Update patch will follow...., thanks for review!

Regards,
Peter

