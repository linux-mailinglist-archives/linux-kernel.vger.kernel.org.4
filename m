Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41A6A68F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:35:59 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D183801E;
        Wed,  1 Mar 2023 00:35:57 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536cd8f6034so345892117b3.10;
        Wed, 01 Mar 2023 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677659757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGs9LOCZf2XKLf/5MYphyrbJ5yqe/DA7GQ/3C3v30kA=;
        b=Wy0qGplFM4so7Hmt8kBpdGEnG8FHnFelBoGgCN7n5rL8UCVZ3cA7N6wjTJF2JcPGl8
         2CYQpQROcXCznbWYXyYUsLZD4gZzbQ6a7+vd/piHDHDSfwtEcHeum6Oetf1Wrl+pMsqi
         /1HmtNg8fkLbwCIa55Qq9vg+A3wr1bFZJy4BjcMUFIKg266Mx/ewsE+PzChuYtCJu86P
         +tYVslNQDLReSTHwxqSPHUNdvga+nZel2ldvCOy5kBcVOeaP2n2dNeziJ2h+yxyZdM4g
         ph7p9Ve0PD+gOHGN9ggE/vrUqpNVWwBoaNZaw0dfnymQqTdLv30oQoSDM5dluxc4mNt5
         NkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677659757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGs9LOCZf2XKLf/5MYphyrbJ5yqe/DA7GQ/3C3v30kA=;
        b=PoVY98xqHL03ptR0/oNga97LipsC8mlYXhTiytV85Q3VOoNV90RYDLPgpGwqYdRvts
         lAkqMRv+b+3n3x4gIHlSakfdiRnYgooTG2H6SQHlqnmlw1EakPmodH3+Xpb6OfR35i2/
         1MDbE2QXVPslHKW9aiSZZMcZNI4oCu4+oCaRFBDo227FC5ivoXWVfxvp8DnVLG+40jQY
         ci0P4rRVQR8eMoTmRVjSHEk+HvLWrq4uGZTU5GuaX+DNBJMYoU6+DiyirlKjic8Hcr72
         8Qe4Qs0t94SHVYjHb4Av5ks457SwF+PLi39VgX+1221qjRji1ZykqG0pz4kIaD4q0jFV
         9YWA==
X-Gm-Message-State: AO0yUKVY6XMiHNykgaHVINWaOy25VujVva/iUfEDaZ2tYNH7eNUKkDaD
        Iqjsqcn1qFmvYahzPo1pEKJjIKJkT2jiV/a4f20=
X-Google-Smtp-Source: AK7set8TiOBVyaXAOitu4dieQCJbBqw+ECvxyLNxR4af4YrRwQj105FirjOpDVEk/2AL7kNKi7PaCZNJczMFoHA5eTc=
X-Received: by 2002:a5b:a10:0:b0:87a:957b:fd67 with SMTP id
 k16-20020a5b0a10000000b0087a957bfd67mr2989573ybq.10.1677659756726; Wed, 01
 Mar 2023 00:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228143547.52f30201@gandalf.local.home>
In-Reply-To: <20230228143547.52f30201@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 09:35:44 +0100
Message-ID: <CAFULd4Z3gpPUO7vQxinm1rQcndP9c_08arBNjNtjagOiuiiABQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Improve trace/ring_buffer.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
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

On Tue, Feb 28, 2023 at 8:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 28 Feb 2023 18:59:26 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > This series improves ring_buffer.c by changing the type of some
> > static functions to void or bool and
>
> Well, it's not really an improvement unless it has a functional change. But
> I'm OK with taking these.

"No functional changes intended" claim should be taken in the sense
that the same functionality is achieved in a more optimal way. As a
trivial example, changing some functions to bool eliminates many
unnecessary zero-extensions and results in smaller code:

size ring_buffer-*.o
  text    data     bss     dec     hex filename
  25599    1762       4   27365    6ae5 ring_buffer-vanilla.o
  25551    1762       4   27317    6ab5 ring_buffer-bool.o

Please also note that setting the output value with "SETcc r8" results
in a partial register stall on x86 when returning r32. The compiler
knows how to handle this issue (using register dependency breaking XOR
in front of SETcc), but it is better to avoid the issue altogether.
So, there are also secondary benefits of the above "No functional
changes intended" change, besides lower code size.

> > uses try_cmpxchg instead of
> > cmpxchg (*ptr, old, new) == old where appropriate.
>
> Now, the try_cmpxchg() could be an improvement on x86.

True, the concrete example is e.g. ring_buffer_record_off, where the
cmpxchg loop improves from:

      78:    8b 57 08                 mov    0x8(%rdi),%edx
      7b:    89 d6                    mov    %edx,%esi
      7d:    89 d0                    mov    %edx,%eax
      7f:    81 ce 00 00 10 00        or     $0x100000,%esi
      85:    f0 0f b1 31              lock cmpxchg %esi,(%rcx)
      89:    39 d0                    cmp    %edx,%eax
      8b:    75 eb                    jne    78 <ring_buffer_record_off+0x8>

to:

     1bb:    89 c2                    mov    %eax,%edx
     1bd:    81 ca 00 00 10 00        or     $0x100000,%edx
     1c3:    f0 0f b1 17              lock cmpxchg %edx,(%rdi)
     1c7:    75 f2                    jne    1bb <ring_buffer_record_off+0xb>

As can be demonstrated above, the move to a temporary reg and the
comparison with said temporary are both eliminated.

The above code is generated with gcc-10.3.1 to show the direct
benefits of the change. gcc-12+ is able to use likely/unlikely
annotations inside try_cmpxchg definition and generates fast paths
through the code (as mentioned by you in the RCU patch-set thread).

Please also note that try_cmpxchg generates better code also for
targets that do not define try_cmpxchg and use fallback code, as
reported in [1] and follow-up messages.

The API of try_cmpxhg is written in such a way that benefits loops and
also linear code. I will discuss this in the reply of PATCH 3/3.

[1] https://lore.kernel.org/lkml/871qwgmqws.fsf@mpe.ellerman.id.au/

Uros.
