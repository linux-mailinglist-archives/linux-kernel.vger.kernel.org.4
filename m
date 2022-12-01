Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4283163F5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiLAQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLAQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:59:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0249F4AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:59:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fy37so5611245ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAMpMHrp1O/RuJopeXaPzD5eZ1V6ZQmoOR0qBVYhFMA=;
        b=L4sYRD43/mv/STHpswugH9M/06nyMnRsf/uSTIa/sr0RtkjqB0r3wyI3XGZ+VoyBDb
         lXkGtLvucaz9S4daD1J2qIqQLeUu0YZjZ/Bz1zBVLAZp2RYVO1fxDMMCKseQ0ItuKD8k
         OKEXDkaGm6+aGhcBbW/F1B4eXADhp2bKm4yxGm4I6mNi+eNc3fhvu82cma3wlx2gxZwg
         tKbi1Y/Qhlb4bpyEKEbiJniyPw/7RMi9Tpl6zQ1JEmCzq0NBKWV+KMz38+is2+76ixkJ
         qUuuQRhuiNzGxcP9tMDOZaTgGCGsU5/wRkKhCjzKa88eil2JgFDiNAzj6S4vabbcXjju
         1CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAMpMHrp1O/RuJopeXaPzD5eZ1V6ZQmoOR0qBVYhFMA=;
        b=0dFHsgFofeYVKOlZLR6T0TD8Ei16wftfK+Hzs5zzNittruq40kTvNQEXoWfj1tvQ8h
         bEPOOpCDZvbcZhHep2yC8lNS+xuRvM7f7fn38KvpoT2LhaWmfXzKv3IK5mpJbmPyppTm
         Zvb1dGW4q1iyDOqRbsURBcWjXQi2kl1U15OiG/kvaRsxadUIaSAjbG0wpZNMq+7v1rp9
         6UMlB/rwLER/wNFbrMDk4u51J0TtimI56nXH97j/Y17aPTjPrzS8tFRYkUtmtiO0/+bo
         EgOCHhn2hvQOrrk6H6QRRbpkT5/L+SwIzkJinMRqq7dx7O8bj58Qcz1TOPAVadabCrJM
         n5pg==
X-Gm-Message-State: ANoB5pkke8uQ8RaszLdHowxLcN1ox/2/otlu9f/aXKAucy3+CsDVnSIa
        PqWN4gZAASkUqB6urcudDwtiVIKhzYhy9KiE03k=
X-Google-Smtp-Source: AA0mqf5OdU5NSsoVseHRZEVNIou2O9oDrHgwA3IMPzdBULQBQIrL22YMGj+KNI5ghWLh4L/Dg5jLGnopMi4fvBCA62k=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr43484840eje.94.1669913947205; Thu, 01
 Dec 2022 08:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home> <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
In-Reply-To: <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Dec 2022 08:58:55 -0800
Message-ID: <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@meta.com>, Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

On Wed, Nov 30, 2022 at 2:37 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 22 Nov 2022 14:51:08 -0500 Chris Mason <clm@meta.com> wrote:
>
> > On 11/22/22 1:29 PM, Steven Rostedt wrote:
> > > On Tue, 22 Nov 2022 12:42:33 -0500
> > > Chris Mason <clm@meta.com> wrote:
> > >
> > >> On 11/22/22 5:39 AM, Borislav Petkov wrote:
> > >>> On Mon, Nov 21, 2022 at 03:36:08PM -0800, Alexei Starovoitov wrote:
> > >>>> The commit log is bogus and the lack of understanding what
>
> Why am I not understanding the controversy here?  With this patch
> applied, people who want function error injection enable
> CONFIG_FUNCTION_ERROR_INJECTION and people who don't want it don't do
> that.
>
> Alexei, can you please suggest a less bogus changelog for this?

People are using ALLOW_ERROR_INJECTION to allowlist kernel functions
where bpf progs can attach.
For example in the linux-next:
git grep ALLOW_ERROR_INJECTION
drivers/hid/bpf/hid_bpf_dispatch.c:ALLOW_ERROR_INJECTION(hid_bpf_device_event,
ERRNO);
drivers/hid/bpf/hid_bpf_dispatch.c:ALLOW_ERROR_INJECTION(hid_bpf_rdesc_fixup,
ERRNO);
drivers/hid/bpf/hid_bpf_jmp_table.c:ALLOW_ERROR_INJECTION(__hid_bpf_tail_call,
ERRNO);

The hid-bpf framework depends on it.
iirc Benjamin mentioned that chromeos is one of the future users
of hid-bpf. They need it to deal with a variety of quirks in hid
devices in production.

Either hid-bpf or bpf core can add
"depends on FUNCTION_ERROR_INJECTION"
to its kconfig.
Like:
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2dfe1079f772..281e5263f3d1 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -32,6 +32,7 @@ config BPF_SYSCALL
        select BINARY_PRINTF
        select NET_SOCK_MSG if NET
        select PAGE_POOL if NET
+       depends on FUNCTION_ERROR_INJECTION
        default n

but the better option for now would be to drop this patch.
For the next next merge window we can come up with alternative way
(instead of ALLOW_ERROR_INJECTION) to mark kernel functions
purely on the bpf side.
I don't think we have time to add this marking infrastructure
for the upcoming merge window.
