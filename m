Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A406C3DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCUWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:23:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856A22C91;
        Tue, 21 Mar 2023 15:23:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso10356386wmo.0;
        Tue, 21 Mar 2023 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679437391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrv9jJ3AdCNTWt85MeiC3aT4ke6dH7Ht0E0gm4oJlV8=;
        b=fACC/2kzAWcwEXo+61byf3CLolgXqWlPzekcsqtxdx1WdoaLxSxkws7NoY3ejtBfOf
         g4+A50IH3vMQZNMz79QokqNj7SL65WJP3cMSCt0rdaC+YOcGnSqRimwm9bDDsLxtBk8q
         XaupQdIxHW/Zum+qry/aDNgz8lqZHNbKalIWd9WVy9qHRpz6J59avNIG029Z4B8SrG3A
         ypzVOllfc8Z81Rc00zVhvSFxQLZQZOYBWha8HnYzkUy5qqI7pCu0OmutuYBSgmglzHAv
         2cQhBTw1zcV/gjCcIblBexjgVkLy+I22K20/mI3z2PqKUj/ehmOuUDgWpX2O6wFvWvyz
         qE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrv9jJ3AdCNTWt85MeiC3aT4ke6dH7Ht0E0gm4oJlV8=;
        b=eJBjZRxzJr0YtIT9ESl2atHaEhco5adGTGJTllpn449Is8jncIPoK3dPCwttAt7CyB
         bm/mOu7Puan6rQythGhTZ7Bc7UyYRpkuhnbrICOTHPzrs8h7oWSZx55AARxiQlH2VxAA
         /JVFx7AAU34+16GQFBMQPk/OyjO42FqFLzb3Byhtd/LLnbqEKDAmttvodC8MGIzpodrS
         rLaqbWtKpzliY5WChWh4iuTOBob64I8xiQm17iuhgPyTcfAn54vVVw4XrvGufcm8TvYz
         Z/cnEX01YTd5D97PDlniE9vj4jlPNDZV95dqhdbodNhQW7ZaGFm+iDJ+m1wqbqjkHBUM
         67NQ==
X-Gm-Message-State: AO0yUKXlRH0etFKc0GA7D2DzoTLbhMDKvyYjwtHVNo57gVEEyeCXh9yX
        tlILVEVBjZYYKnCiI5TH/vv8cNf6JyI=
X-Google-Smtp-Source: AK7set+sOwGkE9gD00SBPRoBBMoB3Sd/0ySHtdInDmTC+zCnUdcvq7WmAJ8v5qBRgJIXhPUVqKlNKw==
X-Received: by 2002:a05:600c:2251:b0:3ea:f75d:4626 with SMTP id a17-20020a05600c225100b003eaf75d4626mr3467150wmm.38.1679437390810;
        Tue, 21 Mar 2023 15:23:10 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm21168331wmb.15.2023.03.21.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:23:10 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:23:08 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: + mm-vmalloc-convert-vread-to-vread_iter-fix.patch added to
 mm-unstable branch
Message-ID: <ec52646c-b5a2-4a67-9a6b-333c81aa29df@lucifer.local>
References: <20230321213633.7DE54C433D2@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321213633.7DE54C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:36:32PM -0700, Andrew Morton wrote:
>
> The patch titled
>      Subject: mm-vmalloc-convert-vread-to-vread_iter-fix
> has been added to the -mm mm-unstable branch.  Its filename is
>      mm-vmalloc-convert-vread-to-vread_iter-fix.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-vmalloc-convert-vread-to-vread_iter-fix.patch
>
> This patch will later appear in the mm-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-vmalloc-convert-vread-to-vread_iter-fix
> Date: Tue Mar 21 02:34:51 PM PDT 2023
>
> fix nommu build
>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>
> --- a/mm/nommu.c~mm-vmalloc-convert-vread-to-vread_iter-fix
> +++ a/mm/nommu.c
> @@ -199,7 +199,7 @@ unsigned long vmalloc_to_pfn(const void
>  }
>  EXPORT_SYMBOL(vmalloc_to_pfn);
>
> -long vread_iter(struct iov_iter *iter, char *addr, size_t count)
> +long vread_iter(struct iov_iter *iter, const char *addr, size_t count)

Apologies, missed that. Will make sure it's included in any future respin.

>  {
>  	/* Don't allow overflow */
>  	if ((unsigned long) addr + count < count)
> _
>
> Patches currently in -mm which might be from akpm@linux-foundation.org are
>
> mm-page_alloc-reduce-page-alloc-free-sanity-checks-checkpatch-fixes.patch
> mm-page_alloc-reduce-page-alloc-free-sanity-checks-fix.patch
> mm-userfaultfd-support-wp-on-multiple-vmas-fix.patch
> mm-add-new-api-to-enable-ksm-per-process-fix.patch
> mm-treewide-redefine-max_order-sanely-fix-2.patch
> mm-treewide-redefine-max_order-sanely-fix-3-fix.patch
> memcg-do-not-drain-charge-pcp-caches-on-remote-isolated-cpus-fix.patch
> vmstat-add-pcp-remote-node-draining-via-cpu_vm_stats_fold-fix.patch
> mm-vmalloc-convert-vread-to-vread_iter-fix.patch
> scripts-link-vmlinuxsh-fix-error-message-presentation.patch
> notifiers-add-tracepoints-to-the-notifiers-infrastructure-checkpatch-fixes.patch
>
