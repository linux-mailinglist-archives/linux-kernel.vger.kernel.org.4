Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89034609706
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJWWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJWWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:19:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654A28737
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:19:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m6so5210818qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDuYPbSy2ARF9msXVJhQW+HurxcpnbQPUhbr2uLzj9g=;
        b=hvYqLXNxgcfZg/6dTWAaKpb++Wa9cAbgx15nMK3Y8ykx3enV1c7f9jkzOAIw1EP142
         UrhDtdN7Wro5kh+a4v0/Lje8Cki6pBlWRN+0qEQ+9+nk5NYY/oUK1HxeUJhbDhD+vUSO
         NjmHvDYKhwFLB++TeJrrbE9rDnApMJcDOeS7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDuYPbSy2ARF9msXVJhQW+HurxcpnbQPUhbr2uLzj9g=;
        b=AsfCsI6rNOdLAmZs8wIJuouLFTYpVo0k6/aYoAZ2jCyVnTR8wLFkF1ZucpgQwUjV2h
         yusH9Sw4qxdNcBJs9qsveMgEIT5naJc16yc3Ut4L4ShBm3IiKgweVC/VqkHeXxXF1GX4
         fQOsuBH5BTmRZwTgGtyov7M2oYsYYYJlnTyzNjDRpXErEUjVCcbXIaS6chzMofA0I/OE
         3o7UDQxKwsFIyKbEq3tGWPZlGzyO+o/9fvtUDo3d4bc2hdEZW5+l2y3PQwYhpB4wt017
         CMNao4GWARVKCRNwGx6Tl+WTdL6QFLY8Te0IP6AjDOkjwII79vcYmanejbmXuNZA1tMJ
         kn0g==
X-Gm-Message-State: ACrzQf3QF134o/lYP0ZuxnFsTY8pkP8YrWCnHd1eTdP6LypJWouj647d
        CSiKhkIH1hBqaNus73bvVcbh4wdpiVuCDQ==
X-Google-Smtp-Source: AMsMyM5niGhpJ8VRxZc/QaW6ofAJLRnxLyiMSdLJrG4AhCDk6Y3ozSSa/Hmb7kd/O5KyQZ08m2XLdQ==
X-Received: by 2002:a05:620a:458e:b0:6ee:cd9a:212c with SMTP id bp14-20020a05620a458e00b006eecd9a212cmr20961965qkb.775.1666563581919;
        Sun, 23 Oct 2022 15:19:41 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id hh6-20020a05622a618600b00343057845f7sm11528804qtb.20.2022.10.23.15.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 15:19:41 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-35befab86a4so71462597b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:19:40 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr8493776ywr.58.1666563580499; Sun, 23 Oct
 2022 15:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221020032024.1804535-1-yury.norov@gmail.com> <20221020032024.1804535-2-yury.norov@gmail.com>
In-Reply-To: <20221020032024.1804535-2-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 15:19:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
Message-ID: <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bitmap: add sanity check function for find_bit()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 8:24 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> This patch adds runtime check for the pointers to be aligned.

No. Don't add pointless things like this. It only adds code, with no advantage.

The bitmap ops all operate on 'unsigned long', and if a bitmap isn't
aligned, we'll take a fault on the architectures that don't do
unaligned accesses natively.

And the find-bit functions simply aren't special enough to have this
kind of random testing, when the *basic* bitmap functions like
"set_bit()" and friends all do the accesses without any alignment
checks.

The fact that filesystem code often uses bitmap functions with a cast
from 'char *' is immaterial. Those things are already aligned
(typically they are a whole disk block). They just weren't an array of
'unsigned long'.

                  Linus
