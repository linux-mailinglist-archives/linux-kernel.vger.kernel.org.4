Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1156A2A93
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBYPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBYPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:53:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78A76A5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:53:02 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pVwr6-0000Pj-O2; Sat, 25 Feb 2023 16:53:00 +0100
Message-ID: <6bfa6d67-27ce-04b3-a1f9-3768b8a0169f@leemhuis.info>
Date:   Sat, 25 Feb 2023 16:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     davidgow@google.com, rmoar@google.com, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
 <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info>
 <CABXGCsNruNKfx3d1dpneRUvn3dCqv_bM93TdJsCLeRYiP3qYaA@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [6.3][regression] after commit
 7170b7ed6acbde523c5d362c8978c60df4c30f30 my system stuck in initramfs forever
In-Reply-To: <CABXGCsNruNKfx3d1dpneRUvn3dCqv_bM93TdJsCLeRYiP3qYaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1677340382;6fea737d;
X-HE-SMSGID: 1pVwr6-0000Pj-O2
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.23 15:55, Mikhail Gavrilov wrote:
> On Sat, Feb 25, 2023 at 7:22 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 25.02.23 14:51, Mikhail Gavrilov wrote:
>>> new kernel release cycle returning with new bugs
>>> Today my system got stuck in initramfs environment after updating to
>>> commit d2980d8d826554fa6981d621e569a453787472f8.
>>>
>>> I still do not understand how to configure the network inside the
>>> initramfs environment to grab the logs.
>>> Since an attempt to rebuild the initramfs with all modules (dracut
>>> --no-hostonly --force) leads to the stuck initramfs environment and
>>> impossible entering into initramfs console.
>>
>> Do you see any error messages? I have problems since Friday morning as
>> well (stuck in Fedora's initramfs) and see a lot of BPF warnings like
>> "BPF: invalid name" and "failed to validate module". Was able to do a
>> screenshot:
>>
>> https://www.leemhuis.info/files/misc/Screenshot_ktst-f36-x86-64_2023-02-24_07:53:14.png
> 
> I also seen such messages
> https://freeimage.host/i/img-1475.HMPL26l

Pretty sure that's the same problem, at least the symptoms match. If
anyone needs a config to reproduce this, here's one of mine that shows
the problem:

https://www.leemhuis.info/files/misc/config

> P.S.: I also use Fedora Rawhide.

Happens for me on all Fedora 36, 37, and 38 (my rawhide build failed for
other reasons, so I couldn't test).

Ciao, Thorsten
