Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC06A114B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBWUfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBWUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:35:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598221A3D;
        Thu, 23 Feb 2023 12:35:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 641A46179C;
        Thu, 23 Feb 2023 20:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB164C433EF;
        Thu, 23 Feb 2023 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677184535;
        bh=JHEqfRl0X/jFNF8vQposUxtRh/7zormMksualB8s0UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RFS+rViljTl38Rt2RUZQ82Nk9gp/zq7B6CWbAeN37ENhecuy8gA7KAghKfkARQulf
         9lhTPOrqah9mHRnPQZKElgAqxkgOTePGTyf9gsEyLhEomCFKv3CsLAxUokbwJkJKCo
         tBfQDYhEknGCIHrEYZCakrm8I/8JlnVM4tGDnwbM=
Date:   Thu, 23 Feb 2023 12:35:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kbuild@vger.kernel.org, Li Zhe <lizhe.67@bytedance.com>,
        llvm@lists.linux.dev, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] Patches used to build mkroot.
Message-Id: <20230223123534.a193783f82489eb3d1b65373@linux-foundation.org>
In-Reply-To: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 14:53:30 -0600 Rob Landley <rob@landley.net> wrote:

> The ~300 line bash script in toybox that builds bootable Linux systems
> for a dozen-ish targets can use a vanilla kernel, but the binaries I
> ship are built from a kernel with these patches:

It's nice to see a diffstat of the whole series to at least get an idea
of who might merge the series.

Who were you thinking might merge the series?  I was only cc'ed on two
of them, I think.

There is no "Previously:" changelog tag.  Please use plain old "Link:".

Also, "See https://..." after the "^---$" will get chopped off.  It
might be helpful to includes this also as a Link: tag.

