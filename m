Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE95618DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKDBer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKDBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:34:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A91DA4C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:34:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so5171067wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCUmmg3mwQnbZSMi4Ib3DymPpTK0e4OmbXuDOe+8olc=;
        b=Rp/4/1clzD2oMGuWVdaPSRSg3ISt4DnIry3chHsO6PT6vXXNNnHPKVdjUcMG7Gak5R
         QCITBKgBwv3XhePZwiZs5GLmiFNtQtBXbwp2ILGwsXIM+bUy7j9NI/Bb5lujMsnbcmjJ
         8K8bJsCMiDPKmlSt7dkzyBUFBpCV7WTe8YSKeuIvnY7/hLLybPgRMO8A7TzeXvewiDDS
         BvHa6CyDcEwDNiVptiew/jVL+VHWLAKgXHjNeRQLqNhK59eVwfBd/3Jbeq7q5s1lSJ4E
         C3pKrQIsenWihrkrABjlto7p5BIIbrMIMM10B+EFIVpz32vd1z0RH1IhdmLsxcH3tyPg
         bSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCUmmg3mwQnbZSMi4Ib3DymPpTK0e4OmbXuDOe+8olc=;
        b=quaCZwZBCpWSKEKFMpt6K8JPis1CY2PKjiUcIpxz7Vs6B2yWovIV4oG9YQpU6EizGs
         SnhktiJL2wYxRZvo8isLIWmjpVt6VRttH2zHC86HwFTnVQPeNr7X75tmiAGYfQyr4eSp
         Q+WDHDC9tTaDHqcZyH65haMhz2h7mFbpCarQbc86Q21vI+XgZzl7jEOyOAwN0MxWyvyh
         jKWZGjG+F7VqLJ+c3s9+J+ix0JC4ULbrsaRs3g+Nna5w4jSTtSNY1HVpQ7tTIRZ3YEcH
         3956W2aPjGM4X6+bv9yxIOVzdbFcY7gI42Ti6WT2TX/+Z6lf0AEVVbsheu7KEy7iAVcY
         epfA==
X-Gm-Message-State: ACrzQf0PPlmtr5FcgvHjrn7TCiT6dxNgYeIVQfK4bYYX8RG9p3BOXYyI
        W2spGox0JOAxsb6vuBBUG1/ty/B1N4TDiWXrYqXkZw==
X-Google-Smtp-Source: AMsMyM5HYNjfGkY3CQUPnER3v8TfnFTuQScHgzMFLMYgZPUEzgx9AaxYUcKmyYHUmUQWE5X391dVfTHdbaqQY9tr0Yo=
X-Received: by 2002:adf:f411:0:b0:236:e5a2:4f64 with SMTP id
 g17-20020adff411000000b00236e5a24f64mr10596787wro.182.1667525682799; Thu, 03
 Nov 2022 18:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221019202843.40810-1-helgaas@kernel.org> <Y2RlxvPAvzVXtw9t@google.com>
 <8a23b1d3ee853cee73385e8144338f399cbe3165.camel@perches.com>
In-Reply-To: <8a23b1d3ee853cee73385e8144338f399cbe3165.camel@perches.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 3 Nov 2022 18:34:31 -0700
Message-ID: <CAMn1gO7tEF+VioB8n0=8vQ4gRPKqSSfPwmbX8ci82D=hBbcfyw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > as lore.kernel.org because they use different styles, add advertising, and
> > > may disappear in the future.  The lore archives are more consistent and
> > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > they exist.
> >
> > If the commit message contains a line like:
> >
> > Cc: linux-arm-kernel@lists.infradead.org
> >
> > this patch causes checkpatch.pl to complain. Would it be possible to
> > restrict this to URLs?
>
> Yes, I believe this would probably work well enough:
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7be93c3df2bcb..fe25642d8bacc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3336,7 +3336,8 @@ sub process {
>                 }
>
>  # Check for mailing list archives other than lore.kernel.org
> -               if ($rawline =~ m{\b$obsolete_archives}) {
> +               if ($rawline =~ m{\b$obsolete_archives} &&
> +                   $rawline !~ /^\s*cc:/i) {

Can we make this (to|cc): instead? Otherwise developers (like me) who
use custom scripts to add To: headers to their patches before passing
them to checkpatch.pl will also hit this warning if their patch is
being sent To: one of these mailing lists.

Peter
