Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F275F59DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJES1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJES1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:27:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C17F267;
        Wed,  5 Oct 2022 11:27:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by36so1939201ljb.4;
        Wed, 05 Oct 2022 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TN119QVN+u188i2GwRPJv4bH78lYSjg4ygkzIvMlOQA=;
        b=cGSnZYCe7WecmLIuZoK+XnKOTOBzGy9s7OWwkdme6HQlJHE9GIX/uPr2SFA+vZjVhP
         OzmUwyFIoTw+9L+IgP9j+JbUOIxOAIt41bY0hCqxINh/YaHZugWbO3didPW6YpM4sJ6Y
         GngDP1ggZrwyMNun3LK1N0tDmu2mf5Kkvsww/RYBqGS2UN1EIHilCsvB3JsJefhY1nbt
         MdG+N8hDLx/J4WNOJeyY0Cad8qNNafSk0QBhAql8iZE4wgTGVt/zd8n7jmwgd06qHaM1
         JVqYzvb50ablO+MLSs0kOle+/qHCpqZQD326CXkgPaAmAtk0G0/9gsAA99H1kkU8mkyW
         HSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TN119QVN+u188i2GwRPJv4bH78lYSjg4ygkzIvMlOQA=;
        b=cln9Zsw0JCGmed+0/cne13HVZLth6g/LrBFWUrJt0PdJigw4wJ/GjJqnLfX+Gg1Cm0
         GSxHLuKgs8VpeUE4UkRBPWA/Aq7gowCOlcEO536ZZoQ0JzpzO+Wskd+PGHSTLwZSEX0S
         jO7r58OuGPk2SwN/VnP1hOkuQsrPEkK60TDF6h4CPwaR2fAcXzbb1OZ8Oe14GVlYrGXo
         nMjruRHMPG8qB9yLhABFT9Km+smXyDKlScZcqqPF3ciEnd6Tlf0ATV9qXfABniEEsE+F
         B9A1xvPcM2jSaE4/xa/txqg8e7UwaP3js7VIym8teFZ7AyTevVxCdcLQpg1OOOX3VMAH
         f86Q==
X-Gm-Message-State: ACrzQf33GONkL8k4irixrMmS4MFKgpDK5IB/6DRW7EBLUwed41YZWQhP
        Kp+LO9FU+Q4YBG+KqVwIsGhQf4BYxQoN0V21lW6zqcwg10Q=
X-Google-Smtp-Source: AMsMyM5B71A63HTcn7N7P2FgvSQ5hc/pS0K1RAYe9jiE9nCH+OuGYmZ7vsf31tu5s+5c2lPbBjatN1dUMyojCasJnno=
X-Received: by 2002:a05:651c:1547:b0:26c:7d5a:5350 with SMTP id
 y7-20020a05651c154700b0026c7d5a5350mr350018ljp.293.1664994465308; Wed, 05 Oct
 2022 11:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221005124936.2390-1-hildawu@realtek.com>
In-Reply-To: <20221005124936.2390-1-hildawu@realtek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Oct 2022 11:27:33 -0700
Message-ID: <CABBYNZ+AwSxTJeRa-2Y_C48KLoBJs1a-aJWCY76syhjHn+R69Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Workaround for spotty SCO quality
To:     hildawu@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        apusaka@chromium.org, yinghsu@chromium.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilda,

On Wed, Oct 5, 2022 at 5:49 AM <hildawu@realtek.com> wrote:
>
> From: Hilda Wu <hildawu@realtek.com>
>
> When streaming HFP, once a few minutes a brief pause in audio can be
> heard on some platform with Realtek Bluetooth. When the issue occurs,
> the system will see the SCO packet for unknown connection handle messages=
.
>
> Note: This issue affects (e)SCO only, does not affect ACLs.
> Because the duplicate packet causing the problem only occurs in Realtek B=
T.
> This is to filter out duplicate packet for avoiding influence.

Is this perhaps related to:

https://patchwork.kernel.org/project/bluetooth/patch/20221005150621.20771-1=
-nicolas.cavallari@green-communications.fr/

> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> The btmon trace should give a better idea of what we're filtering.
> The following excerpts are part of SCO packets in the HCI log:
>
> Packet; Timestamp    ; Item             ; Payload;
> 23327    ;131.399466000; HCI SCO Data IN    ; 0B 00 48 8C A3 55 4F 8A D5 =
56 E9 35 56 37 8D 55 87 53 55 59 66 D5 57 1D B5 54 00 01 08 AD 00 00 E0 10 =
00 00 00 85 C6 D5 60 E9 B5 52 94 6D 54 E4 9B 55 B1 B6 D5 62 91 B5 57 84 6D =
56 E4 5B 55 75 C6 D5 51 2D B5 53 9A 6D 54 A5 1B;
> 23328    ; 131.399648000; HCI SCO Data OUT  ; 0B 00 48 01 C8 AD 00 00 AA =
DB BA AA A9 72 B4 D9 5D AF 14 53 0C 75 B0 A6 F3 8A 51 B3 54 17 B1 A6 D5 62 =
C5 D5 6B 35 29 8D C5 1C 56 4C 24 96 9B 8D B5 D7 1A B2 8D BC DA 3B 8C 46 AE =
1D 4D A4 04 01 F8 AD 00 00 3D EC BB A9 98 8B 28;
> 23329    ; 131.409467000; HCI SCO Data IN    ; 0B 00 48 55 55 C6 D5 62 29=
 B5 57 B2 6D 54 00 01 38 AD 00 00 E0 10 00 00 00 0B 00 D5 62 55 C6 57 B2 29=
 B5 00 01 6D 54 00 00 38 AD 00 00 E0 10 00 00 00 92 36 D5 5A ED B5 58 6C 6D=
 55 B3 1B 55 6B 26 D5 52 D1 B5 54 23 6D 56 82 DB;
> 23330    ; 131.409629000; HCI SCO Data OUT  ; 0B 00 48 6D 5B BE DB 89 34 =
66 E9 FA 99 A6 6E E5 6D 9F 1A 1C 57 D2 66 92 63 98 99 A9 3B 8A 6C 3E 5B 5A =
34 A4 96 E2 21 21 8C F8 88 0F 3D E0 52 48 85 18 00 01 08 AD 00 00 0C EB BA =
A9 A8 28 CA 9A D0 3C 33 45 4A F9 90 FB CA 4B 39;
> 23331    ; 131.429464000; HCI SCO Data IN    ; 55 AB 36 D5 48 A9 B5 56 AA=
 6D 56 D2 DB 55 75 36 D5 56 2D B5 57 5B 6D 54 00 0B 00 48 01 C8 AD 00 00 E0=
 10 00 00 00 5E C6 D5 56 E1 B5 56 43 6D 55 CA DB 55 7D C6 D5 5B 31 B5;
>
> We handle is HCI SCO Data IN packets.
> The packet 23327 was a normal HCI SCO Data IN packet.
> The packet 23329 was the abnormal HCI SCO Data IN packet.
> The packet 23331 was the invalid connection handle affected by the
> packet 23329 abnormal HCI SCO Data IN packet.

Please use btmon to collect these logs.

> So we expect to filter is the packet 23329 SCO data IN packet case.
> As you can see the packet 23329 packet's connection handle (0x0B 00)
> and length (0x48) is normal.
> This btmon trace is SCO packets in USB alternate setting 3, payload
> length is 72 bytes, so it is consist of three data packets.
> After our investigation, we found that the anomaly is due to the
> intermediate composition data.
> So we estimate and find out its abnormal rule to filter it.
> Filtering out the abnormal packet and then it will not affect the
> system parsing of the conenction handle subsequent.
> Let the invalid connection handle not occur, avoid the spotty SCO
> quality.
>
> Changes in v3:
>  - Use the vendor function to replace btus_recv_isoc
>  - Additional info: The comparison of btrtl_usb_recv_isoc here is
>    for invalid handle, the invalid handle shouldn't appear.
>    So we try to find out the rule and filter out this.
>
> Changes in v2:
>  - Seperate commits for functions
> ---
> ---
>  drivers/bluetooth/btrtl.c | 27 ++++++++++++++
>  drivers/bluetooth/btrtl.h |  8 ++++
>  drivers/bluetooth/btusb.c | 77 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index fb52313a1d45..272f90621a10 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -937,6 +937,33 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>  }
>  EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>
> +int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *p, int len,
> +                       u16 wMaxPacketSize)
> +{
> +       u8 *prev;
> +
> +       if (pos >=3D HCI_SCO_HDR_SIZE && pos >=3D wMaxPacketSize &&
> +           len =3D=3D wMaxPacketSize && !(pos % wMaxPacketSize) &&
> +           wMaxPacketSize >=3D 10 && p[0] =3D=3D data[0] && p[1] =3D=3D =
data[1]) {
> +               prev =3D data + (pos - wMaxPacketSize);
> +
> +               /* Detect the sco data of usb isoc pkt duplication. */
> +               if (!memcmp(p + 2, prev + 2, 8))
> +                       return -EILSEQ;
> +
> +               if (wMaxPacketSize >=3D 12 &&
> +                   p[2] =3D=3D prev[6] && p[3] =3D=3D prev[7] &&
> +                   p[4] =3D=3D prev[4] && p[5] =3D=3D prev[5] &&
> +                   p[6] =3D=3D prev[10] && p[7] =3D=3D prev[11] &&
> +                   p[8] =3D=3D prev[8] && p[9] =3D=3D prev[9]) {
> +                       return -EILSEQ;
> +               }
> +       }

In case I was not clear before, I don't want us accessing data like
above, if you want to check if the handle matches please use something
similar to btusb_validate_sco_handle as in the patch:

https://patchwork.kernel.org/project/bluetooth/patch/20221005150621.20771-1=
-nicolas.cavallari@green-communications.fr/

> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btrtl_usb_recv_isoc);
> +
>  MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION)=
;
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index 2c441bda390a..1a23a99536a0 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -62,6 +62,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             struct btrtl_device_info *btrtl_dev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
> +int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
> +                               u16 wMaxPacketSize);
>
>  #else
>
> @@ -105,4 +107,10 @@ static inline int btrtl_get_uart_settings(struct hci=
_dev *hdev,
>         return -ENOENT;
>  }
>
> +static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int=
 len,
> +                               u16 wMaxPacketSize)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 271963805a38..704e38e6d7d1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -689,6 +689,7 @@ struct btusb_data {
>         int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
>         int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
>         int (*recv_bulk)(struct btusb_data *data, void *buffer, int count=
);
> +       int (*recv_isoc)(struct btusb_data *data, void *buffer, int count=
);
>
>         int (*setup_on_usb)(struct hci_dev *hdev);
>
> @@ -1245,7 +1246,7 @@ static void btusb_isoc_complete(struct urb *urb)
>
>                         hdev->stat.byte_rx +=3D length;
>
> -                       if (btusb_recv_isoc(data, urb->transfer_buffer + =
offset,
> +                       if (data->recv_isoc(data, urb->transfer_buffer + =
offset,
>                                             length) < 0) {
>                                 bt_dev_err(hdev, "corrupted SCO packet");
>                                 hdev->stat.err_rx++;
> @@ -2315,6 +2316,77 @@ static int btusb_send_frame_intel(struct hci_dev *=
hdev, struct sk_buff *skb)
>         return -EILSEQ;
>  }
>
> +static int btusb_recv_isoc_realtek(struct btusb_data *data, void *buffer=
,
> +                                  int count)
> +{
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +       int err =3D 0;
> +       u16 wMaxPacketSize =3D le16_to_cpu(data->isoc_rx_ep->wMaxPacketSi=
ze);
> +
> +       spin_lock_irqsave(&data->rxlock, flags);
> +       skb =3D data->sco_skb;
> +
> +       while (count) {
> +               int len;
> +
> +               if (!skb) {
> +                       skb =3D bt_skb_alloc(HCI_MAX_SCO_SIZE, GFP_ATOMIC=
);
> +                       if (!skb) {
> +                               err =3D -ENOMEM;
> +                               break;
> +                       }
> +
> +                       hci_skb_pkt_type(skb) =3D HCI_SCODATA_PKT;
> +                       hci_skb_expect(skb) =3D HCI_SCO_HDR_SIZE;
> +               }
> +
> +               len =3D min_t(uint, hci_skb_expect(skb), count);
> +
> +               /* Gaps in audio could be heard while streaming WBS using=
 USB
> +                * alt settings 3 on some platforms, since this is only u=
sed
> +                * with RTK chips so let vendor function detect it.
> +                */
> +               if (!btusb_find_altsetting(data, 6) &&
> +                       test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags)) {
> +                       err =3D btrtl_usb_recv_isoc(skb->len, skb->data, =
buffer,
> +                                                       len, wMaxPacketSi=
ze);
> +                       if (err)
> +                               break;
> +               }
> +
> +               skb_put_data(skb, buffer, len);
> +
> +               count -=3D len;
> +               buffer +=3D len;
> +               hci_skb_expect(skb) -=3D len;
> +
> +               if (skb->len =3D=3D HCI_SCO_HDR_SIZE) {
> +                       /* Complete SCO header */
> +                       hci_skb_expect(skb) =3D hci_sco_hdr(skb)->dlen;
> +
> +                       if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> +                               kfree_skb(skb);
> +                               skb =3D NULL;
> +
> +                               err =3D -EILSEQ;
> +                               break;
> +                       }
> +               }
> +
> +               if (!hci_skb_expect(skb)) {
> +                       /* Complete frame */
> +                       hci_recv_frame(data->hdev, skb);
> +                       skb =3D NULL;
> +               }
> +       }
> +
> +       data->sco_skb =3D skb;
> +       spin_unlock_irqrestore(&data->rxlock, flags);
> +
> +       return err;
> +}
> +
>  /* UHW CR mapping */
>  #define MTK_BT_MISC            0x70002510
>  #define MTK_BT_SUBSYS_RST      0x70002610
> @@ -3747,6 +3819,7 @@ static int btusb_probe(struct usb_interface *intf,
>
>         data->recv_event =3D hci_recv_frame;
>         data->recv_bulk =3D btusb_recv_bulk;
> +       data->recv_isoc =3D btusb_recv_isoc;
>
>         if (id->driver_info & BTUSB_INTEL_COMBINED) {
>                 /* Allocate extra space for Intel device */
> @@ -3917,6 +3990,8 @@ static int btusb_probe(struct usb_interface *intf,
>                 hdev->shutdown =3D btrtl_shutdown_realtek;
>                 hdev->cmd_timeout =3D btusb_rtl_cmd_timeout;
>
> +               data->recv_isoc =3D btusb_recv_isoc_realtek;
> +
>                 /* Realtek devices need to set remote wakeup on auto-susp=
end */
>                 set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
>                 set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
