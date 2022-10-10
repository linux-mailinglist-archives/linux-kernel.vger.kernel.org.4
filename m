Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7532B5FA3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJJTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:00:43 -0400
Received: from qproxy4-pub.mail.unifiedlayer.com (qproxy4-pub.mail.unifiedlayer.com [66.147.248.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280056BD49
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:00:41 -0700 (PDT)
Received: from alt-proxy28.mail.unifiedlayer.com (alt-proxy28.mail.unifiedlayer.com [74.220.216.123])
        by qproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id BD6848035B01
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:00:30 +0000 (UTC)
Received: from cmgw11.mail.unifiedlayer.com (unknown [10.0.90.126])
        by progateway1.mail.pro1.eigbox.com (Postfix) with ESMTP id AD9CE1003F00E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:59:58 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id hy0Loy2Cf9t3Uhy0Mo2wki; Mon, 10 Oct 2022 18:59:58 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=R/vGpfdX c=1 sm=1 tr=0 ts=63446bae
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=Qawa6l4ZSaYA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pHmFqU1MfZqmF2wH4HA5mBKkgOLwVlHajjT+9iaqM0I=; b=BTRK/tNtffeV/9tfFuP2TL29X4
        X8GPirEaPokyrQD4v1c5hHWG1vydQZw00x8cDhd4jhDmjkBTsNmxqHkhlcsGu7tmQxMkemsYVF+pJ
        jgHnbaFk3C/gbDDHr2321Xf5yiwdZlxAjZpo6B2nuLNYPZNgrv4aaaopvBYJqlCDuIwh+KtM3jZJ5
        5itjbdHF4H7URv1T4Wmd6PGZ0l/JVW89SkrW8PsqIJ/FMFOPLYNMq3xgC1y6aKK8xBKzpIB/lW+dx
        s8CuDGA0L2Cojv9SWod2JE7sl1iy7IYMvWknDDkLt7JfR4JDrKy4bYz/0dq8LE97HbcbA9AyHjNIt
        V0eZBl1w==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:53274 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1ohy0J-000Mbp-Rl;
        Mon, 10 Oct 2022 12:59:55 -0600
Subject: Re: [PATCH 5.15 00/37] 5.15.73-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
References: <20221010070331.211113813@linuxfoundation.org>
In-Reply-To: <20221010070331.211113813@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <26bfea6d-4470-6329-f216-541fe615f536@w6rz.net>
Date:   Mon, 10 Oct 2022 11:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1ohy0J-000Mbp-Rl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:53274
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 12:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.73 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Oct 2022 07:03:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

