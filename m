Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0C70F46F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjEXKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEXKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:42:22 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820697
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:42:21 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id 1lvTqnH5pEoVs1lwjq0Ix0; Wed, 24 May 2023 10:42:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 1lwiqcsMQipLm1lwiqmEvL; Wed, 24 May 2023 10:42:20 +0000
X-Authority-Analysis: v=2.4 cv=R5gQpPdX c=1 sm=1 tr=0 ts=646dea0c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=533kGXqUlK_MWtiuI0gA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jyuIbAssiy/Sf7j9Qj1G/b2n1LG+av2mAC3uxplu1Lw=; b=Ek8Ow101SykqzlMQ57/EQMUBcx
        Nufs7SkTH2dJogpkDBWx/QEztnaOruUgR1Sr82mr9pxAZoaTOkN6YN0uE2y5f0tvfHS9EMKKRbilz
        mN0ZLEA1BTk2QWiHWqRBdVPecZrWf/eJLREJR/K89ur5F6B89kiBDSzxxKYcUK/K2B9JJ49PhabfA
        zxyrcSARIMnpqu18J/Ig3o7cV5BRCgD+Wke+JKn6T3QfnBt/+CaJsWZdtP8TvH6AfSEmvDbn4iQfQ
        NhjbOmSaQmFM5+/Zu84muZcSZk1FpYv5G5gnYKh0nw21fWkBEAZJQJ0JyG401zzcTjGkMEct/Oxf/
        zpH+/V/Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:46694 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q1lwh-003bxf-Pa;
        Wed, 24 May 2023 05:42:19 -0500
Message-ID: <d247d8ec-0ab6-c552-fef5-8d48b245a7dd@embeddedor.com>
Date:   Wed, 24 May 2023 04:43:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rtw89: use flexible array member in rtw89_btc_btf_tlv
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ching-Te Ku <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523113241.2772811-1-arnd@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230523113241.2772811-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1q1lwh-003bxf-Pa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:46694
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOz/vlCKAM9uf5e32r2OZ73hMU3bJjrSA8qGqGC/qJrUx6swwgzqc8WAn9aqswcZ+EWK/gDdTctM9oTntEhYY5Ik6gnYoWpYl+t0o3ZcfdBZpSsGXCUV
 wEYbJ+NjTzPvTH8h4QhvEayquENjOhUo+bD/zcCni1Ehw9errjd2ZFcFPB0w5dRD0ZK1nJJkVDpKaUk20yv5rf+nhgEDQ028DQ27SJ3vicuGfHYWqQJIRJ+e
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 05:32, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> struct rtw89_btc_btf_tlv contains a one-byte member that is intended as a
> flexible array:
> 
> In function 'fortify_memcpy_chk',
>      inlined from '_append_tdma' at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
> include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    583 |                         __write_overflow_field(p_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make this actually use a flexible array to let the compiler understand.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> index 3a586a971e8f..bda0e1e99a8c 100644
> --- a/drivers/net/wireless/realtek/rtw89/coex.c
> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> @@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
>   struct rtw89_btc_btf_tlv {
>   	u8 type;
>   	u8 len;
> -	u8 val[1];
> +	u8 val[];
>   } __packed;
>   
>   enum btc_btf_set_report_en {
