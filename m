Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8044D6A8E31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCCAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCCAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:34:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB814EBB;
        Thu,  2 Mar 2023 16:33:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j11so1482878lfg.13;
        Thu, 02 Mar 2023 16:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1358ydspFYB2bW9gvhhunso/S6mQxFWzCBYnMBZJ50=;
        b=V/gBXd9i6Xa3Z18/J0/yC6+p4vcgpA2wAQCz1XLCLIqL/2umPJ0F69SX71vNXEnIPV
         MIsv+oAM8E4Dyq78NMBxEYqx1Lw+MmEUg/CWtmkFWiygjd+m4XT+2olSDSwgvbjbAjqc
         zW4zYfm5oyDCc2yYoPGE42kOOG8WN6pMhfPiXmz8X72PohiKlJg7tmvtvac9F3zfscEW
         KKuDLmCmHnq05eGkY/WHf9HvGtYRqOfh6TlYEsFIvzLtIHphIMkTBg/rkED1Cd8/aaxK
         yTS7DdCgPYsAILFS3TgvCGFHAGrWZKsU6053lduL+W809wbtEThYOguQqIUgYkbIatdb
         sGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1358ydspFYB2bW9gvhhunso/S6mQxFWzCBYnMBZJ50=;
        b=Qj1DU/p6I0YlCaZntAkZY+FKAXc1aLhDAo71/b97jDYodUkq7K1W9J/KYJ1eeZVHMZ
         CAyGAg0MjiMaZXzGe0sGnKrNA3YcRYlZ4RekjNQS86CurKJXtCGNBMx4QEO+73vala6g
         9set/Df4nD+6A9lxJ6MQLzyIpb6dH5Rq0XGC1OPCh22O792O1St6XD0Kc6wz1PJEkIdo
         GIGtz5BgbVQt14bEwfnYFRPW1uluXH5sjcz60KDGCQH4DXZ4lwJN0yAFUS/6nRAF7TP5
         S+x8hRy1RzcLlxh+UMFi/m/8+nGC/VxiVMuY6eFm5X6cQOoeU3yzBWpp8eGlvBJtG84q
         9hjg==
X-Gm-Message-State: AO0yUKXuD4KBQn0xW0wT4x4cFXTZ3AGjeOOHPM1CERSnSkwSEHo/8LaG
        0NZYmvohl9cVbt3lXEwp9FZ0aW6RP6luDgH1TdyrdRXc
X-Google-Smtp-Source: AK7set8IuNAPfY1oe0oKAXMfjpCAy7pidQZVTScgYUDst6+d3Efp+TjCfgxuot4GuT5D+szRdMiKgbBM51vIUiBwoj0=
X-Received: by 2002:ac2:530d:0:b0:4db:1809:29a1 with SMTP id
 c13-20020ac2530d000000b004db180929a1mr1912881lfh.2.1677803537758; Thu, 02 Mar
 2023 16:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
 <20230302151413.v7.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
In-Reply-To: <20230302151413.v7.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Mar 2023 16:32:06 -0800
Message-ID: <CABBYNZ+FmpKV69SeQEGDfewjpf_msdPzv=KktxZXsho5E5FegA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] Bluetooth: Add vhci devcoredump support
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
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

Hi Manish,

On Thu, Mar 2, 2023 at 3:15=E2=80=AFPM Manish Mandlik <mmandlik@google.com>=
 wrote:
>
> Add devcoredump support for vhci that creates forcce_devcoredump debugfs
> entry. This is used for mgmt-tester tests.
>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
>
> Changes in v7:
> - New patch in the series
>
>  drivers/bluetooth/Kconfig    |  1 +
>  drivers/bluetooth/hci_vhci.c | 72 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 5a1a7bec3c42..7bc7a765ad69 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -363,6 +363,7 @@ config BT_HCIBLUECARD
>
>  config BT_HCIVHCI
>         tristate "HCI VHCI (Virtual HCI device) driver"
> +       select WANT_DEV_COREDUMP
>         help
>           Bluetooth Virtual HCI device driver.
>           This driver is required if you want to use HCI Emulation softwa=
re.
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index c443c3b0a4da..8a74e66f8b8e 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -278,6 +278,75 @@ static int vhci_setup(struct hci_dev *hdev)
>         return 0;
>  }
>
> +static void vhci_coredump(struct hci_dev *hdev)
> +{
> +       /* No need to do anything */
> +}
> +
> +static int vhci_coredump_hdr(struct hci_dev *hdev, char *buf, size_t siz=
e)
> +{
> +       char *ptr =3D buf;
> +       size_t rem =3D size;
> +       size_t read =3D 0;
> +
> +       read =3D snprintf(ptr, rem, "Controller Name: vhci_ctrl\n");
> +       rem -=3D read;
> +       ptr +=3D read;

Don't really like these pointer operations, can't we pass the skb here
and then use the likes of skb_push?

> +       read =3D snprintf(ptr, rem, "Firmware Version: vhci_fw\n");
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       read =3D snprintf(ptr, rem, "Driver: vhci_drv\n");
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       read =3D snprintf(ptr, rem, "Vendor: vhci\n");
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       return size - rem;
> +}
> +
> +static ssize_t force_devcoredump_write(struct file *file,
> +                                      const char __user *user_buf,
> +                                      size_t count, loff_t *ppos)
> +{
> +       struct vhci_data *data =3D file->private_data;
> +       struct hci_dev *hdev =3D data->hdev;
> +       struct sk_buff *skb =3D NULL;
> +       char buf[512];
> +       int ret;
> +
> +       ret =3D simple_write_to_buffer(&buf, sizeof(buf), ppos, user_buf,=
 count);
> +       if (ret < count)
> +               return ret;
> +
> +       skb =3D alloc_skb(count, GFP_ATOMIC);
> +       if (!skb)
> +               return -ENOMEM;
> +       skb_put_data(skb, &buf, count);
> +
> +       hci_devcoredump_register(hdev, vhci_coredump, vhci_coredump_hdr, =
NULL);
> +
> +       ret =3D hci_devcoredump_init(hdev, skb->len);
> +       if (ret) {
> +               BT_ERR("Failed to generate devcoredump");
> +               kfree_skb(skb);
> +               return ret;
> +       }
> +
> +       hci_devcoredump_append(hdev, skb);
> +       hci_devcoredump_complete(hdev);
> +
> +       return count;
> +}
> +
> +static const struct file_operations force_devcoredump_fops =3D {
> +       .open           =3D simple_open,
> +       .write          =3D force_devcoredump_write,
> +};
> +
>  static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>  {
>         struct hci_dev *hdev;
> @@ -355,6 +424,9 @@ static int __vhci_create_device(struct vhci_data *dat=
a, __u8 opcode)
>                 debugfs_create_file("aosp_capable", 0644, hdev->debugfs, =
data,
>                                     &aosp_capable_fops);
>
> +       debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, dat=
a,
> +                           &force_devcoredump_fops);
> +
>         hci_skb_pkt_type(skb) =3D HCI_VENDOR_PKT;
>
>         skb_put_u8(skb, 0xff);
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>


--=20
Luiz Augusto von Dentz
