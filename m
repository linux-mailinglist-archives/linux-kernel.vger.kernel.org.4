Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D146C7E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCXMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCXMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:45:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313FCC2A;
        Fri, 24 Mar 2023 05:45:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z18so985329pgj.13;
        Fri, 24 Mar 2023 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679661934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpf4OkQ9ZCWW1S8L2UsDLHFAbEnlNYu/Xzcrj9wogs=;
        b=Rrc1LYqjAqETK3k6kFTvezr/BXR7cc0eTMw0n1z/dC98/jIs75+UMEbwsyHvg0jhjb
         NLlZ912yRk4Ks34Rt4KCHCSB2bOUBFCnLJHaBq5FVbihLSi7LiS51tM6MN7Oo++yznel
         X8kluD5x+3jzfFv7r7LuZTpW0I0jRg+0X9l5rpQFAT8TEVGBY1f9ySqEuwXivlgTpPZD
         6gUd3Q1k2FKaP33rU6omam7Yj93xipv3KuvtG9wf0QWF2ShWHjJlmtQRz3nCNHqNyu/j
         4PEKPDjUzaRgo/KkoK6XbP+Sl2hZm0QxY9rMuLBcs8aHV/FCl0fbllVs933vRVTk4+Vo
         iVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWpf4OkQ9ZCWW1S8L2UsDLHFAbEnlNYu/Xzcrj9wogs=;
        b=1dOQdf72pk0uDmlCIi01shj8q/SRBUryboFGju1obVIY1O9GF5H3Tw9Y+A5oAjusFd
         MzU/GGJNtScca3qHnnlrLviY3sdE1DrzyIsEUvvywcNYuxy3uRa7vyqn3zh1V2NsRHXj
         dakzbt1f4yQJxjjrv2KtxW9hRh67pCQMsbJbDskfgTW5jY7m5ukSOW0nfqVaHdh8qwiY
         eWzZxLpzrMvcpIupMLDT1Yo1ze8lQa2VgqzVJ1Xg78SuGMBzhmFnqI5D33Ao9FwrURY7
         mALyfTaFU4IAKDKT1FFFYMBrBKzaGeIwQmnKeEcywbjYV0CDlWgI7iRZlJK3Q6BLiuwI
         Zezw==
X-Gm-Message-State: AAQBX9dIpe6jyUvfI77z7QbR9bFIm4br8m9X2zjXtaFVhtohmVfKx5/B
        H8KL/OUdD0QXR+TJno7dGY4=
X-Google-Smtp-Source: AKy350Z1Aa9QhsMRyPvp1b7Voh3TwHp0uBjEfDOTCVT04eocigw6DVY/e5jUTqb2B4T8NVDMPuys+A==
X-Received: by 2002:aa7:9696:0:b0:627:fae5:b3d0 with SMTP id f22-20020aa79696000000b00627fae5b3d0mr2835430pfk.24.1679661934552;
        Fri, 24 Mar 2023 05:45:34 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0062bada5db75sm504162pfn.172.2023.03.24.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:45:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 17C521060BB; Fri, 24 Mar 2023 19:45:28 +0700 (WIB)
Date:   Fri, 24 Mar 2023 19:45:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Subject: Re: [PATCH v1] Documentation: Add document for false sharing
Message-ID: <ZB2baIDIPhxj5Vdl@debian.me>
References: <20230324071316.167337-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bmr6WrZlwmrP0vLx"
Content-Disposition: inline
In-Reply-To: <20230324071316.167337-1-feng.tang@intel.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bmr6WrZlwmrP0vLx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 03:13:16PM +0800, Feng Tang wrote:
> +There are many real-world cases of performance regressions caused by
> +false sharing, and one is a rw_semaphore 'mmap_lock' inside struct
"... . One of these is rw_semaphore 'mmap_lock' ..."

But I think in English we commonly name things as "foobar struct"
instead of "struct foobar" (that is, common noun follow the proper noun
that names something).

> +* A global datum accessed (shared) by many CPUs
Global data?

> +Following 'mitigation' section provides real-world examples.
"The real-world examples are given in 'Possible mitigations' sections."
> +  #perf c2c record -ag sleep 3
> +  #perf c2c report --call-graph none -k vmlinux

Are these commands really run as root?

> +
> +Run it when testing will-it-scale's tlb_flush1 case, and the report
> +has pieces like::

"When running above during testing ..., perf reports something like::"

> +False sharing hurting performance cases are seen more frequently with
> +core count increasing, and there have been many patches merged to
> +solve it, like in networking and memory management subsystems.  Some
> +common mitigations (with examples) are:

"... Because of these detrimental effects, many patches have been
proposed across variety of subsystems (like networking and memory
management) and merged."

> +
> +* Separate hot global data in its own dedicated cache line, even if it
> +  is just a 'short' type. The downside is more consumption of memory,
> +  cache line and TLB entries.
> +
> +  Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_socke=
ts_allocated")
> +
> +* Reorganize the data structure, separate the interfering members to
> +  different cache lines.  One downside is it may introduce new false
> +  sharing of other members.
> +
> +  Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce =
false sharing")
> +
> +* Replace 'write' with 'read' when possible, especially in loops.
> +  Like for some global variable, use compare(read)-then-write instead
> +  of unconditional write. For example, use:
"... For example, write::"
> +
> +	if (!test_bit(XXX))
> +		set_bit(XXX);
> +
> +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
> +
> +  Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() mul=
tithreaded CPU false sharing")
> +  Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> +
> +* Turn hot global data to 'per-cpu data + global data' when possible,
> +  or reasonably increase the threshold for syncing per-cpu data to
> +  global data, to reduce or postpone the 'write' to that global data.
> +
> +  Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cach=
e hits/misses")
> +  Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm=
 overcommit policy")

IMO it's odd to jump to specifying example commits without some sort of
conjuction (e.g. "for example, see commit <commit>").

> +
> +Surely, all mitigations should be carefully verified to not cause side
> +effects.  And to avoid false sharing in advance during coding, it's
> +better to:
> +
> +* Be aware of cache line boundaries
> +* Group mostly read-only fields together
> +* Group things that are written at the same time together
> +* Separate known read-mostly and written-mostly fields

Proactively prevent false sharing with above tips?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--bmr6WrZlwmrP0vLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB2bYwAKCRD2uYlJVVFO
o6aVAP4k4TZkALv52VhS6ilM3BXWRZ9wrsPMkJ+Udg9do+OosgD9F6em3Tvl3RKS
KFZ/T31R1voKg7eV70fPWSsimVlUYgA=
=DfFY
-----END PGP SIGNATURE-----

--bmr6WrZlwmrP0vLx--
