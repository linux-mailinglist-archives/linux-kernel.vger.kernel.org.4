Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB027427F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2OI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:08:25 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E38A2D4E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:08:24 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id EZSzqvsJaKBQaEsJrqDX82; Thu, 29 Jun 2023 14:08:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id EsJqqpsddYjkzEsJqqjXw9; Thu, 29 Jun 2023 14:08:22 +0000
X-Authority-Analysis: v=2.4 cv=PdrsOwtd c=1 sm=1 tr=0 ts=649d9056
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=DrW6eaa5WwPzkhE0AvAA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cgcRBF5Td84A1IoYq3JdbJJRYrniVHnwRAUvLebZ7Cw=; b=FHcPgCH0lCnOhNeiq0O2/eB4s5
        3olkLNN4icWU6HlH+/K/jY1Lj5wKh83K/Epu9SGSaFP9sAWzgphd3Thwu2UmXR1A7tdlSShiNQ5kF
        7delqX0tO9a22WcejFbCB8j66Adie2mnd3nWUCH+2b7sIvC/k6NoStwW9Msg2QT0D94ttQ7P99kAz
        uTjVRiCll565kyf5gur9EG8o4fMqXtjsCvvLak8rHOs9q2kthqjXAMriMO9i1e5xNxe1uXkRU+1r2
        reADKKAiPYGwx8ZWmk30FqnZNMV9UGJC+k6ZB4eALtEQK7mMiz66RMoFEXYLUwgtHTVmmZEEWNCnp
        3TLquwDg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37752 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qEsJp-000r5F-2I;
        Thu, 29 Jun 2023 09:08:21 -0500
Message-ID: <c0db4c48-6090-5c72-b597-9d4146dbc26c@embeddedor.com>
Date:   Thu, 29 Jun 2023 08:09:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: mainline build failure due to df8fc4e934c1 ("kbuild: Enable
 -fstrict-flex-arrays=3")
Content-Language: en-US
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZJ2M4yqnOCqqGWH0@debian>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZJ2M4yqnOCqqGWH0@debian>
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
X-Exim-ID: 1qEsJp-000r5F-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:37752
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCDlN0LNMLQUGprq8rX7ilDdocQTo/YN34FpUhNjHRnZhF8mxQIO6zor0i+2CCMpqvdNeMM+le4HYVODKFVrx/05SbER30a79U8j8ixTPwReRKnLoQeb
 I/3w17ArPxzA2ml0WXp7j0kVh3ZjD2CLPkkXrVvzDrDGKypSGSU7bIOoX5EXzTT+cV5oV76SKlSnLCMFUZCMV5ziRXbcORgbIdg7p4uqEBJKKB1GfxWVYVdC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the report. See my comments below.

On 6/29/23 07:53, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build with clang (version 16.0.1), and the errors are like:
> 
> 
> drivers/scsi/aacraid/commsup.c:1170:17: error: array index 1 is past the end of the array (that has type 'u8[1]' (aka 'unsigned char[1]'), cast to '__le32 *' (aka 'unsigned int *')) [-Werror,-Warray-bounds]
>                                  (((__le32 *)aifcmd->data)[1] == cpu_to_le32(3));
>                                              ^             ~
> drivers/scsi/aacraid/aacraid.h:2621:2: note: array 'data' declared here
>          u8 data[1];             /* Undefined length (from kernel viewpoint) */
>          ^
> drivers/scsi/aacraid/commsup.c:1290:20: error: array index 3 is past the end of the array (that has type 'u8[1]' (aka 'unsigned char[1]'), cast to '__le32 *' (aka 'unsigned int *')) [-Werror,-Warray-bounds]
>                                    ((((__le32 *)aifcmd->data)[3]

These are addressed by this patch:
https://lore.kernel.org/linux-hardening/65907ee4083de62fbaadc5c2e6512e3828912d1b.1687974498.git.gustavoars@kernel.org/

in this series (for which I'll send v2 shortly):
https://lore.kernel.org/linux-hardening/62386518-4123-db1f-4656-6b4ea509f5b1@embeddedor.com/T/


> drivers/staging/ks7010/ks_wlan_net.c:1600:34: error: array index 16 is past the end of the array (that has type '__u8[0]' (aka 'unsigned char[0]')) [-Werror,-Warray-bounds]
>                                  memcpy(&key->tx_mic_key[0], &enc->key[16], 8);
>                                                               ^        ~~
> ./include/linux/fortify-string.h:694:35: note: expanded from macro 'memcpy'
>                  __struct_size(p), __struct_size(q),                     \
>                                                  ^
> ./include/linux/fortify-string.h:96:56: note: expanded from macro '__struct_size'
> #define __struct_size(p)        __builtin_dynamic_object_size(p, 0)
>                                                                ^
> ./include/linux/fortify-string.h:638:27: note: expanded from macro '__fortify_memcpy_chk'
>          const size_t __q_size = (q_size);                               \
>                                   ^~~~~~
> ./include/uapi/linux/wireless.h:838:2: note: array 'key' declared here
>          __u8            key[0];
>          ^

and these are addressed by this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp&id=40ca06d71d60677a8424798610c97a46e4140a21

in this pull-request:
https://lore.kernel.org/linux-hardening/ZJxZJDUDs1ry84Rc@work/

Thanks
--
Gustavo

> 
> _______________________________________________________________________
> 
> 
> git bisect pointed to df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3").
> 
> Reverting the commit has fixed the build failure.
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> #regzbot introduced: df8fc4e934c12b906d08050d7779f292b9c5c6b5
> 
> 
