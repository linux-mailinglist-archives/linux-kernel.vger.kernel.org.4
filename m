Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAA674331
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjASTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:55:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2E3595;
        Thu, 19 Jan 2023 11:55:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g13so4803536lfv.7;
        Thu, 19 Jan 2023 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsg8NivT21h3lfHgOXVf2ee4FCCOrc4as+CmyM7IJ+Q=;
        b=PHTWjFoLFu+uwbNiSvga3AEgHi6g4X1y1lNo1uZI2XSZpRbbbmSShWuqxdNi9IZq/p
         0A6DQ45p04hoXR1Hl8pIlW9gYJyBli9RgGwKp8Y4Q2V+9+obLfncz+Xom+tIsZjdNuN0
         +bFD6bBIpl4ZDKPdI2btaMicH2sD5ofIYcGv+c6U0fwF00CX6wxl1LIHo5mFbvvYM6AR
         oN32dwb+/k3MFFOXJFQYC3vkUyJxTxZSns5wUJMPhBghh51Wa4GVhTVMqpGpiG3L5gpO
         GCH7yZVCKmTYt46W8Ak+dLX/QiSFfIwKrb9yjsplJClQjtiFy0BHY7xF/9JjjuMga+HQ
         6dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vsg8NivT21h3lfHgOXVf2ee4FCCOrc4as+CmyM7IJ+Q=;
        b=NeLk38mOKBa3vDSoxxXvMSy6kVXwgHlHU5hVgZppvdOkSDcy9f98W/Lr3K31gG6VHo
         zcORtmQNkzhZk5/fxIQAW81PPlWCtKE3HaIivbEpDHLNMH8zcv/TwvAgw6VljSo1YzSI
         nwXgUoVZNvStDIJt70WW/jTwkuuWdDkYwptd3yH1A6aWLlFEL2TA6MYYTVkbwHKD8Aru
         dCXSa34Pk6CSFEOLREMXpCDVTiYIu45lCfmsgmQhMi1+a7fpaFwTKrZRTex9N2wmkKKB
         3U9s2xqgPuWhIDFLR2w3C/Hfk/ut8yeLBl+HdUgIXWL5ZbWDBVY4M1CoLG3EOtt0JF5+
         zBgg==
X-Gm-Message-State: AFqh2kqUEbPCQj+cgQ/8bMOgKWj3kQAjIobb5bCMhP/OAdTbpzTNLCmh
        xYTdHaBdRtkNSHw8khOLYbm4cYwjYBYp31LjTqk=
X-Google-Smtp-Source: AMrXdXvMbMx7KvjfYuOFaGQPaYQMsDYXABgxANtmCM6mZuMu/okrIRkqrb4dWrpSZGt33mPwqAT7rkHYsmIpGxW+888=
X-Received: by 2002:a05:6512:159:b0:4b5:2958:bd06 with SMTP id
 m25-20020a056512015900b004b52958bd06mr717019lfo.26.1674158120585; Thu, 19 Jan
 2023 11:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20230119074714.156283-1-max.chou@realtek.com>
In-Reply-To: <20230119074714.156283-1-max.chou@realtek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Jan 2023 11:55:07 -0800
Message-ID: <CABBYNZJtEobWiGVtnJpAVJ-qjoegk4a=AP55zEYbkJ-9rKy8RA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: btrtl: Firmware format v2 support
To:     max.chou@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com,
        allen_chen@realsil.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Wed, Jan 18, 2023 at 11:47 PM <max.chou@realtek.com> wrote:
>
> From: Max Chou <max.chou@realtek.com>
>
> Realtek changes the format for the firmware file as v2. The driver
> should implement the patch to extract the firmware data from the
> firmware file.
> It's compatible with the both previous format(v1) and new format(v2).
>
> Signed-off-by: Allen Chen <allen_chen@realsil.com.cn>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 364 +++++++++++++++++++++++++++++++++-----
>  drivers/bluetooth/btrtl.h |  61 +++++++
>  2 files changed, 385 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 69c3fe649ca7..2277cb4e50c2 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -18,6 +18,7 @@
>  #define VERSION "0.1"
>
>  #define RTL_EPATCH_SIGNATURE   "Realtech"
> +#define RTL_EPATCH_SIGNATURE_V2        "RTBTCore"
>  #define RTL_ROM_LMP_8723A      0x1200
>  #define RTL_ROM_LMP_8723B      0x8723
>  #define RTL_ROM_LMP_8821A      0x8821
> @@ -38,6 +39,14 @@
>         .hci_ver = (hciv), \
>         .hci_bus = (bus)
>
> +#define        RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
> +#define        RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
> +#define        RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
> +
> +#define RTL_PATCH_SNIPPETS             0x01
> +#define RTL_PATCH_DUMMY_HEADER         0x02
> +#define RTL_PATCH_SECURITY_HEADER      0x03
> +
>  enum btrtl_chip_id {
>         CHIP_ID_8723A,
>         CHIP_ID_8723B,
> @@ -75,6 +84,8 @@ struct btrtl_device_info {
>         int cfg_len;
>         bool drop_fw;
>         int project_id;
> +       u8 key_id;
> +       struct list_head patch_subsecs;
>  };
>
>  static const struct id_table ic_id_table[] = {
> @@ -284,6 +295,242 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
>         return 0;
>  }
>
> +
> +static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
> +                                  struct rtl_vendor_cmd *cmd, u8 *rp)
> +{
> +       struct sk_buff *skb;
> +       int err = 0;
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
> +                            HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err = PTR_ERR(skb);
> +               rtl_dev_err(hdev, "RTL: Read reg16 failed (%d)", err);
> +               return err;
> +       }
> +
> +       if (skb->len != 3 || skb->data[0]) {
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
> +static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
> +                                       struct btrtl_device_info *btrtl_dev)
> +{
> +       struct list_head *pos;
> +       struct list_head *next;
> +       struct rtl_subsection *subsec;
> +
> +       list_for_each_safe(pos, next, &btrtl_dev->patch_subsecs) {
> +               subsec = list_entry(pos, struct rtl_subsection, list);
> +               if (subsec->prio >= node->prio)
> +                       break;
> +       }
> +       __list_add(&node->list, pos->prev, pos);
> +}
> +
> +static int btrtl_parse_section(struct hci_dev *hdev,
> +                              struct btrtl_device_info *btrtl_dev, u32 opcode,
> +                              u8 *data, u32 len)
> +{
> +       struct rtl_section_hdr *hdr;
> +       struct rtl_subsection *subsec;
> +       struct rtl_common_subsec *common_subsec;
> +       struct rtl_sec_hdr *sec_hdr;
> +       int i;
> +       u8 *ptr;
> +       u8 *end = data + len;

I rather use an skb for parsing the data instead of parsing via
pointer directly, that way you can use the likes of skb_pull_data
which makes the code a lot simpler to follow and less prone to
mistakes accessing data outside the buffer area.

> +       u16 num_subsecs;
> +       u32 subsec_len;
> +       int rc = 0;
> +
> +       if (sizeof(*hdr) > len)
> +               return -EINVAL;
> +
> +       hdr = (void *)data;
> +       ptr = data + sizeof(*hdr);
> +       num_subsecs = le16_to_cpu(hdr->num);
> +       for (i = 0; i < num_subsecs; i++) {
> +               common_subsec = (void *)ptr;
> +               if (ptr + sizeof(*common_subsec) > end)
> +                       break;
> +               ptr += sizeof(*common_subsec);
> +
> +               subsec_len = le32_to_cpu(common_subsec->len);
> +               if (ptr + subsec_len > end)
> +                       break;
> +               ptr += subsec_len;
> +       }
> +
> +       if (i < num_subsecs)
> +               return -EOVERFLOW;
> +
> +       ptr = data + sizeof(*hdr);
> +       for (i = 0; i < num_subsecs; i++) {
> +               common_subsec = (void *)ptr;
> +               subsec_len = le32_to_cpu(common_subsec->len);
> +               ptr += sizeof(*common_subsec);
> +
> +               if (common_subsec->eco != btrtl_dev->rom_version + 1) {
> +                       ptr += subsec_len;
> +                       continue;
> +               }
> +
> +               switch (opcode) {
> +               case RTL_PATCH_SECURITY_HEADER:
> +                       sec_hdr = (void *)common_subsec;
> +                       if (sec_hdr->key_id != btrtl_dev->key_id) {
> +                               ptr += subsec_len;
> +                               continue;
> +                       }
> +                       break;
> +               }
> +
> +               subsec = kzalloc(sizeof(*subsec), GFP_KERNEL);
> +               if (!subsec)
> +                       return -ENOMEM;
> +               subsec->prio = common_subsec->prio;
> +               subsec->len  = subsec_len;
> +               subsec->data = ptr;
> +               btrtl_insert_ordered_subsec(subsec, btrtl_dev);
> +
> +               ptr += subsec_len;
> +               rc  += subsec_len;
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
> +       int len = 0;
> +       int i;
> +       int secure = 0;
> +       int dummy = 0;
> +       u8 *ptr;
> +       /* Cut the tail of the firmware. */
> +       u8 *end = btrtl_dev->fw_data + btrtl_dev->fw_len - 7;
> +
> +       rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> +       if (rc < 0)
> +               return -EIO;
> +
> +       key_id = reg_val[0];
> +       rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
> +       btrtl_dev->key_id = key_id;
> +
> +       hdr = (struct rtl_epatch_header_v2 *)btrtl_dev->fw_data;
> +       num_sections = le32_to_cpu(hdr->num_sections);
> +
> +       rtl_dev_dbg(hdev, "FW version %08x-%08x", *((u32 *)hdr->fw_version),
> +                   *((u32 *)(hdr->fw_version + 4)));
> +
> +       ptr = btrtl_dev->fw_data + sizeof(*hdr);
> +       for (i = 0; i < num_sections; i++) {
> +               section = (void *)ptr;
> +               if (ptr + sizeof(*section) > end)
> +                       break;
> +               ptr += sizeof(*section);
> +
> +               section_len = le32_to_cpu(section->len);
> +               if (ptr + section_len > end)
> +                       break;
> +               ptr += section_len;
> +       }
> +
> +       if (i < num_sections)
> +               return -EOVERFLOW;
> +
> +       ptr = btrtl_dev->fw_data + sizeof(*hdr);
> +       for (i = 0; i < num_sections; i++) {
> +               section = (void *)ptr;
> +               rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
> +               ptr += sizeof(*section);
> +
> +               section_len = le32_to_cpu(section->len);
> +               opcode      = le32_to_cpu(section->opcode);
> +               switch (opcode) {
> +               case RTL_PATCH_SNIPPETS:
> +                       rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
> +                                                section_len);
> +                       break;
> +               case RTL_PATCH_SECURITY_HEADER:
> +                       /* If key_id from chip is zero, ignore all security
> +                        * headers.
> +                        */
> +                       if (!key_id)
> +                               break;
> +                       rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
> +                                                section_len);
> +                       if (rc > 0)
> +                               secure += rc;
> +
> +                       break;
> +               case RTL_PATCH_DUMMY_HEADER:
> +                       if (key_id)
> +                               break;
> +                       rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
> +                                                section_len);
> +                       if (rc > 0)
> +                               dummy += rc;
> +                       break;
> +               default:
> +                       rc = 0;
> +                       break;
> +               }
> +               if (rc < 0) {
> +                       rtl_dev_err(hdev, "RTL: Parse section (%u) err %d",
> +                                   opcode, rc);
> +                       return rc;
> +               }
> +               len += rc;
> +               ptr += section_len;
> +       }
> +
> +       if (!len)
> +               return -ENODATA;
> +
> +       bt_dev_info(hdev, "RTL: Patch (len %d) found", len);
> +
> +       /* Allocate mem and copy all found subsecs. */
> +       ptr = kvmalloc(len, GFP_KERNEL);
> +       if (!ptr)
> +               return -ENOMEM;
> +
> +       len = 0;
> +       list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
> +               rtl_dev_dbg(hdev, "RTL: len 0x%x", entry->len);
> +               memcpy(ptr + len, entry->data, entry->len);
> +               len += entry->len;
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
> +
> +       *_buf = ptr;
> +       return len;
> +}
> +
>  static int rtlbt_parse_firmware(struct hci_dev *hdev,
>                                 struct btrtl_device_info *btrtl_dev,
>                                 unsigned char **_buf)
> @@ -317,7 +564,18 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>                 { RTL_ROM_LMP_8852A, 25 },      /* 8852C */
>         };
>
> -       min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
> +       if (btrtl_dev->fw_len <= 8)
> +               return -EINVAL;
> +
> +       if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
> +               min_size = sizeof(struct rtl_epatch_header) +
> +                               sizeof(extension_sig) + 3;
> +       else if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, 8))
> +               min_size = sizeof(struct rtl_epatch_header_v2) +
> +                               sizeof(extension_sig) + 3;
> +       else
> +               return -EINVAL;
> +
>         if (btrtl_dev->fw_len < min_size)
>                 return -EINVAL;
>
> @@ -382,12 +640,14 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>                 return -EINVAL;
>         }
>
> -       epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
> -       if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
> +       if (memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8) != 0) {
> +               if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, 8))
> +                       return rtlbt_parse_firmware_v2(hdev, btrtl_dev, _buf);
>                 rtl_dev_err(hdev, "bad EPATCH signature");
>                 return -EINVAL;
>         }
>
> +       epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
>         num_patches = le16_to_cpu(epatch_info->num_patches);
>         BT_DBG("fw_version=%x, num_patches=%d",
>                le32_to_cpu(epatch_info->fw_version), num_patches);
> @@ -451,6 +711,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>         int frag_len = RTL_FRAG_LEN;
>         int ret = 0;
>         int i;
> +       int j = 0;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *rp;
>
> @@ -461,17 +722,16 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>         for (i = 0; i < frag_num; i++) {
>                 struct sk_buff *skb;
>
> -               BT_DBG("download fw (%d/%d)", i, frag_num);
> -
> -               if (i > 0x7f)
> -                       dl_cmd->index = (i & 0x7f) + 1;
> -               else
> -                       dl_cmd->index = i;
> +               dl_cmd->index = j++;
> +               if (dl_cmd->index == 0x7f)
> +                       j = 1;
>
>                 if (i == (frag_num - 1)) {
>                         dl_cmd->index |= 0x80; /* data end */
>                         frag_len = fw_len % RTL_FRAG_LEN;
>                 }
> +               rtl_dev_dbg(hdev, "download fw (%d/%d). index = %d", i,
> +                               frag_num, dl_cmd->index);
>                 memcpy(dl_cmd->data, data, frag_len);
>
>                 /* Send download command */
> @@ -589,8 +849,16 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
>
>  void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
> +       struct rtl_subsection *entry, *tmp;
> +
>         kvfree(btrtl_dev->fw_data);
>         kvfree(btrtl_dev->cfg_data);
> +
> +       list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
> +
>         kfree(btrtl_dev);
>  }
>  EXPORT_SYMBOL_GPL(btrtl_free);
> @@ -604,9 +872,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>         char cfg_name[40];
>         u16 hci_rev, lmp_subver;
>         u8 hci_ver;
> +       u8 lmp_ver;
>         int ret;
>         u16 opcode;
>         u8 cmd[2];
> +       u8 reg_val[2];
>
>         btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
>         if (!btrtl_dev) {
> @@ -614,26 +884,56 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>                 goto err_alloc;
>         }
>
> +       INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +
> +check_version:
> +       ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
> +       if (ret < 0)
> +               goto err_free;
> +       lmp_subver = le16_to_cpu(*((u16 *)reg_val));
> +
> +       if (lmp_subver == RTL_ROM_LMP_8822B) {
> +               ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_REV, reg_val);
> +               if (ret < 0)
> +                       goto err_free;
> +               hci_rev = le16_to_cpu(*((u16 *)reg_val));
> +
> +               /* 8822E */
> +               if (hci_rev == 0x000e) {
> +                       hci_ver = 0x0c;
> +                       lmp_ver = 0x0c;
> +                       btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev,
> +                                                           hci_ver, hdev->bus);
> +                       goto next;
> +               }
> +       }
> +
>         skb = btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret = PTR_ERR(skb);
>                 goto err_free;
>         }
> -
>         resp = (struct hci_rp_read_local_version *)skb->data;
> -       rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
> -                    resp->hci_ver, resp->hci_rev,
> -                    resp->lmp_ver, resp->lmp_subver);
>
> -       hci_ver = resp->hci_ver;
> -       hci_rev = le16_to_cpu(resp->hci_rev);
> +       hci_ver    = resp->hci_ver;
> +       hci_rev    = le16_to_cpu(resp->hci_rev);
> +       lmp_ver    = resp->lmp_ver;
>         lmp_subver = le16_to_cpu(resp->lmp_subver);
>
> +       kfree_skb(skb);
> +
>         btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
>                                             hdev->bus);
>
> -       if (!btrtl_dev->ic_info)
> +next:
> +       rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
> +                    hci_ver, hci_rev,
> +                    lmp_ver, lmp_subver);
> +
> +       if (!btrtl_dev->ic_info && !btrtl_dev->drop_fw)
>                 btrtl_dev->drop_fw = true;
> +       else
> +               btrtl_dev->drop_fw = false;
>
>         if (btrtl_dev->drop_fw) {
>                 opcode = hci_opcode_pack(0x3f, 0x66);
> @@ -642,41 +942,25 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>
>                 skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>                 if (!skb)
> -                       goto out_free;
> +                       goto err_free;
>
>                 skb_put_data(skb, cmd, sizeof(cmd));
>                 hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>
> -               hdev->send(hdev, skb);
> +               ret = hdev->send(hdev, skb);
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "sending frame failed (%d)", ret);
> +                       kfree_skb(skb);
> +                       goto err_free;
> +               }
>
>                 /* Ensure the above vendor command is sent to controller and
>                  * process has done.
>                  */
>                 msleep(200);
>
> -               /* Read the local version again. Expect to have the vanilla
> -                * version as cold boot.
> -                */
> -               skb = btrtl_read_local_version(hdev);
> -               if (IS_ERR(skb)) {
> -                       ret = PTR_ERR(skb);
> -                       goto err_free;
> -               }
> -
> -               resp = (struct hci_rp_read_local_version *)skb->data;
> -               rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
> -                            resp->hci_ver, resp->hci_rev,
> -                            resp->lmp_ver, resp->lmp_subver);
> -
> -               hci_ver = resp->hci_ver;
> -               hci_rev = le16_to_cpu(resp->hci_rev);
> -               lmp_subver = le16_to_cpu(resp->lmp_subver);
> -
> -               btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
> -                                                   hdev->bus);
> +               goto check_version;
>         }
> -out_free:
> -       kfree_skb(skb);
>
>         if (!btrtl_dev->ic_info) {
>                 rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index ebf0101c959b..9fbfe323120b 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -47,6 +47,67 @@ struct rtl_vendor_config {
>         struct rtl_vendor_config_entry entry[];
>  } __packed;
>
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
> +struct rtl_snippet {
> +       __u8   eco;
> +       __u8   prio;
> +       __u16  reserved;
> +       __le32 len;
> +       __u8   data[];
> +} __packed;
> +
> +struct rtl_dummy_hdr {
> +       __u8   eco;
> +       __u8   prio;
> +       __le16 reserved;
> +       __le32 len;
> +       __u8   data[];
> +} __packed;
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
> +       u8 prio;
> +       u32 len;
> +       u8 *data;
> +};
> +
> +struct rtl_vendor_cmd {
> +       __u8 param[5];
> +} __packed;
> +
>  enum {
>         REALTEK_ALT6_CONTINUOUS_TX_CHIP,
>
> --
> 2.34.1
>


-- 
Luiz Augusto von Dentz
