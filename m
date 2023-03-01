Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F86A6FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCAPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCAPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:36:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC803525C;
        Wed,  1 Mar 2023 07:36:04 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so7924866pgh.13;
        Wed, 01 Mar 2023 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677684964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx2Y04HnbVuJVg0xOpO6v56u/oJYu43rVfvF9yJ29p0=;
        b=pF5MsrHtv0EhvXmTsxznc8Fe+kqFIJ66uvA2fk9s5FYr/yyv/JMagS+vmF5zDCDU+k
         CBMNL8f/Qv/DEOebnFKPAhwuSK084Gu3dzO3QeUqR2aBjgErM2bm5PbbOkUIna1dwigT
         2sfBwuw5KAQxfv4JO5Vy+0/DeWreC4YusUx/LpwUmub5ZJauKPG/Kb5Pco8hR8PD0ZSs
         kDV8f57I/cYutHVxQdS2A/EUm1U9kOZYaAXUt/dau+NNJlazb4RhVKI4cPgQJvUgYaqz
         finuqruKf3hqpOl+Du2FeyTeq8dhEumIFNO0if8ve9Ot4POt9eqGq03tNI+k+LzW4t48
         aVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677684964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gx2Y04HnbVuJVg0xOpO6v56u/oJYu43rVfvF9yJ29p0=;
        b=VkkKUdc9OKMbrJVSO4XV+xFluJttK9GcNtU/O2nvErgv1O6/Hy1tYX6ewav3DEsefq
         cj1vYYTejDWd/qRzoPw+SeS6Zig6bj5JpeHN/YrVLDXF/e/EQMOnWOdqpnaxNu1sw39N
         6vBBvcLwl0QliIMWEM7VM7iKo3fq/cucPhNNNtGeu/qXpUYqR4xN/xtjWEZUFoRFwSQN
         Mq6vZUxgS/veTPHygX9RmAUEOuE8RVJwffVJrAdObaUP3qIcmwVStMD4352wdIh6Fonx
         7UVgh6cgj7ttUygXKGckBkB+WoVBHEyLKKsXRWuPYIZdY4jOYi5pOXesu2YR/hZBVMuX
         f+fQ==
X-Gm-Message-State: AO0yUKVmlebTMY/JimzQ48lnlPraHnMfeCA79P0/gRv63TnUFAM+3Ygy
        U5fYLOZY8QUgZMTP3GVQk8vtIhZZzOcMOT2hOGA=
X-Google-Smtp-Source: AK7set/tcFRH/h71gLqfGSCLKue7Ra4g5s2d4KChaBPTuRlmH41mpYCu3VEgWHVMhCqbKpz83rkdLv6FUbSqfQBe3fY=
X-Received: by 2002:a63:741e:0:b0:502:fd12:83ce with SMTP id
 p30-20020a63741e000000b00502fd1283cemr2277016pgc.5.1677684964298; Wed, 01 Mar
 2023 07:36:04 -0800 (PST)
MIME-Version: 1.0
References: <583f41c49eef15210fa813e8229730d11427efa7.1677614637.git.andreyknvl@google.com>
 <Y/7VeHQBL43MzIPR@debian.me>
In-Reply-To: <Y/7VeHQBL43MzIPR@debian.me>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 1 Mar 2023 16:35:53 +0100
Message-ID: <CA+fCnZdq0FkQDe+FU-dUfsBFnQz-xqRO1eUJ3_Oq38OuN2N7zg@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: improve documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux Documentation <linux-doc@vger.kernel.org>
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

On Wed, Mar 1, 2023 at 5:33=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> > +2. Using `KCOV_REMOTE_ENABLE`` instead of ``KCOV_ENABLE`` in the users=
pace
> ``KCOV_REMOTE_ENABLE``

Will fix in v3.

> Otherwise LGTM.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you, Bagas!
