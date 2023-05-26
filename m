Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6F712BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbjEZRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbjEZRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:41:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC6A4;
        Fri, 26 May 2023 10:41:16 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so2867988276.0;
        Fri, 26 May 2023 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122876; x=1687714876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrAsusgkfBvmmmiwPVcpmH1+bX7KkadAb7REhNybOik=;
        b=cyk1Fl5sFjYFPxobyF1bLxe3S0/gPVKrhd38Hn0JZz4PQsHfkIBTjZdlekhgVzzZa6
         EqE4rUtlOZLKt/z4GJTDeTJWW8W9i5VvakM8hmqXfzvA3kAfV2VCNWnWcLomEypvh0GI
         cF2Ft1vg4IkxYxcLenMisHvrfa/0YbQTipzDKVcngH5IHo48aGXieUzu0H5YTABE84ev
         4GNqVUxB4k1uT5Ga1JBkvAGFW3bXBqNWKo7VA8Vn3UonIdckb+IKx/vRL+83m4wVCG7j
         hiu6zF0/4sa4w61VuBa52Nxubh66xK5uwIgi3mboqX2E3jZBPbxsQrtKlntyjtUpTJSo
         fY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122876; x=1687714876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrAsusgkfBvmmmiwPVcpmH1+bX7KkadAb7REhNybOik=;
        b=d8CApYypOVVbrWCVoC9BIKUVZiacbtSZHI/XLNYVa3cVWbJRXwXRxtYcFOZjAzIgLq
         JpLYzy76akUqyUqE00BksgPq7T9VImnlbPgeTCh3AFNycKaWaO+kN+DRgatkuEc6zcAM
         MZbbMHl5Nj4qdMeqAY5M5hkyR8Prrweay5pS0T6WvR6HWSf6nAvfNVSlm312A4KC1qpb
         ekiiFJGvtlLapkQs/XcieAcc20kvTd1k47TvhnxdQ7RsGc/27k5LDmwQHX99HWkm8LGB
         llqt7xH6tdfU1QDRwA6A5pPFXy6lxzqsVtjGN778cmri3DmX0/X0ercwuEr0JWRWKMeO
         p9qw==
X-Gm-Message-State: AC+VfDwf1QwVgkuyE8CXyiUWsHTcKGS5HaIPRc3sELcaLvAyeNJmOa4H
        zwDVckfYt005xr1/Yowp67TG7xGKhTt2bTegnoA=
X-Google-Smtp-Source: ACHHUZ4msg3OMq6zrCQo3POGz+RWt3y3ZzFaDJ/ZZxp/v2NmxHD2ruTetxOCZ5Lzd9VFLoYy6yfsBfG6T8Kc3xivkMs=
X-Received: by 2002:a05:690c:84d:b0:561:fc3a:30f3 with SMTP id
 bz13-20020a05690c084d00b00561fc3a30f3mr3014315ywb.8.1685122876075; Fri, 26
 May 2023 10:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150549.250372621@infradead.org> <20230526151947.027972233@infradead.org>
 <2023052626-blunderer-delegator-4b82@gregkh> <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
 <202305261006.01B34DB4C@keescook>
In-Reply-To: <202305261006.01B34DB4C@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 May 2023 19:41:04 +0200
Message-ID: <CANiq72=SBvK6cON3s_rdSpsOgUAzZPT+iQeH_fmvatPcKP7fCw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
To:     Kees Cook <keescook@chromium.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 7:08=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> > FWIW C++ has std::scoped_lock. So perhaps using a similar wording may h=
elp ?
>
> Yeah, I like "scoped_*" and "guarded_*" for naming. IMO, it reads better.

FWIW in the Rust side we called the general facility `ScopeGuard`,
then we also have lock `Guard`s and Rust stdlib has things like
`MutexGuard`.

Cheers,
Miguel
