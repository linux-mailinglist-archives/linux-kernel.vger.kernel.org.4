Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11664A64D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiLLRxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiLLRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:53:19 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8B32624
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:53:17 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221212175313euoutp0281fcd2f5ae5154a535de31a97734c4e1~wHTk_MYDc2403824038euoutp02o
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221212175313euoutp0281fcd2f5ae5154a535de31a97734c4e1~wHTk_MYDc2403824038euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670867593;
        bh=o0Z0aMTgUWzlfuyhDqGfM/F4VpBiWulTa2DHCXRG1Lo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ul9HJZkrgqqacFdmWveiwWrNAwAs3VHOJ55vhCf8gcPf/0V+CQotJ9t1Y8QykGu74
         7zCHUx/Mf907ttcrtTwdvfFovYndg8vCu7/8vbubeZbF58JdsYEOzJ9VEJbDp+Dsn/
         x45R5pnN7rlTy9G24N0fKKfhCZ0G5t9ve/UYmjBs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221212175313eucas1p2e4342c5fd8c3048ec674d08031f25d36~wHTkwzxSu1618016180eucas1p2W;
        Mon, 12 Dec 2022 17:53:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.7E.09549.98A67936; Mon, 12
        Dec 2022 17:53:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221212175312eucas1p22ba1a31d4809be0ffa8715438b174281~wHTkUj29V2462424624eucas1p2d;
        Mon, 12 Dec 2022 17:53:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221212175312eusmtrp19e2e59144ccaefc97a8a9cac41a3cdf5~wHTkUBzCm0242602426eusmtrp1N;
        Mon, 12 Dec 2022 17:53:12 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-f9-63976a89baa1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.6E.08916.88A67936; Mon, 12
        Dec 2022 17:53:12 +0000 (GMT)
Received: from [106.120.9.77] (unknown [106.120.9.77]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221212175312eusmtip1f3e54b606dd8e9182209fc236ca81be3~wHTj3ps-T0885208852eusmtip13;
        Mon, 12 Dec 2022 17:53:12 +0000 (GMT)
Message-ID: <c1d10d21-f3ca-7633-8b65-5d3916cfa648@samsung.com>
Date:   Mon, 12 Dec 2022 18:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, russell.h.weight@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Content-Language: en-US
From:   =?UTF-8?Q?Micha=c5=82_Lach?= <michal.lach@samsung.com>
In-Reply-To: <Y5bEYfQOMyA4XQEW@bombadil.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7qdWdOTDX5/4bJoXryezeLyrjls
        FjcmPGW02PXwO7vF3C9TmS2WzlzBbPFy8xsmB3aPWQ29bB6L97xk8ti0qpPNY//cNewem09X
        e3zeJBfAFsVlk5Kak1mWWqRvl8CV0bHrEEvBNZ6K64ePMDUwfuHsYuTkkBAwkeicOZEFxBYS
        WMEoceYSRxcjF5D9hVHi+M6/LBDOZ0aJFat2MsF0TLy2iA2iYzmjxKFZbBBFrxkl5nR3gyV4
        BewkJi95zwpiswioSsy+PJkZIi4ocXLmE7B1ogJREk0XfoLZwgKhEhvedzGC2CICGhL7JvQy
        gQxlFpjGKPGn9TRYEbOAuMStJ/PBrmATsJF4M+8LWJxTwEziyIKHUDXyEs1bZzODNEsIPOGQ
        eHDrLgvE2S4SnyecZoewhSVeHd8CZctInJ7cA1VTLHHnyXw2CLtG4tvvDmYI21pi1dYbQHEO
        oAWaEut36UOEHSVm3/3HDBKWEOCTuPFWEOIEPolJ26ZDhXklOtqEIKpVJf43foJaKi2xd+Uh
        5gmMSrOQQmUWkidnIXlmFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT0el/
        x7/uYFzx6qPeIUYmDsZDjBIczEoivKoa05KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ866Y0pEs
        JJCeWJKanZpakFoEk2Xi4JRqYJo259WrO6ZJPZLT6isLlfv9qx3CXubIn5ybblcuFV4TbHzk
        RrPV/5WvnlyMWnaaLWZ552WdgHdBP998vuTrfL7zkOXndU0/NLsvVzRzlPC7y2oI6s/18ttW
        8l7J4/4sB+svdjkxAb9seQ+nKLid/G/5pft1r2kYiwe/xtHW9Bsn1k260jnzT8PGaalfzI4K
        OvlorPujalIZ07s98MCmMh4vdpE6xp4LZ9psdn1kX3Ty3bufFSoeNglav45cXiLkfIHdvXQV
        87IGt3O/n29X/Vvjv9OZScvOSkDm0vRlKibaMjs36Fk9vbPzwYUovthlR91Z7s+d+1ViSWBb
        R/8Rdf0ktbtL/sge+MibVHCzSomlOCPRUIu5qDgRABjDTMmzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7odWdOTDTbe07RoXryezeLyrjls
        FjcmPGW02PXwO7vF3C9TmS2WzlzBbPFy8xsmB3aPWQ29bB6L97xk8ti0qpPNY//cNewem09X
        e3zeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CX0bHrEEvBNZ6K64ePMDUwfuHsYuTkkBAwkZh4bRFbFyMXh5DAUkaJIwc6mLoYOYAS0hJd
        86QhaoQl/lzrgqp5ySix99YaFpAEr4CdxOQl71lBbBYBVYnZlyczQ8QFJU7OfAJWIyoQJXHz
        /EMmEFtYIFRiw/suRhBbREBDYt+EXiaQocwC0xglbr56wA6xYQ/QhhsLwTqYBcQlbj2ZD2az
        CdhIvJn3BWwqp4CZxJEFD1lALmUWUJdYP08IolxeonnrbOYJjEKzkNwxC8mkWQgds5B0LGBk
        WcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYe9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8Kpq
        TEsW4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnA6M8riTc0MzA1NDGzNDC1NDNWEuf1LOhI
        FBJITyxJzU5NLUgtgulj4uCUamASUGJYpXJToW52W8Osv6IpOzzD3np9zF2u55Fj0yt4Nt5E
        LEjATPTB04YT0lvNjhzQiVRdsSTXrij0K1eo7K8zu/wz/9g0rEze/vJkvOzeNobJ68I5P54M
        v3fIanJPXudRi4f550/59sTqsnB/1Dr8Y64a8+z1/Uz7My44r54lzFv45fb2Zn350wvXHpE0
        y1bY054yR5RBS/2EQvZ8vtBFv4T7d0YmxSt8FVmtp/1uQ35y+teUNj5bm8hbWUsfd293/aa7
        eQlHi15XLffSC5GnZ5+Ma1WrmqfYIjejV/lioVvZM4cnXuEXFyQlxJaK3Gfq3Br/O05PudvS
        64XiihjbFdZdBRV+G/effmD/RImlOCPRUIu5qDgRAHitMoxGAwAA
X-CMS-MailID: 20221212175312eucas1p22ba1a31d4809be0ffa8715438b174281
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
        <20221123111455.94972-1-michal.lach@samsung.com>
        <Y5bEYfQOMyA4XQEW@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 07:04, Luis Chamberlain wrote:
> Hey Michal! Thanks for your patch! I have a few doubts though!

:-)

> To account for not having to deal with specific drivers we have the
> Linux kernel selftests. And so you can test the firmware loader with all
> sorts of crazy situations which any driver could use and try to see
> if you can re-recreate the issue.
> 
> The kernel selftests driver for the firmware loader is in
> lib/test_firmware.c and you can use thetools/testing/selftests/firmware/fw_run_tests.sh
> to run all the tests. To test the firmware fallback alone you can use
> just fw_fallback.sh.
> 
> If you want to just virtualize this and you can also use kdevops [0] and
> enable the firmware loader selftest and use:;
> 
> make menuconfig          #  enable selftests and just the firmware test
> make linux               #  build linux, pick linux-next
> make selftests
> make selftests-firmware
> 
> But this may be something more you can use later once you get your flow
> going. Just compiling the kernel and running the selftest manually with
> fw_fallback.sh should suffice.

Thanks a lot, I had no idea that there is something like this.

> OK so this proves the bug can happen but I'd like to see the full trace
> and the exact kernel version showing that this can happen on a recent
> kernel. Without that I'm not seeing how this can trigger yet.

Unfortunately I cannot provide a trace. The kernel version was 5.15.41 (-stable).

Keeping that in mind, I will try to reproduce this behaviour with in-tree
code and provide proof.

With regards,
Michał
