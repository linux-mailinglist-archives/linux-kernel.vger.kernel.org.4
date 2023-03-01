Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD36A73B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCASns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCASnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:43:47 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E532D175;
        Wed,  1 Mar 2023 10:43:46 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id t4so1335656ybg.11;
        Wed, 01 Mar 2023 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677696225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hyPtn2UBKb0jqXlSHLLwcxVonecNrdFfMaZTCU8GNK4=;
        b=SjOQaOfy08Ha6XQJzfkLHNluDF0JrhGU+rsPbi0tRmGEP+2LMA4CqGOaWN6a0LMTxm
         uTWFFw1EF4xLBGZWZ8QUHQY/d94v0S/+IGdVIHxarU3YDZ4CJp6EwUojugYARr6txef1
         /k1jl/b8ARM0Umb1uzz2iUbXWLZ13WnnQoQg6xroMt4ifePQTFWfE0Zhp2YgsktOTBpK
         HL37wrMYf0qCqNmjVNDUejVvmp6OW2ND/zkGI0zOO1qn8js/6WZ2J729CSIqm/n7saSf
         iKvXx9BURCLlv/xXBWg0Eg7HDpx4zumTw0PSYw2hbWE+9hOpYDvmaQhyQBQbAEjXKP9C
         uu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyPtn2UBKb0jqXlSHLLwcxVonecNrdFfMaZTCU8GNK4=;
        b=mR4jxTQ/r6xM5snxQJoaXwhl1P0/m8+PJAGUecbLZA0Qe5zbklRVpR7CxmAtkOou5Y
         T51d+7gIJ/hOmRD/LUfv31friEpul6k1KGA2VIv3KPb5ldtfTR11L4gFKyxXHcFbnUOz
         FPuyTt0104KELYus0MaNTgqXpdC7oorrR/O9yC0yDtORpqeSa+ba8uXFBCru9BHmq8u0
         Y1ZnTdYxitACxL0gHK4TqJ0uhupJFRN08qvSroEl1EkKDoq1yYIBVKtxc+ejn49Efflx
         dNW8OIofG10YbzCoeCOcBhjggYOGKTcFY9LSANGtWEYpiLFUhGLoPTkA2nDs4cGrTAIj
         bHCQ==
X-Gm-Message-State: AO0yUKWggoM9RhKXt7K6UA7RYEr8m/J8kvJbRWH7cVIybRtuGV5K0eaO
        9R+MP3Co/sRAp/UEI8Zje4ZIavkQDYlT219h4U4=
X-Google-Smtp-Source: AK7set/prPUf3VjhE4PZmTXMe6IhBy1sHnmn5X0w6za6akZV3tC40IuT8Ix5z/I98to53CK2eZE3X5Dt8eWFq63JHhQ=
X-Received: by 2002:a05:6902:50b:b0:8e2:6b58:5fe8 with SMTP id
 x11-20020a056902050b00b008e26b585fe8mr4055708ybs.10.1677696225458; Wed, 01
 Mar 2023 10:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home> <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home> <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
 <20230301113813.4f16a689@gandalf.local.home>
In-Reply-To: <20230301113813.4f16a689@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 19:43:34 +0100
Message-ID: <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008f74f605f5db173f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008f74f605f5db173f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 1, 2023 at 5:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 11:28:47 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > These benefits are the reason the change to try_cmpxchg was accepted
> > also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
> > name a few commits, with a thumbs-up and a claim that the new code is
> > actually *clearer* at the merge commit [4].
>
> I'll say it here too. I really like Joel's suggestion of having a
> cmpxchg_success() that does not have the added side effect of modifying t=
he
> old variable.
>
> I think that would allow for the arch optimizations that you are trying t=
o
> achieve, as well as remove the side effect that might cause issues down t=
he
> road.

Attached patch implements this suggestion.

Uros.

--0000000000008f74f605f5db173f
Content-Type: text/plain; charset="US-ASCII"; name="rcu-2.diff.txt"
Content-Disposition: attachment; filename="rcu-2.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_leq1061i0>
X-Attachment-Id: f_leq1061i0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9zdGFsbC5oIGIva2VybmVsL3JjdS90cmVlX3N0
YWxsLmgKaW5kZXggYjEwYjgzNDliYjJhLi4yMjkyNjNlYmJhM2IgMTAwNjQ0Ci0tLSBhL2tlcm5l
bC9yY3UvdHJlZV9zdGFsbC5oCisrKyBiL2tlcm5lbC9yY3UvdHJlZV9zdGFsbC5oCkBAIC03MDks
NiArNzA5LDEyIEBAIHN0YXRpYyB2b2lkIHByaW50X2NwdV9zdGFsbCh1bnNpZ25lZCBsb25nIGdw
cykKIAlzZXRfcHJlZW1wdF9uZWVkX3Jlc2NoZWQoKTsKIH0KIAorI2RlZmluZSBjbXB4Y2hnX3N1
Y2Nlc3MocHRyLCBvbGQsIG5ldykJCQkJXAorKHsJCQkJCQkJCVwKKwlfX3R5cGVvZl9fKCoocHRy
KSkgX190bXAgPSAob2xkKTsJCQlcCisJdHJ5X2NtcHhjaGcoKHB0ciksICZfX3RtcCwgKG5ldykp
OwkJCVwKK30pCisKIHN0YXRpYyB2b2lkIGNoZWNrX2NwdV9zdGFsbChzdHJ1Y3QgcmN1X2RhdGEg
KnJkcCkKIHsKIAlib29sIGRpZHN0YWxsID0gZmFsc2U7CkBAIC03NjAsNyArNzY2LDcgQEAgc3Rh
dGljIHZvaWQgY2hlY2tfY3B1X3N0YWxsKHN0cnVjdCByY3VfZGF0YSAqcmRwKQogCWpuID0gamlm
ZmllcyArIFVMT05HX01BWCAvIDI7CiAJaWYgKHJjdV9ncF9pbl9wcm9ncmVzcygpICYmCiAJICAg
IChSRUFEX09OQ0Uocm5wLT5xc21hc2spICYgcmRwLT5ncnBtYXNrKSAmJgotCSAgICBjbXB4Y2hn
KCZyY3Vfc3RhdGUuamlmZmllc19zdGFsbCwganMsIGpuKSA9PSBqcykgeworCSAgICBjbXB4Y2hn
X3N1Y2Nlc3MoJnJjdV9zdGF0ZS5qaWZmaWVzX3N0YWxsLCBqcywgam4pKSB7CiAKIAkJLyoKIAkJ
ICogSWYgYSB2aXJ0dWFsIG1hY2hpbmUgaXMgc3RvcHBlZCBieSB0aGUgaG9zdCBpdCBjYW4gbG9v
ayB0bwpAQCAtNzc4LDcgKzc4NCw3IEBAIHN0YXRpYyB2b2lkIGNoZWNrX2NwdV9zdGFsbChzdHJ1
Y3QgcmN1X2RhdGEgKnJkcCkKIAogCX0gZWxzZSBpZiAocmN1X2dwX2luX3Byb2dyZXNzKCkgJiYK
IAkJICAgVUxPTkdfQ01QX0dFKGosIGpzICsgUkNVX1NUQUxMX1JBVF9ERUxBWSkgJiYKLQkJICAg
Y21weGNoZygmcmN1X3N0YXRlLmppZmZpZXNfc3RhbGwsIGpzLCBqbikgPT0ganMpIHsKKwkJICAg
Y21weGNoZ19zdWNjZXNzKCZyY3Vfc3RhdGUuamlmZmllc19zdGFsbCwganMsIGpuKSkgewogCiAJ
CS8qCiAJCSAqIElmIGEgdmlydHVhbCBtYWNoaW5lIGlzIHN0b3BwZWQgYnkgdGhlIGhvc3QgaXQg
Y2FuIGxvb2sgdG8K
--0000000000008f74f605f5db173f--
