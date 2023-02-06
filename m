Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4C68C69C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBFTRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjBFTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:17:17 -0500
Received: from omta37.uswest2.a.cloudfilter.net (omta37.uswest2.a.cloudfilter.net [35.89.44.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559F23107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:16:56 -0800 (PST)
Received: from eig-obgw-6015a.ext.cloudfilter.net ([10.0.30.134])
        by cmsmtp with ESMTP
        id OrWtp5qrnYHR1P6z1pSP9Y; Mon, 06 Feb 2023 19:16:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id P6z0pvLNPSogtP6z1pXsPW; Mon, 06 Feb 2023 19:16:55 +0000
X-Authority-Analysis: v=2.4 cv=Ov5cdgzt c=1 sm=1 tr=0 ts=63e15227
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=UlVX6gWz2MDTxooHeI4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1ObxFuiXqXpyZXTg1dGdS/FIxrV/Q7eEElLE6od08UE=; b=udDrHuHpv7MF7SH93SgyDTv2xC
        jBTuMCI22NGTAOGSsjc1k8SLVfZiYWEt6kinXuB8N4+MaPcqPVDN+WNtdCYRdDKCBcIny7wV2jT2Z
        uzBKdTnKPz0ptRsEMRfRHrQM2o7b+9vUjDWDOSfoqFXj/TSamsA+mwGp2sJBdQllFao+vMfgPrten
        oe/eQOKO2kaueD1bkH5xtPDEJQUSGuq8hkvDFiFO6ciQN+WHomDq7AShpPSNIzMRtm0PjCxBrujl3
        IkikvflaRyjVUmndcV0ebPXvZmjnuNgGSTtu3HSeS/GjlgDHpRSBh6BBEAk2krgt8JBcBPnCuCs7k
        nitx9XfA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:58048 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pP6z0-0015W0-Bv;
        Mon, 06 Feb 2023 13:16:54 -0600
Message-ID: <f6bec0de-3d6d-6d59-5ef3-2903f40451d3@embeddedor.com>
Date:   Mon, 6 Feb 2023 13:17:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with flexible-array
 members
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>
References: <Y9xiYmVLRIKdpJcC@work>
 <63dd4a37.630a0220.e4652.35de@mx.google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <63dd4a37.630a0220.e4652.35de@mx.google.com>
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
X-Exim-ID: 1pP6z0-0015W0-Bv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:58048
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPPJ1fHbB1JldO9brUBBWp0iOPYzTZ5HJ2XzC6CAiwv//AWIKvkeuVwBN78SZrDfNmGJv6LXvEfziRsNzPBi0pSdpgJAEQTiT4nTO6jh2AtUyKDKtNXG
 jKrkxreb0v0FjV4qwKHsCWaHp6k3W67OFchhtYC4k15PmwoDKgCTnMHVjFMBww1u0cIpf7+E+CcmZMAGgsWMQ2G2adN+qNI76em4i2MP4MngkNfEe3au+51X
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/23 11:53, Kees Cook wrote:
> On Thu, Feb 02, 2023 at 07:24:50PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element arrays with flexible-array
>> members in structures xfs_attr_leaf_name_local and
>> xfs_attr_leaf_name_remote.
>>
>> The only binary differences reported after the changes are all like
>> these:
>>
>> fs/xfs/libxfs/xfs_attr_leaf.o
>> _@@ -435,7 +435,7 @@
>>        3b8:      movzbl 0x2(%rbx),%eax
>>        3bc:      rol    $0x8,%bp
>>        3c0:      movzwl %bp,%ebp
>> -     3c3:      lea    0x2(%rax,%rbp,1),%ebx
>> +     3c3:      lea    0x3(%rax,%rbp,1),%ebx
>>        3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
>>                          3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
>>        3cc:      or     $0x3,%ebx
>> _@@ -454,7 +454,7 @@
>>        3ea:      movzbl 0x8(%rbx),%ebx
>>        3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
>>                          3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
>> -     3f3:      add    $0xa,%ebx
>> +     3f3:      add    $0xb,%ebx
>>        3f6:      or     $0x3,%ebx
>>        3f9:      add    $0x1,%ebx
>>        3fc:      mov    %ebx,%eax
>>
>> similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.
> 
> I usually turn off the sanitizers for the A/B build comparisons to make

Oh yes! that's a good point. I'll see that they are turned off next time. :)

> it easier to read the results. It looks like it _grew_ in size here,
> though?

Yep; I'm sorry I got it wrong. :/ I had it right in the beginning, then after
reading the code once again just before sending out a version of this patch
with only the flex-array transformations, I noticed the entsize functions and
the "sizeof(struct-with-one-element-array) - 1" and I forgot about the padding,
removed the "- 1" and got a bit confused with my build-tests.

I'll send v2 with my original changes... the flex-array transformations, only.

--
Gustavo
