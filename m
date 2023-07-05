Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C13748F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjGEUma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjGEUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:42:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D419B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:42:27 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635dbfa710dso815296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688589746; x=1691181746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9IOBh2dErzq5pc0UHadZ7sAXf6kWe3n0/dn9RfHGYo=;
        b=dh4WoR3tlKTcrXQJem35j9FNYUIenpsZPsRsu3o2yL/euzR3wgpNzFqRsyPvjtniX9
         BGsTSgz5HwMiKXmztwf6HK4vEMBgpB3lkyj2Cz211Vf4iA518z0wdqt9dCU0H2kDwDO7
         0tDgNaFk3pNdxVbcagamldZztzPyJDuioE1zv9d4+rARk5gQ3SJC+ChUBasjRWHRlwe3
         D126qlNKwo+q/dkpU41pQ2FTa+o3P/2ij5eqp4c71aNUxifzhGntBeO1zSGWy1Je06Kx
         1FuuX3Tky8IM1L5vLiI/e3mB66822aXFocZSTtzWT5cFoQ9Pq3Nn0sUAB/1QwATZD6N+
         M+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589746; x=1691181746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9IOBh2dErzq5pc0UHadZ7sAXf6kWe3n0/dn9RfHGYo=;
        b=cFSEhaqQj3OKtExBOMxlFjhipg9qIk87tc6X1k/i1QGTyrVYYC4KuFDPN/Hu46Xo/D
         LwkvZjtHjpm4f9nJnzkQUvezepr+lg8CniMidWcbad2YiyACF8IEmF3GFll4lmxjazBk
         XlOTmK7feW9NsmRePbNUQpnyxAl4ke0NWw/mHNNMR511mNVX6KYbqxjeBGpWEyKdKzoO
         CDoPyYH517uJoE+hsZPuJHFiiL/nDv5y5BCTBEDcGgN03Ccnpowvj8Qe2xTiv38E6zfc
         HEGrPEhj6iIiR+z6ZbsZCmp2OkR4ka8PRQa6VXPgGVYMUw7fCM5WXABpK8zx+jnXIKpb
         /SyA==
X-Gm-Message-State: ABy/qLb/3VrrneKvnuln1zCUXCW/YJVF/pODHCaWd5jXf1MJpfIR5djQ
        8vtQE6jEuAxlhCwI9lL06AwHj0u7Q2b1iabi9fKYrg==
X-Google-Smtp-Source: APBJJlGWRpwfhA4itLA+4UG2F5/nsuTLfZv6whI8ChgzNcaYXQwv2I0wbKEv2ceM7nlvKMw4nMyhYlyjVDw07pw7s9E=
X-Received: by 2002:a05:6214:b6c:b0:636:cc82:8cb4 with SMTP id
 ey12-20020a0562140b6c00b00636cc828cb4mr12099439qvb.33.1688589746277; Wed, 05
 Jul 2023 13:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com> <20230630-phrasing-strung-12e53988ad81@spud>
In-Reply-To: <20230630-phrasing-strung-12e53988ad81@spud>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 5 Jul 2023 13:41:49 -0700
Message-ID: <CABCJKue+4E7mbzkZqsUYzwUf9VY4+nY6+5E1aF_XyQito_399g@mail.gmail.com>
Subject: Re: [PATCH 0/6] riscv: KCFI support
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Jun 30, 2023 at 11:48=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey Sami,
>
> On Thu, Jun 29, 2023 at 11:42:45PM +0000, Sami Tolvanen wrote:
> > This series adds KCFI support for RISC-V. KCFI is a fine-grained
> > forward-edge control-flow integrity scheme supported in Clang >=3D16,
> > which ensures indirect calls in instrumented code can only branch to
> > functions whose type matches the function pointer type, thus making
> > code reuse attacks more difficult.
>
> > base-commit: c6b0271053e7a5ae57511363213777f706b60489
>
> Could you please rebase this on top of v6.5-rc1 when that comes out?
> This base-commit is some random commit from Linus' tree, that because we
> are currently in the merge window has is not in the RISC-V trees yet,
> and means the series wasn't applied by our CI stuff.

Sure, I'll send v2 rebased on top of -rc1 once it's out. The random
commit was the ToT at the time this series was sent out.

Sami
