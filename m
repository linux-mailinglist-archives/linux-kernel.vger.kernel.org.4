Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1B6A29DC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBYMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYMz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:55:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2AA264
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HZaGAx3N33jF1q/NgT0nSb5QFVJjeHw9L7c7gc+C4W0=; b=tweeWNRRZSiUb0t7YRS3iDWOb6
        FL5XzHvZes4+JgCjeGGkeeExmA6b8gQ90CntbDgPRnZT2ocNCX+BVhwIf0QdHEypPdigSz7STP/Bx
        ZvfgShe0pVWmGCyZuQVx0/axSjpLpSaS4wYvXQrxu+/A9qdzcJMk4ocja/dpniZvGTXaRtGpGpaXV
        P5oPevf2RCzrFKG3Kptz7RzRQxTDPUV5mQh3dPupQcVWxdCRBX8I6lZjVOVyK6fiVDWMJcpV3WHz1
        epYsYHRd3n6UG13r0xrmWzDPvFoZUBrDWnYTFPqG5f5URwKjWtga7RH93xBolZ7Gqqj+jG6wO7TjC
        XWvbA5kA==;
Received: from [2a00:23ee:1108:ee66:41e3:be24:54a5:1dc5] (helo=[IPv6:::1])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVu57-00G7qZ-NW; Sat, 25 Feb 2023 12:55:18 +0000
Date:   Sat, 25 Feb 2023 12:55:12 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
CC:     Usama Arif <usama.arif@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BExternal=5D_=5BPATCH_v2_0/5=5D_x86-6?= =?US-ASCII?Q?4=3A_Remove_global_variables_from_boot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com>
References: <20230224154235.277350-1-brgerst@gmail.com> <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com> <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com> <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org> <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com>
Message-ID: <E940A2E7-6FAC-4E87-96DE-596BA3F505AF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 February 2023 12:47:33 GMT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Sat, Feb 25, 2023 at 5:20 AM David Woodhouse <dwmw2@infradead=2Eorg> w=
rote:
>>
>> On Fri, 2023-02-24 at 16:38 -0500, Brian Gerst wrote:
>> > Removing the globals before the parallel boot series, would be the
>> > best option IMO=2E  That would make the transition simpler=2E
>>
>> Looks like this:
>>
>> https://git=2Einfradead=2Eorg/users/dwmw2/linux=2Egit/shortlog/refs/hea=
ds/parallel-6=2E2-rc8-brfirst
>>
>> Passes basic smoke testing in qemu, including suspend to RAM and
>> offlining CPU0=2E
>
>Looks good, thanks=2E

Aside from the fact that I forgot to put the tr_lock into the other startu=
p paths that load the realmode %esp=2E But I'll let Usama do that now=2E

I can probably work out how to test the AMD SEV path; is there a way I can=
 test the startup_64 MADT one?
