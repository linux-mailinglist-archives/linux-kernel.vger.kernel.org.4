Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ABE615D38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKBH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBH6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:58:10 -0400
X-Greylist: delayed 203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 00:58:08 PDT
Received: from omta37.uswest2.a.cloudfilter.net (omta37.uswest2.a.cloudfilter.net [35.89.44.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CFB252AF;
        Wed,  2 Nov 2022 00:58:08 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id ppxCotPVGqEICq8WZoOBJq; Wed, 02 Nov 2022 07:50:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id q8WYoqJtNJzQ5q8WYoC2Gp; Wed, 02 Nov 2022 07:50:59 +0000
X-Authority-Analysis: v=2.4 cv=MaV/Brzf c=1 sm=1 tr=0 ts=63622163
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=wYkD_t78qR0A:10 a=TCL3t-gOmiXOs0atSnwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MLjpJH6sJtG3eyLqG+16mXrzIl/XBNVKLpM3ejMi4SQ=; b=BnPGvJJflWMNqJk68ts2+Vm40U
        vPCGZkq0B3jqkVA/xWogy8JsdvNwmlVHdDDJT93FZBt/JNV+xv+3g4GKEMhQlLXDz3UVieqIGBm9N
        zEGGOJ8fs8Yu1ZDCAmuYkZdpnAGgq4u0OIYeujIaJ9TrnicN4ug9IpDTSD7teJN9Yrn8OeQdjHv//
        6JTR3qJB4+zmZl6WaCb7rU3bu0hrzXm+1sxAYDFWTqmq+iWLsPisGvkNRRUwCL+Mtv7lZw5qRDRW7
        rTS4FW9vG4Qki2PRp7bxUo4wjOHNtgSwbR/RTVQv9fqWxqTRUG04T8uCsjVD27lJb++CkzZEgu85m
        AXg7JFbA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:41634 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1opaOT-000xYN-EP;
        Mon, 31 Oct 2022 14:24:22 -0500
Message-ID: <89eca382-fca3-28f9-eac7-f855f2efb598@embeddedor.com>
Date:   Mon, 31 Oct 2022 13:23:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: new checkpatch flexible array test ? (was Re: [PATCH v4 12/14]
 gunyah: rsc_mgr: Add RPC for console services)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-13-quic_eberman@quicinc.com>
 <YzbfaCj9jvSUDfUg@kroah.com>
 <c7e45416cc911290efb5ad669f4a45bdc5678f69.camel@perches.com>
 <YzpzVfwA7NMCIyIp@kroah.com>
 <04ade5f54bd3dc658cb8606c98b0b1fe34a97383.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <04ade5f54bd3dc658cb8606c98b0b1fe34a97383.camel@perches.com>
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
X-Exim-ID: 1opaOT-000xYN-EP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:41634
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFfzNBKwhR3kFxUhhlT0wgwPghkc7emVB6d8R3TL0p7J8XAV+SrN3jcK5Buk1qRib4qOmwmnmWIdm6kzVT60hiSv1aEsbZX6t5JWBLkMCBc3p5dRK0A4
 omlC12ROJnF9Q5YHLFYCOKrw07xUjZahM40febtL73U4JYao6k7ewZqwRM45oN29F3+pi3SfxNzUpfi5gF6H8CnFrBlb+iw0nSacuBFErkqzRgKZm/jxbAdj
 A6LL5bxwCV3EzTWTSnLocveLoJQJtiOJxgfSE2V7+3WOuHk9qahFYTZb4yK/WRoQ8OkwiHBunXvO1G4GHKDBeendIQw/6a/cXFSmuqTLmTI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 00:38, Joe Perches wrote:
> On Mon, 2022-10-03 at 07:29 +0200, Greg Kroah-Hartman wrote:
>> On Sun, Oct 02, 2022 at 06:46:30PM -0700, Joe Perches wrote:
>>> On Fri, 2022-09-30 at 14:22 +0200, Greg Kroah-Hartman wrote:
>>>> On Wed, Sep 28, 2022 at 12:56:31PM -0700, Elliot Berman wrote:
>>>>> Gunyah resource manager defines a simple API for virtual machine log
>>>>> sharing with the console service.
>>> []
>>>>> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
>>> []
>>>>> +struct gh_rm_notif_vm_console_chars {
>>>>> +	u16 vmid;
>>>>> +	u16 num_bytes;
>>>>> +	u8 bytes[0];
>>>>
>>>> Please do not use [0] for new structures, otherwise we will just have to
>>>> fix them up again as we are trying to get rid of all of these from the
>>>> kernel. Just use "bytes[];" instead.
>>>
>>> Maybe a checkpatch addition like:
>>> ---
> []
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>>> @@ -3948,6 +3948,17 @@ sub process {
>>>   			}
>>>   		}
>>>   
>>> +# check for zero length array declarations in likely structs
>>> +		if ($line =~ /^\+\t($Declare\s*$Ident)\s*\[\s*0\s*\]\s*;\s*$/ &&
>>> +		    defined $lines[$linenr] &&
>>> +		    $lines[$linenr] =~ /^[\+ ]\}\s*(?:__\w+\s*(?:$balanced_parens)?)\s*;\s*$/) {

This sounds great. We need the same for one-element arrays. :)
Both zero-length and one-element arrays are deprecated.

> 
> This should actually be:
> 
> 		    $lines[$linenr] =~ /^[\+ ]\}(?:\s*__\w+\s*(?:$balanced_parens)?)*\s*;\s*$/) {

I agree. Thanks.

> 
> as it was missing a * for uses like
> 
> 	int foo[0];
> } __packed __aligned(4);
> 
> and uses without any attribute at all
> 
>>> +			if (WARN("FLEXIBLE_ARRAY_ZERO",
>>> +				 "Prefer flexible length array declarations with [] over [0]\n" . $herecurr) &&
>>> +			    $fix) {
>>> +				$fixed[$fixlinenr] =~ s/\[\s*0\s*\]/[]/;
>>> +			}
>>> +		}
>>> +
>>>   # check for multiple consecutive blank lines
>>>   		if ($prevline =~ /^[\+ ]\s*$/ &&
>>>   		    $line =~ /^\+\s*$/ &&
>>
>> This is a question for Gustavo, who did all the work here.  Gustavo,
>> does the above checkpatch change look good to you?

Yep; the idea is great. :)

Another alternative to stop those fake flex-arrays from entering the codebase
is to run Coccinelle scripts during linux-next builds, as suggested by Elena
Reshetova at LSSEU a couple of months ago.

However, if these can be stopped with checkpatch it'd be really helpful, as well.

Thanks
--
Gustavo
