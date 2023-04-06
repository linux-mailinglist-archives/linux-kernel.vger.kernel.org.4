Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0816DA47A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbjDFVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjDFVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338A83DC;
        Thu,  6 Apr 2023 14:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D1BA60FC8;
        Thu,  6 Apr 2023 21:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952CC433D2;
        Thu,  6 Apr 2023 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680815465;
        bh=2yegvndSNWcDDDZa3DYn4RZfHLTWagweI7FoXC1lxE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dB8rOFd6TPZOUe8GnmRNJbwWjs3N4zkHlmfqgXzf9KpWRhaijRFTAttjV1HfYkUup
         n4COpwx0bJdBq+l4xXUBWDkpfwyGHiLNWLFsDjOCbiIUyjEl0cS4Az0AN9Dy7XG2Ji
         x62D8KqLxplxhAwrOIs5HHyJv6HCcQ/aSV6GSyOgoFginudc42SxDrQd6ozuOjvnC8
         Hw2WqJIhAoeCLAG9G0rqUO16lbOqi47I3NTRkhzLttpVBnyWiNYTnYiLIhSJ9b+6X9
         nfQ8VSRfPvD4UCrU0/sZ8Isf4tfKdF43kxmEzfuSGYvduJqNN2A3onBJIruPLPzPoE
         EB7918ghh8XEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14D244052D; Thu,  6 Apr 2023 18:11:03 -0300 (-03)
Date:   Thu, 6 Apr 2023 18:11:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
Message-ID: <ZC81Z4p8WnYtVwFT@kernel.org>
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
 <20230406195830.ieiozetmk7qjllol@revolver>
 <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 06, 2023 at 10:02:57PM +0200, Miguel Ojeda escreveu:
> On Thu, Apr 6, 2023 at 9:58 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > Any chance of this being accepted?  I'm looking to use this in the radix
> > test suite and would rather not duplicate code.
> 
> That would be up to the `tools/perf/` maintainers.

Thanks, applied,

- Arnaldo
