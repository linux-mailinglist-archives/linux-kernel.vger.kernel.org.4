Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6F73B99D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFWOOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFWON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:13:57 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B226A4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:13:43 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id CavsqNcEEfaVXChXjqRomn; Fri, 23 Jun 2023 14:13:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ChXiquqvqxbr9ChXiqVjil; Fri, 23 Jun 2023 14:13:42 +0000
X-Authority-Analysis: v=2.4 cv=X7pBlUfe c=1 sm=1 tr=0 ts=6495a896
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=BcPKCTjPAAAA:8 a=gXX8WB0La0bPfeWsKLEA:9 a=QEXdDO2ut3YA:10
 a=MNXww67FyIVnWKX2fotq:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ggIwwTYhottxi04Zasz3x7eXJpA/jwqZTeAugce7Xmo=; b=L3dBkwwpM2oISkMbAzyzFTu312
        9djvHarUevAgTTFSCvYctBsddcNpSSyo25LG5uM+9FXUDJwrSlTAUcQQgcr47KKF+dwW4d1WhkCgK
        nK89yjMI3gWj/c6jYozXFnZUtJ9T4HSyGd2X5Cd9L6cv+mgJUvIw9fSsnKSw2jAlrlXbrAK7qr51O
        IufsI6eRsgIKSKDIzDQ779oFk5w3C4eWorP2W0fSZCpLqxW4P+QjuSylwJ5id+tbNb+CXRZZgbGA1
        MT31qwZJuC3Xm2CIp1im3PV8AOgmX8zwRK1wZx4Na1WrEj4qGxeBcBTJI53Qen/85K5ypEkiTX+US
        wU+ckTSw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34840 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qChXh-0020dR-KP;
        Fri, 23 Jun 2023 09:13:41 -0500
Message-ID: <54fe1ebc-6b3a-178c-d7d2-fb5486f54e8d@embeddedor.com>
Date:   Fri, 23 Jun 2023 08:14:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] MIPS: dec: prom: Address -Warray-bounds warning
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZJTcvfpvhvF+OLjc@work> <20230623131019.GD11636@alpha.franken.de>
 <alpine.DEB.2.21.2306231432120.14084@angie.orcam.me.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <alpine.DEB.2.21.2306231432120.14084@angie.orcam.me.uk>
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
X-Exim-ID: 1qChXh-0020dR-KP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:34840
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIhW6nft+01bk2X6dB6OqrCPYZ0xNl7ZApigMk269cucXaeLjmUVO7vJiDk8ll0b3W+fyA5LcpUH9wxiAz0VIbNuwMOQKTvP8X5Is5MGvtmVLwP3tk11
 0qqxBTXfsSNLojcVdR1d5uGLvu5Us9x24dVC377iwaI6ygjgndIUarYVyQEs4T8KB5ynZbPgg+UtIxiZScvM946CH6pBsDPGKyf4hlAGwmXezHEMER+zaZPj
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/23 07:41, Maciej W. Rozycki wrote:
> On Fri, 23 Jun 2023, Thomas Bogendoerfer wrote:
> 
>>> Zero-length arrays are deprecated, and we are replacing them with flexible
>>> array members instead. So, replace zero-length array with flexible-array
>>> member in struct memmap.
> 
>   Technically it is a semantics bug fix actually, as the TURBOchannel
> firmware specification (from Jan 1993) says it's:
> 
> typedef struct{ int pagesize; unsigned char bitmap[];}memmap;
> int getbitmap(memmap *map);
> 
> (formatting preserved as in the document) so it should have always been a
> flexible array member.  Maybe old (2.x) GCC versions had an issue with it
> or something, as otherwise I can't imagine why whoever added our typedef
> did it differently from the spec.

Apparently, flexible-array members were supported in some 2.x versions as an
extension to the language; and it was not until GCC 3.0 that they were fully
supported by the compiler.

> 
>> applied to mips-next.
> 
>   Not sure if you can retrofit it, but:
> 
> Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

Thanks!
--
Gustavo
