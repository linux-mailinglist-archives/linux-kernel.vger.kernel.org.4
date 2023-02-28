Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334796A5F22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjB1TDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1TDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:03:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916824C81
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:03:37 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id bo10so7593474qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhF0f5+OI0BrKkPV5TeYBsk54yszg6zUdMYrMu7RCfM=;
        b=h+L4MFqDtmZ+GTkE19Pe0xpMlAJVgmaPr04s99cIr2BJJJXOBUDw/0ZlI8RXgc0tLc
         8TzTLjRsIp6qyRAPCjtGdFhRihInCsNrEJmZxD3ZV7LdM/D+X8mxQTq6p2/qWdyX5GGf
         7zXpgiufF1duId32oYz1lYReQYMZesAD9779H/0y8gpn1AHBObfDRfJ1c10Rr+3ww89p
         jZaRMArTrL4QpAHVBWfxBT5dwqTRUWcnmgfxqeWuLAkwjDfmZMuvBwsFa0MmjJuGRBBE
         72mzWzb9RE2edvVqbVh+TeNQL4n0QIvS7ul1uObwFKsVN5DRWesi3BqYZd3HEqk6eT9B
         RZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhF0f5+OI0BrKkPV5TeYBsk54yszg6zUdMYrMu7RCfM=;
        b=2HxsZYBzYzmEefpXm15Ap6lhEk3f0V1VP6ZrCz9PtkFBXFTE849NCphdlzKxFIqZ5J
         qc6mgHlqgME9HoAef8X1k2aMTpcKo0/U1Vj+BGJwPaaenxM1qnxFOyXzqDn2sINvO9L6
         zAjAEBYnMLUIBvzJ1b9zZZuao6Lx3q9Cj6HQ9JO1IkEaWWJKSsUgZE3CTseEuWsVSSP/
         uNDvSrYK4x38AUBem1GnxT5ipoIDi9d0pJyYp78qWqcXvZ5JuFvnuTxWO73iapC26+mN
         pyCz9RUf2al7QNkc9CrUv9259Wo3q9XaL7eCaK1QClTPTkEHjRTzl30O8PIsRKeAiwqs
         qnSA==
X-Gm-Message-State: AO0yUKXEocgreBshS2VZCXJVMaZ2SbAO54vZb5SGLeTiL6KVIyZVXlUG
        gcLsetWy/0wgQ9bEhXvwGfhr0xL4dm3SBuD2fDg=
X-Google-Smtp-Source: AK7set+Fy1XS77KWw+GxkksHVNDG5xO/igrEX9DvAIbbOptVcmS3xk67Y1RELe/94wY887lm6V/NBy+zZ6x0FH+mGx4=
X-Received: by 2002:ad4:5949:0:b0:56b:ed36:ffb with SMTP id
 eo9-20020ad45949000000b0056bed360ffbmr4646782qvb.1.1677611016847; Tue, 28 Feb
 2023 11:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20230228184245.1585775-1-bjorn@kernel.org>
In-Reply-To: <20230228184245.1585775-1-bjorn@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Feb 2023 21:03:00 +0200
Message-ID: <CAHp75VfK3RM+SP90d3nOXEobY81Xd_94tLL=Qt86mmdNwXaQpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/test_string.c: Make definition less dense
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 8:42=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Checkpatch seems to have trouble making sense of the situation when
> struct definitions, variable definitions, and __initconst marking is
> done in one go.
>
> Let's be nicer to checkpatch, and move the struct definition out,
> which removes the error.

Not that I'm against the patch, but how hard is it to fix the checkpatch?

In case you go this way with a patch, it probably makes sense to move
test data out of the function as well with something like
strspn_test_data name.

--=20
With Best Regards,
Andy Shevchenko
