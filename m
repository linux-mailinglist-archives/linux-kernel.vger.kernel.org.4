Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300D70EB58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbjEXCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjEXCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:32:16 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 19:32:14 PDT
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47CFE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:32:14 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id 1bH1qfNvRyYOw1eGxqibfF; Wed, 24 May 2023 02:30:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 1eGwqhNLCo9g81eGxqe8NX; Wed, 24 May 2023 02:30:43 +0000
X-Authority-Analysis: v=2.4 cv=R6oQpPdX c=1 sm=1 tr=0 ts=646d76d3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=n9Sqmae0AAAA:8 a=NEAV23lmAAAA:8
 a=mDV3o1hIAAAA:8 a=8x618Ytda_mi-GpODIUA:9 a=QEXdDO2ut3YA:10 a=3IOs8h2EC4YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UmAUUZEt6-oIqEbegvw9:22 a=_FVE-zBwftR9WsbkzFJk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aasTBZQZv56mUB/he0G3yIgLrQXzoF0Jna8m775QSPo=; b=yVeyFgkgSqd9sVwqNbCmQd10v5
        ZrYkd0xRd9opKBUoM+cnKlDhJ6IVP0hWMLfj1uR4clLebAx4ULey9Oluk5HTGQ/kTrsSH0tHTmC+d
        fmOcr/Hd7d25OrzWDz9llsPhnkkccI1Q48foyO8rbM4Jr2TRJ1oPfoV9/HXdf7co/OEmZ/A5WMgPB
        bB6bO5SI+bv3ZufNjm31d/SzqCeuU+HMX+5zsK85xGwcoi/Lh1pdYC+XJu/j32YRfwPRqOtjoiny5
        u3axL2ESVtn2ZTgosSL5d5MOymt4B/dGMVaNyzzL+rlxw3ETn1lCubM87paAEO9QQ7K3Un+3W/R5J
        vD0+Zcug==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:41992 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q1eGw-000m3M-9t;
        Tue, 23 May 2023 21:30:42 -0500
Message-ID: <13a74848-d961-7424-da7e-2bb7b904e899@embeddedor.com>
Date:   Tue, 23 May 2023 20:31:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] wifi: rtw89: coex: Fix __write_overflow_field error
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <ZG1ynqdAnXArMfBE@work>
 <b45c71d19add4f749a687e5ca483244b@realtek.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <b45c71d19add4f749a687e5ca483244b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1q1eGw-000m3M-9t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:41992
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOF9VHsMEvagRmikadW+gIaR+Q5sOsqmaQstNAJu4LAb5rwZq9/08J+FjiOHRe6YC6aGkdp7j2dcmv4xTZ/SHikUc6RHfJk1H+PqbSgM0blfHN3ca4kJ
 cOkCW0Bix+cZRKHJbV+d8IraZPiR2ZDkWQqDUh53TLNWJdfJlZzrI39Kya5Whvp10r+gghhPNFbtbZfwRi/vB+ExXhWNzKpOplvMvC8Wwz3C2XEl6r3k2pjK
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 20:21, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Sent: Wednesday, May 24, 2023 10:13 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva
>> <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
>> Subject: [PATCH][next] wifi: rtw89: coex: Fix __write_overflow_field error
>>
>> One-element arrays as fake flexible arrays are deprecated, and we are
>> moving towards adopting C99 flexible-array members instead.
>>
>> Fix the following error seen under GCC-13 and -fstrict-flex-arrays=3:
>> In function ‘fortify_memcpy_chk’,
>>      inlined from ‘_append_tdma’ at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
>> include/linux/fortify-string.h:583:25: error: call to ‘__write_overflow_field’ declared with attribute
>> warning: detected write beyond size of field (1st parameter); maybe use struct_group()?
>> [-Werror=attribute-warning]
>>    583 |                         __write_overflow_field(p_size_field, size);
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> This results in no differences in binary output.
>>
>> Link: https://github.com/KSPP/linux/issues/21
>> Link: https://github.com/KSPP/linux/issues/299
>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
>> index 3a586a971e8f..bda0e1e99a8c 100644
>> --- a/drivers/net/wireless/realtek/rtw89/coex.c
>> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
>> @@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
>>   struct rtw89_btc_btf_tlv {
>>          u8 type;
>>          u8 len;
>> -       u8 val[1];
>> +       u8 val[];
>>   } __packed;
>>
>>   enum btc_btf_set_report_en {
> 
> Arnd has sent the same patch [1] as yours.

Oh that's great! What a coincidence. :)

Thanks for letting me know.
--
Gustavo

> 
> [1] https://lore.kernel.org/linux-wireless/27a7010de8be4006a3e4b95e851781c6@realtek.com/T/#mca619c8261b87b88eedd391ceafb34c40d513ce5
> 
