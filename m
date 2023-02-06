Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593968B95E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBFKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBFKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:05:05 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CD206A7;
        Mon,  6 Feb 2023 02:03:51 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 60A9361CC40F9;
        Mon,  6 Feb 2023 11:03:11 +0100 (CET)
Message-ID: <5c249a19-f79b-346d-2fb1-cdfc05324909@molgen.mpg.de>
Date:   Mon, 6 Feb 2023 11:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND] Bluetooth: btrtl: Add support for RTL8852BS
Content-Language: en-US
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206063334.45861-1-victor@allwinnertech.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230206063334.45861-1-victor@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Victor,


Thank you for your patch.

Am 06.02.23 um 07:33 schrieb Victor Hassan:
> Add the support for RTL8852BS BT controller on UART interface.
> The necessary firmware file will be submitted to linux-firmware.
> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---
>   drivers/bluetooth/btrtl.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 69c3fe649ca7..36c3a23324f8 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -198,6 +198,14 @@ static const struct id_table ic_id_table[] = {
>   	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
>   	  .cfg_name = "rtl_bt/rtl8852bu_config" },
>   
> +	/* 8852B with UART interface */
> +	{ IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_UART),
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .has_msft_ext = true,
> +	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8852bs_config" },
> +

I’d sort *bs* before *bu*.

>   	/* 8852C */
>   	{ IC_INFO(RTL_ROM_LMP_8852A, 0xc, 0xc, HCI_USB),
>   	  .config_needed = false,
> @@ -965,5 +973,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");

Ditto.


Kind regards,

Paul
