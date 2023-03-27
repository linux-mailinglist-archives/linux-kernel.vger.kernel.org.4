Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCD6CAA71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC0QVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC0QVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:21:21 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C9BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m2oL8yLwon6/nUPqqxY4yxqxx1T7yRaYgo26N9XN7CA=; b=jVS8Upcw2IhSMzeMfuD85+hefx
        wTOLJIMi2M6x1JxHRfLdw9NNy7zDzORuD7FeFwX9djKU8X3UcDqB7YP/CeJMjlXS/tlMPy5BQGFuO
        vCjLysAS/FEK4VWoYtGlP/ItE0Kafn9KVMJCD5bjY4gs15cbK2WqPwAFpHOFB3AxL+pntluBmICU1
        33k4nslmHdWrBhFxi48ZigmRPNUAAdtDhAzyTefWgKtHjAy9gMmcNtVwEbKL+jq1TINp2U3dKrSXK
        xeYKoKoLqu1OqKCBsK9HEh8+pW1aa783fP7GjfGtJlHIuTBdFYGAVl8JrX9g+oc00Y4OIxboIA+qg
        inwpAIJQ==;
Message-ID: <24f77ddd-a852-b496-0e2e-b331061bce07@unsolicited.net>
Date:   Mon, 27 Mar 2023 17:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
From:   David R <david@unsolicited.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net> <878rfi718j.ffs@tglx>
 <d18c96d6-d1e2-aaa9-fab5-e6fc8cc0d1f9@unsolicited.net>
In-Reply-To: <d18c96d6-d1e2-aaa9-fab5-e6fc8cc0d1f9@unsolicited.net>
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

On 27/03/2023 16:53, David R wrote:
> On 27/03/2023 14:49, Thomas Gleixner wrote:
>> On Mon, Mar 27 2023 at 09:13, David R. wrote:
>>> On 27/03/2023 08:49, Borislav Petkov wrote:
>>>> On Mon, Mar 27, 2023 at 07:43:52AM +0100, David R wrote:
>>>>> I have the following panic after upgrading my kernel. Working 
>>>>> version is
>>>>> 6.1.10, so something has happened after that.
>> IIUC 6.1.11 is failing, right?
>>
>>>>> 6.2.x kernels crash in the same way. Attached config.
>>>>>
>>>> Please send dmesg from 6.1.
>>>>
>>> Of course - attached.
>> Thanks for the info.
>>
>>         tglx
> Currently:
>
>  6.1.14 good
>  6.1.16 bad
>
> Currently building 6.1.15 .....

6.1.15 is good too - so the issue starts at 6.1.16
