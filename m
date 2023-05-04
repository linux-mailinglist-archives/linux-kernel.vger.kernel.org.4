Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AB6F6D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjEDNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEDNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C41737
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C62B761724
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D33C433D2;
        Thu,  4 May 2023 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683208088;
        bh=R9GKOXYE8PBV0LY9sI0Q299FOl49FSPW4seo6zskIsk=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=SJQr4kHdHxPmT1D1jnczqDSkjtXVsFUuGuMIN1CnHeXgOMmLV6fSvkTcGaGMq5b9Z
         TEl/BafjqL9bQbfNNX6fDzVN6z5O9E+g3fG6FbNCyinu/AvzsFMthcqg0KQHdV989/
         cR6If4+zn3wr37KnQBpRXbUT0jsApaLmc+tA2BzJVCn/Cyong61NXlYDow/EWiIRfG
         ovGVV8Wbi9s3zyytslHEPH12cN7W/RP5pDc/5T2Fo/NBi9Ve+ICbZKHCnyxK9krzNU
         jvnHkFkTM9Wsg612GufUOEAa7SNw715sI0cPS3qN/CH2q339j4N4xhdtk4Z9QVCg5X
         hQQV/eWQjPAXw==
Message-ID: <d6a26ad8-3c90-d932-d966-85414e0ae42a@kernel.org>
Date:   Thu, 4 May 2023 21:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
Content-Language: en-US
To:     syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000032909d05fade30c8@google.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <00000000000032909d05fade30c8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/4 21:31, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:

It said the reproducer is still triggering an issue, however, there is
no error output from the test.

Could you please help to check whether such status is normal or not, or
am I missing something?

Thanks,

> no output from test machine
> 
> 
> 
> Tested on:
> 
> commit:         2adb872d f2fs: fix potential deadlock due to unpaired ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git dev-test
> console output: https://syzkaller.appspot.com/x/log.txt?x=114b5338280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4eb913e90d4b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Note: no patches were applied.
