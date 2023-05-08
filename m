Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE36FB7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjEHTzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjEHTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:55:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA165BF;
        Mon,  8 May 2023 12:54:40 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac7c59665bso57381261fa.3;
        Mon, 08 May 2023 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683575668; x=1686167668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aond+PBh56G+BZA3H7+tIB9ZL9ml8G3VONmOz3SWSsI=;
        b=CF9eCwKhsjEdE6QtfUE1lz3kJpia2NFTqxrJB8eyf6nE0slKUMDW+LB4S7hZf4Zefs
         FDrDSu12mRBTQorkOV1EbSPA86H3zsoW5zxwB1kRysL08aNQCrandfvgSPVMbeSjZGyE
         EDBCeyUjk5UkYIQrCY9re9OIRmf/77snJEb1LlUD0vrComgtgIHmrIHcBGjUMdRjjs4T
         4MDXrpOCRXNKUab9lF3D/pbRGIcca8wNZlxEAQlGyMaMkiU53OUpRaHRh9sTqiQPgrO7
         OSAvM4lY0Gq0NSYrfb8upL4g3P8oifqbui8Eph8tBnjMkrtP84EhGfajyxBmTCFjgQ4L
         dVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575668; x=1686167668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aond+PBh56G+BZA3H7+tIB9ZL9ml8G3VONmOz3SWSsI=;
        b=WPfZHehEQely7buGa+p+XHKLjxrX7w2uOwlIVj5n/G+EawBTe9MpDT2elaW4MsZvlv
         SJFBALOgwz3wJH67cN+auG2hhiAkLtMlT5C+C6341LSed17MZuoRfjb5kGe6qz3NBEqG
         yFhGRBBprMP9vRkJWLOzobC/EMepq6Jz2PkYK6tEM3C+pEdTN4qYFK8hWPgwyq4WDq3O
         x8gnBYNWDoiIhXNLidqN+8F1B1ISATldZBlwx0mAWu1uPeDsaQs7EpRDjBjFMJxKwjnJ
         VGJo3Iy6m6h0zCYuRj4IAy/mHzPsiI/8oopxIBmTinWGcz6e5vVFNNSYTA5TZYl6e6Uv
         1ZnQ==
X-Gm-Message-State: AC+VfDz0VHwC5df4Mx1GumFV6/1sojL+LM4Y360b32UxXi+FS5QDalDC
        vLxKO1QK6BdNZKgwiTO8wE8JJrqz6ycwMLUQWrU=
X-Google-Smtp-Source: ACHHUZ7H4PDX2u0w6WQ6LT5sjOWRLUvhtxu9dXeWV5/9JodHVsFloTya/PWTJ71zN3zfU48x6Cmb/Z/kMU+s/bETORE=
X-Received: by 2002:a2e:7004:0:b0:2ac:8e5a:1054 with SMTP id
 l4-20020a2e7004000000b002ac8e5a1054mr96891ljc.0.1683575667931; Mon, 08 May
 2023 12:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <c90f4606c85f5862e2e3e1dc330af4ac95f2bc9f.1683065391.git.objelf@gmail.com>
 <ddcbc509b5024882583d5c143ec5f4520bef860a.1683065391.git.objelf@gmail.com>
In-Reply-To: <ddcbc509b5024882583d5c143ec5f4520bef860a.1683065391.git.objelf@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 May 2023 12:54:15 -0700
Message-ID: <CABBYNZJQjoTzqmivUbLnDnn826pStW+kTuicYN1qVuHDoQjfmw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: btusb: mediatek: add MediaTek
 devcoredump support
To:     sean.wang@mediatek.com, Manish Mandlik <mmandlik@google.com>
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

On Tue, May 2, 2023 at 4:02=E2=80=AFPM <sean.wang@mediatek.com> wrote:
>
> From: Jing Cai <jing.cai@mediatek.com>
>
> This patch implement function .coredump() and dmp_hdr() in btusb
> driver for MediaTek controller.  FW core dump was triggered by FW
> specific event to show something unexpected happened in the controller.
>
> The driver would be responsible for collecting and uploading the device
> core dump pieces in hci driver using core dump API. Once we finished
> the whole process, the driver would reset the controller to recover the
> kind of fatal error.
>
> Co-developed-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Jing Cai <jing.cai@mediatek.com>
> ---
> v2, v3: rebase onto the latest codebase
> v4: update the newest API usage for the coredump which was already
>     into the upstream
> v5: support devcoredump on hdev basis
> ---
>  drivers/bluetooth/btmtk.c | 117 ++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btmtk.h |  28 +++++++++
>  drivers/bluetooth/btusb.c |  14 +++++
>  3 files changed, 159 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index ac2fac7e3c5f..657792f9dcab 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -19,6 +19,12 @@
>  #define MTK_SEC_MAP_COMMON_SIZE        12
>  #define MTK_SEC_MAP_NEED_SEND_SIZE     52
>
> +enum {
> +       BTMTK_COREDUMP_INIT,
> +       BTMTK_COREDUMP_DISABLED,
> +       BTMTK_COREDUMP_ACTIVE,
> +};
> +
>  struct btmtk_patch_header {
>         u8 datetime[16];
>         u8 platform[4];
> @@ -53,6 +59,56 @@ struct btmtk_section_map {
>         };
>  } __packed;
>
> +static void btmtk_coredump(struct hci_dev *hdev)
> +{
> +       int err;
> +
> +       err =3D __hci_cmd_send(hdev, 0xfd5b, 0, NULL);
> +       if (err < 0)
> +               bt_dev_err(hdev, "Coredump failed (%d)", err);
> +}
> +
> +static void btmtk_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb=
)
> +{
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
> +       char buf[80];
> +
> +       snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
> +                data->cd_info.dev_id);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Firmware Version: 0x%X\n",
> +                data->cd_info.fw_version);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Driver: %s\n",
> +                data->cd_info.driver_name);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Vendor: MediaTek\n");
> +       skb_put_data(skb, buf, strlen(buf));
> +}
> +
> +static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
> +{
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
> +
> +       switch (state) {
> +       case HCI_DEVCOREDUMP_IDLE:
> +               data->cd_info.state =3D BTMTK_COREDUMP_INIT;
> +               break;
> +       case HCI_DEVCOREDUMP_ACTIVE:
> +               data->cd_info.state =3D BTMTK_COREDUMP_ACTIVE;
> +               break;
> +       case HCI_DEVCOREDUMP_TIMEOUT:
> +       case HCI_DEVCOREDUMP_ABORT:
> +       case HCI_DEVCOREDUMP_DONE:
> +               data->cd_info.state =3D BTMTK_COREDUMP_INIT;
> +               btmtk_reset_sync(hdev);
> +               break;
> +       }
> +}

Don't really like where this is going, why can't you just use the
state from devcd?

> +
>  int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>                               wmt_cmd_sync_func_t wmt_cmd_sync)
>  {
> @@ -295,6 +351,67 @@ void btmtk_reset_sync(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_reset_sync);
>
> +int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id,
> +                            const char *name, u32 fw_version)
> +{
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
> +
> +       if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
> +               return -EOPNOTSUPP;
> +
> +       data->cd_info.dev_id =3D dev_id;
> +       data->cd_info.fw_version =3D fw_version;
> +       data->cd_info.state =3D BTMTK_COREDUMP_INIT;
> +       strncpy(data->cd_info.driver_name, name, MTK_DRIVER_NAME_LEN - 1)=
;

Im not really sure why every devcd is having to store the driver name
as a copy, the driver name is already accessible via
hdev->dev->driver->name.

@Manish Mandlik we might want to fix any code that still is doing
copies of driver name like above.

> +
> +       return hci_devcd_register(hdev, btmtk_coredump, btmtk_coredump_hd=
r,
> +                                 btmtk_coredump_notify);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_register_coredump);
> +
> +int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
> +       int err;
> +
> +       if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
> +               return 0;
> +
> +       switch (data->cd_info.state) {
> +       case BTMTK_COREDUMP_DISABLED:
> +               err =3D -EINVAL;
> +               break;
> +       case BTMTK_COREDUMP_INIT:
> +               err =3D hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
> +               if (err < 0)
> +                       break;
> +               /* It is supposed coredump can be done within 5 seconds *=
/
> +               schedule_delayed_work(&hdev->dump.dump_timeout,
> +                                     msecs_to_jiffies(5000));
> +               fallthrough;
> +       case BTMTK_COREDUMP_ACTIVE:
> +       default:
> +               err =3D hci_devcd_append(hdev, skb);
> +               if (err < 0)
> +                       break;
> +
> +               if (skb->len > 12 &&
> +                   !strncmp((char *)&skb->data[skb->len - 13],
> +                            MTK_COREDUMP_END, 12))
> +                       hci_devcd_complete(hdev);
> +
> +               break;
> +       }
> +
> +       if (err < 0) {
> +               data->cd_info.state =3D BTMTK_COREDUMP_DISABLED;
> +               kfree_skb(skb);
> +       }
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_process_coredump);
> +
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>  MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
>  MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION=
);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 6245662f6ccb..7eb162f0e7aa 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -21,6 +21,10 @@
>  #define MT7921_DLSTATUS 0x7c053c10
>  #define BT_DL_STATE BIT(1)
>
> +#define MTK_DRIVER_NAME_LEN            16
> +#define MTK_COREDUMP_SIZE              (1024 * 1000)
> +#define MTK_COREDUMP_END               "coredump end"
> +
>  enum {
>         BTMTK_WMT_PATCH_DWNLD =3D 0x1,
>         BTMTK_WMT_TEST =3D 0x2,
> @@ -119,12 +123,20 @@ struct btmtk_hci_wmt_params {
>         u32 *status;
>  };
>
> +struct btmtk_coredump_info {
> +       char driver_name[MTK_DRIVER_NAME_LEN];
> +       u32 dev_id;
> +       u32 fw_version;
> +       int state;
> +};
> +
>  typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
>                                    struct btmtk_hci_wmt_params *);
>
>  typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
>
>  struct btmtk_data {
> +       struct btmtk_coredump_info cd_info;
>         btmtk_reset_sync_func_t reset_sync;
>  };
>
> @@ -139,6 +151,11 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const=
 char *fwname,
>                          wmt_cmd_sync_func_t wmt_cmd_sync);
>
>  void btmtk_reset_sync(struct hci_dev *hdev);
> +
> +int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char=
 *name,
> +                            u32 fw_version);
> +
> +int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -162,4 +179,15 @@ static int btmtk_setup_firmware(struct hci_dev *hdev=
, const char *fwname,
>  static void btmtk_reset_sync(struct hci_dev *hdev)
>  {
>  }
> +
> +static int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, con=
st char *name,
> +                            u32 fw_version)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *=
skb)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 034edd8ad777..1c2a0cbcf62e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3035,6 +3035,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>         }
>
>         btmtk_data->reset_sync =3D btusb_mtk_reset_work;
> +       err =3D btmtk_register_coredump(hdev, dev_id, btusb_driver.name,
> +                               fw_version);
> +       if (err < 0)
> +               bt_dev_err(hdev, "Failed to register coredump (%d)", err)=
;
>
>         switch (dev_id) {
>         case 0x7663:
> @@ -3189,6 +3193,7 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev,=
 struct sk_buff *skb)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         u16 handle =3D le16_to_cpu(hci_acl_hdr(skb)->handle);
> +       struct sk_buff *skb_cd;
>
>         switch (handle) {
>         case 0xfc6f:            /* Firmware dump from device */
> @@ -3196,6 +3201,15 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev=
, struct sk_buff *skb)
>                  * suspend and thus disable auto-suspend.
>                  */
>                 usb_disable_autosuspend(data->udev);
> +
> +               /* We need to forward the diagnostic packet to userspace =
daemon
> +                * for backward compatibility, so we have to clone the pa=
cket
> +                * extraly for the in-kernel coredump support.
> +                */
> +               skb_cd =3D skb_clone(skb, GFP_ATOMIC);
> +               if (skb_cd)
> +                       btmtk_process_coredump(hdev, skb_cd);
> +
>                 fallthrough;
>         case 0x05ff:            /* Firmware debug logging 1 */
>         case 0x05fe:            /* Firmware debug logging 2 */
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
