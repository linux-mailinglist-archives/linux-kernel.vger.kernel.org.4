Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAA6CBCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjC1LDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjC1LDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:03:02 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D82B199E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BGcqvjAvAr0DdvvnH3LPxZVJzBmax0C05XNKRWOpsq4=; b=TeS6ds0rltsMhdCG8yoz/VgLdm
        U0sUzeMx9EOH1hxdNfH2nqCyGkk8aK67AQT5lkPSn5Vw2BQStmyf3ORemu9dBnyqY8vz/3vfpn3Hx
        XyaW4gDQsJNEHqt3+6B0j/kCALsrmPJpF42GdZkCMgNrLlzP6ypS/emORw4yPfBQRlcYze7zTdMMT
        pyOuCpcPmDLsQWzcDJKAl34NCVjqt6JcPoZIw4xLvv2YYfxVRX3aH3Tt9F72O5UnSbFjnSqZI1mhL
        bgUFLCD1xEL9FAYLbsT5enkwfVQro5q8XzjK7Td1GyCfaElVZGj62EXpdex9yjoQFMdBYePJhy5pZ
        /Z4eSkzw==;
Message-ID: <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
Date:   Tue, 28 Mar 2023 12:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
From:   David R <david@unsolicited.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
In-Reply-To: <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
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

On 27/03/2023 09:13, David R wrote:
> On 27/03/2023 08:49, Borislav Petkov wrote:
>> On Mon, Mar 27, 2023 at 07:43:52AM +0100, David R wrote:
>>> I have the following panic after upgrading my kernel. Working 
>>> version is
>>> 6.1.10, so something has happened after that. 6.2.x kernels crash in 
>>> the
>>> same way. Attached config.
>>

After more investigation :

     Revert "x86/acpi/boot: Do not register processors that cannot be 
onlined for x2APIC"

     This reverts commit ce7d894bed1a539a8d6cff42f6f78f9db0c9c26b.

Corrects the issue for me.

Cheers
David
