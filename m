Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDA64E5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLPBoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLPBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:44:11 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7CB7EB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671155050; x=1702691050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XXXd/KGEnlY9M5D8rYxoFlOUBugtdt/fm6g3o8GolGQ=;
  b=d+0nbhsG/adNle+XKmxahIWX1QCK7Sj5TZYVCyE3LQ+0m+tvYMDe/Aqt
   vzWjuJQwoE22bAd94cApbC1QzsPJ2E8Ff/2n/s5uFXVRNU0+ec5dgkHMu
   b3KJu52LXo4RHIrq9K5kdAzWb7vNQTD6duYlVXWvAKK113Kuw9qYF++yQ
   mq5mrfbQ5rW39WF4Vz2rQGkhbXr/qTSNnnpuwu3T4SeflBtc5ljQ4zDnv
   yak+++a8atnicc9PAmVkuWMAd9DAUZCWYr8RIje+QP1u+r9pJYR5+CfF2
   gMTbgGncz6SElwyCEN2xVEi2/9O1yvg+uK3SoymULmwfvD1u5ACy4r0VV
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665417600"; 
   d="scan'208";a="330883177"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2022 09:44:09 +0800
IronPort-SDR: t55jqdCV3wBtN4/pD4zlk/x1thvNuQ8O9KI9LfZPpOjwfRE6MYOpMk4ClCshp9X8T//LqHC0Ml
 BQcC8W/HAxX3XFWAgC5BaD+6q2fvTTq2X95JuO4JpZXCMI2lsREFsLPHOgo0+KKkUZ+Zj4Y+gI
 T7UYxJUQvP2bjnS2pUeny7LsAcH+Hypn6SH6h8kM89JDGEpdwGhVk3V4qMxGTizU/ShIWCDWM2
 9WJBTsrTn4CvzARuLAOo4EtuFjSxnoYfXA0dKtnK4RmLx5LzK39YcKPJCU1R/gtsxuSbCCB4TW
 zjw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 17:02:30 -0800
IronPort-SDR: C+h7RS+sDhm/60syVsZobEIrsCTc+VQyvUvqc6oGRI9WW1wSVnNXyqcI1ysgHul9XH+yIqp6/B
 INa885yywMwNeIowrp5yFM2WG62FwhSQWjp0eu4s11wTs3/qFz3A85B39yomanTXDeLMgd9pmn
 YJjwkB9oH2XVH8jHkWPouo97Uobr/VLnuGGEhTrrhwt0v195YbqLHEdXbYWPTUuqbFUYotLTQ+
 ajzmw0eZAXHY2+0dBdEBxLmQ2vz32D6d45X/c3Cd3cohyqveeP2PlHFTCtj1DtVrFQdrwImOoy
 Sgs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 17:44:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NYBj5276mz1Rwt8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:44:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671155048; x=1673747049; bh=XXXd/KGEnlY9M5D8rYxoFlOUBugtdt/fm6g
        3o8GolGQ=; b=KVR4Bx7YrZm6o+smURIYHhA6xc07ZJaWCKPlYfODRnGv1N7bRqw
        XgkR+fB+gkAXZubmyqTplGEjiP85DPUbw18TjMvdKulq9TaMk2rBQSBEqAsHucA2
        QNdnojjan9ZI3smk9ExywRUz5qLu8d0bHAaaSp4WtQsGmUaHoTNccXbFDbSR94V9
        y9o/qnmle7HLKmwAzMozSFvpEU9BvdxFemXD3XXFkc/cviM/3YaLBfNz/dwnJaSF
        B+0j7bWRuuHIv0mqGJQlwauXJlnfThvcwAQQLy2wQ5ypYa9h7/jzIlPp3NUkMvYS
        Faaz4DuTsgHNFGDAdE6046TyyPIgr9VoFBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3SpupjVwhI0m for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 17:44:08 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NYBj31vP0z1RvLy;
        Thu, 15 Dec 2022 17:44:07 -0800 (PST)
Message-ID: <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
Date:   Fri, 16 Dec 2022 10:44:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: possible deadlock in __ata_sff_interrupt
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y5s7F/4WKe8BtftB@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 00:19, Al Viro wrote:
> On Thu, Dec 15, 2022 at 06:48:20PM +0900, Damien Le Moal wrote:
> 
>> The problem is here: sg_rq_end_io() calling kill_fasync(). But at a quick
>> glance, this is not the only driver calling kill_fasync() with a spinlock
>> held with irq disabled... So there may be a fundamental problem with
>> kill_fasync() function if drivers are allowed to do that, or the reverse,
>> all drivers calling that function with a lock held with irq disabled need
>> to be fixed.
>>
>> Al, Chuck, Jeff,
>>
>> Any thought ?
> 
> What is the problem with read_lock_irqsave() called with irqs disabled?
> read_lock_irq() would have been a bug in such conditions, of course, but
> that's not what we use...

The original & complete lockdep splat is in the report email here:

https://marc.info/?l=linux-ide&m=167094379710177&w=2

It looks like a spinlock is taken for the fasync stuff without irq
disabled and that same spinlock is needed in kill_fasync() which is
itself called (potentially) with IRQ disabled. Hence the splat. In any
case, that is how I understand the issue. But as mentioned above, given
that I can see many drivers calling kill_fasync() with irq disabled, I
wonder if this is a genuine potential problem or a false negative.

-- 
Damien Le Moal
Western Digital Research

