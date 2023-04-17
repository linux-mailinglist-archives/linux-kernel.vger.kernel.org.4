Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7C6E5047
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDQSd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDQSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:33:20 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4EF46A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:33:19 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 33HIWO5a822699
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 17 Apr 2023 11:32:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 33HIWO5a822699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023040901; t=1681756345;
        bh=uLowGqBn0KRTDbHMKgtvS9A/f9l+M9Fpbtog9Fn0rpE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=VhvJolikEz8An8m+jtq9VAH6jP43sJWjxNwJ+NnZkDLbvg1BDJknWz1zc0aGEBYpQ
         pVzFaqGbPLUqcmY8N0mzjQwh21gd+Hxea27zPMcODb51Qh4TRRRdPCMy+5PrbDcueE
         YQ2t1n9FAD952jafB+Fi4Y+9kNTj5FshLiEp+xFQoH1nktQiDc0NBMQIzf/EqCgBbo
         u8t1mgLjsjwfQoYAOYpL8d/sSnoRX9+TUYGzJoRk0sdOHhed7ghw56df3wXIVd/GCU
         uj3mWVBIBxcWsVk0nxF2cDglfslFwP1lPgpx0sWkRQc1+qAQFz0tOwGsbFrKHMUBjZ
         +goUGL0mwTHWA==
Date:   Mon, 17 Apr 2023 11:32:19 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>
CC:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BBUG_REPORT=5D_arch/x86/include/asm/uac?= =?US-ASCII?Q?cess=5F64=2Eh=3A119=3A_Error=3A_junk_at_end_of_line?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230417181417.GHZD2MeRSuMWUPEU3V@fat_crate.local>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com> <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local> <ZDrlMfy+OcDjXwvn@1wt.eu> <E8CB02C5-E18C-42F6-93D8-2CC7CB4CB3FF@alien8.de> <ZDuzlNOmIT0Gd7fF@1wt.eu> <20230417181417.GHZD2MeRSuMWUPEU3V@fat_crate.local>
Message-ID: <F3AC1D23-D1B7-4036-BF52-1CC4FD6C3EAD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 17, 2023 11:14:17 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sun, Apr 16, 2023 at 10:36:36AM +0200, Willy Tarreau wrote:
>> =2E=2E=2E
>> So it just means that the support for the "U" suffix on numbers was
>> added in binutils 2=2E27 and the "L" suffix on numbers was added somewh=
ere
>> between 2=2E27 and 2=2E29=2E
>
>Thanks for that - I'd like to document this once I've hashed out with
>the toolchain person the proper binutils versions which got this
>support=2E But that'll come later=2E
>
>> And given that there's a single occurrence of all this in the whole tre=
e,
>> that's why I'm proposing to just get back to the good old (1 << 0) inst=
ead
>> of BIT(0)=2E
>
>Yeah, we have those UC() macro things but they don't work in inline asm
>in C code=2E So yeah, pls do the thing you're suggesting=2E
>
>Thx=2E
>

We do have assembly-aware macros for this; I believe they are called _UL()=
 etc=2E
