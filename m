Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3C6E9FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjDTXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjDTXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:12:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B526B3;
        Thu, 20 Apr 2023 16:12:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso9530751fa.1;
        Thu, 20 Apr 2023 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682032357; x=1684624357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmDHFgakKQi6ueQUrVtV/dN3UoSrMFu5Fj3nKq50Hpo=;
        b=OfTy4ZBAjoNcBaLsrNa3jc0/yN7VVZjw4FCZLkmuiEtrkm6c2agsgvMj/LQcLZjCpD
         BO0IoDNtwj8ACLon7bQGedf8gwovmWyBfWyT2IGg0WBrK4rLOQ8AG3F8+KMfR2jOuqOC
         rivKrkY02EvRlzR+KjRY4Jjq9Ti1FxGABuMwxB10OEA60YmtpHOTw4Z3vKk83eaZf0f0
         1iEM0QqTuBoKidsUkYlUfcUZ6jOSg67GYIcsCgOJtch0hKV4y+mJMskNroUkdMK3Vny4
         TSUcnXNRxDL7KNxBa2SsZkrPQw3mAX8g/ksT6Jo9pxZ1H81G5QLmJwNzpscq5PwJV7If
         Twrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682032357; x=1684624357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmDHFgakKQi6ueQUrVtV/dN3UoSrMFu5Fj3nKq50Hpo=;
        b=kFxJlnvkYGKsuN2LVIeOwoo810wP/K/Nh3kooh9Fsgze6403DRGwwCs0UOcHeL+Y1U
         llqqXZL9HOqLbQ5QuakUYMaUJ18gxKXf30fs/vAggupOYF/lk5GWlpLeZ4K11TefnGH5
         BZf1sc8T+18YgoY6Lx/TqQmtMG/P4v9FodN41o3ia3tjQNWm4vxCjhOQg+ZSVgCb6j2X
         eigTpgFQ+F/Xz9mb/VaWjU2QyudUV+l3dYh64OF0y+cX5fnjR5kooVoKKwv8qmIgcVPI
         k9NrqJetdv1GTFYakMesCnUq+FXIcztnzQ8fOyOiYqjr1DbbIyTDZLyzWBKvrcMSm5J/
         1+sg==
X-Gm-Message-State: AAQBX9eWrYA+M/AvmlI86wMjbZGu/GiqxVY0ikNQ5hc6wKSGbeJnHJUc
        QyhpI2LsNCNCSLCSloXyGadvUTSA5gajet1SZLE=
X-Google-Smtp-Source: AKy350Zl10tvLDk1J0YLQIUU8jTJFHLOf7gcO67GskX6nLiP9N6Q5bFYb6HYCo1z5EigfgwF39WqpuGXd/KrlyZIA5Y=
X-Received: by 2002:a2e:b0ec:0:b0:2a7:a691:f5f2 with SMTP id
 h12-20020a2eb0ec000000b002a7a691f5f2mr174802ljl.8.1682032356404; Thu, 20 Apr
 2023 16:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230420105343.2014-1-hildawu@realtek.com>
In-Reply-To: <20230420105343.2014-1-hildawu@realtek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Apr 2023 16:12:24 -0700
Message-ID: <CABBYNZJ5q1BJ3LFLgcevEM-NZMiqXy24qpUbOvbYskEBuR+dug@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btrtl: Add Realtek devcoredump support
To:     hildawu@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmandlik@google.com, apusaka@chromium.org, yinghsu@chromium.org,
        alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
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

Hi,

On Thu, Apr 20, 2023 at 3:53=E2=80=AFAM <hildawu@realtek.com> wrote:
>
> From: Hilda Wu <hildawu@realtek.com>
>
> Catch debug exception from controller and driver, and trigger a
> devcoredump using hci devcoredump APIs. The debug exception data
> will be parsed in userspace.
>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Changes in v3:
>  - Rebase, fixed merge confilt
>
> Changes in v2:
>  - According to devcoredump API revision, modified related part.
> ---
> ---
>  drivers/bluetooth/btrtl.c | 145 +++++++++++++++++++++++++++++++-------
>  drivers/bluetooth/btrtl.h |   6 ++
>  drivers/bluetooth/btusb.c |  74 +++++++++++++++++++
>  3 files changed, 198 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 2915c82d719d..ffb94d6481e2 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -32,6 +32,8 @@
>  #define RTL_ROM_LMP_8851B      0x8851
>  #define RTL_CONFIG_MAGIC       0x8723ab55
>
> +#define RTL_VSC_OP_COREDUMP    0xfcff
> +
>  #define IC_MATCH_FL_LMPSUBV    (1 << 0)
>  #define IC_MATCH_FL_HCIREV     (1 << 1)
>  #define IC_MATCH_FL_HCIVER     (1 << 2)
> @@ -81,6 +83,7 @@ struct id_table {
>         bool has_msft_ext;
>         char *fw_name;
>         char *cfg_name;
> +       char *hw_info;
>  };
>
>  struct btrtl_device_info {
> @@ -102,21 +105,24 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D false,
>           .fw_name =3D "rtl_bt/rtl8723a_fw.bin",
> -         .cfg_name =3D NULL },
> +         .cfg_name =3D NULL,
> +         .hw_info =3D "rtl8723au" },
>
>         /* 8723BS */
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723bs_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723bs_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723bs_config",
> +         .hw_info  =3D "rtl8723bs" },
>
>         /* 8723B */
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723b_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723b_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723b_config",
> +         .hw_info  =3D "rtl8723bu" },
>
>         /* 8723CS-CG */
>         { .match_flags =3D IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
> @@ -127,7 +133,8 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723cs_cg_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723cs_cg_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723cs_cg_config",
> +         .hw_info  =3D "rtl8723cs-cg" },
>
>         /* 8723CS-VF */
>         { .match_flags =3D IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
> @@ -138,7 +145,8 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723cs_vf_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723cs_vf_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723cs_vf_config",
> +         .hw_info  =3D "rtl8723cs-vf" },
>
>         /* 8723CS-XX */
>         { .match_flags =3D IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
> @@ -149,28 +157,32 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723cs_xx_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723cs_xx_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723cs_xx_config",
> +         .hw_info  =3D "rtl8723cs" },
>
>         /* 8723D */
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723d_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723d_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723d_config",
> +         .hw_info  =3D "rtl8723du" },
>
>         /* 8723DS */
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8723ds_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8723ds_config" },
> +         .cfg_name =3D "rtl_bt/rtl8723ds_config",
> +         .hw_info  =3D "rtl8723ds" },
>
>         /* 8821A */
>         { IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8821a_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8821a_config" },
> +         .cfg_name =3D "rtl_bt/rtl8821a_config",
> +         .hw_info  =3D "rtl8821au" },
>
>         /* 8821C */
>         { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
> @@ -178,7 +190,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8821c_config" },
> +         .cfg_name =3D "rtl_bt/rtl8821c_config",
> +         .hw_info  =3D "rtl8821cu" },
>
>         /* 8821CS */
>         { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
> @@ -186,14 +199,16 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8821cs_config" },
> +         .cfg_name =3D "rtl_bt/rtl8821cs_config",
> +         .hw_info  =3D "rtl8821cs" },
>
>         /* 8761A */
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8761a_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8761a_config" },
> +         .cfg_name =3D "rtl_bt/rtl8761a_config",
> +         .hw_info  =3D "rtl8761au" },
>
>         /* 8761B */
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
> @@ -201,14 +216,16 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8761b_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8761b_config" },
> +         .cfg_name =3D "rtl_bt/rtl8761b_config",
> +         .hw_info  =3D "rtl8761btv" },
>
>         /* 8761BU */
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .fw_name  =3D "rtl_bt/rtl8761bu_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8761bu_config" },
> +         .cfg_name =3D "rtl_bt/rtl8761bu_config",
> +         .hw_info  =3D "rtl8761bu" },
>
>         /* 8822C with UART interface */
>         { IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
> @@ -216,7 +233,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8822cs_config" },
> +         .cfg_name =3D "rtl_bt/rtl8822cs_config",
> +         .hw_info  =3D "rtl8822cs" },
>
>         /* 8822C with UART interface */
>         { IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
> @@ -224,7 +242,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8822cs_config" },
> +         .cfg_name =3D "rtl_bt/rtl8822cs_config",
> +         .hw_info  =3D "rtl8822cs" },
>
>         /* 8822C with USB interface */
>         { IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
> @@ -232,7 +251,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8822cu_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8822cu_config" },
> +         .cfg_name =3D "rtl_bt/rtl8822cu_config",
> +         .hw_info  =3D "rtl8822cu" },
>
>         /* 8822B */
>         { IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_USB),
> @@ -240,7 +260,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8822b_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8822b_config" },
> +         .cfg_name =3D "rtl_bt/rtl8822b_config",
> +         .hw_info  =3D "rtl8822bu" },
>
>         /* 8852A */
>         { IC_INFO(RTL_ROM_LMP_8852A, 0xa, 0xb, HCI_USB),
> @@ -248,7 +269,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8852au_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8852au_config" },
> +         .cfg_name =3D "rtl_bt/rtl8852au_config",
> +         .hw_info  =3D "rtl8852au" },
>
>         /* 8852B with UART interface */
>         { IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_UART),
> @@ -256,7 +278,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8852bs_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8852bs_config" },
> +         .cfg_name =3D "rtl_bt/rtl8852bs_config",
> +         .hw_info  =3D "rtl8852bs" },
>
>         /* 8852B */
>         { IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_USB),
> @@ -264,7 +287,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8852bu_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8852bu_config" },
> +         .cfg_name =3D "rtl_bt/rtl8852bu_config",
> +         .hw_info  =3D "rtl8852bu" },
>
>         /* 8852C */
>         { IC_INFO(RTL_ROM_LMP_8852A, 0xc, 0xc, HCI_USB),
> @@ -272,7 +296,8 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
>           .fw_name  =3D "rtl_bt/rtl8852cu_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8852cu_config" },
> +         .cfg_name =3D "rtl_bt/rtl8852cu_config",
> +         .hw_info  =3D "rtl8852cu" },
>
>         /* 8851B */
>         { IC_INFO(RTL_ROM_LMP_8851B, 0xb, 0xc, HCI_USB),
> @@ -280,9 +305,16 @@ static const struct id_table ic_id_table[] =3D {
>           .has_rom_version =3D true,
>           .has_msft_ext =3D false,
>           .fw_name  =3D "rtl_bt/rtl8851bu_fw.bin",
> -         .cfg_name =3D "rtl_bt/rtl8851bu_config" },
> +         .cfg_name =3D "rtl_bt/rtl8851bu_config",
> +         .hw_info  =3D "rtl8851bu" },
>         };
>
> +static struct {
> +       const char *driver_name;
> +       char *controller;
> +       u32  fw_version;
> +} coredump_info;
> +
>  static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev=
,
>                                              u8 hci_ver, u8 hci_bus,
>                                              u8 chip_type)
> @@ -707,6 +739,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>         num_patches =3D le16_to_cpu(epatch_info->num_patches);
>         BT_DBG("fw_version=3D%x, num_patches=3D%d",
>                le32_to_cpu(epatch_info->fw_version), num_patches);
> +       coredump_info.fw_version =3D le32_to_cpu(epatch_info->fw_version)=
;
>
>         /* After the rtl_epatch_header there is a funky patch metadata se=
ction.
>          * Assuming 2 patches, the layout is:
> @@ -903,6 +936,50 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev=
,
>         return ret;
>  }
>
> +static void btrtl_coredump(struct hci_dev *hdev)
> +{
> +       static const u8 param[] =3D { 0x00, 0x00 };
> +
> +       __hci_cmd_send(hdev, RTL_VSC_OP_COREDUMP, sizeof(param), param);
> +}
> +
> +static void btrtl_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       char buf[80];
> +
> +       if (coredump_info.controller)
> +               snprintf(buf, sizeof(buf), "Controller Name: %s\n",
> +                        coredump_info.controller);
> +       else
> +               snprintf(buf, sizeof(buf), "Controller Name: Unknown\n");
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Firmware Version: 0x%X\n",
> +                coredump_info.fw_version);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Driver: %s\n", coredump_info.driver_n=
ame);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Vendor: Realtek\n");
> +       skb_put_data(skb, buf, strlen(buf));
> +}
> +
> +static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
> +{
> +       int err;
> +
> +       err =3D hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, N=
ULL);
> +
> +       return err;
> +}
> +
> +void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name=
)
> +{
> +       coredump_info.driver_name =3D driver_name;
> +}
> +EXPORT_SYMBOL_GPL(btrtl_set_driver_name);

If there are multiple drivers calling the above they will likely
overwrite driver_name.

> +
>  static bool rtl_has_chip_type(u16 lmp_subver)
>  {
>         switch (lmp_subver) {
> @@ -1113,6 +1190,9 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         if (btrtl_dev->ic_info->has_msft_ext)
>                 hci_set_msft_opcode(hdev, 0xFCF0);
>
> +       if (btrtl_dev->ic_info)
> +               coredump_info.controller =3D btrtl_dev->ic_info->hw_info;

Ditto, coredump_info needs to be stored on a per hdev basis, probably
inside btrtl_device_info.

> +
>         return btrtl_dev;
>
>  err_free:
> @@ -1125,6 +1205,8 @@ EXPORT_SYMBOL_GPL(btrtl_initialize);
>  int btrtl_download_firmware(struct hci_dev *hdev,
>                             struct btrtl_device_info *btrtl_dev)
>  {
> +       int err =3D 0;
> +
>         /* Match a set of subver values that correspond to stock firmware=
,
>          * which is not compatible with standard btusb.
>          * If matched, upload an alternative firmware that does conform t=
o
> @@ -1133,12 +1215,14 @@ int btrtl_download_firmware(struct hci_dev *hdev,
>          */
>         if (!btrtl_dev->ic_info) {
>                 rtl_dev_info(hdev, "assuming no firmware upload needed");
> -               return 0;
> +               err =3D 0;
> +               goto done;
>         }
>
>         switch (btrtl_dev->ic_info->lmp_subver) {
>         case RTL_ROM_LMP_8723A:
> -               return btrtl_setup_rtl8723a(hdev, btrtl_dev);
> +               err =3D btrtl_setup_rtl8723a(hdev, btrtl_dev);
> +               break;
>         case RTL_ROM_LMP_8723B:
>         case RTL_ROM_LMP_8821A:
>         case RTL_ROM_LMP_8761A:
> @@ -1146,11 +1230,18 @@ int btrtl_download_firmware(struct hci_dev *hdev,
>         case RTL_ROM_LMP_8852A:
>         case RTL_ROM_LMP_8703B:
>         case RTL_ROM_LMP_8851B:
> -               return btrtl_setup_rtl8723b(hdev, btrtl_dev);
> +               err =3D btrtl_setup_rtl8723b(hdev, btrtl_dev);
> +               break;
>         default:
>                 rtl_dev_info(hdev, "assuming no firmware upload needed");
> -               return 0;
> +               break;
>         }
> +
> +done:
> +       if (!err)
> +               err =3D btrtl_register_devcoredump_support(hdev);
> +
> +       return err;
>  }
>  EXPORT_SYMBOL_GPL(btrtl_download_firmware);
>
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index adb4c2c9abc5..fe2888c2d175 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -139,6 +139,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             struct btrtl_device_info *btrtl_dev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
> +void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name=
);
>
>  #else
>
> @@ -182,4 +183,9 @@ static inline int btrtl_get_uart_settings(struct hci_=
dev *hdev,
>         return -ENOENT;
>  }
>
> +static inline void btrtl_set_driver_name(struct hci_dev *hdev, const cha=
r *driver_name)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3aa189b1986d..5fa90347a4e1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -869,10 +869,49 @@ static void btusb_intel_cmd_timeout(struct hci_dev =
*hdev)
>         gpiod_set_value_cansleep(reset_gpio, 0);
>  }
>
> +#define RTK_DEVCOREDUMP_CODE_MEMDUMP           0x01
> +#define RTK_DEVCOREDUMP_CODE_HW_ERR            0x02
> +#define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT       0x03
> +
> +#define RTK_SUB_EVENT_CODE_COREDUMP            0x34
> +
> +struct rtk_dev_coredump_hdr {
> +       u8 type;
> +       u8 code;
> +       u8 reserved[2];
> +} __packed;
> +
> +static inline void btusb_rtl_alloc_devcoredump(struct hci_dev *hdev,
> +               struct rtk_dev_coredump_hdr *hdr, u8 *buf, u32 len)
> +{
> +       struct sk_buff *skb;
> +
> +       skb =3D alloc_skb(len + sizeof(*hdr), GFP_ATOMIC);
> +       if (!skb)
> +               return;
> +
> +       skb_put_data(skb, hdr, sizeof(*hdr));
> +       if (len)
> +               skb_put_data(skb, buf, len);
> +
> +       if (!hci_devcd_init(hdev, skb->len)) {
> +               hci_devcd_append(hdev, skb);
> +               hci_devcd_complete(hdev);
> +       } else {
> +               bt_dev_err(hdev, "RTL: Failed to generate devcoredump");
> +               kfree_skb(skb);
> +       }
> +}
> +
>  static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> +       struct rtk_dev_coredump_hdr hdr =3D {
> +               .type =3D RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT,
> +       };
> +
> +       btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
>
>         if (++data->cmd_timeout_cnt < 5)
>                 return;
> @@ -899,6 +938,18 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hd=
ev)
>         gpiod_set_value_cansleep(reset_gpio, 0);
>  }
>
> +static void btusb_rtl_hw_error(struct hci_dev *hdev, u8 code)
> +{
> +       struct rtk_dev_coredump_hdr hdr =3D {
> +               .type =3D RTK_DEVCOREDUMP_CODE_HW_ERR,
> +               .code =3D code,
> +       };
> +
> +       bt_dev_info(hdev, "RTL: hw err, trigger devcoredump");

This probably should be printed as an error with bt_dev_err and print
the code as well.

> +       btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
> +}
> +
>  static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -2539,6 +2590,25 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>         return ret;
>  }
>
> +static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff=
 *skb)
> +{
> +       if (skb->data[0] =3D=3D HCI_VENDOR_PKT && skb->data[2] =3D=3D RTK=
_SUB_EVENT_CODE_COREDUMP) {
> +               struct rtk_dev_coredump_hdr hdr =3D {
> +                       .code =3D RTK_DEVCOREDUMP_CODE_MEMDUMP,
> +               };
> +
> +               bt_dev_info(hdev, "RTL: received coredump vendor evt, len=
 %u",
> +                       skb->len);

The above should probably be using bt_dev_dbg instead bt_dev_info.

> +               btusb_rtl_alloc_devcoredump(hdev, &hdr, skb->data, skb->l=
en);
> +               kfree_skb(skb);
> +
> +               return 0;
> +       }
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +
>  /* UHW CR mapping */
>  #define MTK_BT_MISC            0x70002510
>  #define MTK_BT_SUBSYS_RST      0x70002610
> @@ -3978,6 +4048,8 @@ static int btusb_probe(struct usb_interface *intf,
>         } else if (id->driver_info & BTUSB_REALTEK) {
>                 /* Allocate extra space for Realtek device */
>                 priv_size +=3D sizeof(struct btrealtek_data);
> +
> +               data->recv_event =3D btusb_recv_event_realtek;
>         }
>
>         data->recv_acl =3D hci_recv_frame;
> @@ -4136,9 +4208,11 @@ static int btusb_probe(struct usb_interface *intf,
>
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
>             (id->driver_info & BTUSB_REALTEK)) {
> +               btrtl_set_driver_name(hdev, btusb_driver.name);
>                 hdev->setup =3D btusb_setup_realtek;
>                 hdev->shutdown =3D btrtl_shutdown_realtek;
>                 hdev->cmd_timeout =3D btusb_rtl_cmd_timeout;
> +               hdev->hw_error =3D btusb_rtl_hw_error;
>
>                 /* Realtek devices need to set remote wakeup on auto-susp=
end */
>                 set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
