Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBD6CD95A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjC2M2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC2M2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:28:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAA3C32;
        Wed, 29 Mar 2023 05:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714A7B822EF;
        Wed, 29 Mar 2023 12:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8CFC433D2;
        Wed, 29 Mar 2023 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680092922;
        bh=Tma0nx8qcRtkWCc9Gjurf+Xd13FP8BlcwH32Awk9oTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXzP+wP+L4+UzendYyyBTPCCLeqdzeecjA30dTlujZjH7fPh0k4AnzRJ4k7P9oIZk
         vOV8eGuLxUC0toPf2Xe2n9Rli2EeP443RCAtf7KPulpSdejYraODI6irGmepOLmXfw
         ym8fNetsLnr1yZK4O6iTPw8aq7J2iN0pArzdLuu+UOxvexvkOCQZcs+ZKqzxPnDMwN
         CsSFs2iU//4e6Qj/bmekDHrBk2XR/ME9h8eeXZ/tCKQ8opObiTjU18kS3qKhUjBrkR
         9guSQS5IZpwbBjcyqgq5/wv7Q4SM1pgi6XNtd4Sn5tKdXhor81PnaiQH+hR1QGm1wA
         5cxdAfwpvTcqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D80C4052D; Wed, 29 Mar 2023 09:28:39 -0300 (-03)
Date:   Wed, 29 Mar 2023 09:28:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZCQu9+J8/AhAXgNI@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
 <20230322083956.5c051777@canb.auug.org.au>
 <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
 <20230323095437.1ecccec1@canb.auug.org.au>
 <ZBxTyLqkIaoVhIXU@kernel.org>
 <20230328123332.0a3e2b6d@canb.auug.org.au>
 <ZCNES6N7AkskjD0o@kernel.org>
 <20230329100612.074b18d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329100612.074b18d0@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 10:06:12AM +1100, Stephen Rothwell escreveu:
> Hi Arnaldo,
 
> On Tue, 28 Mar 2023 16:47:23 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > The config files you used don't match the running kernels
 
> This is just the way Debian names its kernel packages.
 
> > > $ uname -a
> > > Linux zz1 6.0.0-5-powerpc64le #1 SMP Debian 6.0.10-2 (2022-12-01) ppc64le GNU/Linux
>               ^^^^^^^^^^^^^^^^^^^
> > > $ ls -l /sys/kernel/bpf/
> > > ls: cannot access '/sys/kernel/bpf/': No such file or directory
> > > $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.0.0-5-powerpc64le
>                                               ^^^^^^^^^^^^^^^^^^^
> And so on.  It just happens that this kernel is based on v6.0.10.
 
> $ uname -r
> 6.0.0-5-powerpc64le
 
> So they are the correct config files.
 
> Also, the mail I replied to talked about checking /sys/kernel/bpf/ (not
> btf) :-(

Sorry about that, I replied from my smartphone, when on my workstation
I try to try the commands and copy'n'paste the whole command + output
sequence to avoid such mistakes.
 
> still on my build machine (of course):
 
> $ ls -l /sys/kernel/btf/
> ls: cannot access '/sys/kernel/btf/': No such file or directory
 
> So it seems that Debian do not build their powerpcle kernels with
> CONFIG_DEBUG_INFO_BTF. I don't know why not since all the dependencies
> seem to be OK.

Right, at this point they should if they want to properly support the
full set of BPF functionalities, notably CO-RE.
 
> [On my arm64 machine:
> 
> $ ls -l /sys/kernel/btf/vmlinux
> -r--r--r-- 1 root root 5209570 Mar 29 09:52 /sys/kernel/btf/vmlinux
> 
> and on my amd64 machine:
> 
> $ ls -l /sys/kernel/btf/vmlinux
> -r--r--r-- 1 root root 8536946 Mar 29 10:04 /sys/kernel/btf/vmlinux
> ]

Everything should be working fine on those machines, right?

- Arnaldo
