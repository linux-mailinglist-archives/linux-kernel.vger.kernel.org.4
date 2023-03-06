Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0345D6ACF5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:44:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B8457F1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:43:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j11so24522577edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678135432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOLgvSHzKn8+tEFxw5Ix+wflDWiRU8fkXBHzHjj9Cu0=;
        b=VNVWrO4jBVpPby0IbDLhzbrF2Wl3+gP7isXJ0RZPtx/yne2a51ThScOB4nVDCLiGx+
         QLmOTiArDaVoDAYe5+JAJQt+5wusiOURTMzgR8SbokOJFcR8+/V1Uzn6dyDTrubfR30u
         2FmKr8u3JaYovfMSGXK1mEfbx81cGTq9V+RxwKSIWKLk7CpPnMdJlpaZcvL19pBc/IWb
         P2roY0o4oosmSn6o/5d5nEkRL0Se15RuQh8Fxfh52KztgiXx5lR6FfXLjrdAuYDuI1gs
         4b1hKbUAwospm+w6Bf6Ao2qysa5Rn/rj+wrcw+/me6+wLLIjmvb523QSeSKv3sG814AV
         RyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOLgvSHzKn8+tEFxw5Ix+wflDWiRU8fkXBHzHjj9Cu0=;
        b=Cy2V4grzViT3jyimVkC/6V3+1C4/xFPmfyn7l05VQXfNDDF69PQkxCZus7mxz+/pnf
         IF3JmxVBeJlbH8LCYxreDm1TB+BbLT5J1wTkg3dNOWpuUaj8TRbWQAlLhQ4noyA5RmER
         9b42Qpl/cdVlCUTu9GRXm/4DDb1qgLhCNSsaRKBERiP6vhdLGuLGeo3ndidFv/6zt66m
         LpJ7ScPmEuQ/pb3oU13zEPh+zcP9W0p8G/5x5Tp7a/jOm9tJyxCKiYLg79UNW5wRGZKh
         asA09vYltCWhOdkng0a9yCNgbn3DwEcAnCDwDF3QoG0T3ZmDe9RCl92t5R1SuWlzXy5A
         4pMw==
X-Gm-Message-State: AO0yUKWFFnlcqhS76tphN0ZBDc0ExUMsXJ1WJqXMepzm9LQ+sWq+eo8r
        e7dq8Ly07+lDm8FVYJPJpbw=
X-Google-Smtp-Source: AK7set9FIVv1ZeAKHQSVi+LBnVXKHzw2TvNR7WtSwb3kRKTYIgu3FkK6xfB7undDvnhi6F9E5sagoQ==
X-Received: by 2002:a05:6402:4409:b0:4be:9ca:a677 with SMTP id y9-20020a056402440900b004be09caa677mr14739536eda.3.1678135431628;
        Mon, 06 Mar 2023 12:43:51 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id kt21-20020a170906aad500b008d398a4e687sm4997435ejb.158.2023.03.06.12.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:43:50 -0800 (PST)
Message-ID: <de4266bf-a2b5-0b34-1802-7886fbd8351a@gmail.com>
Date:   Mon, 6 Mar 2023 21:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioC_Array
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
 <d8f0e8c7ee6dd820b56636db8d891012aa3ab263.1678051460.git.philipp.g.hortmann@gmail.com>
 <51b147e6-d502-461d-9c29-647ec67e0d38@kili.mountain>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <51b147e6-d502-461d-9c29-647ec67e0d38@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 10:12, Dan Carpenter wrote:
> On Sun, Mar 05, 2023 at 11:33:05PM +0100, Philipp Hortmann wrote:
>> Remove empty array Rtl8192PciERadioC_Array and the code where it is used
>> because it is dead code.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ------------
>>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  2 --
>>   drivers/staging/rtl8192e/rtl8192e/table.c      |  3 ---
>>   drivers/staging/rtl8192e/rtl8192e/table.h      |  2 --
>>   4 files changed, 19 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
>> index 35ca01ab65ff..fe0ef52c163a 100644
>> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
>> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
>> @@ -649,18 +649,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
>>   					  bMask12Bits,
>>   					  Rtl819XRadioB_Array[i+1]);
>>   
>> -		}
>> -		break;
>> -	case RF90_PATH_C:
>> -		for (i = 0; i < RadioC_ArrayLength; i += 2) {
>> -			if (Rtl819XRadioC_Array[i] == 0xfe) {
>> -				msleep(100);
>> -				continue;
>> -			}
>> -			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioC_Array[i],
>> -					  bMask12Bits,
>> -					  Rtl819XRadioC_Array[i+1]);
>> -
> 
> Why is this dead code?  So far as I can see "== 0xfe" is always false
> so this calls rtl92e_set_rf_reg() on every iteration through the loop.
> It only does one iteration through the loop.
> 
> Is it dead code because case RF90_PATH_C is always false?  If so then
> that needs to be explained in the commit message.
> 
> regards,
> dan carpenter
> 

Hi Dan,

thanks for the review. Here some answers to your questions:

With patch: "[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x 
to table.x" I changed the filename of r8192E_hwimg.c to table.c and 
r8192E_hwimg.h to table.h to adapt filenames from 
drivers/net/wireless/realtek/rtlwifi rtl8192ee and rtl8192se. Task is 
from TODO file.

The explanation from the cover letter of this patch series was:

Rtl8192PciERadioC_Array and Rtl8192PciERadioD_Array contain only two
values set to 0. Reviewing the other Arrays in table.c and looking into
other realtek drivers (rtl8192se and rtl8192ee) this arrays are not
containing valid data.

Here some more examples of my thoughts:

A valid filled array is looking like this:
u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE] = {
	0x019, 0x00000003,
	0x000, 0x000000bf,
	0x001, 0x00000ee0,
	...
	over 100 lines but no 0x000, 0x00000000,
	...
	0x004, 0x00000975,
	0x007, 0x00000700,
};

u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE] = {
	0x019, 0x00000003,
	0x000, 0x000000bf,
	0x001, 0x000006e0,
	...
	over 30 lines but no 0x000, 0x00000000,
	...
	0x004, 0x00000975,
	0x007, 0x00000700,
};

The empty (it is not empty but compared to the ones filled with data it 
is empty) one is looking like this:
u32 Rtl8192PciERadioC_Array[RadioC_ArrayLengthPciE] = {
	0x0,  };

Looking into other cleaned up drivers from the same family:
Example: drivers/net/wireless/realtek/rtlwifi/rtl8192se
Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.
Example: drivers/net/wireless/realtek/rtlwifi/rtl8192ee
Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.
Example: drivers/net/wireless/realtek/rtlwifi/rtl8192de
Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.


In Example: drivers/net/wireless/realtek/rtlwifi/rtl8192cu
I can find a RadioB Array that is just filled with one 0 which is odd:
#define RTL8192CURADIOB_1TARRAYLENGTH	1

u32 RTL8192CU_RADIOB_1TARRAY[RTL8192CURADIOB_1TARRAYLENGTH] = {
	0x0,
};

Here it is written to a variable:

		rtlphy->hwparam_tables[RADIOB_1T].length =
			RTL8192CURADIOB_1TARRAYLENGTH;
		rtlphy->hwparam_tables[RADIOB_1T].pdata =
			RTL8192CU_RADIOB_1TARRAY;

Written to an another variable:

		radiob_arraylen = rtlphy->hwparam_tables[RADIOB_1T].length;
		radiob_array_table = rtlphy->hwparam_tables[RADIOB_1T].pdata;


And then accessed after with i + 1 the element that is random/undefined.


	case RF90_PATH_B:
		for (i = 0; i < radiob_arraylen; i = i + 2) {
			rtl_rfreg_delay(hw, rfpath, radiob_array_table[i],
					RFREG_OFFSET_MASK,
					radiob_array_table[i + 1]);
		}

May be another patch.

I hope this can convince you that Arrays for RadioX that do only contain 
one or two 0 are not in use.

Please let me know your thoughts.

Thanks

Philipp
























