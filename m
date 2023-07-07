Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646A74B501
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGGQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGGQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:16:23 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0A91FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:16:20 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id HllaqbGUmEoVsHo83qI9Vn; Fri, 07 Jul 2023 16:16:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Ho82qW5jNeQQzHo83qLHGF; Fri, 07 Jul 2023 16:16:19 +0000
X-Authority-Analysis: v=2.4 cv=VaXkgXl9 c=1 sm=1 tr=0 ts=64a83a53
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=hRA6dbrf6ar1ToGhP8sA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i0RIjplkv8YMTvjY+KkgMdjkmPutWbywcnCQfTBbR4Y=; b=oY0RcCTaOAZ4kucMLnrx0pgLTr
        pMJjxOZkMhUDKUuYUSit3JPJnp5fLVHeOaE46TQ4SEySnUguxsQumkq88jLQCO/fnCAOVcomVGZIS
        fWQFn6eLKCKI6xqWjOt8kG6ToJloTygEdY72dpksbLsWQBNfNsNBLgTMoE0g4hcq8H1G7T3lpnub1
        tUDkv7WUa87oYqMNhOjnwRFmZiuHbHcRfqcFExf8Lmpbs53tY4BhDm5RJWNQgow9/+Ct4QmWOfX/v
        D2nVN1Yu9YMNzcH5HHpUuSDrYDg/QBoLRfJSArnDNQBBISY9Gwt85dqx1/OQFtw4OP8kJwlcSUymO
        WsvSo5mQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58802 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qHo82-002XfG-0s;
        Fri, 07 Jul 2023 11:16:18 -0500
Message-ID: <1fb40135-2a4c-5d54-c5a1-db36244128aa@embeddedor.com>
Date:   Fri, 7 Jul 2023 10:17:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: mainline build failure due to df8fc4e934c1 ("kbuild: Enable
 -fstrict-flex-arrays=3")
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ZJ2M4yqnOCqqGWH0@debian>
 <c0db4c48-6090-5c72-b597-9d4146dbc26c@embeddedor.com>
 <423a78fe-ac40-9983-ff44-90b1759fc0b5@leemhuis.info>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <423a78fe-ac40-9983-ff44-90b1759fc0b5@leemhuis.info>
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
X-Exim-ID: 1qHo82-002XfG-0s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:58802
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG/yroYrpkjpMbeG1dNLPcosoBtC0ccY8dJzd8jZLAhLtANBx69DZ7gQqwe8Al2yfPS3E7KryBcjZk/6pCxfyC3pj02wnj8OJoY+0FZCbq+kHk/TfpS6
 UwQH46LECdZB3yRDEq7ZHDV6NlELrZ0rW7nVIpm1Hu6Rk7gwkl5NXjCBfICZJwJbTrGisEFd5GoDCYxn9eDo2Vkg1QwRPXEynP/f9abNz2qRK1tvDsfp5Y+Q
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 06:52, Linux regression tracking (Thorsten Leemhuis) wrote:

> Are those fixes still on track? Looks like there was not much progress
> since then, so I suspect this won't be fixed before -rc1? Or did miss
> something?

The change is already in SCSI for them to send it to mainline when they
see fit:
https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=6.5/scsi-staging&id=47699a2b63caaa0de4841d4402627c2fdf3452a6

--
Gustavo
