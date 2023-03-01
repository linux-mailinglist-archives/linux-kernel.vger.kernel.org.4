Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6886A726D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCAR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCAR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:57:26 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74C4393C;
        Wed,  1 Mar 2023 09:57:25 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x199so1197327ybg.5;
        Wed, 01 Mar 2023 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677693444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMv+GjvytLsvaeDW1zTsrcY8O7+nvDjVCDCxEs6ENjo=;
        b=qy4P9hh4vD9xeqKHYs3AJ0KuY7+3ziLMMdZK8pdyxXl2u13le0xV2+3OcH35eajVBq
         hq5uHdFIp7b9Y1wsHLBdiznHSe4E2VL6YH+TKZC7Grl0+dLiiB5s8MpRgN5u/PUbAWoD
         W3rJhN1tAmGCTH7cDwPVSn+yjPXocJjMUzpR3KkqGArjTom9L1KofcnFgGMdOplPuYKV
         jMLFS9qMv8exdoIoE1koiOPL+7ZeN1MCDmNsbcWhW/HiA6C/se99whGX21sKE5w4LDBk
         qJKRIr0IdXvfORiw936K/ao5hj3gZNXhhlw6V1BiyiBXLdnXeQ5lFdfsVVIdR5+9U7ZO
         hYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMv+GjvytLsvaeDW1zTsrcY8O7+nvDjVCDCxEs6ENjo=;
        b=NAYCDVAMANFayGUbvsXMK54wlFewDaDqHBnsEfIsfMZySqn5r4eGGTirhx6evkn3Cw
         yFPYlphu7wtuTT+I76qJqojnjeuj5JSSkjWa2bHJ8/j38CHHQoK7wkek1kRfWS9hbskR
         WKbe6VB1I5HMVObZPFf+2C8mT+3GVTCgpDfyZE/K4pPAyh+l88NkQxXTz6z+LqvvIdeM
         XDPNM6NgqHvWk07AIFsvGzKG9jK9+k6LgQfMCQxQzjEmn8Hf6592gqJSQFD10HbJBHE/
         frp1ol1xcX7tHZmyrXF3YjLMMS8Bwz7VCyH0wg5L7uXVlTo3TCJ+HAPUbO10aoNoGyct
         83dA==
X-Gm-Message-State: AO0yUKXbYPnh0rrhU8pnJYeqjNIIzR+ykLTzKJzfeIx/aoB80I++w2MV
        dOl9zG405XsBzD00W/2eiUDQAfgsGaw0DunJfZJetQe13qZOQA==
X-Google-Smtp-Source: AK7set/ydCF++OuTc1H2qvo5j7B39t/T/cPRmZRXYH5jco7DxcqHDq8YdinHXzm+SbPdTqBqngobIiYOEEySeXIcAz8=
X-Received: by 2002:a25:e210:0:b0:a36:3875:56be with SMTP id
 h16-20020a25e210000000b00a36387556bemr3882339ybe.10.1677693444700; Wed, 01
 Mar 2023 09:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
 <20230301111850.768f8526@gandalf.local.home> <20230301112808.73d1e316@gandalf.local.home>
In-Reply-To: <20230301112808.73d1e316@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 18:57:13 +0100
Message-ID: <CAFULd4aQTEmJz6Q9B6vSm-90A41g7T1pVntaR_PUMSoFRQUGZg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: multipart/mixed; boundary="000000000000d0793c05f5da717f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d0793c05f5da717f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 1, 2023 at 5:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 11:18:50 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > But with gcc 12.2.0 I don't really see the benefit. And I'm worried tha=
t
> > the side effect of modifying the old variable could cause a bug in the
> > future, if it is used after the try_cmpxchg(). At least for the second =
case.
>
> Actually, I like Joel's recommendation of adding a cmpxchg_succeeded()
> function, that does the try_cmpxchg() without needing to save the old
> variable. That's my main concern, as it does have that side effect that
> could be missed when updating the code.

The "controversial" part of the patch would then look like the
attached patch. As expected, the compiler again produces expected
code:

     eb8:    48 8b 0e                 mov    (%rsi),%rcx
     ebb:    48 83 e1 fc              and    $0xfffffffffffffffc,%rcx
     ebf:    48 83 c9 01              or     $0x1,%rcx
     ec3:    48 89 c8                 mov    %rcx,%rax
     ec6:    f0 48 0f b1 3e           lock cmpxchg %rdi,(%rsi)
     ecb:    48 39 c1                 cmp    %rax,%rcx
     ece:    74 2d                    je     efd <rb_get_reader_page+0x12d>

to:

     eb8:    48 8b 01                 mov    (%rcx),%rax
     ebb:    48 83 e0 fc              and    $0xfffffffffffffffc,%rax
     ebf:    48 83 c8 01              or     $0x1,%rax
     ec3:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
     ec8:    74 2d                    je     ef7 <rb_get_reader_page+0x127>

Uros.

--000000000000d0793c05f5da717f
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lepzbu5o0>
X-Attachment-Id: f_lepzbu5o0

ZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9yaW5nX2J1ZmZlci5jIGIva2VybmVsL3RyYWNlL3Jp
bmdfYnVmZmVyLmMKaW5kZXggYWY1MGQ5MzFiMDIwLi43YWQ4NTVmNTQzNzEgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC90cmFjZS9yaW5nX2J1ZmZlci5jCisrKyBiL2tlcm5lbC90cmFjZS9yaW5nX2J1ZmZl
ci5jCkBAIC0xNjMsNiArMTYzLDEyIEBAIGVudW0gewogI2RlZmluZSBleHRlbmRlZF90aW1lKGV2
ZW50KSBcCiAJKGV2ZW50LT50eXBlX2xlbiA+PSBSSU5HQlVGX1RZUEVfVElNRV9FWFRFTkQpCiAK
KyNkZWZpbmUgY21weGNoZ19zdWNjZXNzKHB0ciwgb2xkLCBuZXcpCQkJCVwKKyh7CQkJCQkJCQlc
CisJdHlwZW9mKCoocHRyKSkgX190bXAgPSAob2xkKTsJCQkJXAorCXRyeV9jbXB4Y2hnKChwdHIp
LCAmX190bXAsIChuZXcpKTsJCQlcCit9KQorCiBzdGF0aWMgaW5saW5lIGludCByYl9udWxsX2V2
ZW50KHN0cnVjdCByaW5nX2J1ZmZlcl9ldmVudCAqZXZlbnQpCiB7CiAJcmV0dXJuIGV2ZW50LT50
eXBlX2xlbiA9PSBSSU5HQlVGX1RZUEVfUEFERElORyAmJiAhZXZlbnQtPnRpbWVfZGVsdGE7CkBA
IC0xNDk1LDE0ICsxNTAxLDExIEBAIHN0YXRpYyBpbnQgcmJfaGVhZF9wYWdlX3JlcGxhY2Uoc3Ry
dWN0IGJ1ZmZlcl9wYWdlICpvbGQsCiB7CiAJdW5zaWduZWQgbG9uZyAqcHRyID0gKHVuc2lnbmVk
IGxvbmcgKikmb2xkLT5saXN0LnByZXYtPm5leHQ7CiAJdW5zaWduZWQgbG9uZyB2YWw7Ci0JdW5z
aWduZWQgbG9uZyByZXQ7CiAKIAl2YWwgPSAqcHRyICYgflJCX0ZMQUdfTUFTSzsKIAl2YWwgfD0g
UkJfUEFHRV9IRUFEOwogCi0JcmV0ID0gY21weGNoZyhwdHIsIHZhbCwgKHVuc2lnbmVkIGxvbmcp
Jm5ldy0+bGlzdCk7Ci0KLQlyZXR1cm4gcmV0ID09IHZhbDsKKwlyZXR1cm4gY21weGNoZ19zdWNj
ZXNzKHB0ciwgdmFsLCAodW5zaWduZWQgbG9uZykmbmV3LT5saXN0KTsKIH0KIAogLyoKQEAgLTIw
NjEsNyArMjA2NCw3IEBAIHJiX2luc2VydF9wYWdlcyhzdHJ1Y3QgcmluZ19idWZmZXJfcGVyX2Nw
dSAqY3B1X2J1ZmZlcikKIAlyZXRyaWVzID0gMTA7CiAJc3VjY2VzcyA9IDA7CiAJd2hpbGUgKHJl
dHJpZXMtLSkgewotCQlzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkX3BhZ2UsICpwcmV2X3BhZ2UsICpy
OworCQlzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkX3BhZ2UsICpwcmV2X3BhZ2U7CiAJCXN0cnVjdCBs
aXN0X2hlYWQgKmxhc3RfcGFnZSwgKmZpcnN0X3BhZ2U7CiAJCXN0cnVjdCBsaXN0X2hlYWQgKmhl
YWRfcGFnZV93aXRoX2JpdDsKIApAQCAtMjA3OSw5ICsyMDgyLDggQEAgcmJfaW5zZXJ0X3BhZ2Vz
KHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpjcHVfYnVmZmVyKQogCQlsYXN0X3BhZ2UtPm5l
eHQgPSBoZWFkX3BhZ2Vfd2l0aF9iaXQ7CiAJCWZpcnN0X3BhZ2UtPnByZXYgPSBwcmV2X3BhZ2U7
CiAKLQkJciA9IGNtcHhjaGcoJnByZXZfcGFnZS0+bmV4dCwgaGVhZF9wYWdlX3dpdGhfYml0LCBm
aXJzdF9wYWdlKTsKLQotCQlpZiAociA9PSBoZWFkX3BhZ2Vfd2l0aF9iaXQpIHsKKwkJaWYgKGNt
cHhjaGdfc3VjY2VzcygmcHJldl9wYWdlLT5uZXh0LAorCQkJCSAgICBoZWFkX3BhZ2Vfd2l0aF9i
aXQsIGZpcnN0X3BhZ2UpKSB7CiAJCQkvKgogCQkJICogeWF5LCB3ZSByZXBsYWNlZCB0aGUgcGFn
ZSBwb2ludGVyIHRvIG91ciBuZXcgbGlzdCwKIAkJCSAqIG5vdywgd2UganVzdCBoYXZlIHRvIHVw
ZGF0ZSB0byBoZWFkIHBhZ2UncyBwcmV2Cg==
--000000000000d0793c05f5da717f--
