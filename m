Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7873EC10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFZUtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:49:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5599E;
        Mon, 26 Jun 2023 13:49:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso37194611fa.0;
        Mon, 26 Jun 2023 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687812555; x=1690404555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZHpqF/1DwLchfO/E1isy5Jjb+iD/kON+N4YR2/Rvi0=;
        b=dTfkG8sEnv1OONyJ1ulcHt5Ll+GljRlBIui1D0dtBqL6+PV/u85hgyA9giCol+pVlL
         kfUfUhUh9zgWhKTo7WaFynUO/F/pQ9wumpC1H+AeNXaTf2e6Zqlw3aGFl24eBvSB05j2
         +THy2YigMXLI+gjgBlucZc5Fc9TIvb24BybQpWt87koFvV7fzF4RSd0u5T/9M/Cm4/zd
         he5PCp/CNtajIrO3u/jDPz0KAo41c2V4kD8zlww4XHURJFpK2tD0BySOAiL1+b2Ju1z/
         N1z1rbTIOXMoZnLp6rGRefvpooDZFp/4KkxGKajNgeTxGdyGYDvaFXhyM5tmkwrxCDzK
         LTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812555; x=1690404555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZHpqF/1DwLchfO/E1isy5Jjb+iD/kON+N4YR2/Rvi0=;
        b=JS4s0IbSXY6U+IOinHFJpidZTxR7aa5GwxaQTO9OE6+cyN4BRNq0pO+SM4O9CAzzCq
         TN+L8L45Bh8HGLxOfUNsvPO9/0LxiEj43XOwt4pzUn0tbCWrcy45JVhrHBQTN9ehCZTg
         KC+/Pc3mh6vv0qGPTHY/7GWfejuYXvKZmlTf3D3aUlZEsXWwp4byH/p301Cv21cvzE19
         nAWguTY7v6vcEl7lNyrEfPIjXEU+VTExr8/fQXhahvuCGubo1gucC21GSzBk9AXCmnjt
         b9n0gdle2n7JOBUGO5DAEY1Oh6h0mbHXa6v6despNtXuPsQ61spE7j9FRCrL2ndhpzoB
         hxeQ==
X-Gm-Message-State: AC+VfDzHfDX+XkIwbOnMGoXi8Rj9pdK0KPHjHfCY1K5wJq+MbBWOqz3b
        h3S3iTRjOMewwaxtjTRp1rlnsCfQ9h7CqK7PVRENm9QHFsMYHA==
X-Google-Smtp-Source: ACHHUZ5LD702vJx9z6IG7ZDQSTOpEbwB7T7eT1AkAJo55TrAeYPh1RjRkuCe1SURpa6Rmhnwi9DWP5ZwL8EhBH59c08=
X-Received: by 2002:a2e:721a:0:b0:2b4:836b:3cb5 with SMTP id
 n26-20020a2e721a000000b002b4836b3cb5mr14291683ljc.43.1687812554393; Mon, 26
 Jun 2023 13:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
 <0bf904a2581fe3ede716f329bb59d81b5fbec1f0.1687565769.git.objelf@gmail.com>
In-Reply-To: <0bf904a2581fe3ede716f329bb59d81b5fbec1f0.1687565769.git.objelf@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jun 2023 13:49:01 -0700
Message-ID: <CABBYNZKk_nXP+zBrZt4FSrT6hRW2WrsUfuV6av4nud7f8LXdrg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] Bluetooth: btmtk: introduce btmtk reset work
To:     sean.wang@mediatek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        chris.lu@mediatek.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jing Cai <jing.cai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Mon, Jun 26, 2023 at 1:41=E2=80=AFPM <sean.wang@mediatek.com> wrote:
>
> From: Jing Cai <jing.cai@mediatek.com>
>
> Introduce btmtk_reset_work which can be called whenever the firmware abor=
t,
> HCI command timeout, other fatal error happen.
>
> Co-developed-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Jing Cai <jing.cai@mediatek.com>
> ---
> v2, v3, v4: rebase onto the latest codebase
> v5: reset the device on hdev basis and use hci_cmd_sync_queue to
>     schedule reset work
> v6 and v7: rebase onto the latest codebase
> ---
>  drivers/bluetooth/btmtk.c |  15 ++++
>  drivers/bluetooth/btmtk.h |   8 +++
>  drivers/bluetooth/btusb.c | 145 +++++++++++++++++++-------------------
>  3 files changed, 97 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 9482401d97fa..b8678b75276e 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -280,6 +280,21 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bda=
ddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
>
> +void btmtk_reset_sync(struct hci_dev *hdev)
> +{
> +       struct btmediatek_data *reset_work =3D hci_get_priv(hdev);
> +       int err;
> +
> +       hci_dev_lock(hdev);
> +
> +       err =3D hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NU=
LL);
> +       if (err)
> +               bt_dev_err(hdev, "failed to reset (%d)", err);
> +
> +       hci_dev_unlock(hdev);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_reset_sync);
> +
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>  MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
>  MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION=
);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index fadc1a520652..75d8e71efcd3 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -120,8 +120,11 @@ struct btmtk_hci_wmt_params {
>         u32 *status;
>  };
>
> +typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
> +
>  struct btmediatek_data {
>         u32 dev_id;
> +       btmtk_reset_sync_func_t reset_sync;
>  };
>
>  typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
> @@ -136,6 +139,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
>
>  int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
>                          wmt_cmd_sync_func_t wmt_cmd_sync);
> +
> +void btmtk_reset_sync(struct hci_dev *hdev);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -156,4 +161,7 @@ static int btmtk_setup_firmware(struct hci_dev *hdev,=
 const char *fwname,
>         return -EOPNOTSUPP;
>  }
>
> +static void btmtk_reset_sync(struct hci_dev *hdev)
> +{
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 71b119bcff29..4ebab61c288c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3037,6 +3037,78 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hd=
ev)
>         return val & MTK_BT_RST_DONE;
>  }
>
> +static int btusb_mtk_reset_work(struct hci_dev *hdev, void *rst_data)

You can probably drop _work suffix since it no longer runs on its own
dedicated work.

> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmediatek_data *mediatek;
> +       u32 val;
> +       int err;
> +
> +       /* It's MediaTek specific bluetooth reset mechanism via USB */
> +       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> +               return -EBUSY;
> +       }
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return err;
> +
> +       btusb_stop_traffic(data);
> +       usb_kill_anchored_urbs(&data->tx_anchor);
> +       mediatek =3D hci_get_priv(hdev);
> +
> +       if (mediatek->dev_id =3D=3D 0x7925) {
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> +               val |=3D (1 << 5);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> +               val &=3D 0xFFFF00FF;
> +               val |=3D (1 << 13);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> +               val |=3D (1 << 0);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> +               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000=
000FF);
> +               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> +               msleep(100);
> +       } else {
> +               /* It's Device EndPoint Reset Option Register */
> +               bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_=
IN_OUT_OPT);
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
> +
> +               /* Reset the bluetooth chip via USB interface. */
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> +               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000=
000FF);
> +               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> +               /* MT7921 need to delay 20ms between toggle reset bit */
> +               msleep(20);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +       }
> +
> +       err =3D readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
> +                                val & MTK_BT_RST_DONE, 20000, 1000000);
> +       if (err < 0)
> +               bt_dev_err(hdev, "Reset timeout");
> +
> +       btusb_mtk_id_get(data, 0x70010200, &val);
> +       if (!val)
> +               bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
> +
> +       usb_queue_reset_device(data->intf);
> +
> +       clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
> +
> +       return err;
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -3076,6 +3148,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>
>         mediatek =3D hci_get_priv(hdev);
>         mediatek->dev_id =3D dev_id;
> +       mediatek->reset_sync =3D btusb_mtk_reset_work;
>
>         switch (dev_id) {
>         case 0x7663:
> @@ -3233,76 +3306,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev=
)
>         return 0;
>  }
>
> -static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
> -{
> -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> -       u32 val;
> -       int err;
> -       struct btmediatek_data *mediatek;
> -
> -       /* It's MediaTek specific bluetooth reset mechanism via USB */
> -       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> -               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> -               return;
> -       }
> -
> -       err =3D usb_autopm_get_interface(data->intf);
> -       if (err < 0)
> -               return;
> -
> -       btusb_stop_traffic(data);
> -       usb_kill_anchored_urbs(&data->tx_anchor);
> -       mediatek =3D hci_get_priv(hdev);
> -
> -       if (mediatek->dev_id =3D=3D 0x7925) {
> -               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> -               val |=3D (1 << 5);
> -               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> -               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> -               val &=3D 0xFFFF00FF;
> -               val |=3D (1 << 13);
> -               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> -               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
> -               btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> -               val |=3D (1 << 0);
> -               btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> -               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> -               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> -               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000=
000FF);
> -               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> -               msleep(100);
> -       } else {
> -               /* It's Device EndPoint Reset Option Register */
> -               bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> -               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_=
IN_OUT_OPT);
> -               btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
> -
> -               /* Reset the bluetooth chip via USB interface. */
> -               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> -               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> -               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> -               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000=
000FF);
> -               btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> -               /* MT7921 need to delay 20ms between toggle reset bit */
> -               msleep(20);
> -               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> -               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> -       }
> -
> -       err =3D readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
> -                                val & MTK_BT_RST_DONE, 20000, 1000000);
> -       if (err < 0)
> -               bt_dev_err(hdev, "Reset timeout");
> -
> -       btusb_mtk_id_get(data, 0x70010200, &val);
> -       if (!val)
> -               bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
> -
> -       usb_queue_reset_device(data->intf);
> -
> -       clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
> -}
> -
>  static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -4429,7 +4432,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 hdev->setup =3D btusb_mtk_setup;
>                 hdev->shutdown =3D btusb_mtk_shutdown;
>                 hdev->manufacturer =3D 70;
> -               hdev->cmd_timeout =3D btusb_mtk_cmd_timeout;
> +               hdev->cmd_timeout =3D btmtk_reset_sync;
>                 hdev->set_bdaddr =3D btmtk_set_bdaddr;
>                 set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev-=
>quirks);
>                 set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
