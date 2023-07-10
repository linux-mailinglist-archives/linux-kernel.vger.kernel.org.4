Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08774E02B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGJVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjGJVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:22:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9891A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:22:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635fa79d7c0so28649596d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689024142; x=1691616142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/AHnLRjSLfFE9cPgB0m1arr9qA/D4bUxDLvGm185g4=;
        b=p5bEh9YpRBSvdjZQX8rMsK7yK10d4+t79qj0lXTV1iANI6Zi8/7mfKnUVPneSAWGET
         ocTlr4vlq45Nf+fvDaKYPrSTPBYfUMtsHoEqbWVHyWwlcRUgZ9oCYjxSSudPXmEL0vQ6
         fE3BP/WKikO8G8l0OLD/RFGA82qdICWixK1tuplEuNXFFkaLuv2dTqJpTlTvhbmLG+3S
         ip4z8zyBOTNeMBaEqdcwVyvKXYwYLVouJpqAIRs8TdYl9HzCrCcKvHx1PvH1+7W3jDfk
         9Fe1T81re8u4E2XdgUAOawq6VYTSS/Y5WnEmPyoNPnZ0F/9QnAAQRw+HOlENg4ZLEMcs
         0SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024142; x=1691616142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/AHnLRjSLfFE9cPgB0m1arr9qA/D4bUxDLvGm185g4=;
        b=BTiU37yOVgxYfqt1ypiDlj5J9/qxG4Wu3LV7BTYll4jiMzeRRVGZSPPLM/kgxSqQZ4
         ikQbmGVvjmde8DlwlpDM91S7+0B5iuTpwUxdRGTXrRMEckEa6uKSTPrmqzV8jctzM0Xw
         +N85hKbaelzGYVGZk1+emU7X5ca/bVhR/p0k8PFGUKAMRMk2OFlPMR/97bVf9WFqmJqZ
         GO+vjWQlCsnF+mLzaTeZ1eTX6sIqx4YeFU4GFCneA+uyh000UtlgFLWIonqRuohKw/0m
         XJUivHNTOikh78Bv84QSrWt+20OQNwvB+jSiZ1tfceEK9IlPrvSuYUs6wcRFUDqP/1I4
         AkTw==
X-Gm-Message-State: ABy/qLavLx10nc3V3wMGyRABGQAM6FylDGBKN4V0LI97xRNyT4nhY5on
        M8w4QmtAxBHCoaEfulx94wrayE2L9rbVXSP7s+T4cg==
X-Google-Smtp-Source: APBJJlEyTl3gs/z6eTnepp8nz5+pFBwJ2K0VEGAzQIoNlATKxCwU0usk0HgClb+WScNXShjcKaBO3hflJJH/vIj4QtA=
X-Received: by 2002:a0c:9701:0:b0:634:97ed:9a5f with SMTP id
 k1-20020a0c9701000000b0063497ed9a5fmr14901888qvd.26.1689024142302; Mon, 10
 Jul 2023 14:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com> <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com> <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com> <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
 <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com> <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
In-Reply-To: <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Jul 2023 14:22:11 -0700
Message-ID: <CAKwvOdm9SAQ5i74JUzWP4Q1WW3aHq+3Jo7hqfie+oMxjnKqxSA@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:45=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> Hi Nick,
>
> On 23-Jun-23 9:53 PM, Nick Desaulniers wrote:
> >>> On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
> > Hi Ravi,
> > Sorry, I'm not able to load a custom kernel image on my employer
> > provided workstation, and I never got approval to expense hardware for
> > testing this otherwise.
> >
> > Was there ever any update on this? I'm on 6.1.25 now and still cant run
> > $ perf record -e cycles:pp --call-graph lbr <any command to profile>
>
> Per-process precise sampling on AMD platforms should work from 6.2-rc1
> onward.

Ok, I can wait for my employer to ship 6.2 on our workstations.

> However, --call-graph=3Dlbr is not supported on AMD (hw limitation).

On any AMD uarches? Is there an equivalent? LBR encoding is compact
which makes working it much faster than DWARF or stack frame
unwinding.
--=20
Thanks,
~Nick Desaulniers
