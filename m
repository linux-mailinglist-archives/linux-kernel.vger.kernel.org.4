Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222B86F22C5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjD2D4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjD2D4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:56:36 -0400
Received: from qproxy1-pub.mail.unifiedlayer.com (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69DD1FF3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:56:34 -0700 (PDT)
Received: from gproxy2-pub.mail.unifiedlayer.com (unknown [69.89.18.3])
        by qproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 32C208027431
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:56:34 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway4.mail.pro1.eigbox.com (Postfix) with ESMTP id 4AE851004439C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:56:32 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id sbhHpT9UZUwlvsbhHp3TLJ; Sat, 29 Apr 2023 03:56:32 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=BbEdbph2 c=1 sm=1 tr=0 ts=644c9570
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=dKHAf1wccvYA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dzz66+pXIPTugAbZFhlPRLRoxTYq1sWBlKytls8PqNw=; b=tCYdWr4tShcVfgINkj7LDbGvPV
        tEcLC7HPulKwh06HVHJfKtY+IOHTFD/wt/qC1eRW+HKzlUG/7wJ1OXxtK0AKDuNBkkNS6XPyhHn3p
        X/8FXzalU2mOASLK6Nrltbtp1ix5bF94gIGuf4u96vLz8Qe4BNc4FPbv96LkhJGaumIC4WBTi83qc
        zHAgNn6pEiNhnJODse3u72UWQx/es07DHd39+XG1kV1gU+D7czCWIuQC9DmmP7MJ08mWiliyjt5e+
        mKcfCanRt+wJxLWIaNR1YfqiScD3KsNUonrLLb2sFRQeti0Y3+iOBA5/c185I9T7BizskcRQ2xqhc
        4E/o4wkg==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:36422 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1psbhH-003yut-4p;
        Fri, 28 Apr 2023 21:56:31 -0600
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230428112039.886496777@linuxfoundation.org>
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <79093ab5-155d-d324-e40e-77091789f320@w6rz.net>
Date:   Fri, 28 Apr 2023 20:56:29 -0700
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
X-Exim-ID: 1psbhH-003yut-4p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:36422
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 4:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

