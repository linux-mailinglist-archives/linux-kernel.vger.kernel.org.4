Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441EC600F28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387741B9C5;
        Mon, 17 Oct 2022 05:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA2060F36;
        Mon, 17 Oct 2022 12:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BBC433D6;
        Mon, 17 Oct 2022 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666009502;
        bh=05YlSAuu/0CUFb3449jUV4GD/RxFgbKpazT1tHrbRhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZlGA7C1E+QM/irWF2a2Ik/TqnMuPHTB90qrcMbSuxrXTBxfZLQ+rHzOQYUnr6y9k
         VdmigLEwuhgTkuuspXKYbxuIwztbB8N9wYRbvtgfxzK1OQF6tdSz45FfIqmk8lBp3g
         Gs2PRPtlHRbV96NcHWGVve/IngNxqJACBm5Q7Mo31FfPMDHex7atAhhtIIwk1d/+QZ
         wGtZ6jAMk55byo/VQlN8v/efB1MFC9B/savoAHXXETxjpUcOocwtgwtMG8ypccJCrE
         2xPxTXPly1QEzlqqI5eH7C2bExAmkaopv0a2bUOx5qmOnOCMxG/NHfGwo53HTxb3uO
         1RHKYLaWso72w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C82B403B6; Mon, 17 Oct 2022 09:24:59 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:24:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     acme@redhat.com, linux@yadro.com, anup@brainfault.org,
        n.shubin@yadro.com, aou@eecs.berkeley.edu,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v6 0/3] RISC-V: Create unique identification for SoC PMU
Message-ID: <Y01Jm6PHA1m7B1Vl@kernel.org>
References: <20220815132251.25702-1-nikita.shubin@maquefel.me>
 <mhng-a8eaa55b-16b0-4b17-b202-881e75a65eaf@palmer-ri-x1c9>
 <20221017091948.1961294e@redslave.neermore.group>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017091948.1961294e@redslave.neermore.group>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 17, 2022 at 09:19:48AM +0300, Nikita Shubin escreveu:
> On Mon, 03 Oct 2022 19:54:40 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Mon, 15 Aug 2022 06:22:37 PDT (-0700), nikita.shubin@maquefel.me wrote:
> > > From: Nikita Shubin <n.shubin@yadro.com>

> > > This series aims to provide matching vendor SoC with corresponded
> > > JSON bindings.
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
 
> > not sure if you're looking for this via the RISC-V tree, it looks
> > like usually these get merged via a perf tree?  That's OK with me,
> > but I'm also OK taking them through the RISC-V tree.  Note that
> > cpuinfo dependency seems to be triggering kasan failures, so we'll at
> > least need to sort that out.

> As i remember correctly you were willing to take these patches into 6.0
> =).

> Well they are acked by Palmer and [2] series, which my series depends
> on, also have been accepted.

> I can resend if it helps you.

I picked it from this Message-ID with b4, applied cleanly, but yesterday
the merge window closed for v6.1, I applied it to my perf/core branch,
for v6.2.

Thanks,

- Arnaldo
