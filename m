Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B43673315
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjASH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjASH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:57:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D8C46BF;
        Wed, 18 Jan 2023 23:57:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id br9so2055603lfb.4;
        Wed, 18 Jan 2023 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TgKWEjbZbhQRuOfWl79+7R0LGUimYBR1yeNE3XKpH0=;
        b=O5OOcGHT8mbVgqz+xU8R3u/0Dej6PlOqg70mCK2wGAreZDuLODizWG9JUSVbLzLBdD
         bOe5UluncIcrAXMjUaninWEDL9nTVCF9DC/WFFSZ9SIY9h0A6Y9AXDxdWnYGmFuPZYUa
         MMeI5ecP+nmOp1ndKjxSuO+tTLkLqs7GKR696ORhKSN4cvssXHlsh1VuuVvXjJusjQDd
         FqvNonW4uNW9K71T6rN6hQf8rSY3w9ybFmAu0dQeA0Pp7ulyLGEsOJ4KRoMnpjf2V091
         /IZ2ZeVxELMI276y7LE/C7abpkjAEHTVhAjD1mgd6uxhl9hoxoXbCGx5iMLrUAu2sEeU
         C0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TgKWEjbZbhQRuOfWl79+7R0LGUimYBR1yeNE3XKpH0=;
        b=Bp2xVYF7ylzGpdxaKvg7QYjCJwgophUgqolNwzPmaWEyhBcOnRjbF+HdMzSAzH43We
         8wpp574RhgXDkr9VGYj8GivSlM+CMo0IVpEcWSo+fsg5AyKzhHCFVD1Q5aheMnxpyOj0
         6iqX5rSzO5kX0GBOopZLGlTxNL7omThyM23SPVLfy5YuEuxMwuGe0G8l7pfiY6BBLEu0
         +UHuR4AJrRH1mJaEfPSB7TKFu/W9QrXoOf7KgI1/ZCfieXQfwIE1eKRCE/eRfh0gwh6T
         JzB6e13q1vTEOnY0weaBc5tmR3Xjc4g6IgeiIuDo4NCpjVwFK8ndTuspeLNQ9ZdlxqjQ
         AACw==
X-Gm-Message-State: AFqh2krVne09Q4IvunA1bMid/nvtP3mT9kxaFNrJAJKkTDxWYE2z2aNu
        /3/Il5WISRhHkrQyFDQzgXV/lxk2MuLF5BF2ZwdrRM8HHilpJw==
X-Google-Smtp-Source: AMrXdXvfyxm+Khz7t9NWJHmc8O3DRyVENAto+8LT2ZweE4+J3Euiwtliwzv+23vzh82ABNkLwm9BgiIcFUumNfvGZMQ=
X-Received: by 2002:a05:6512:159:b0:4b5:2958:bd06 with SMTP id
 m25-20020a056512015900b004b52958bd06mr577515lfo.26.1674115036290; Wed, 18 Jan
 2023 23:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20230119071215.23042-1-masahiroy@kernel.org>
In-Reply-To: <20230119071215.23042-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 19 Jan 2023 08:56:38 +0100
Message-ID: <CA+icZUUKHi5h_QsoSfXLLW7cygsCub7EvtPdoWoG6WXAmoKLeQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: remove bin2c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
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

On Thu, Jan 19, 2023 at 8:16 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit 80f8be7af03f ("tomoyo: Omit use of bin2c") removed the last
> use of bin2c.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

With yesterday's build including latest tomoyo changes in Linus Git I see:

$ scripts/diffconfig /boot/config-6.2.0-rc4-1-amd64-clang15-kcfi
/boot/config-6.2.0-rc4-2-amd64-clang15-kcfi
-BUILD_BIN2C y
BUILD_SALT "6.2.0-rc4-1-amd64-clang15-kcfi" -> "6.2.0-rc4-2-amd64-clang15-kcfi"

So, yes bin2c can go.

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

-Sedat-
