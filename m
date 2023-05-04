Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788B6F700E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjEDQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEDQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:44:43 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21666359F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:44:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-763af6790a3so4516439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683218680; x=1685810680;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RldMxRu/eCeUoOgwIk9gehyNreGKl8U4r7xfbeXdGLk=;
        b=gU503mwUGDgvk+ob6edwahv5IgBmP7ZtABLqT6FPLZO7zKK1IskehUe3xVTWnfHAer
         2GNQ6R1WgeObwkRXPElf2IRADlJ2RKBOmcwCBcmuWhO8+Gf33wDYQrPm2PeE9cwjKGm7
         1OCO8hT67pAfXiTKkAFr2mKExEMqV4ZEIGxK/biH2fNi4LT1B9RTkxtn3RTwfheUNTIL
         j4ropzYAbeRCuDJ6m/CRWHRMHkmmadk1taXK+N105YYs4jbCE92pd830QdorGNc6n6pa
         s5Mr3FOZgEpUqYvb48dd5Ac1yNhVqQToWjDbzYalgM7vIxxHa2RO6ntIpdJ4RItv5/LI
         1rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218680; x=1685810680;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RldMxRu/eCeUoOgwIk9gehyNreGKl8U4r7xfbeXdGLk=;
        b=QKzPggJebPC5alUMN5y2RDleOmn2rGApOTI/0xFpPfLUzMBLD+oIkiX/n4PksVNJjD
         Vcih0hzKibdf3v6j9SRdE88Mh7ghXXC4xRfzQZmBKsFWxAyJC2OsQz0tE7xOZQkFdi7C
         dcKx+jR1U/Fv+IOlnP1HCkuJxwq19JAMX2+snt1asR556Qay13aWPghPpKT7nJuSapvz
         sDwsXlQSob/pufLC7auwECC+tUlUgx2RT1WQJM6bN0V1An6gOXLPdyTpNKSzLEzklZ7u
         t4BOEZY+zvbn9440Oh1TnjYa2BymRLirxWjMgaItxx//ncZxWdSqz3iU532NqHzb8prN
         cm6g==
X-Gm-Message-State: AC+VfDxRqJKCCyAB99f5GteimiccGyt2NJqFnyuhjfzi7doZA75t/k55
        YPVDbQi/g9KlYmJoLBCUkcFJmg==
X-Google-Smtp-Source: ACHHUZ5prRsEWmIhj5kFGb/cvDO1yaOeYY5WSRuaeVPJa7Z898cL5o2X7LzPPTIx95hwtUQnda+dVQ==
X-Received: by 2002:a05:6602:4089:b0:760:ed2e:cc32 with SMTP id bl9-20020a056602408900b00760ed2ecc32mr11841776iob.2.1683218680379;
        Thu, 04 May 2023 09:44:40 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y24-20020a027318000000b0040fbc31614esm10675095jab.54.2023.05.04.09.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:44:39 -0700 (PDT)
Message-ID: <b9acff08-913b-55cc-75dd-4a1bbe63e330@kernel.dk>
Date:   Thu, 4 May 2023 10:44:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     Raghavendra K T <raghavendra.kt@amd.com>,
        Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <835c3de6-7460-226c-96e7-839aeef6064e@amd.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <835c3de6-7460-226c-96e7-839aeef6064e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 10:38 AM, Raghavendra K T wrote:
> On 5/4/2023 5:19 AM, Ben Greear wrote:
>> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>>
>>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>>
>>> Just to understand this properly: you mean after the boot loader said it
>>> loaded the initramfs, not when the kernel starts using it?
>>
>> I am bisecting...it appears to be .config related.  If I skip enabling things
>> during bisect, then I do not see the problem.  But I copied my original buggy .config
>> into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
>> the .config settings....
>>
>> Thanks,
>> Ben
>>
> 
> Hello Ben,
> 
> (CCing Jens here)
> 
> I was facing same issue too. Surprising I did not hit the same on the
> guest VM.
> 
> After bisecting, found that Reverting
> [9f4107b07b17b5ee68af680150f91227bea2df6f] block: store bdev->bd_disk->fops->submit_bio state in bdev
> 
> Helped me to boot back the system. Can you please confirm

Can you try and pull:

git://git.kernel.dk/linux for-6.4/block

into current -git and see if that works for you? There's a fix for that
commit in there.

-- 
Jens Axboe


