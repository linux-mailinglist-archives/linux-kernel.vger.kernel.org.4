Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839B651FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiLTLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiLTLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:31:03 -0500
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC2DE9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LWl+dwuFvwHM/La+sthWt8IK+hkiLuNLi0fAV3LorRw=;
 b=sMh80TyaViBU8f0N1VOTpbz/32r4zlEP2Jo54z0E4Qcj6yHglfzLPDMmgeNcBU2VcACkaKl/dOBD
   bVfQPMH8MwhVjaRU2uJqElJM/FqOKafUuYNb9WpPequEdZDGNkXiFrMUgKQXPNJhjdCDRqe9P4nh
   RJWNvb0CeEniJqXe/zkBw5PSBH24y4QzPy06E8gv9kww2Q/ld7ngL0Wo07aDHIxwSbqPoMK9GEgj
   R3soMwhcs2YT/Ijid7R59IDFwrBtA4X7HGTsycBL0uIEsx3zY2cpBx8/9eFZzHu7QdfRmzZzjf5I
   thdFkvY15i+cdZfA/94u5iDHOdlUp1fOnOJqzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LWl+dwuFvwHM/La+sthWt8IK+hkiLuNLi0fAV3LorRw=;
 b=auIOpP+0iiXAAS9+7sJaG9ODk1UCeEVb6T7IKc1eVzwrRWOKmqu/quNxNFrZBqOWFW2Td/ciM/nU
   NuUoerXSUR6HIDVPShtkj0uWCfoZwhmPeBm51oTSTut0/KUr8uMrWDsbdYSRb4SU3neIBFLRlt9N
   WByy/Uhjp7cAIwjUI/W553dJkzVMUlqex1azTeUoqLrY3irtf96vF1XRkMQ5ixRRaBB1X3nmIF3X
   SwrxMNH9Az0iW/skZJ70RqLu7Zzw5U23OyqnP4rbyJWH1kYcolV5d7uuH0QJqHkk3PMw2TPvkbV0
   KwQBMQltdYSjGOIwt9NfoGjicyrC8+Hyg8aJsg==
Received: by omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221212 64bit (built Dec 12
 2022))
 with ESMTPS id <0RN600LPXTB6XSB0@omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Tue, 20 Dec 2022 11:30:42 +0000 (GMT)
Message-id: <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
Date:   Tue, 20 Dec 2022 12:30:39 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
Content-language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com>
 <20221116171935.GA24524@lst.de> <20221117031951.GB392@test-zns>
 <20221206055928.GB24451@test-zns>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20221206055928.GB24451@test-zns>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGILxLChfRQdNmOHagNzZxsBm++OdYCqjaY8vHGYk7FpcpdeqBieFG87sYLWtZE
 9KAz4qXu7D9U91Btd+Yjlw6FxRtZl6XjVEKGEXZrhEWBTRRCsIwsA6omS0X+6IUm
 RbpExorMWpollADH5GHiIp/ugzlDMlRTHT8tu5PP/P/rBhrWZPCQpR7sE+39OAI2
 B7V4SaaozLh6AwapbQL61+KeYW5SliBUAYJ2eCi0D6V1bgZo6/IxqzzytShcAWXH
 jmmKWiuJ/mKgGFUnQOQ1aFTK4bZMgffUZol7jW9JilxfUODLlwN4d/03Bb1H/IcE
 SPKKrEiiFhE08FBrXemLv0z1BY10D/6Smz5ZjzhSKyzNYkVmFfAZfCzNAT2dCI3B
 GhdiI9+CCBbMUOC+xidO712tTgSmU63fHj2d56hV47j+8uXxaN+UuQYGD7x8m3P1 a1+f1g==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-06 06:59, Kanchan Joshi wrote:
> On Thu, Nov 17, 2022 at 08:49:51AM +0530, Kanchan Joshi wrote:
>> On Wed, Nov 16, 2022 at 06:19:35PM +0100, Christoph Hellwig wrote:
>>> On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop 
>>>> units
>>>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>> device to be removed with this error in dmesg:
>>>>
>>>> nvme nvme0: identifiers changed for nsid 1
>>>
>>> What EUI did it report before? Is the identifier stable after
>>> multiple resume cycles?
>>>
>>> Can some of the Samsung folks here reach out to the relevant firmware
>>> team to see if they have any clues?
>>
>> I will check.
> 
> Took more time than I wanted. Firmware team mentioned that issue existed
> in this firmware. This is fixed in new firmware, but bit of travel time
> is involved when official release from OEM (Lenovo) comes out.
> 
> Hope the information is sufficient, and quirk can go in.
> 
> If required, Acked-by: Kanchan Joshi <joshi.k@samsung.com>

Ping, anything left for me to do before this can be merged?

Regards,
August Wikerfors
