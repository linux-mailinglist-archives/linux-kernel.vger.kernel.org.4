Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704C69591D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBNGXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:23:29 -0500
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152213DFB;
        Mon, 13 Feb 2023 22:23:27 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.179232|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.213737-0.00173606-0.784527;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.RLc3oUz_1676355804;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.RLc3oUz_1676355804)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 14:23:25 +0800
Message-ID: <0e5db8d4-9d33-0c26-cc39-0b43770901fe@allwinnertech.com>
Date:   Tue, 14 Feb 2023 14:23:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND] Bluetooth: btrtl: Add support for RTL8852BS
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206063334.45861-1-victor@allwinnertech.com>
 <5c249a19-f79b-346d-2fb1-cdfc05324909@molgen.mpg.de>
From:   Victor Hassan <victor@allwinnertech.com>
In-Reply-To: <5c249a19-f79b-346d-2fb1-cdfc05324909@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul:
   Thank you for your advises. I had send PATCH-v2 to fix it. Can you 
give me more advises?

On 2023/2/6 18:03, Paul Menzel wrote:
> Dear Victor,
> 
> 
> Thank you for your patch.
> 
> Am 06.02.23 um 07:33 schrieb Victor Hassan:
>> Add the support for RTL8852BS BT controller on UART interface.
>> The necessary firmware file will be submitted to linux-firmware.
>>
>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
>> ---
>>   drivers/bluetooth/btrtl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>> index 69c3fe649ca7..36c3a23324f8 100644
>> --- a/drivers/bluetooth/btrtl.c
>> +++ b/drivers/bluetooth/btrtl.c
>> @@ -198,6 +198,14 @@ static const struct id_table ic_id_table[] = {
>>         .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
>>         .cfg_name = "rtl_bt/rtl8852bu_config" },
>> +    /* 8852B with UART interface */
>> +    { IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_UART),
>> +      .config_needed = true,
>> +      .has_rom_version = true,
>> +      .has_msft_ext = true,
>> +      .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
>> +      .cfg_name = "rtl_bt/rtl8852bs_config" },
>> +
> 
> I’d sort *bs* before *bu*.
> 
>>       /* 8852C */
>>       { IC_INFO(RTL_ROM_LMP_8852A, 0xc, 0xc, HCI_USB),
>>         .config_needed = false,
>> @@ -965,5 +973,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
>>   MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
>>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>>   MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>> +MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
>> +MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
>>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
> 
> Ditto.
> 
> 
> Kind regards,
> 
> Paul
