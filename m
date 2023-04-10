Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F746DC3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDJGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:55:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C375E72;
        Sun,  9 Apr 2023 23:55:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx15so2402188ljb.7;
        Sun, 09 Apr 2023 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681109726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=658x8A/iPoD+vFzpVweOeSjGqVgiWPTj28VddVw3s6g=;
        b=hRvdWNgjng5LTsTV9KCEW8k3vQpNSHC+kxTOK9glaARG+8qnN6IG9xEeFyUOkic5a6
         4IPysXWw7+jpoAWNHy7eUlFtHkmCkXUav10GUQwaW2+QQFgpGujm0JY3vCMWrhfviVk1
         JG9nqcPQuXE7du7xRrXOQUiMKz70SNutQzsSJhgTYLsNzKS++Vl+3PAXahQ8l6JnETo0
         Mdb4dJxL9/XIxFwE71kvqfmWQyZ0cSE33iXpVZnTUQ9Agtr7P39sVmnBqJ+H9k3OlMEY
         HV1XHETLT4sVNansr2vWXRgcMUMu+raCLzmc9R92AuaWJLKQ6AlpHabDbSNfMHghRtfJ
         kG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681109726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=658x8A/iPoD+vFzpVweOeSjGqVgiWPTj28VddVw3s6g=;
        b=5gZOrMpArJiI28K+3rexgxdZ7t0cwTVVoTjOHCTDncLrYOf9k281MQXNgzTwZ13pFx
         f7uYsxj5iLzlHucDRcu+9/QfX+O1llRhIqGyZxPx/FAYgcSS3Dipb74X9WtqnBy3aATm
         kpIr0V1njA7JCfgQqkUe5V6Bi6YOoV5n26pZzgske8gfNT3kxFufDPcUitq28W8zRre4
         rNfI8vbETs1r0wxDJ+7zsCfoKmehlRSL/BBzqmlQkyRyEBXjJVnKxSrX3mCK4eW/2cCe
         hMR8AK2Vg/WfgjAVv/U03g10BYxcgU1gzpsEq0P/P7rmFw9oUAXBU/tPB9f2HKBdJczh
         lLFw==
X-Gm-Message-State: AAQBX9fW+W+bhQs/TFxt4WifFVS3Z7KelWybWtANnMHL/mEqXjk8XUQw
        G+HPm/4EWHRvgul1J/Px0i9WR2P8rP6eA3kUoZs=
X-Google-Smtp-Source: AKy350ZUbpaV/eFzviBY1wFkNALsitKo00A9a3rXW34iTl3YA7nbRr2lsmR1R7WKEjX6q5s782KXq1aGEim14qHr6Zg=
X-Received: by 2002:a05:651c:198e:b0:2a7:75b2:ae4 with SMTP id
 bx14-20020a05651c198e00b002a775b20ae4mr1058722ljb.2.1681109726041; Sun, 09
 Apr 2023 23:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230407032936.14799-1-quic_tjiang@quicinc.com>
 <20230407161242.hydjluny5y6bttmh@ripper> <DM5PR02MB36867598C679054414EB735DED959@DM5PR02MB3686.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB36867598C679054414EB735DED959@DM5PR02MB3686.namprd02.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 9 Apr 2023 23:55:13 -0700
Message-ID: <CABBYNZLWaX6kQDrusVQHUjDdVEAfeoiTNe6tOSQ87Tw8oKe85A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Sun, Apr 9, 2023 at 9:15=E2=80=AFPM Tim Jiang (QUIC) <quic_tjiang@quicin=
c.com> wrote:
>
> Hi Bjorn,
>   Inline comments, thank you.
>
> Regards.
> Tim
>
>
> -----Original Message-----
> From: Bjorn Andersson <andersson@kernel.org>
> Sent: Saturday, April 8, 2023 12:13 AM
> To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; linux-bluetooth@vg=
er.kernel.org; linux-arm-msm@vger.kernel.org; Balakrishna Godavarthi (QUIC)=
 <quic_bgodavar@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc.com>=
; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
> Subject: Re: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> On Fri, Apr 07, 2023 at 11:29:36AM +0800, Tim Jiang wrote:
> > WCN6855 will report memdump via ACL data or HCI event when it get
> > crashed, so we collect memdump to debug firmware.
> >
> > Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> > ---
> >  drivers/bluetooth/btusb.c | 221
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 221 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 2303b0a66323..ecc346d8b2ea 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -752,6 +752,7 @@ static const struct dmi_system_id btusb_needs_reset=
_resume_table[] =3D {
> >  #define BTUSB_WAKEUP_AUTOSUSPEND     14
> >  #define BTUSB_USE_ALT3_FOR_WBS       15
> >  #define BTUSB_ALT6_CONTINUOUS_TX     16
> > +#define BTUSB_HW_SSR_ACTIVE  17
> >
> >  struct btusb_data {
> >       struct hci_dev       *hdev;
> > @@ -904,6 +905,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *=
hdev)
> >       struct btusb_data *data =3D hci_get_drvdata(hdev);
> >       struct gpio_desc *reset_gpio =3D data->reset_gpio;
> >
> > +     if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> > +             bt_dev_info(hdev, "Defer cmd_timeout due to dump
> > + active");
>
> "Ramdump in progress, defer cmd_timeout"
> [Tim] will address this comments  in V2 version.
>
> > +             return;
> > +     }
> > +
> >       if (++data->cmd_timeout_cnt < 5)
> >               return;
> >
> > @@ -3294,6 +3300,213 @@ static int btusb_set_bdaddr_wcn6855(struct hci_=
dev *hdev,
> >       return 0;
> >  }
> >
> > +#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD #define QCA_MEMDUMP_SIZE_MAX
> > +0x100000 #define QCA_MEMDUMP_VSE_CLASS 0x01 #define
> > +QCA_MEMDUMP_MSG_TYPE 0x08 struct qca_dump_hdr {
> > +     u8 vse_class;
> > +     u8 msg_type;
> > +     __le16 seqno;
> > +     u8 reserved;
> > +     union {
> > +             u8 data[0];
> > +             struct {
> > +                     __le32 ram_dump_size;
> > +                     u8 data0[0];
> > +             } __packed;
> > +     };
> > +} __packed;
> > +
> > +struct qca_dump_info {
> > +     /* fields for dump collection */
> > +     u16 id_vendor;
> > +     u16 id_product;
> > +     u32 fw_version;
> > +     u32 controller_id;
> > +     u32 ram_dump_size;
> > +     u32 ram_dump_offs;
> > +     u16 ram_dump_seqno;
> > +};
> > +
> > +static struct qca_dump_info qca_dump =3D {0};
>
> Do you really need to keep track of this across the individual packets?
>
> What if I connect two btqca devices to my machine?
> [Tim] currently we only support one BT device , not support two Bluetooth=
 chip in one machine.

This is the sort of assumption that can catch us in the future, in
practice Linux does support attaching more than one BT controller, so
the best practice is really to use the hci_dev if you need to store
any data that needs to be associated with a device.

> > +
> > +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff
> > +*skb) {
> > +     char buf[128];
> > +
> > +     snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> > +                     qca_dump.controller_id);
> > +     skb_put_data(skb, buf, strlen(buf));
> > +
> > +     snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> > +                     qca_dump.fw_version);
> > +     skb_put_data(skb, buf, strlen(buf));
> > +
> > +     snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
> > +                     btusb_driver.name);
> > +     skb_put_data(skb, buf, strlen(buf));
> > +
> > +     snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
> > +                     qca_dump.id_vendor, qca_dump.id_product);
> > +     skb_put_data(skb, buf, strlen(buf));
> > +
> > +     snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
> > +                     hdev->lmp_subver);
> > +     skb_put_data(skb, buf, strlen(buf)); }
> > +
> > +static void btusb_coredump_qca(struct hci_dev *hdev) {
> > +     static const u8 param[] =3D { 0x26 };
> > +     struct sk_buff *skb;
> > +
> > +     skb =3D __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
> > +     if (IS_ERR(skb))
> > +             bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func=
__, PTR_ERR(skb));
> > +     kfree_skb(skb);
> > +}
> > +
> > +/*
> > + * =3D=3D0: not a dump pkt.
> > + * < 0: fails to handle a dump pkt
> > + * > 0: otherwise.
> > + */
> > +static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff
> > +*skb) {
> > +     int ret =3D 0;
> > +     u8 pkt_type;
> > +     u8 *sk_ptr;
> > +     unsigned int sk_len;
> > +     u16 seqno;
> > +     u32 ram_dump_size;
> > +
> > +     struct hci_event_hdr *event_hdr;
> > +     struct hci_acl_hdr *acl_hdr;
> > +     struct qca_dump_hdr *dump_hdr;
> > +     struct btusb_data *btdata =3D hci_get_drvdata(hdev);
> > +     struct usb_device *udev =3D btdata->udev;
> > +
> > +     pkt_type =3D hci_skb_pkt_type(skb);
> > +     sk_ptr =3D skb->data;
> > +     sk_len =3D skb->len;
> > +
> > +     if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> > +             acl_hdr =3D hci_acl_hdr(skb);
> > +             if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HAN=
DLE)
> > +                     return 0;
> > +             sk_ptr +=3D HCI_ACL_HDR_SIZE;
> > +             sk_len -=3D HCI_ACL_HDR_SIZE;
> > +             event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> > +     } else {
> > +             event_hdr =3D hci_event_hdr(skb);
> > +     }
> > +
> > +     if (event_hdr->evt !=3D HCI_VENDOR_PKT)
> > +             return 0;
> > +     if (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE))
> > +             return 0;
> > +     sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> > +     sk_len -=3D HCI_EVENT_HDR_SIZE;
> > +
> > +     if (sk_len < offsetof(struct qca_dump_hdr, data))
> > +             return 0;
> > +     dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> > +     if ((dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> > +         || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> > +             return 0;
> > +
> > +     /*it is dump pkt now*/
> > +     ret =3D 1;
>
> Perhaps you can redesign this so that you don't need to set ret =3D 1 in =
multiple places?
> [Tim] Ok, I will address it in v2 version
>
> > +     seqno =3D le16_to_cpu(dump_hdr->seqno);
> > +     if (seqno =3D=3D 0) {
> > +             set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> > +             ram_dump_size =3D le32_to_cpu(dump_hdr->ram_dump_size);
> > +             if (!ram_dump_size || (ram_dump_size > QCA_MEMDUMP_SIZE_M=
AX)) {
> > +                     ret =3D -EILSEQ;
> > +                     bt_dev_err(hdev, "Invalid memdump size(%u)",
> > +                                ram_dump_size);
> > +                     goto out;
> > +             }
> > +
> > +             ret =3D hci_devcd_init(hdev, ram_dump_size);
> > +             if (ret < 0) {
> > +                     bt_dev_err(hdev, "memdump init error(%d)", ret);
> > +                     goto out;
> > +             }
> > +             ret =3D 1;
> > +
> > +             qca_dump.ram_dump_size =3D ram_dump_size;
> > +             qca_dump.ram_dump_offs =3D 0;
> > +             qca_dump.ram_dump_seqno =3D 0;
> > +             sk_ptr +=3D offsetof(struct qca_dump_hdr, data0);
> > +             sk_len -=3D offsetof(struct qca_dump_hdr, data0);
> > +
> > +             usb_disable_autosuspend(udev);
> > +             bt_dev_info(hdev, "%s memdump size(%u)\n",
> > +                         (pkt_type =3D=3D HCI_ACLDATA_PKT) ? "ACL" : "=
event",
> > +                         ram_dump_size);
> > +     } else {
> > +             sk_ptr +=3D offsetof(struct qca_dump_hdr, data);
> > +             sk_len -=3D offsetof(struct qca_dump_hdr, data);
> > +     }
> > +
> > +     if (!qca_dump.ram_dump_size) {
> > +             ret =3D -EINVAL;
> > +             bt_dev_err(hdev, "memdump is not active");
> > +             goto out;
> > +     }
> > +
> > +     if ((seqno !=3D qca_dump.ram_dump_seqno) && (seqno !=3D 0xFFFF)) =
{
> > +             ret =3D -EILSEQ;
> > +             bt_dev_err(hdev,
> > +                        "expected memdump seqno(%u) is not received(%u=
)\n",
> > +                        qca_dump.ram_dump_seqno, seqno);
> > +             hci_devcd_abort(hdev);
> > +             goto out;
> > +     }
> > +
> > +     skb_pull(skb, skb->len - sk_len);
> > +     hci_devcd_append(hdev, skb);
> > +     qca_dump.ram_dump_offs +=3D sk_len;
> > +     qca_dump.ram_dump_seqno++;
> > +     if (seqno !=3D 0xFFFF)
> > +             return ret;
>
> It wasn't immediately clear to me that this means "return OK, but we're w=
aiting for more data".
>
> How about turning this the other way around?
>
> if (all_data_received) {
>         bt_dev_info("memdump done");
>         hci_devcd_complete();
>         ...
> }
> [Tim] ok, I will address this in v2 version
>
> ...
>
> > +     hci_devcd_complete(hdev);
> > +
> > +out:
> > +     if (qca_dump.ram_dump_size) {
>
> So if I get seqno =3D=3D 0, followed by seqno =3D=3D 2 we will print memd=
ump Done and return -EILSEQ?
> [Tim] we can also apply pattern byte if needed , do you need me to apply =
pattern bytes in v2 version ?
>
> Regards,
> Bjorn
>
> > +             usb_enable_autosuspend(udev);
> > +             bt_dev_info(hdev,
> > +                             "memdump Done: pkts(%u), dumped(%u)/total=
(%u)\n",
> > +                             qca_dump.ram_dump_seqno, qca_dump.ram_dum=
p_offs,
> > +                             qca_dump.ram_dump_size);
> > +     }
> > +     qca_dump.ram_dump_size =3D 0;
> > +     qca_dump.ram_dump_offs =3D 0;
> > +     qca_dump.ram_dump_seqno =3D 0;
> > +     clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> > +
> > +     if (ret < 0)
> > +             kfree_skb(skb);
> > +     return ret;
> > +}
> > +
> > +static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff
> > +*skb) {
> > +     if (handle_dump_pkt_qca(hdev, skb))
> > +             return 0;
> > +     return hci_recv_frame(hdev, skb); }
> > +
> > +static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff
> > +*skb) {
> > +     if (handle_dump_pkt_qca(hdev, skb))
> > +             return 0;
> > +     return hci_recv_frame(hdev, skb); }
> > +
> > +
> >  #define QCA_DFU_PACKET_LEN   4096
> >
> >  #define QCA_GET_TARGET_VERSION       0x09
> > @@ -3628,6 +3841,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> >       if (err < 0)
> >               return err;
> >
> > +     qca_dump.fw_version =3D le32_to_cpu(ver.patch_version);
> > +     qca_dump.controller_id =3D le32_to_cpu(ver.rom_version);
> > +
> >       if (!(status & QCA_SYSCFG_UPDATED)) {
> >               err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
> >               if (err < 0)
> > @@ -4117,6 +4333,11 @@ static int btusb_probe(struct usb_interface *int=
f,
> >       }
> >
> >       if (id->driver_info & BTUSB_QCA_WCN6855) {
> > +             qca_dump.id_vendor =3D id->idVendor;
> > +             qca_dump.id_product =3D id->idProduct;
> > +             data->recv_event =3D btusb_recv_evt_qca;
> > +             data->recv_acl =3D btusb_recv_acl_qca;
> > +             hci_devcd_register(hdev, btusb_coredump_qca,
> > + btusb_dump_hdr_qca, NULL);
> >               data->setup_on_usb =3D btusb_setup_qca;
> >               hdev->shutdown =3D btusb_shutdown_qca;
> >               hdev->set_bdaddr =3D btusb_set_bdaddr_wcn6855;
> > --
> > 2.17.1
> >



--=20
Luiz Augusto von Dentz
