Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A274688849
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBBUeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBBUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:34:02 -0500
Received: from omta33.uswest2.a.cloudfilter.net (omta33.uswest2.a.cloudfilter.net [35.89.44.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9317C6CC81
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:34:01 -0800 (PST)
Received: from eig-obgw-5017a.ext.cloudfilter.net ([10.0.29.154])
        by cmsmtp with ESMTP
        id NQmip3PMAII8dNgHQpYtFu; Thu, 02 Feb 2023 20:34:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id NgHPpkt7JdJoxNgHPpN1AF; Thu, 02 Feb 2023 20:34:00 +0000
X-Authority-Analysis: v=2.4 cv=C9L6dCD+ c=1 sm=1 tr=0 ts=63dc1e38
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=gwZbGxDKoGpvoHXj0fsA:9 a=QEXdDO2ut3YA:10 a=t_mPKkL_zAAA:10
 a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=havDD7BADH0COSYVLMyQg91Hn9SZSCTeeTvqOnemfFo=; b=sE6KXZogcskAgJDd4SwF9bxrs5
        qbZ/IL1PnJ7ZSPn9AgsXl/qsvuTDTtqY/o0oUDV2Laju4nvIOkPs8EfzCIOAMtFFuvTTwvQs0NGbP
        1b3I//jSpeZxL2mU3/v9XWzkywsGZ1WE0SehkfTcmMJtttJdZr40vTTUV5NWlWaJZ3N483NZJ3Gnf
        RSSEqwNgXazUoTRP09bgS4Ah49YZB7i/3FsTEqjRcfkC74t9qzPKMJI6uHXRb0liNV5UMAK2OzdQ3
        uoF+YMPPNhEJ2BT1yAl9B2cR+4ojKQcotZ2T1MyflqEZGxzILkuva43nt+RMuyGwLx/fkDGWZK5Vk
        QVBR5NDQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48834 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pNgHO-002ALM-V6;
        Thu, 02 Feb 2023 14:33:59 -0600
Message-ID: <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
Date:   Thu, 2 Feb 2023 14:34:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <YzIzUjUuJKf0mkKg@work>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <YzIzUjUuJKf0mkKg@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pNgHO-002ALM-V6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:48834
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDlDCdbQNHxyMkdpkiwJOuHC8KxyusQQDt/mxPORpQLc/dFVPSZs6uW6QXGMBVZcl2oljll/q156DHNvLZwAw8Ptb2p3Tw1KLYJ0o/mmfQ3v5BvYu1oi
 g3FowVm4HBRoSzSmGhkic2ZnKYBm+x1/fQ4OrePjrY3oddf22zfMQ8RrXgdtfBRNzpvbBmed0WHWo22o47noz/I9ZW9P87QEipgIV70gY5blixtE+fVaX5Oh
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

I wonder if this can go through your tree.

It's already been reviewed by a couple of people. :)

Thanks
--
Gustavo

On 9/26/22 18:18, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new __DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/227
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/uapi/sound/asoc.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 053949287ce8..dd8ad790fc15 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -226,9 +226,9 @@ struct snd_soc_tplg_vendor_array {
>   	__le32 type;	/* SND_SOC_TPLG_TUPLE_TYPE_ */
>   	__le32 num_elems;	/* number of elements in array */
>   	union {
> -		struct snd_soc_tplg_vendor_uuid_elem uuid[0];
> -		struct snd_soc_tplg_vendor_value_elem value[0];
> -		struct snd_soc_tplg_vendor_string_elem string[0];
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_uuid_elem, uuid);
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_value_elem, value);
> +		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_string_elem, string);
>   	};
>   } __attribute__((packed));
>   
