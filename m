Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D76CF331
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjC2TbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjC2TbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:31:17 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F0171B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DRQKiNNJTk+MgAULbHa2SIh38BgVc3n0jnc/VOe3EA0=; b=qfv7ugESK9XlwIAMpTYUytLWpq
        yr8bmgESpbqAngyOGI39+RwdVNWQxew3vrgbOXpFCR7dBwntWW1Ubr9qN9xyjL3+u/6aTMEnjus4d
        cqs+xgtZ+v9Ps9NyQD7UKmwSO0XGs9/RkCk5oJLDVI4oS14qICo6l17HcqTXH9SeK2JIU+tFh6E6j
        BUA38WA5pHPmRotDxqfqVlGE/TlCCC/oWUfpGuyuEbDQACAFVe+yDG4BUAmkAzFiUWY+Ko9SlKejq
        CFO6rj3EfaglO+QVRMz2KY1ZozZR4h/jUDEbmQt5CgnIzCS02T+PDlrbKZ9K1RZQo/pPBYQ2WNCd1
        LFmyDkWA==;
Message-ID: <c99b8e4b-b835-8520-2667-3d7dd2839a3e@unsolicited.net>
Date:   Wed, 29 Mar 2023 20:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>,
        eric.devolder@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
 <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
 <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
 <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
 <e8fd7cdf-b6a5-1c7d-bd08-0d60a1c10495@amd.com>
 <eaa97a25-27b2-187c-1db2-9c56e35d3463@unsolicited.net>
 <b65c4f1f-4990-f7ce-e4c0-85912d187eaf@amd.com>
 <a0ca1e4e-891c-273d-e2d8-eeb9fc4d0c77@unsolicited.net>
 <e4a6e5bb-d014-aa55-5eee-65f1c5f59875@amd.com>
 <7218e006-9f4f-a9bc-cdd2-a595a8e64ede@unsolicited.net>
 <70291f94-1fcf-175c-fc18-e9b656f55af3@amd.com>
From:   David R <david@unsolicited.net>
In-Reply-To: <70291f94-1fcf-175c-fc18-e9b656f55af3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 20:24, Limonciello, Mario wrote:
> On 3/29/2023 14:20, David R wrote:
>> On 29/03/2023 20:17, Limonciello, Mario wrote:
>>>
>>> You mean specifically this change:
>>> https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/ 
>>>
>>>
>>> Yes; I suppose that still makes sense.
>>>
>> Yes, that's the one.
>>
>> But the fact that  that one worked own its own implies that my system 
>> never had the flag set in the first place?
>>
>> David
>
> Right - your BIOS doesn't support MADT revision 5 which was introduced 
> as part of ACPI 6.3.
>
> If you haven't already you should add a Tested-by tag for Eric's patch.
>
> I think both mine and his coupled together should cover both of these 
> possible areas of breakage.

Indeed.

I'm not subscribed to linux-pm so don't know how I'd add my Tested-by:

By all means add it on my behalf.

Cheers
David


