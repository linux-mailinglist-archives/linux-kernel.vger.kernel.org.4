Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA26DA224
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjDFUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDFUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:03:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41AE83D0;
        Thu,  6 Apr 2023 13:03:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536af432ee5so761150177b3.0;
        Thu, 06 Apr 2023 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680811389; x=1683403389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFrdCeDCOJkHQGDyFu7yRUwnrgoVUUx7k0c1Neje6RM=;
        b=fkVai4FnC0lB+EnDg9FQsFrd/PbAgdmTtU6AOiIa8YwIAlVMTCf0R3kWHL9ZGmsE40
         IwBT6ePo/Rz23Sr8X0MftHYStPGTuXDN6BiWGM0qB3QPD+xedt6G9QHbExJlEH6AgrQP
         kR37B350cFN4uLxmlRpeGNV9g/h0DhphVVUZ5zFl4VROMjbqbcKRX3vox69dHOKkwCto
         rlj3IyC9KTiyekNYFcRSTOGGRwgBzIKpuudtjNArayKwSOHjPAjN5B0e7fyQ7K/0AJBA
         q0tx5DE4PetsJdBUwvgyXmCuAclVdiVhLisQ2kfLxUnzFSruzelRAUA4GPghTSdCbFYK
         zy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811389; x=1683403389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFrdCeDCOJkHQGDyFu7yRUwnrgoVUUx7k0c1Neje6RM=;
        b=Jcfa4HVVygrg0yqHrcsBRZIDvIP9XVtwRqrrp3UpX4H7zXDeL7Q4BTsLSku66XQBXS
         d+m4YsXDt5h0xGM9WYYQpPrfPx1N6J/jtlXLGmMNbgw8TLTTHibCJxtLO+hLrbazqjzm
         CeJNPqAtndy39qyxO0eQw5QkZfCbZFeP6YUoDk+yndzLPrpPxmEP4oQ+wz2AZ/XrGUxJ
         kXwaHic/vVszpv93jQu3IUUaYcEHf7k7KOBt5EBnT+mHRp47ANPhECCuHbyqqeuiHI0T
         g84tQBTsfTyGDVrfg1vMdtV3NJZwHRYDZYBic/NXW9Xx/od5pxTjvpfSqSu9eWab0Nyy
         ws+g==
X-Gm-Message-State: AAQBX9dPdbESWkZRJ/isSTGrGahHf+fmhSEvLc/7CYQ9sIR4n5ePA3/X
        c5YItUu2P6FJUMeYy4kOjKy7Pn9vPBPUAmt3XFk=
X-Google-Smtp-Source: AKy350aANX+UTxPTPh2+zIsCbbdQdpecQ1XqZIGaIBnAYEiVmox+pwYQ2BDIID4Tc/Vw0OZ3VsJGHNzZDnE+tHV9BAg=
X-Received: by 2002:a81:c509:0:b0:52e:e095:d840 with SMTP id
 k9-20020a81c509000000b0052ee095d840mr6802785ywi.0.1680811388797; Thu, 06 Apr
 2023 13:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com> <20230406195830.ieiozetmk7qjllol@revolver>
In-Reply-To: <20230406195830.ieiozetmk7qjllol@revolver>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 22:02:57 +0200
Message-ID: <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 9:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> Any chance of this being accepted?  I'm looking to use this in the radix
> test suite and would rather not duplicate code.

That would be up to the `tools/perf/` maintainers.

Cheers,
Miguel
