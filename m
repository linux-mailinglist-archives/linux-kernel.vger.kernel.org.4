Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0AD5F7C68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJGRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:44:07 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCCD8EFD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:44:07 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297Hhb1k3871548
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 10:43:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297Hhb1k3871548
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665164618;
        bh=my1b0qtvsPdCaDJq4ZnTV0d8jLsLsG2IS1TNTWvIsE0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HmMxuObHYwLnNoVGUqOILqAuESYcH2YUKZOa2xxGUshkwlVsJM3XUdJWpdqy1ggMr
         k8TRq6sSI0u/neRWMzfvWnhzXSYwxx6V/4OLEhLrUkE5yOLp5Cm44CbZzrDEjh1W8B
         t+c+ke5CTQ7/yiKLuHkqbS+DqLonFj5inZ1lzV8VsoCWrojgG2IEx3p/p8yMTGKBys
         akqto1ohGppdZtHAP1TdmrHDNybRjDLu0w/fxzymt44jZoIpQ/RYfVBINyzrc/3Nj4
         VqN11tZ0cjmftWoTzExoIvrRjEgxXXE/YS4FZfAy1wJ4gOyUr4ey6Bxm4wrNMTXCyc
         /D+hQe3vttWNw==
Date:   Fri, 07 Oct 2022 10:43:34 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>, Xin Li <xin3.li@intel.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_5/6=5D_x86/gsseg=3A_move_loa?= =?US-ASCII?Q?d=5Fgs=5Findex=28=29_to_its_own_header_file?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2gYp0WXQYX1GHad3jCvoBBbO4yiEk_sJrfNUF1zGGapsg@mail.gmail.com>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-6-xin3.li@intel.com> <CAMzpN2gYp0WXQYX1GHad3jCvoBBbO4yiEk_sJrfNUF1zGGapsg@mail.gmail.com>
Message-ID: <6CBB0EC9-5EF1-4396-9B5F-C0A5592BFD37@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 7, 2022 8:40:41 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Thu, Oct 6, 2022 at 12:13 PM Xin Li <xin3=2Eli@intel=2Ecom> wrote:
>>
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>
>> <asm/cpufeature=2Eh> depends on <asm/special_insns=2Eh>, so in order to=
 be
>> able to use alternatives in native_load_gs_index(), factor it out into
>> a separate header file=2E
>>
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>
>This could be moved into <asm/segment=2Eh> instead of creating a new head=
er file=2E
>
>--
>Brian Gerst

At least at the time I wrote the code, it could not, without creating yet =
another circular header file dependency=2E
