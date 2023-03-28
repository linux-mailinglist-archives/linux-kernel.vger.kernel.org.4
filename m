Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7916CC4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1PKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjC1PKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:10:25 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A586AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KK2SFGrsQMr3j8FZqsNKuM7Ny/ZbyryWCbCocIFHq/8=; b=Gyovh8fJI3DfcZpG/E8UQuPhgk
        AJdiHXWOcxkjAAZNyai+1akYzdFFzF5XAOED4RFB5h1EDT1/7MMfJhFaoPODBFol80ZG1+RGELh6I
        lrZ5hF8JK4R69M6w71yElf+ZnxAMY2ABqBooy7BhwJVbjF7zrmd2PWsLmEjmUnwEl03xwfoQyWw2q
        gdmiRxOkrU61PUZVDD63YNg++chlUKSBKbZuE1wdrQ0qImEs62ld8vyU4BZlfwXI8sxm7AZv/3X9p
        DGHNkW/Gwlj+VRFJ52qc4R51ICkeinQUreOKoqeB5/RRxnSJXU94KentPRIw062TwfOhMxXzOM/m3
        5lj4MApA==;
Message-ID: <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
Date:   Tue, 28 Mar 2023 16:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
From:   David R <david@unsolicited.net>
In-Reply-To: <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
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

On 28/03/2023 15:20, Borislav Petkov wrote:
> On Tue, Mar 28, 2023 at 12:02:57PM +0100, David R wrote:
>> After more investigation :
>>
>>      Revert "x86/acpi/boot: Do not register processors that cannot be onlined
>> for x2APIC"
>>
>>      This reverts commit ce7d894bed1a539a8d6cff42f6f78f9db0c9c26b.
>>
>> Corrects the issue for me.
> Hmm, weird. That commit came up already yesterday. But in conjunction
> with qemu.
>
> Does this fix it per chance?
>
> https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/
>
> You'd need to revert the revert and apply this one ontop.
>
> Thx.
>
Yes, that patch fixes it also. By all means add my tested by:

Thanks
David
