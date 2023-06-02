Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8872081E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjFBRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjFBRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C28C0;
        Fri,  2 Jun 2023 10:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67B165023;
        Fri,  2 Jun 2023 17:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0868CC433D2;
        Fri,  2 Jun 2023 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685725501;
        bh=GlAu0aNbwphKJhUnVkda7AFO2q1J46qAqdw0mddHz8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wbUPswsr9hr4BB65JJHlta8rBwcdaRFkBVsiH4/ntoRMYwOu94aaLbzEifi0NpL9I
         CdFdcg82Z1jAb5xxiOv29zX2Me0iKTFh4z0rNZK3ba4myatC7/i2uZ/uuIZHntqrcW
         upJOS7V/k80FeZVXx76UKic3eQErySt/CpRS0ArA=
Date:   Fri, 2 Jun 2023 10:05:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tip tree
Message-Id: <20230602100500.2416fabea876b03b129bbf23@linux-foundation.org>
In-Reply-To: <20230602130423.424e37cd@canb.auug.org.au>
References: <20230602130423.424e37cd@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 13:04:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>   b7a7ce1bb77b ("vdso/timens: Always provide arch_get_vdso_data() prototype for vdso")
> 
> This is commit
> 
>   0361c2513d36 ("time_namespace: always provide arch_get_vdso_data() prototype for vdso")
> 
> in the mm tree.

Thanks.  I think I'll leave things as-is - both trees want the patch.
