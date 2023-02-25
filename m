Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175DE6A2C11
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBYWUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYWUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:20:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0225BDBE1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7ci/pPxKiXiAJSQ2/zCq8t8hQkA6cZTtd9tSCNJd6pE=; b=diw2AMv9Ahyn9YollldYtEYF5+
        Y4cbxZh3Y2EnzyEwePYJzOJyyG9zYUFImmBUblCPFHPBD28JD0ld/YLvXQFGjCrKHGf3whWJf8jpL
        NyoSgBlZG68Dr0ZMz7fYlE+3Eo+Yubug8zpC9HhKWviINvhsf6uGzIyTzjctJmiA7WDIkRyecuBQ5
        E4Bb6HKuVkvqpjBFW9rhl9TVXeCA+0rxfTlZVBMwNfSaRyNHA+7KFan94b9CK7uncd7Fu2ZJCxs9T
        WvuNVXLMt3gz+F7R45lBnhd8F5DeRRwKz+XrC9KGo1XSbJlX5MWCIQFv59RPCkz3KQhsnXu3Fg9sd
        DaxZV0fw==;
Received: from [172.31.31.185] (helo=[127.0.0.1])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pW2tY-00DfsD-2J;
        Sat, 25 Feb 2023 22:20:00 +0000
Date:   Sat, 25 Feb 2023 22:19:56 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Usama Arif <usama.arif@bytedance.com>,
        Brian Gerst <brgerst@gmail.com>,
        Yuan Yao <yuan.yao@linux.intel.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BExternal=5D_=5BPATCH_v2_0/5=5D_x86-6?= =?US-ASCII?Q?4=3A_Remove_global_variables_from_boot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d6d4096c-2373-aafc-ed17-e44e351e66e1@bytedance.com>
References: <20230224154235.277350-1-brgerst@gmail.com> <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com> <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com> <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org> <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com> <E940A2E7-6FAC-4E87-96DE-596BA3F505AF@infradead.org> <671dc8ad-2721-a3a3-7aa2-0e2558d5c953@bytedance.com> <1c64afc8769c222e27ee22a3758b6c32348949d0.camel@infradead.org> <d6d4096c-2373-aafc-ed17-e44e351e66e1@bytedance.com>
Message-ID: <B1B02751-035E-478E-8A3B-FA4F852321CC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 February 2023 22:15:02 GMT, Usama Arif <usama=2Earif@bytedance=2Ecom=
> wrote:
>
>
>On 25/02/2023 13:52, David Woodhouse wrote:
>> On Sat, 2023-02-25 at 13:33 +0000, Usama Arif wrote:
>>>=20
>>> Yeah looks good! I am testing with the macro diff for tr_lock from
>>> https://lore=2Ekernel=2Eorg/all/05e27a7a-1faa-944e-2764-6ab4d620fb8f@b=
ytedance=2Ecom/=2E
>>> If it all works, happy for me to send out v12 with it?
>>=20
>> I moved the macro definition up a little to put it between the =2Ecode1=
6
>> and the =2Ealign, pushed it out as a commit on top of the above branch=
=2E
>>=20
>> We'll collapse it into the 'Support parallel startup' patch, yes?
>>=20
>
>Yes, collapsed with "Support parallel startup of secondary CPUs" patch=2E=
 I think Thomas' solution to dealing with suspend might be better? So I was=
 thinking of sending v12 on top of v6=2E2 release with the following diff o=
ver your branch (merged in the right commit ofcourse):

Nah, I think I prefer it as I had it=2E The new comment says it all=2E

>-       /*
>-        * Ensure the CPU knows which one it is when it comes back, if
>-        * it isn't in parallel mode and expected to work that out for
>-        * itself=2E
>-        */
>-       if (!(smpboot_control & STARTUP_PARALLEL_MASK))
>-               smpboot_control =3D smp_processor_id();

And since Brian's patches there is no "boot mode" any more=2E

>+       /* Force the startup into boot mode */

