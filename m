Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497E95F25EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJBWVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJBWVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:21:09 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FF39133;
        Sun,  2 Oct 2022 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664749242;
        bh=wxcJ1oVVAgA7JG2CodhHq8sHP/Kq00NTKknAQPYnPoM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FV0GBs3XBLTYS1x2nKSOFiGLJSvECYlGxbZcYsohsbeNAxRO/sqiqbAc76SFJCalG
         RRX9RvLXRvTfBUuxiWV/T+SKkAWVTo80tMduaZ4Swxns+wrMwywpep1LCccZmnY/K+
         brsWIKHqbbmrgZJtxWuuA5QAeeRKyjNo4kNYPFUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1or0tx0qEh-00QEmg; Mon, 03
 Oct 2022 00:20:42 +0200
Message-ID: <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
Date:   Sun, 2 Oct 2022 22:20:40 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002180844.2e91b1f1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hYH43PNKFMNifBbao336dksMqDiZ/1kccCI7/W5OQbB75JF4IMc
 Jypay1VNx/0xXyxppt2hRRjJoOOEpe1K7WS/WZk+eMHH6fN3OdtamuoSI6+MD50UbP7d76u
 J4rjgWD+3FVj5+b/v6D64oGaCV5OKSlONOr0ExR8Gcb4bcGFTmHMMBBezu2saaHhRv8ZPhS
 F8yfGI8XJducGL8uJ/+MQ==
X-UI-Out-Filterresults: junk:10;V03:K0:0mnP7+1aEvg=:MgcwMVAR2o2JHwpBDmt3KxaV
 Ycrfj+CNxX+Lq8+jJogpUqOrgnCEpHUf6waHq1kKzTezUlchPFXQ3MeWY4n3he2biN5hKVU4l
 1KMrz9YqjsvExKRsjpG7to//oBLcs3aOzbKa2v6tzgT0Rh9pyybhqA7PFVgtepHdYT2G9ysZ5
 GmTNrzfHO7axEyTs3H4/AbaRx2a19bF54PVhxkxMRcWuG6oYwFBTxarrTW8XVvageuyskQJ0r
 I7KIn3yr3/8GOjDqy5FoNTO+OODu+e2AHmNC2P9qn7G5pKHw6YbbUwazzdwFlikFV8PDcsmWz
 mIlFlD6B38PvkVBpVuXPtptRcytLykd5ZApFR5bh/cMguvHXHtqp3nGaaoPKPmSdlkkSUHzY/
 xa59RtiXqy6RV+rWow7urGl/s91E8JzqzeCvBhRUsHsdn+4Vs4YNr0bxrYA3IpR5EbxIBrxzx
 0o2O9QPf+Df0otp4p7vxNoQ/BADZcxLduAQvA3c39fSsQoXUsa41ojwpQ3M0BL+PEoeKxgyCK
 lwqtNIxoNq3Ow4MsdoE4WEKbVQcYlhbZG7LZ/FIvUymnz0L5LdeLeUH89x9jgIYNNeBvlYPDL
 ZVeplWjwO+HSw8WHF6Aamrukw1904oCjfC2EeG9J39YB+HBq8DefA1ISwmespyCkIT0YUHesM
 y8Ye+N7WGupI/WQIT9boW5syQtCJ7vIlnpgyPPVPPL3C8+UHfV057j67/z5zR9kgsBSuFbkII
 FOFDLlqEHHOWYw3bGP8vd7atf2kKQmRPZ30M3LuPCxhFS+oMUa9afDMGdolGIU3Bf9gkA1HXX
 OS6GY6tnZl4xSc2tJTVPzJlZ0uJtIKhEXcGAnylRXYpuHl2i3SNHH9bLPXWVvvO7PLixisZFj
 1h00qkfARtAu5NCaKfYnz1n07TGdInIF7/JJi7i2LMQaIihg1sGD6IVyOd/1hmzdD1/9QjOur
 HBPUkndjpPhR82/gcuIbA8G7xJaUtTbb/NZi3rbN/0FrbKM9Xa/kIbhWGt6JCkjaFXsYEO/Kd
 qHdLDFWO1tIcs6zP+IEDZ1Xi0CXf2pBiC6AmaiIAXQSQZH/bbNMhmbwnhmxOJN+TPkLLKe7fU
 yPoGrqT2lEEadetx5PbnYAKV9Xq75kaPgJGYlg+gHfzVVrRqP5xVm1HoC+DS/xnLIpwuLhxGO
 Z5cgl/D9nXIUcdiwtFuKfgjf2pMo+hb3J/mddlHBYpKd9A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 22:08, Steven Rostedt wrote:

Sometime mailing lists are worth CC'ing, sometimes individual developers
when you can easily find/bisect the bad commit.

Bugzilla hasn't been updated in a very long time so it's missing both
mailing lists and individual kernel developers.

AFAIK, some pieces of kernel have no appropriate mailing lists at all.
What about that? I've no clue.

Opt-in will work, except I've no idea how to make it work. Mass email
all the kernel developers and politely invite them to sign up? Most will
simply ignore it.

It's been mentioned here several times already that even collecting
their public email addresses in public git logs could be considered illega=
l.

There's too much resistance, too much "Mail will work for everyone"
except when it doesn't. I've got a strong feeling inving me to this
discussion was a bad mistake and no one even remotely likes my
proposals. Sorry, I give up.


Best regards,
Artem
