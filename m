Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4D6CEF26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC2QUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC2QUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:20:19 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AAEBA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FmMKCABAq32DvmBCefrXGRoM5Ji+JK6eayU3ugc06WA=; b=coFgJt8zFRKuM+PTwzv0Qm/zCt
        OEC/I+lSRRXLKbqwVIW+I1cPCYBqSfBFMreRzyhlFcUJYc+PrPJwwm46L4SIfKmT0lNn4XglFBsl0
        TUqOOlJ+ndp4u1k9fuwPWgtm0BvEi3FAvREBOP2XhxMe5UWpxJ39ImtRQBG+gzsZdJSQ1wWduARtP
        6FqNGJVMsW+VYJeRO0YdR5vm/FR5/Qod0P1OwH/KEN+CCM3VaNJEBEBRi81ErWq60LfZrYElI1i+S
        I+qa9RW0Nkec6Q/mZUN8CA+k7ARalwDzwbZ8hiAOYx2llJE09PARo80nNE30xx/EPYePzwGzF443L
        DpxbFJTw==;
Message-ID: <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
Date:   Wed, 29 Mar 2023 17:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>
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
From:   David R <david@unsolicited.net>
In-Reply-To: <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
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

On 29/03/2023 17:14, Borislav Petkov wrote:
> Gabriel and David,
>
> can you both pls do:
>
> # acpidump -n MADT
>
> as root and dump the output here?
>
> Thx.
>
APIC @ 0x0000000000000000
     0000: 41 50 49 43 DE 00 00 00 03 AC 41 4C 41 53 4B 41 APIC......ALASKA
     0010: 41 20 4D 20 49 20 00 00 09 20 07 01 41 4D 49 20  A M I ... ..AMI
     0020: 13 00 01 00 00 00 E0 FE 01 00 00 00 00 08 01 00 ................
     0030: 01 00 00 00 00 08 02 01 01 00 00 00 00 08 03 02 ................
     0040: 01 00 00 00 00 08 04 03 01 00 00 00 00 08 05 08 ................
     0050: 01 00 00 00 00 08 06 09 01 00 00 00 00 08 07 0A ................
     0060: 01 00 00 00 00 08 08 0B 01 00 00 00 00 08 09 00 ................
     0070: 00 00 00 00 00 08 0A 00 00 00 00 00 00 08 0B 00 ................
     0080: 00 00 00 00 00 08 0C 00 00 00 00 00 00 08 0D 00 ................
     0090: 00 00 00 00 00 08 0E 00 00 00 00 00 00 08 0F 00 ................
     00A0: 00 00 00 00 00 08 10 00 00 00 00 00 04 06 FF 05 ................
     00B0: 00 01 01 0C 09 00 00 00 C0 FE 00 00 00 00 01 0C ................
     00C0: 0A 00 00 10 C0 FE 18 00 00 00 02 0A 00 00 02 00 ................
     00D0: 00 00 00 00 02 0A 00 09 09 00 00 00 0F 00 ..............


Cheers
David
