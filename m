Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22E6A12EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjBWWnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBWWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:43:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431D71258F;
        Thu, 23 Feb 2023 14:43:29 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a10so12447496ljq.1;
        Thu, 23 Feb 2023 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnsLkrA5D9GHFeODkBBbFO8tc6DFtrFz35r/rr2GSec=;
        b=TLl/TBDNHctznhe95HthIpoKnFCKTKDJVTQMn1rAMISr92Lp/A2nW54F3BA55Fzy1q
         /9I7jeblry1fccNxdRMVNramhYVLNfROzNsdwU97eZmtvPfJzlnywEFJ40PXLkxiXnca
         ZQTaxC6syDwWJluPpQqpNc+ie4ksU7gplKdmg492gkbfx8H7y7u88dse1Z/jxrAd7rP0
         PMPQyluhc7S3pgc9InrMYuUyAsx7FqoNks4VeTtg3rtk02NoJsNRWUMT3r+KGPlZmfF1
         J8ZSfZeDPYLqyeqgXqzuJcOk3VjRWpBYQyYDef7zqz0U8UcBfLoRFUyYjUCGrAGC1fUw
         7ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnsLkrA5D9GHFeODkBBbFO8tc6DFtrFz35r/rr2GSec=;
        b=vDHwTpHwoQVCFFcWrctZvIp7OqHjYcPHbO9MXmUn6EUrY5wHP/7bNU2K7SyxYYJhyS
         jjs0dVKV1ZfvRQ1d+v5t87wIjmBr2BfcDgUacnSnzl90kMUHhirOwKESnzauRjDLtusa
         OKcXri2q+eUf2gRfLdaBcxdPGt4ADQjGLXTkqrye/3fnUJQ++ASBEPkkn/QVpLfcWXVV
         VKEJVm6YadqlL+RqdBUC23je3ajQHbFXnyFXuwggEzSg9JBhjpo57N3esLwgZyFC0dtL
         BF7XjRhBxvwq2qQlNDtcO6a/Ma7g1EZePlxZ7351Cb8M9VfPHhjS1EITafLszh5LwE3S
         IhTw==
X-Gm-Message-State: AO0yUKW9+4mI7TResfQpuW52l0OWCtcrsU+06OAjqbpMHSguaTpabNYK
        QMAcnAalSDEV5e2rQFdb/KgjOHY5PDkGshfbkQiOdzYI
X-Google-Smtp-Source: AK7set9aYHhk9ETSwqKIIxZFGRkD9lyqfLrcfD9IogdIIUeHtPll6jS+NOj/SkAakxSuCsk2/IFpoOoo+D8qNV1HjPc=
X-Received: by 2002:a2e:a60b:0:b0:294:6de5:e644 with SMTP id
 v11-20020a2ea60b000000b002946de5e644mr4227826ljp.5.1677192207224; Thu, 23 Feb
 2023 14:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20230224081042.36fa0f2f@canb.auug.org.au>
In-Reply-To: <20230224081042.36fa0f2f@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 23 Feb 2023 16:43:16 -0600
Message-ID: <CAH2r5mvGuvmryt=dr9Tm_2OyZ7QZ0QE54Ei2FrybQ0x39dAi_w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed
and updated in cifs-2.6.git for-next

On Thu, Feb 23, 2023 at 3:10 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   23b7e4141de5 ("cifs: reuse cifs_match_ipaddr for comparison of dstaddr too")
>   c9334cd0edaf ("cifs: match even the scope id for ipv6 addresses")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
