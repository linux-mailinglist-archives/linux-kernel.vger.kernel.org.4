Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D673770A557
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjETEmy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 May 2023 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETEmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:42:52 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FFE40;
        Fri, 19 May 2023 21:42:49 -0700 (PDT)
Received: from smtpclient.apple (unknown [124.16.139.61])
        by APP-05 (Coremail) with SMTP id zQCowAC3v4u5T2hkS4LeAQ--.40596S2;
        Sat, 20 May 2023 12:42:34 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: memory leak in do_epoll_create
From:   =?utf-8?B?6IyD5L+K5p2w?= <junjie2020@iscas.ac.cn>
In-Reply-To: <20230519185703.GA3288616@google.com>
Date:   Sat, 20 May 2023 12:42:23 +0800
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BF300751-7758-4FDE-AB54-9D25974DC873@iscas.ac.cn>
References: <eb5a09c.67fa.1883321b285.Coremail.junjie2020@iscas.ac.cn>
 <20230519185703.GA3288616@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-CM-TRANSID: zQCowAC3v4u5T2hkS4LeAQ--.40596S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8AFy7tF15GrW5uFW3KFg_yoW8JFy7pF
        45ta9a9r4ktFn3J340va18Za4ft3yfWFy3Jrs8Xw4rGr9xJryfArykKFWY9asFqr18CrWF
        vrWqqF1qyw1UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
        4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
        rwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07j7KsbUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: xmxqyxbhsqji46lvutnvoduhdfq/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your response. This is my first time submitting crashes to kernel developers, so forgive me if there are any shortcomings. In my opinion, some of the code crashes in the old version may also be present in the new version. That’s why I want to report these crash to you. I will take note of the issues you mentioned and make a meaningful contribution by submitting valid kernel errors next time.!
Sincerely!
> 2023年5月20日 02:57，Eric Biggers <ebiggers@kernel.org> 写道：
> 
> On Fri, May 19, 2023 at 04:30:26PM +0800, 范俊杰 wrote:
>> Hi Kernel maintainers,
>> 
>> Our tool found a new bug memory leak in do_epoll_create in Kernel commit
>> v5.14.
>> 
> 
> v5.14 is almost 2 years old.  Why are you testing such an old kernel version?
> This bug could have already been fixed almost 2 years ago.
> 
> Also, if you think this is a bug in eventpoll, this report should be sent to
> linux-fsdevel, as per './scripts/get_maintainer.pl fs/eventpoll.c'.  It's
> unclear why you are sending this report to linux-scsi.
> 
>> The report is as below and this bug don't have a repro C program until
>> now. Please inform me if you confirm this is a reproducible bug.
> 
> I think you answered your own question.  It doesn't have a reproducer;
> therefore, it's not reproducible.
> 
> - Eric

