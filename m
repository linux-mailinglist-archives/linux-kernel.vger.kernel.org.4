Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA0C736777
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjFTJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFTJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:15:57 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B31170F;
        Tue, 20 Jun 2023 02:15:20 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4ABD361E5FE04;
        Tue, 20 Jun 2023 11:13:32 +0200 (CEST)
Message-ID: <4986d15b-feb4-2111-39b5-20763d5b392f@molgen.mpg.de>
Date:   Tue, 20 Jun 2023 11:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] Bluetooth: btusb: Add support Mediatek MT7925
To:     Peter Tsao <peter.tsao@mediatek.com>
Cc:     Josh Boyer <jwboyer@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Chris Lu <chris.lu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.Wu@mediatek.com>,
        Aaron Hou <aaron.hou@mediatek.com>,
        Steve Lee <steve.lee@mediatek.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20230620082750.9218-1-peter.tsao@mediatek.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230620082750.9218-1-peter.tsao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Peter,


Thank you for your patch.

Am 20.06.23 um 10:27 schrieb Peter Tsao:
> This patch is added support Mediatek MT7925.

Maybe:

This patch adds support for the Mediatek MT7925.

Or in imperative mood:

Add support for the Mediatek MT7925.

Could you please add some more information to the chip. What chip is it 
similar to, what is different.

> 1. The firmware location of MT7925 will set to
> /lib/firmware/mediatek/mt7925

The firmware location of MT7925 is …

> 2. Add Mediatek private data in hdev
> to record the device for handle MT7925 flow.

Sorry, I do not understand. Could you please rephrase.

> 3. Use the recoreded dev_id to condition chip reset flow.

recorded

Could you please document the name and version of the datasheet you used?

> The information in /sys/kernel/debug/usb/devices about the MT7925U
> Bluetooth device is listed as the below
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 27 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0e8d ProdID=7925 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 5 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8f(I) Atr=03(Int.) MxPS=   2 Ivl=125us
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> I:* If#= 3 Alt= 0 #EPs= 9 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=   2 Ivl=125us
> 
> Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
> ---
>   drivers/bluetooth/btmtk.c |  1 +
>   drivers/bluetooth/btmtk.h |  5 +++
>   drivers/bluetooth/btusb.c | 78 +++++++++++++++++++++++++++++----------
>   3 files changed, 64 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 809762d64fc6..9482401d97fa 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -289,3 +289,4 @@ MODULE_FIRMWARE(FIRMWARE_MT7622);
>   MODULE_FIRMWARE(FIRMWARE_MT7663);
>   MODULE_FIRMWARE(FIRMWARE_MT7668);
>   MODULE_FIRMWARE(FIRMWARE_MT7961);
> +MODULE_FIRMWARE(FIRMWARE_MT7925);

Sort it lexicographically?

> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 2a88ea8e475e..fadc1a520652 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -5,6 +5,7 @@
>   #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
>   #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
>   #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
> +#define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"

Ditto.

>   #define HCI_EV_WMT 0xe4
>   #define HCI_WMT_MAX_EVENT_SIZE		64
> @@ -119,6 +120,10 @@ struct btmtk_hci_wmt_params {
>   	u32 *status;
>   };
>   
> +struct btmediatek_data {
> +	u32 dev_id;
> +};
> +
>   typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
>   				   struct btmtk_hci_wmt_params *);
>   
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8776e0f93c73..1328709c0f4f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2640,6 +2640,9 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
>   #define MTK_BT_RST_DONE		0x00000100
>   #define MTK_BT_RESET_WAIT_MS	100
>   #define MTK_BT_RESET_NUM_TRIES	10
> +#define MTK_BT_RESET_REG_CONNV3	0x70028610
> +#define MTK_BT_READ_DEV_ID	0x70010200
> +
>   
>   static void btusb_mtk_wmt_recv(struct urb *urb)
>   {
> @@ -3020,10 +3023,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>   	struct sk_buff *skb;
>   	const char *fwname;
>   	int err, status;
> -	u32 dev_id;
> +	u32 dev_id = 0;

Why?

>   	char fw_bin_name[64];
>   	u32 fw_version = 0;
>   	u8 param;
> +	struct btmediatek_data *mediatek;
>   
>   	calltime = ktime_get();
>   
> @@ -3033,7 +3037,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>   		return err;
>   	}
>   
> -	if (!dev_id) {
> +	if (!dev_id || dev_id != 0x7663) {

Define a macro for the id?

>   		err = btusb_mtk_id_get(data, 0x70010200, &dev_id);
>   		if (err < 0) {
>   			bt_dev_err(hdev, "Failed to get device id (%d)", err);
> @@ -3046,6 +3050,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>   		}
>   	}
>   
> +	mediatek = hci_get_priv(hdev);
> +	mediatek->dev_id = dev_id;
> +
>   	switch (dev_id) {
>   	case 0x7663:
>   		fwname = FIRMWARE_MT7663;
> @@ -3055,9 +3062,16 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>   		break;
>   	case 0x7922:
>   	case 0x7961:
> -		snprintf(fw_bin_name, sizeof(fw_bin_name),
> -			"mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
> -			 dev_id & 0xffff, (fw_version & 0xff) + 1);
> +	case 0x7925:

Sort it?

> +		if (dev_id == 0x7925)
> +			snprintf(fw_bin_name, sizeof(fw_bin_name),
> +				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
> +				 dev_id & 0xffff, dev_id & 0xffff, (fw_version & 0xff) + 1);

So this has a new subdirectory (mt%04x)? Why is that needed?

> +		else
> +			snprintf(fw_bin_name, sizeof(fw_bin_name),
> +				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
> +				 dev_id & 0xffff, (fw_version & 0xff) + 1);
> +
>   		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
>   						btusb_mtk_hci_wmt_sync);
>   		if (err < 0) {
> @@ -3200,6 +3214,7 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	u32 val;
>   	int err, retry = 0;
> +	struct btmediatek_data *mediatek;
>   
>   	/* It's MediaTek specific bluetooth reset mechanism via USB */
>   	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> @@ -3213,22 +3228,42 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
>   
>   	btusb_stop_traffic(data);
>   	usb_kill_anchored_urbs(&data->tx_anchor);
> +	mediatek = hci_get_priv(hdev);
> +
> +	if (mediatek->dev_id == 0x7925) {
> +		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
> +		val |= (1 << 5);
> +		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
> +		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
> +		val &= 0xFFFF00FF;
> +		val |= (1 << 13);
> +		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
> +		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
> +		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
> +		val |= (1 << 0);
> +		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
> +		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
> +		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> +		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
> +		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> +		msleep(100);

A delay of 100 ms is quite excessive. Please add comment to the 
datasheet section requiring this.

> +	} else {
> +		/* It's Device EndPoint Reset Option Register */
> +		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> +		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
> +		btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
>   
> -	/* It's Device EndPoint Reset Option Register */
> -	bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
> -	btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
> -	btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
> -
> -	/* Reset the bluetooth chip via USB interface. */
> -	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> -	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
> -	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> -	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
> -	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> -	/* MT7921 need to delay 20ms between toggle reset bit */
> -	msleep(20);
> -	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> -	btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +		/* Reset the bluetooth chip via USB interface. */
> +		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
> +		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
> +		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> +		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
> +		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
> +		/* MT7921 need to delay 20ms between toggle reset bit */
> +		msleep(20);
> +		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> +		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +	}

I’d factor both branches into two new functions.

>   
>   	/* Poll the register until reset is completed */
>   	do {
> @@ -4269,6 +4304,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		priv_size += sizeof(struct btrealtek_data);
>   
>   		data->recv_event = btusb_recv_event_realtek;
> +	} else if (id->driver_info & BTUSB_MEDIATEK) {
> +		/* Allocate extra space for Mediatek device */
> +		priv_size += sizeof(struct btmediatek_data);

This affects all Mediatek devices, right? Please make it a separate 
commit with a dedicated commit message.

>   	}
>   
>   	data->recv_acl = hci_recv_frame;


Kind regards,

Paul
