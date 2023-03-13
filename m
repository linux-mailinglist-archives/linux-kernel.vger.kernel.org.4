Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976696B7FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCMRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCMRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:49:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A9746DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:49:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so51960340edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678729775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YI7vG123iJz9BG91MREAeEtvDgXjHlMUIu3SGWRE0E=;
        b=LvJzflMMdibxRuI5thcajv+uUaX3iulpA0iY50/gaO+gxzFSOmfy1le8CE0BfJk4pi
         q4TbodaR3DSrOvyLSJQOzfRJ3hoC1n9NzFc6SlS1IiQocVDUwPz5V6fyUYo2E0HSNopX
         cMXUu34q5bwi8p7qeYMg9Q6RzTXrx5/xhPrVFiuKsW5qy66tUF5kOZJJSDpNd4AIT4i+
         /RahfSduk53ITlMQXT4P/fkf5SgpqKy1r/S5eCZFh8d4sF9rzXj+MXOsYSpTA6jmb7TE
         Vh0jh3nkOQFRlvX+PVWiGeLrrptYO80036/l3+4qT9LClqytU8DJhTToCqzxRKtmgq5M
         fPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678729775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YI7vG123iJz9BG91MREAeEtvDgXjHlMUIu3SGWRE0E=;
        b=jKlZNTyqxA11KHz8YKwnsicgZF+kL1m2NcN05RJt/topWsvl47p4iqhNYPdtjrjAvm
         P5jax8t3AGePbyNR+aainsVJXKYoGLO+1RjkR4NKbx3UIuLCDqtoRhtamcvGJPmZecFW
         GSfLt7H9dh4d52/St90wAns8CeOacpyG/7bkhe7ONXVatxLMZwRyTn50JsJML2d3RFtR
         rjnG7EA+qHjZqn12wbCAA9dXEAaT3r1zBQDyDDJiG9d6D1HUBaKpJtaW9G8U4FOlNTC2
         2dlbPsKiUwACIcDq1lTfNIZQ81whXPO1xbFBOFj5w0nDRrgAjXUrj/R7qGD83wAfacOk
         bzUQ==
X-Gm-Message-State: AO0yUKVQO9Q+7nQtBydEsqF4fQOtisVG01mkhQhUZ2KZFymdugNsvzYw
        +Zaeg7lg61h8bu69fZCWDfNbRNpnbLfULj5oRW5qI/6Tvr6oD8COm4w=
X-Google-Smtp-Source: AK7set95T+PMiQsyP1fYll2Gn9LpDLkYlUGcsQ9tLbFVmYK+/uSWV5Wbm38nlu48uqIfVvA+s9NJ8Gyinpk/T/sxhZA=
X-Received: by 2002:a17:906:f47:b0:877:747f:f6e5 with SMTP id
 h7-20020a1709060f4700b00877747ff6e5mr17016836ejj.11.1678729774848; Mon, 13
 Mar 2023 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678474914.git.jpoimboe@kernel.org> <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
 <20230311012004.vyc4kdlqjsv4zliw@treble> <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
In-Reply-To: <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 13 Mar 2023 10:48:58 -0700
Message-ID: <CABCJKuezD9sXTUTCecARUzfig+B=VirGBiVNM5bADvKLG3+YYw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Mar 12, 2023 at 8:17=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Mar 10, 2023 at 05:20:04PM -0800, Josh Poimboeuf wrote:
> >   2) Create yet another "tier" of static call implementations, for
> >      arches which can have the unfortunate combo of CFI_CLANG +
> >      !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?
> >
> >      The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inlin=
e
> >      asm to create a CFI-compliant NOP/BUG/whatever version of the
> >      function (insert lots of hand-waving).  Is the kcfi hash available
> >      to inline asm at build time?
>
> Yes, clang creates magic symbol for everything it sees a declaration
> for. This symbols can be referenced from asm, linking will make it all
> work.
>
> And yes, C sucks, you can't actually create a function definition from a
> type :/ Otherwise this could be trivially fixable.

Wouldn't creating a separate inline assembly nop function that
references the CFI hash of another function with the correct type
potentially solve this issue like Josh suggested?

Sami
