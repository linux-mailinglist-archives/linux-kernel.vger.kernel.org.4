Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4D6E2B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNVS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDNVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:18:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EF19B5;
        Fri, 14 Apr 2023 14:18:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j11so7900640ljq.10;
        Fri, 14 Apr 2023 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681507097; x=1684099097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr6urGdCRuB2tXJnxpWRchudH5QaxSQ/3UAzBpyYD80=;
        b=ZDF28nmFXbz2T8ZuNxEzqAC/6WZAOt+WAWbhGMblTWhi4z0t2jRx61YTrKGC7ObZ0l
         XSloJgjldHPw0Rmpg1DM9UipS6UHB50ZQImZwhheym1Il+p51Sq4wX7iu/rqlBX2nRPL
         DqlBOP+RZX7Se8CaGmLqkZ2scvSvNhs2qUQAyCO10roWf9gHQh5sUO6aaG4hqaSBjiVu
         68IFRV3VKcdNgj7PP6DXn1qieK64upp9l4GXl7BFc4yGWhxB4G/5BOi4J0HVrMXrGrcw
         529ZTRbWIpQJytPHYv1CiybtXQcB8BteXpQ7fLOyKzMiKgTu1mtiuHy5uIXjGASqz/bs
         B13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681507097; x=1684099097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr6urGdCRuB2tXJnxpWRchudH5QaxSQ/3UAzBpyYD80=;
        b=OsyZGGhCzC99HWAWRJqiz1Ez48gvADq4D+Zak1WEZYrzUeHM7qZgANwwRxzYyGqWRv
         BpBJAYqYEw/sYLVksiEA+pUOdWwfEYC5/hQPpix08QRoxNjUc3QBkv1nCoBmEkGiwUZV
         MNBvAOQaU5TCUH4QDMcNukPn4e45tGKpWoLqdVzFieWQ+e4zIxN8b1oAqFNNltNZrUse
         Tv8xfj8znV6RKBoIe3rWuFJ5Q6+9HqU20r8uzdTPJbovTQzU9RM6wClHAeypMmfsZdEy
         kV1m4MSCnCSBFS4I+Ei5SH0aPZCfOJXZrNkHKQHhvrC4qnxpvpHI337p+8k0P7VjojIl
         yXOA==
X-Gm-Message-State: AAQBX9cBoRbA7Dpaw8n88Ve0WIAdQTVtOA4EPaaQhwTSZdYW0k09LHEw
        KICvaEYmBweRspkRGOab0h/Mtjyb1se/W++RZnA=
X-Google-Smtp-Source: AKy350aE+wOecMKvjfRRgVoI5aP1v3EwHMKpefsoRBMP4OcqV1imD0L+i1zB5W6sO4fGOPA9J9ty8RveMRhShxt3G0Y=
X-Received: by 2002:a2e:9d83:0:b0:2a7:8544:1e76 with SMTP id
 c3-20020a2e9d83000000b002a785441e76mr2400252ljj.8.1681507097426; Fri, 14 Apr
 2023 14:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230414103125.33496-1-max.chou@realtek.com>
In-Reply-To: <20230414103125.33496-1-max.chou@realtek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Apr 2023 14:17:58 -0700
Message-ID: <CABBYNZL4Nj3a-A4bf_sRgwRF_P=sVWy92xEjB=tvSn4Ty3fWqg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btrtl: Firmware format v2 support
To:     max.chou@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, allen_chen@realsil.com.cn,
        hildawu@realtek.com, karenhsu@realtek.com, kidman@realtek.com,
        mmandlik@google.com, abhishekpandit@chromium.org,
        apusaka@chromium.org, yinghsu@chromium.org, alainmichaud@google.com
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

Hi Max,

On Fri, Apr 14, 2023 at 3:31=E2=80=AFAM <max.chou@realtek.com> wrote:
>
> From: Max Chou <max.chou@realtek.com>
>
> Realtek changed the format of the firmware file as v2. The driver
> should implement the patch to extract the firmware data from the
> firmware file. The future chips must apply this patch for firmware loadin=
g.
> This patch is compatible with the both previous format and v2 as well.
>
> Signed-off-by: Allen Chen <allen_chen@realsil.com.cn>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> Changes in v4:
> - Resolve the conflict due to the later commits
> Changes in v3:
> - Fix sparse check
> - Edit commit log
> Changes in v2:
> - Use iovec pull data function as rtl_iov_pull_data() to parse data.
> ---
>  drivers/bluetooth/btrtl.c | 352 +++++++++++++++++++++++++++++++++-----
>  drivers/bluetooth/btrtl.h |  53 +++++-
>  2 files changed, 364 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 0f256a8abef4..b746fe76809c 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -21,6 +21,7 @@
>  #define RTL_CHIP_8723CS_VF     4
>  #define RTL_CHIP_8723CS_XX     5
>  #define RTL_EPATCH_SIGNATURE   "Realtech"
> +#define RTL_EPATCH_SIGNATURE_V2        "RTBTCore"
>  #define RTL_ROM_LMP_8703B      0x8703
>  #define RTL_ROM_LMP_8723A      0x1200
>  #define RTL_ROM_LMP_8723B      0x8723
> @@ -43,6 +44,14 @@
>         .hci_ver =3D (hciv), \
>         .hci_bus =3D (bus)
>
> +#define        RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0=
x04, 0x28, 0x80}})
> +#define        RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0=
x04, 0x28, 0x80}})
> +#define        RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0=
x0D, 0x00, 0xb0}})
> +
> +#define RTL_PATCH_SNIPPETS             0x01
> +#define RTL_PATCH_DUMMY_HEADER         0x02
> +#define RTL_PATCH_SECURITY_HEADER      0x03
> +
>  enum btrtl_chip_id {
>         CHIP_ID_8723A,
>         CHIP_ID_8723B,
> @@ -81,6 +90,8 @@ struct btrtl_device_info {
>         int cfg_len;
>         bool drop_fw;
>         int project_id;
> +       u8 key_id;
> +       struct list_head patch_subsecs;
>  };
>
>  static const struct id_table ic_id_table[] =3D {
> @@ -343,6 +354,229 @@ static int rtl_read_rom_version(struct hci_dev *hde=
v, u8 *version)
>         return 0;
>  }
>
> +static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
> +                                  struct rtl_vendor_cmd *cmd, u8 *rp)
> +{
> +       struct sk_buff *skb;
> +       int err =3D 0;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
> +                            HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err =3D PTR_ERR(skb);
> +               rtl_dev_err(hdev, "RTL: Read reg16 failed (%d)", err);
> +               return err;
> +       }
> +
> +       if (skb->len !=3D 3 || skb->data[0]) {
> +               bt_dev_err(hdev, "RTL: Read reg16 length mismatch");
> +               kfree_skb(skb);
> +               return -EIO;
> +       }
> +
> +       if (rp)
> +               memcpy(rp, skb->data + 1, 2);
> +
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +
> +static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
> +{
> +       void *data =3D iov->data;
> +
> +       if (iov->len < len)
> +               return NULL;
> +
> +       iov->data +=3D len;
> +       iov->len  -=3D len;
> +
> +       return data;
> +}
> +
> +static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
> +                                       struct btrtl_device_info *btrtl_d=
ev)
> +{
> +       struct list_head *pos;
> +       struct list_head *next;
> +       struct rtl_subsection *subsec;
> +
> +       list_for_each_safe(pos, next, &btrtl_dev->patch_subsecs) {
> +               subsec =3D list_entry(pos, struct rtl_subsection, list);
> +               if (subsec->prio >=3D node->prio)
> +                       break;
> +       }
> +       __list_add(&node->list, pos->prev, pos);
> +}
> +
> +static int btrtl_parse_section(struct hci_dev *hdev,
> +                              struct btrtl_device_info *btrtl_dev, u32 o=
pcode,
> +                              u8 *data, u32 len)
> +{
> +       struct rtl_section_hdr *hdr;
> +       struct rtl_subsection *subsec;
> +       struct rtl_common_subsec *common_subsec;
> +       struct rtl_sec_hdr *sec_hdr;
> +       int i;
> +       u8 *ptr;
> +       u16 num_subsecs;
> +       u32 subsec_len;
> +       int rc =3D 0;
> +       struct rtl_iovec iov =3D {
> +               .data =3D data,
> +               .len  =3D len,
> +       };
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +       num_subsecs =3D le16_to_cpu(hdr->num);
> +
> +       for (i =3D 0; i < num_subsecs; i++) {
> +               common_subsec =3D rtl_iov_pull_data(&iov, sizeof(*common_=
subsec));
> +               if (!common_subsec)
> +                       break;
> +               subsec_len =3D le32_to_cpu(common_subsec->len);
> +
> +               rtl_dev_dbg(hdev, "subsec, eco 0x%02x, len %08x",
> +                           common_subsec->eco, subsec_len);
> +
> +               ptr =3D rtl_iov_pull_data(&iov, subsec_len);
> +               if (!ptr)
> +                       break;
> +
> +               if (common_subsec->eco !=3D btrtl_dev->rom_version + 1)
> +                       continue;
> +
> +               switch (opcode) {
> +               case RTL_PATCH_SECURITY_HEADER:
> +                       sec_hdr =3D (void *)common_subsec;
> +                       if (sec_hdr->key_id !=3D btrtl_dev->key_id)
> +                               continue;
> +                       break;
> +               }
> +
> +               subsec =3D kzalloc(sizeof(*subsec), GFP_KERNEL);
> +               if (!subsec)
> +                       return -ENOMEM;
> +               subsec->opcode =3D opcode;
> +               subsec->prio =3D common_subsec->prio;
> +               subsec->len  =3D subsec_len;
> +               subsec->data =3D ptr;
> +               btrtl_insert_ordered_subsec(subsec, btrtl_dev);
> +               rc  +=3D subsec_len;
> +       }
> +
> +       return rc;
> +}
> +
> +static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
> +                                  struct btrtl_device_info *btrtl_dev,
> +                                  unsigned char **_buf)
> +{
> +       struct rtl_epatch_header_v2 *hdr;
> +       int rc;
> +       u8 reg_val[2];
> +       u8 key_id;
> +       u32 num_sections;
> +       struct rtl_section *section;
> +       struct rtl_subsection *entry, *tmp;
> +       u32 section_len;
> +       u32 opcode;
> +       int len =3D 0;
> +       int i;
> +       u8 *ptr;
> +       struct rtl_iovec iov =3D {
> +               .data =3D btrtl_dev->fw_data,
> +               .len  =3D btrtl_dev->fw_len - 7, /* Cut the tail */
> +       };
> +
> +       rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> +       if (rc < 0)
> +               return -EIO;
> +       key_id =3D reg_val[0];
> +
> +       rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
> +
> +       btrtl_dev->key_id =3D key_id;
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +       num_sections =3D le32_to_cpu(hdr->num_sections);
> +
> +       rtl_dev_dbg(hdev, "FW version %08x-%08x", *((u32 *)hdr->fw_versio=
n),
> +                   *((u32 *)(hdr->fw_version + 4)));
> +
> +       for (i =3D 0; i < num_sections; i++) {
> +               section =3D rtl_iov_pull_data(&iov, sizeof(*section));
> +               if (!section)
> +                       break;
> +               section_len =3D le32_to_cpu(section->len);
> +               opcode      =3D le32_to_cpu(section->opcode);
> +
> +               rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
> +
> +               ptr =3D rtl_iov_pull_data(&iov, section_len);
> +               if (!ptr)
> +                       break;
> +
> +               switch (opcode) {
> +               case RTL_PATCH_SNIPPETS:
> +                       rc =3D btrtl_parse_section(hdev, btrtl_dev, opcod=
e,
> +                                                ptr, section_len);
> +                       break;
> +               case RTL_PATCH_SECURITY_HEADER:
> +                       /* If key_id from chip is zero, ignore all securi=
ty
> +                        * headers.
> +                        */
> +                       if (!key_id)
> +                               break;
> +                       rc =3D btrtl_parse_section(hdev, btrtl_dev, opcod=
e,
> +                                                ptr, section_len);
> +                       break;
> +               case RTL_PATCH_DUMMY_HEADER:
> +                       rc =3D btrtl_parse_section(hdev, btrtl_dev, opcod=
e,
> +                                                ptr, section_len);
> +                       break;
> +               default:
> +                       rc =3D 0;
> +                       break;
> +               }
> +               if (rc < 0) {
> +                       rtl_dev_err(hdev, "RTL: Parse section (%u) err %d=
",
> +                                   opcode, rc);
> +                       return rc;
> +               }
> +               len +=3D rc;
> +       }
> +
> +       if (!len)
> +               return -ENODATA;
> +
> +       /* Allocate mem and copy all found subsecs. */
> +       ptr =3D kvmalloc(len, GFP_KERNEL);
> +       if (!ptr)
> +               return -ENOMEM;
> +
> +       len =3D 0;
> +       list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, l=
ist) {
> +               rtl_dev_dbg(hdev, "RTL: opcode %08x, addr %p, len 0x%x",
> +                           entry->opcode, entry->data, entry->len);
> +               memcpy(ptr + len, entry->data, entry->len);
> +               len +=3D entry->len;
> +       }
> +
> +       bt_dev_info(hdev, "RTL: Patch (len %d) found", len);

This isn't very informative, usually we expect the firmware
filename/version/revision/etc to be printed, just having the length is
not going to be very useful if the user is trying to report a bug or
something, so I recommend either removing this or use bt_dev_dbg and
convert the bt_dev_dbg into bt_dev_info where you print the fw
information.

> +
> +       if (!len)
> +               return -EPERM;
> +
> +       *_buf =3D ptr;
> +       return len;
> +}
> +
>  static int rtlbt_parse_firmware(struct hci_dev *hdev,
>                                 struct btrtl_device_info *btrtl_dev,
>                                 unsigned char **_buf)
> @@ -377,7 +611,18 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev=
,
>                 { RTL_ROM_LMP_8852A, 25 },      /* 8852C */
>         };
>
> -       min_size =3D sizeof(struct rtl_epatch_header) + sizeof(extension_=
sig) + 3;
> +       if (btrtl_dev->fw_len <=3D 8)
> +               return -EINVAL;
> +
> +       if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
> +               min_size =3D sizeof(struct rtl_epatch_header) +
> +                               sizeof(extension_sig) + 3;
> +       else if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, 8))
> +               min_size =3D sizeof(struct rtl_epatch_header_v2) +
> +                               sizeof(extension_sig) + 3;
> +       else
> +               return -EINVAL;
> +
>         if (btrtl_dev->fw_len < min_size)
>                 return -EINVAL;
>
> @@ -442,12 +687,14 @@ static int rtlbt_parse_firmware(struct hci_dev *hde=
v,
>                 return -EINVAL;
>         }
>
> -       epatch_info =3D (struct rtl_epatch_header *)btrtl_dev->fw_data;
> -       if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) !=3D =
0) {
> +       if (memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8) !=3D 0) {
> +               if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, =
8))
> +                       return rtlbt_parse_firmware_v2(hdev, btrtl_dev, _=
buf);
>                 rtl_dev_err(hdev, "bad EPATCH signature");
>                 return -EINVAL;
>         }
>
> +       epatch_info =3D (struct rtl_epatch_header *)btrtl_dev->fw_data;
>         num_patches =3D le16_to_cpu(epatch_info->num_patches);
>         BT_DBG("fw_version=3D%x, num_patches=3D%d",
>                le32_to_cpu(epatch_info->fw_version), num_patches);
> @@ -511,6 +758,7 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
>         int frag_len =3D RTL_FRAG_LEN;
>         int ret =3D 0;
>         int i;
> +       int j =3D 0;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *rp;
>
> @@ -521,17 +769,16 @@ static int rtl_download_firmware(struct hci_dev *hd=
ev,
>         for (i =3D 0; i < frag_num; i++) {
>                 struct sk_buff *skb;
>
> -               BT_DBG("download fw (%d/%d)", i, frag_num);
> -
> -               if (i > 0x7f)
> -                       dl_cmd->index =3D (i & 0x7f) + 1;
> -               else
> -                       dl_cmd->index =3D i;
> +               dl_cmd->index =3D j++;
> +               if (dl_cmd->index =3D=3D 0x7f)
> +                       j =3D 1;
>
>                 if (i =3D=3D (frag_num - 1)) {
>                         dl_cmd->index |=3D 0x80; /* data end */
>                         frag_len =3D fw_len % RTL_FRAG_LEN;
>                 }
> +               rtl_dev_dbg(hdev, "download fw (%d/%d). index =3D %d", i,
> +                               frag_num, dl_cmd->index);
>                 memcpy(dl_cmd->data, data, frag_len);
>
>                 /* Send download command */
> @@ -691,8 +938,16 @@ static int rtl_read_chip_type(struct hci_dev *hdev, =
u8 *type)
>
>  void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
> +       struct rtl_subsection *entry, *tmp;
> +
>         kvfree(btrtl_dev->fw_data);
>         kvfree(btrtl_dev->cfg_data);
> +
> +       list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, l=
ist) {
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
> +
>         kfree(btrtl_dev);
>  }
>  EXPORT_SYMBOL_GPL(btrtl_free);
> @@ -705,10 +960,11 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         struct hci_rp_read_local_version *resp;
>         char cfg_name[40];
>         u16 hci_rev, lmp_subver;
> -       u8 hci_ver, chip_type =3D 0;
> +       u8 hci_ver, lmp_ver, chip_type =3D 0;
>         int ret;
>         u16 opcode;
>         u8 cmd[2];
> +       u8 reg_val[2];
>
>         btrtl_dev =3D kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
>         if (!btrtl_dev) {
> @@ -716,6 +972,31 @@ struct btrtl_device_info *btrtl_initialize(struct hc=
i_dev *hdev,
>                 goto err_alloc;
>         }
>
> +       INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +
> +check_version:
> +       ret =3D btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
> +       if (ret < 0)
> +               goto err_free;
> +       lmp_subver =3D get_unaligned_le16(reg_val);
> +
> +       if (lmp_subver =3D=3D RTL_ROM_LMP_8822B) {
> +               ret =3D btrtl_vendor_read_reg16(hdev, RTL_CHIP_REV, reg_v=
al);
> +               if (ret < 0)
> +                       goto err_free;
> +               hci_rev =3D get_unaligned_le16(reg_val);
> +
> +               /* 8822E */
> +               if (hci_rev =3D=3D 0x000e) {
> +                       hci_ver =3D 0x0c;
> +                       lmp_ver =3D 0x0c;
> +                       btrtl_dev->ic_info =3D btrtl_match_ic(lmp_subver,=
 hci_rev,
> +                                                           hci_ver, hdev=
->bus,
> +                                                           chip_type);
> +                       goto next;
> +               }
> +       }
> +
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -723,14 +1004,14 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>         }
>
>         resp =3D (struct hci_rp_read_local_version *)skb->data;
> -       rtl_dev_info(hdev, "examining hci_ver=3D%02x hci_rev=3D%04x lmp_v=
er=3D%02x lmp_subver=3D%04x",
> -                    resp->hci_ver, resp->hci_rev,
> -                    resp->lmp_ver, resp->lmp_subver);
>
> -       hci_ver =3D resp->hci_ver;
> -       hci_rev =3D le16_to_cpu(resp->hci_rev);
> +       hci_ver    =3D resp->hci_ver;
> +       hci_rev    =3D le16_to_cpu(resp->hci_rev);
> +       lmp_ver    =3D resp->lmp_ver;
>         lmp_subver =3D le16_to_cpu(resp->lmp_subver);
>
> +       kfree_skb(skb);
> +
>         if (rtl_has_chip_type(lmp_subver)) {
>                 ret =3D rtl_read_chip_type(hdev, &chip_type);
>                 if (ret)
> @@ -740,8 +1021,15 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         btrtl_dev->ic_info =3D btrtl_match_ic(lmp_subver, hci_rev, hci_ve=
r,
>                                             hdev->bus, chip_type);
>
> -       if (!btrtl_dev->ic_info)
> +next:
> +       rtl_dev_info(hdev, "examining hci_ver=3D%02x hci_rev=3D%04x lmp_v=
er=3D%02x lmp_subver=3D%04x",
> +                    hci_ver, hci_rev,
> +                    lmp_ver, lmp_subver);
> +
> +       if (!btrtl_dev->ic_info && !btrtl_dev->drop_fw)
>                 btrtl_dev->drop_fw =3D true;
> +       else
> +               btrtl_dev->drop_fw =3D false;
>
>         if (btrtl_dev->drop_fw) {
>                 opcode =3D hci_opcode_pack(0x3f, 0x66);
> @@ -750,41 +1038,25 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>
>                 skb =3D bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>                 if (!skb)
> -                       goto out_free;
> +                       goto err_free;
>
>                 skb_put_data(skb, cmd, sizeof(cmd));
>                 hci_skb_pkt_type(skb) =3D HCI_COMMAND_PKT;
>
> -               hdev->send(hdev, skb);
> +               ret =3D hdev->send(hdev, skb);
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "sending frame failed (%d)", ret=
);
> +                       kfree_skb(skb);
> +                       goto err_free;
> +               }
>
>                 /* Ensure the above vendor command is sent to controller =
and
>                  * process has done.
>                  */
>                 msleep(200);
>
> -               /* Read the local version again. Expect to have the vanil=
la
> -                * version as cold boot.
> -                */
> -               skb =3D btrtl_read_local_version(hdev);
> -               if (IS_ERR(skb)) {
> -                       ret =3D PTR_ERR(skb);
> -                       goto err_free;
> -               }
> -
> -               resp =3D (struct hci_rp_read_local_version *)skb->data;
> -               rtl_dev_info(hdev, "examining hci_ver=3D%02x hci_rev=3D%0=
4x lmp_ver=3D%02x lmp_subver=3D%04x",
> -                            resp->hci_ver, resp->hci_rev,
> -                            resp->lmp_ver, resp->lmp_subver);
> -
> -               hci_ver =3D resp->hci_ver;
> -               hci_rev =3D le16_to_cpu(resp->hci_rev);
> -               lmp_subver =3D le16_to_cpu(resp->lmp_subver);
> -
> -               btrtl_dev->ic_info =3D btrtl_match_ic(lmp_subver, hci_rev=
, hci_ver,
> -                                                   hdev->bus, chip_type)=
;
> +               goto check_version;
>         }
> -out_free:
> -       kfree_skb(skb);
>
>         if (!btrtl_dev->ic_info) {
>                 rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci=
 rev %04x, hci ver %04x",
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index 349d72ee571b..adb4c2c9abc5 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -49,7 +49,58 @@ struct rtl_vendor_config_entry {
>  struct rtl_vendor_config {
>         __le32 signature;
>         __le16 total_len;
> -       struct rtl_vendor_config_entry entry[];
> +       __u8 entry[];
> +} __packed;
> +
> +struct rtl_epatch_header_v2 {
> +       __u8   signature[8];
> +       __u8   fw_version[8];
> +       __le32 num_sections;
> +} __packed;
> +
> +struct rtl_section {
> +       __le32 opcode;
> +       __le32 len;
> +       u8     data[];
> +} __packed;
> +
> +struct rtl_section_hdr {
> +       __le16 num;
> +       __le16 reserved;
> +} __packed;
> +
> +struct rtl_common_subsec {
> +       __u8   eco;
> +       __u8   prio;
> +       __u8   cb[2];
> +       __le32 len;
> +       __u8   data[];
> +};
> +
> +struct rtl_sec_hdr {
> +       __u8   eco;
> +       __u8   prio;
> +       __u8   key_id;
> +       __u8   reserved;
> +       __le32 len;
> +       __u8   data[];
> +} __packed;
> +
> +struct rtl_subsection {
> +       struct list_head list;
> +       u32 opcode;
> +       u32 len;
> +       u8 prio;
> +       u8 *data;
> +};
> +
> +struct rtl_iovec {
> +       u8  *data;
> +       u32 len;
> +};
> +
> +struct rtl_vendor_cmd {
> +       __u8 param[5];
>  } __packed;
>
>  enum {
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
