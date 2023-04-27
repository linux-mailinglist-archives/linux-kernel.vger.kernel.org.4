Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC196EFE48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbjD0APm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0APj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:15:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD803C28;
        Wed, 26 Apr 2023 17:15:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8db10a5d4so77683191fa.1;
        Wed, 26 Apr 2023 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682554502; x=1685146502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDtZLXbFAFSrRNTaQlnsorvortW5QL/pjkB8Q4Z32Is=;
        b=RZihgal0CecRiC7bMBIdK4Hz2KHEQYEU69BRREeG9M+OHILW5hFEt8xqxIm60ZlAsP
         qBppGFJoMdA1tiifALmzzfpeV05lZs1Hrw1wtNMy66pLlFT/ucGYFnDtSF6t6xBf04yL
         4ERpFIjrI59Lg83ML0A5YUnZcn5OPwRiq7jpXRgn/vsRCXbeAtqn6MKt3pV+0/YiE3xM
         CHy77QEJ3KYtT7VYYKgnxVMunUHCz4DyxKHxnyylQ8bsTmq3JQFTOubbZ4LFYnAo7xxL
         XkhiB9B2w1aO+IqaKCMHMx0fvJISrdXNl7DmHTJ62rYwa+NBopnH3IPVJyOHuZmnSYJo
         DgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682554502; x=1685146502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDtZLXbFAFSrRNTaQlnsorvortW5QL/pjkB8Q4Z32Is=;
        b=Ikx+uJwfb+rdVbRooNhynRFugNaW1AbTLjMYl91klLlD0FVJyFgnmAcLK/9J2mxUzk
         tNakfZFm0pEvROZ8WaoC17dzjCIGycvDhPedoGNvbTkuMdKYd7KLIBSc6sd2SQBK6r8n
         C8Q4Kos9vJP4Chhk60WWmozaU8MxdyuEb3RzTUHtaAosuK2nSczyvSjK5vj1ZWv1Us+v
         QptLr/4AsHzCsjMIbR6Kq9hyEk1PPxn91k46nCzeATkbt3KDm6dfJd/LMMqxvJnHTRVt
         bWXHAspnOzwEclLzL+m0tdDUHwd5D07pbXqb/bvwOoYxvpD1K+730GRGHzyPtNNAb8OQ
         9lmQ==
X-Gm-Message-State: AC+VfDxE41Y5dVOyH6bd5gBea/3E+XhNV+3f1QfeTqdHQE+G9Loa8Gmx
        STPK295eLTc7TLVKkprv9IRnXlny7RxKDBOPGE0=
X-Google-Smtp-Source: ACHHUZ4bP+Ko9tHz5/ZZiHbFlbAjbb0NQW1Vpn/otJ2zBNkcVIZB1FD5YJsvdD/K7GJQ6wXNetyZVYoYg1lp/OBkAQY=
X-Received: by 2002:a2e:680d:0:b0:2a8:a859:b5c7 with SMTP id
 c13-20020a2e680d000000b002a8a859b5c7mr38959lja.0.1682554502249; Wed, 26 Apr
 2023 17:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <4699f59b36d522ec263dcea71eda40ae939004f8.1682549719.git.objelf@gmail.com>
 <037a3ab699b7f545884b493c5ea5a4b7e7b667a8.1682549719.git.objelf@gmail.com>
In-Reply-To: <037a3ab699b7f545884b493c5ea5a4b7e7b667a8.1682549719.git.objelf@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Apr 2023 17:14:50 -0700
Message-ID: <CABBYNZKPGZnWDP_fmp9Hf0XEa08tO_X80SxkhOnE+5QB2bZ6eg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Bluetooth: btmtk: introduce btmtk reset work
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

On Wed, Apr 26, 2023 at 4:08=E2=80=AFPM <sean.wang@mediatek.com> wrote:
>
> From: Jing Cai <jing.cai@mediatek.com>
>
> Introduce btmtk_reset_work which can be called whenever the firmware abor=
t,
> HCI command timeout, other fatal error happen.
>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Jing Cai <jing.cai@mediatek.com>
> ---
> v2, v3, v4: rebase onto the latest codebase
> ---
>  drivers/bluetooth/btmtk.c |  16 ++++++
>  drivers/bluetooth/btmtk.h |  14 +++++
>  drivers/bluetooth/btusb.c | 106 ++++++++++++++++++++------------------
>  3 files changed, 86 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 809762d64fc6..77df7b5c3ef3 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -53,6 +53,8 @@ struct btmtk_section_map {
>         };
>  } __packed;
>
> +static struct btmtk_reset_work reset_work;
> +
>  int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>                               wmt_cmd_sync_func_t wmt_cmd_sync)
>  {
> @@ -280,6 +282,20 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bda=
ddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
>
> +void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func)
> +{
> +       reset_work.hdev =3D hdev;
> +       INIT_WORK(&reset_work.work, func);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_init_reset_work);
> +
> +void btmtk_reset_sync(struct hci_dev *hdev)
> +{
> +       schedule_work(&reset_work.work);
> +       flush_work(&reset_work.work);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_reset_sync);

Lets stop assuming there is only one controller in the system, so
works like reset_work need to be store on a per hdev basis, not using
a global variable, also Im not sure why you would need dedicated work
for reset? Can't you use hci_cmd_sync_queue/hci_cmd_sync_submit?

>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>  MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
>  MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION=
);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 2a88ea8e475e..22d39f637652 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -119,6 +119,11 @@ struct btmtk_hci_wmt_params {
>         u32 *status;
>  };
>
> +struct btmtk_reset_work {
> +       struct hci_dev *hdev;
> +       struct work_struct work;
> +};
> +
>  typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
>                                    struct btmtk_hci_wmt_params *);
>
> @@ -131,6 +136,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
>
>  int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
>                          wmt_cmd_sync_func_t wmt_cmd_sync);
> +void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func);
> +void btmtk_reset_sync(struct hci_dev *hdev);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -151,4 +158,11 @@ static int btmtk_setup_firmware(struct hci_dev *hdev=
, const char *fwname,
>         return -EOPNOTSUPP;
>  }
>
> +static void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func=
)
> +{
> +}
> +
> +static void btmtk_reset_sync(struct hci_dev *hdev)
> +{
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 275e0666503d..e84f1a8d03a3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2946,6 +2946,59 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hd=
ev)
>         return val & MTK_BT_RST_DONE;
>  }
>
> +static void btusb_mtk_reset_work(struct work_struct *work)
> +{
> +       struct btmtk_reset_work *info =3D container_of(work,
> +                                                    struct btmtk_reset_w=
ork,
> +                                                    work);
> +       struct hci_dev *hdev =3D info->hdev;
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       u32 val;
> +       int err;
> +
> +       /* It's MediaTek specific bluetooth reset mechanism via USB */
> +       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> +               return;
> +       }
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return;
> +
> +       btusb_stop_traffic(data);
> +       usb_kill_anchored_urbs(&data->tx_anchor);
> +
> +       /* It's Device EndPoint Reset Option Register */
> +       bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> +       btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_O=
PT);
> +       btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
> +
> +       /* Reset the bluetooth chip via USB interface. */
> +       btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> +       btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
> +       btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> +       btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
> +       btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> +       /* MT7921 need to delay 20ms between toggle reset bit */
> +       msleep(20);
> +       btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> +       btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
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
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -2982,6 +3035,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                 }
>         }
>
> +       btmtk_init_reset_work(hdev, btusb_mtk_reset_work);
> +
>         switch (dev_id) {
>         case 0x7663:
>                 fwname =3D FIRMWARE_MT7663;
> @@ -3131,55 +3186,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev=
)
>         return 0;
>  }
>
> -static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
> -{
> -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> -       u32 val;
> -       int err;
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
> -
> -       /* It's Device EndPoint Reset Option Register */
> -       bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> -       btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_O=
PT);
> -       btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
> -
> -       /* Reset the bluetooth chip via USB interface. */
> -       btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> -       btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
> -       btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> -       btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
> -       btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> -       /* MT7921 need to delay 20ms between toggle reset bit */
> -       msleep(20);
> -       btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> -       btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
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
> @@ -4301,7 +4307,7 @@ static int btusb_probe(struct usb_interface *intf,
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
