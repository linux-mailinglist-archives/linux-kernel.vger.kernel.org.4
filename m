Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A3653A19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiLVAaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:30:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F6218AE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B002BB81BE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6BC433EF;
        Thu, 22 Dec 2022 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671669003;
        bh=W3ieMBH1py2ivn2gYCl7Hf6einZeemiSyRBDMxO+2co=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=LC7pVYH9rem06N0nQg5JO40wJEmhJz4oDd7vtKrq6OgFKM0epZ8YtmjEJoiOtm00R
         YI1BMuCHJ/YYMVe9ztbCxACHk9Tub7A4kCcDGA4omlJfJBjKWiGz/0HpiHLmq9OswB
         VH2zaMQYMrH/EvRz6oQbC1O+JbEt0Z2q3zgF9lcxtTC0elauT8WniN5GpSRP9M8lgl
         X9jPcOFpGOJ3VPxjJgOngXteJW/ohsPAlP5bMaSYSnVR4XeMiEQC0KT0XYxCRok03s
         W/0PapvkB62OTr1yp5fL+2ry77CC9MDW4vAk6z/6D/ZWagSbNi6nWjxMbRg2eynPXa
         TCzIAed7Z3DhQ==
Date:   Thu, 22 Dec 2022 00:29:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>, Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, changbin.du@intel.com, zong.li@sifive.com,
        rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
User-Agent: K-9 Mail for Android
In-Reply-To: <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
References: <20221120101049.2078117-1-guoren@kernel.org> <Y3tPEDvM3aVJmVxF@wendy> <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com> <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
Message-ID: <5CA9DB64-CE90-490A-835B-0FC4550E5D9A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 December 2022 00:19:02 GMT, Changbin Du <changbin=2Edu@gmail=2Ecom> =
wrote:
>Hello,
>Does this patch get merged into riscv tree now? This problem has been the=
re for a long
>time=2E (I suppose you have received my previous reponse=2E)

As far as I can tell, this patch is still missing a sign-off from you=2E
There's nothing in response to this thread that I can see which provides o=
ne=2E

>
>On Mon, Nov 21, 2022 at 07:09:45PM +0800, Guo Ren wrote:
>> On Mon, Nov 21, 2022 at 6:13 PM Conor Dooley <conor=2Edooley@microchip=
=2Ecom> wrote:
>> >
>> > On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel=2Eorg wrote:
>> > > From: Changbin Du <changbin=2Edu@gmail=2Ecom>
>> >
>> > > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
>> > > Cc: Changbin Du <changbin=2Edu@gmail=2Ecom>
>> > > Co-developed-by: Guo Ren <guoren@kernel=2Eorg>
>> > > Signed-off-by: Guo Ren <guoren@kernel=2Eorg>
>> > > Cc: Zong Li <zong=2Eli@sifive=2Ecom>
>> > > Cc: Palmer Dabbelt <palmer@dabbelt=2Ecom>
>> > > ---
>> >
>> > Hey Guo Ren,
>> >
>> > FYI you're missing a SoB from Chanbin on this patch=2E They gave one =
in
>> > their v1 though so you should be able to re-use that?
>> I'm waiting for his SoB=2E I don't think I could directly use his SoB i=
n
>> v1=2E I need him to confirm my rewritten commit log for lockdep
>> analysis=2E
>>=20
>> >
>> > Thanks,
>> > Conor=2E
>> >
>> > > Changes in v2:
>> > >  - Rewrite commit log with lockdep explanation [Guo Ren]
>> > >  - Rebase on v6=2E1 [Guo Ren]
>> > >
>> > > v1:
>> > > https://lore=2Ekernel=2Eorg/linux-riscv/20210417023532=2E354714-1-c=
hangbin=2Edu@gmail=2Ecom/
>> >
>>=20
>>=20
>> --=20
>> Best Regards
>>  Guo Ren
>
