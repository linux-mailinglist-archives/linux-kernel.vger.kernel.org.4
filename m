Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F396B7BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCMP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:27:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E94681;
        Mon, 13 Mar 2023 08:27:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso11238735wmb.0;
        Mon, 13 Mar 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721275;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MlqLtviOtYp6HxaLoBe4+wSDth/BbTrrWvwIZUKlwg=;
        b=QEd2dp9v6mDiG0ZlfB3umTfHAdQYxZJ8eDaGw13dPuLSU+j0UUHFP1jGTN4cya+qFF
         HU9xsqw8O3aXkj/2oXHoESKbPdNtKwSL8RQoWN3vp0BU4Q3xWY428VC2Wqo0QzdDkDK4
         CTfv2YRQf3tdFH+s7MOpjDxLCq9jE/ksXO7iKpO6C9xLmQ0yfjZA70yrgo/3dprNUqL+
         D7NmJZ9ZUCYOUxGja37dv72QXXKRYNOVrqn9y023rxeMOL9JWVjxALNJwNs6vHoYdoHQ
         7WoJijSrIpKhzczozcX1ewaHoAq9zgjffVjM8I2xkrdO9Xz1GiA9PZeSQ2dQOQWi63m0
         7qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721275;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MlqLtviOtYp6HxaLoBe4+wSDth/BbTrrWvwIZUKlwg=;
        b=1EkQaEgczDxY0rRwUk3FhFWrvoANSZ7achpMZ7Fg/JO3N+KXFDvGS3V5sEz845thbW
         1U2UjiekEXkdt6INFbOyrDaBz9ewsrimAfu5E9vtSsvUcfrd4VVYX/fG4c8uH0gdpLWK
         4nby1C9mnPDv4BXbNQnUsDK+v20id939eRhfAyiDTVs53ibWstxdTgIpEPol17zTZC4A
         Ig61ucpe9b0dZEI/xHGAiXNhEDd5ryEvOhTuHEbxylsqsmr5XZAZSJ/ODBsPLFD68SuO
         kZjhKqpBnMmklPI4We7xGcnypnADLPigmp6tWZTnNvcrzI6XXAfGzA/p0BjpXvYEqOyG
         0g7g==
X-Gm-Message-State: AO0yUKXehLoHM06T9gdaYOXqFHo7pNA0kFuZQ8RNlsLe4LbScU0blSUu
        Wrfho0Sc/7+v1PwR15P7aMXe/osaUPflQg==
X-Google-Smtp-Source: AK7set9jSPgWPA4c0CSnP9h04Z4BjORE+KGXik6RLZzLIdxKfYDEybMVgA05SmzFddLLAPLg5G6mvA==
X-Received: by 2002:a05:600c:c10:b0:3eb:248f:a13e with SMTP id fm16-20020a05600c0c1000b003eb248fa13emr11542947wmb.22.1678721275178;
        Mon, 13 Mar 2023 08:27:55 -0700 (PDT)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bc8da000000b003e2096da239sm92233wml.7.2023.03.13.08.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 08:27:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Mar 2023 16:27:53 +0100
Message-Id: <CR5D0YM6E93X.S0PN49LMWT0U@vincent-arch>
Cc:     <christophe.leroy@csgroup.eu>, <song@kernel.org>
Subject: Re: [PATCH] stress-module: stress finit_module() and
 delete_module()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Luis Chamberlain" <mcgrof@kernel.org>, <colin.i.king@gmail.com>,
        <patches@lists.linux.dev>, <linux-modules@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <david@redhat.com>, <petr.pavlu@suse.com>, <prarit@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230313103439.1235909-1-mcgrof@kernel.org>
In-Reply-To: <20230313103439.1235909-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some comments on the code that feel a little bit odd to me,=20
while I was reading the code.

> +#if defined(HAVE_LINUX_MODULE_H)
> +#include <linux/module.h>
> +#else
> +UNEXPECTED
> +#endif
> +
> +#if defined(HAVE_LIBGEN_H)
> +#include <libgen.h>
> +#endif
> +
> +#ifndef MODULE_INIT_IGNORE_MODVERSIONS
> +# define MODULE_INIT_IGNORE_MODVERSIONS 1
> +#endif
> +
> +#ifndef MODULE_INIT_IGNORE_VERMAGIC
> +# define MODULE_INIT_IGNORE_VERMAGIC 2
> +#endif
looks like that the #define has an exstra space and this differ from the ot=
hers=20
.[c,h] files?

=E2=9E=9C  stress-ng git:(master) =E2=9C=97 git grep "#define" | wc -l
2830
=E2=9E=9C  stress-ng git:(master) =E2=9C=97 git grep "# define" | wc -l
1

Cheers!

Vincent.
