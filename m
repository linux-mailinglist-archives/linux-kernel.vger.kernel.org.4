Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F968F7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjBHTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjBHTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:04:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BB56498;
        Wed,  8 Feb 2023 11:03:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h4so20507746lja.2;
        Wed, 08 Feb 2023 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwI3aK586VHzNzcOidiZWo9e3xxjvTb1Ua8omhn3lyg=;
        b=OdCeMA4o0UE5DSnrM0ucCNl0eFPoUKjcAsiiVlLsWP86U4IYTdFZOh0vy9pKSnEean
         fG3N8VAhoAOnYts9hmF1G/yMl5IqfyaB+jJbC1M9jtZ2iEuoulAnoPi5xvPbpJxgOGRc
         wxQNPRzetteZ3IzqH92gsXWYojp3siAoLEy+ENKyBkxV/GyENVtr80+YTVV4LZ+gkqCk
         zq4QrTfojwAXO84zDl2BSHH+1F/B4/mpNVJLjmTQmAWmUFH4L4mOe69hjGM6/zMAVz6j
         uqmna9yGSRbNNP1R1K8F6ALN6lf92C8eoMX4bdgtwS5T/Ic3ajrkizlUNZwxeXawDxD2
         ENLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwI3aK586VHzNzcOidiZWo9e3xxjvTb1Ua8omhn3lyg=;
        b=uyFUa4yelKHDIgr9Aowjmv1xFZvHj54cgD/FvXNTwdC3p0SnsrtHFG7DfAksEZ9PB4
         abvI9E3Bht+wccbVae7zmia0JedVEATKXy+vR3uKSbLBrinpDB5e5qjKH5T5kh9efGO+
         /VbYbsN9myLb5gJlLAxKW6pL1TEmYPDbVBtICbeGOALAVkpEOnYmj8Bv2RWxA7KFjt38
         eWsSvaZRXRhArWdbj8gu9KXRemMgQkpoPs1/9ThMKyJqlsIov47wLXNhkRqz+TuG+je3
         Dhkd0L03TiBZ2C8KXZneqSqBhKNugosWb3PVBgAhALwCbRCrWE29KVKr7O4TzLvn82wN
         XL/A==
X-Gm-Message-State: AO0yUKW8o3pcRe60fBOjXDh2YqVPgxXu26nT1el+PkYzdzfu6g82Vzeb
        a0iyz7y9tY40Dvuz2JBCoyGGmnbSmFnrIOi73/4=
X-Google-Smtp-Source: AK7set/QKhFg3n/nCb2zoNs0vGv0NPfzNfcoZ5TscCUslhnPJKO5Qq90El4R2LI0EBD/N97F4mT/h3FfOkyMi1n+tQA=
X-Received: by 2002:a2e:9c4b:0:b0:293:ed1:ee6f with SMTP id
 t11-20020a2e9c4b000000b002930ed1ee6fmr1602262ljj.119.1675882990791; Wed, 08
 Feb 2023 11:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20230208094038.13670-1-quic_tjiang@quicinc.com>
In-Reply-To: <20230208094038.13670-1-quic_tjiang@quicinc.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Feb 2023 11:02:59 -0800
Message-ID: <CABBYNZLaOcYU-2HsSuJy4E6-OyfffmZdfK5mxWY=Wto4G84ySA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hbandi@quicinc.com, quic_hemantg@quicinc.com, mka@chromium.org
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

Hi Tim,

On Wed, Feb 8, 2023 at 1:44 AM Tim Jiang <quic_tjiang@quicinc.com> wrote:
>
> This patch adds support for QCA2066, including the devicetree
> and patch/nvm downloading.
>
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 85 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btqca.h   |  2 +
>  drivers/bluetooth/hci_qca.c |  6 +++
>  3 files changed, 93 insertions(+)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c9064d34d830..7d00df3a1d61 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,55 @@ static int qca_send_reset(struct hci_dev *hdev)
>         return 0;
>  }
>
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u8 *bid)
> +{
> +       u8 cmd;
> +       struct sk_buff *skb;
> +       struct edl_event_hdr *edl;
> +       int err;
> +       int bid_len;
> +
> +       bt_dev_dbg(hdev, "QCA read board ID");
> +
> +       cmd = EDL_GET_BID_REQ_CMD;
> +       skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +                               &cmd, 0, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err = PTR_ERR(skb);
> +               bt_dev_err(hdev, "Reading QCA board ID failed (%d)",
> +                          err);
> +               return err;
> +       }
> +
> +       edl = (struct edl_event_hdr *)(skb->data);

Please use skb_pull_data that checks if the skb has enough data.

> +       if (!edl) {
> +               bt_dev_err(hdev, "QCA read board ID with no header");
> +               err = -EILSEQ;
> +               goto out;
> +       }
> +
> +       if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +           edl->rtype != EDL_GET_BID_REQ_CMD) {
> +               bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +                          edl->rtype);
> +               err = -EIO;
> +               goto out;
> +       }
> +
> +       bid_len = edl->data[0];
> +       bid[0] = edl->data[1];
> +       bid[1] = edl->data[2];
> +       bt_dev_info(hdev, "QCA board ID len %d,id = %x %x", bid_len, bid[0], bid[1]);
> +
> +
> +       err = 0;
> +
> +out:
> +       kfree_skb(skb);
> +       return err;
> +}
> +
> +
>  int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> @@ -574,6 +623,32 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +                  size_t max_size, struct qca_btsoc_version ver, u8 *bid)
> +{
> +       u8 rom_ver = 0;
> +       u32 soc_ver;
> +       const char *variant;
> +
> +       soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +       rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +       bt_dev_info(hdev, "bid == 0x%02x 0x%02x", bid[0], bid[1]);
> +
> +       if ((ver.soc_id & 0x0000ff00) == 0x1200) /*hsp gf chip*/
> +               variant = "g";
> +       else
> +               variant = "";
> +
> +       if (bid[0] == 0 && bid[1] == 0) {
> +               snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +       } else {
> +               snprintf(fwname, max_size, "qca/hpnv%02x%s.%x%02x",
> +                       rom_ver, variant, bid[0], bid[1]);
> +       }
> +       bt_dev_info(hdev, "%s:  %s", __func__, fwname);
> +
> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>                    enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>                    const char *firmware_name)
> @@ -582,6 +657,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>         int err;
>         u8 rom_ver = 0;
>         u32 soc_ver;
> +       u8 bid[2] = {0};
>
>         bt_dev_dbg(hdev, "QCA setup on UART");
>
> @@ -607,6 +683,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>         } else if (soc_type == QCA_QCA6390) {
>                 snprintf(config.fwname, sizeof(config.fwname),
>                          "qca/htbtfw%02x.tlv", rom_ver);
> +       } else if (soc_type == QCA_QCA2066) {
> +               snprintf(config.fwname, sizeof(config.fwname),
> +                        "qca/hpbtfw%02x.tlv", rom_ver);
>         } else if (soc_type == QCA_WCN6750) {
>                 /* Choose mbn file by default.If mbn file is not found
>                  * then choose tlv file
> @@ -628,6 +707,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>         /* Give the controller some time to get ready to receive the NVM */
>         msleep(10);
>
> +       if (soc_type == QCA_QCA2066)
> +               qca_read_fw_board_id(hdev, bid);
> +
> +
>         /* Download NVM configuration */
>         config.type = TLV_TYPE_NVM;
>         if (firmware_name)
> @@ -645,6 +728,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>         else if (soc_type == QCA_QCA6390)
>                 snprintf(config.fwname, sizeof(config.fwname),
>                          "qca/htnv%02x.bin", rom_ver);
> +       else if (soc_type == QCA_QCA2066)
> +               qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname), ver, bid);
>         else if (soc_type == QCA_WCN6750)
>                 snprintf(config.fwname, sizeof(config.fwname),
>                          "qca/msnv%02x.bin", rom_ver);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 61e9a50e66ae..e762c403284a 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,7 @@
>  #define EDL_PATCH_TLV_REQ_CMD          (0x1E)
>  #define EDL_GET_BUILD_INFO_CMD         (0x20)
>  #define EDL_NVM_ACCESS_SET_REQ_CMD     (0x01)
> +#define EDL_GET_BID_REQ_CMD            (0x23)
>  #define EDL_PATCH_CONFIG_CMD           (0x28)
>  #define MAX_SIZE_PER_TLV_SEGMENT       (243)
>  #define QCA_PRE_SHUTDOWN_CMD           (0xFC08)
> @@ -147,6 +148,7 @@ enum qca_btsoc_type {
>         QCA_WCN3991,
>         QCA_QCA6390,
>         QCA_WCN6750,
> +       QCA_QCA2066,
>  };
>
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3df9e692756a..596f730ff375 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1859,6 +1859,11 @@ static const struct qca_device_data qca_soc_data_qca6390 = {
>         .num_vregs = 0,
>  };
>
> +static const struct qca_device_data qca_soc_data_qca2066 = {
> +       .soc_type = QCA_QCA2066,
> +       .num_vregs = 0,
> +};
> +
>  static const struct qca_device_data qca_soc_data_wcn6750 = {
>         .soc_type = QCA_WCN6750,
>         .vregs = (struct qca_vreg []) {
> @@ -2316,6 +2321,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
>  static const struct of_device_id qca_bluetooth_of_match[] = {
>         { .compatible = "qcom,qca6174-bt" },
>         { .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
> +       { .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

Ive been reviewing this changes and I must say I don't like this
pattern of setting a data specific for each soc and then still having
to check what type it is everywhere, it is probably a lot cleaner to
have fields that are soc specific added to qca_device_data directly so
when adding new soc type one just have to update this table.

>         { .compatible = "qcom,qca9377-bt" },
>         { .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>         { .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>


-- 
Luiz Augusto von Dentz
