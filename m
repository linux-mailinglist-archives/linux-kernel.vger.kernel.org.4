Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0B74D11F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGJJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGJJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:11:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D6FB;
        Mon, 10 Jul 2023 02:11:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57688a146ecso53268187b3.2;
        Mon, 10 Jul 2023 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688980279; x=1691572279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OE6ds8cXty874rwlHXWKLaM8k6hS9SCvEgtZP9n8Ek=;
        b=ERr5GyxWLoIfqKeAKocVZjbK3VKsETi85NEQUFRVKkqRhBmh0L+l/JNheQLLNrSMlV
         Z38Qxt3XytDiIyjE0c+lc1EwP6diVjNtg/dPqhgdTqdmx2bkBWvPWnwI1UZGxPIokKGy
         kfhJZk3MWUx6G6/QBb5lD/Nzp7KGZy7PlkwSL4tYC4MU6fCR93CgtxKYzBk+ZEML8qXG
         cLYf1IKpcQTnTCR6aA3i2fYKSbrZ5pjDqJUzhszDLEKqotstWIl5sDOKxJDVtHAIStAI
         vBCwjTaen2HDguZJgjeU/qyw2czvKnWDu4ZAxNOuG1DbdkuUMV9b9xaLQsPTeO4+eBMA
         7YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980279; x=1691572279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OE6ds8cXty874rwlHXWKLaM8k6hS9SCvEgtZP9n8Ek=;
        b=T9zBUYynfilz89uN//9V8lPx/drw7kmAKd9eacEAnX+0dd5W6KBSgZ0KOs8Em/fDVk
         2M5jszKQP5izX2OoOz5zTmYSqcyETXnXETyUBdKrtG74u2GYGpQdBpAcDc46uG+Cg6LW
         OLGQzURE0hAZN93FJl81qenqfAvyOvOSc1wD9g4bGvEEYdrA7l9DVeVGiD9Y3LhIZRjG
         1mJRnxFZdcosBDWRmlFArdB7dR0xmf/02br91susMonHy6awOw0c4WOXkgYePTDZ7bLE
         UcCf8KeWqJWv7Wv4vfmZKLWQ5XIXd74GfUvdArjnJSsN51UelDqXlA3jHmV+zjUm/F6g
         Z9Wg==
X-Gm-Message-State: ABy/qLajngcjzMf+EZEiqjc0wJyzsXuV+cVDZ7AJkKyXKDORxfG3iG60
        5oQEtDoieo1nNfXTvujeDWJUTcRH15AMg7bSRkU=
X-Google-Smtp-Source: APBJJlEOaZTO+JULkSw/suJWkWQ7bUuQ3/HVKN/CTohfWjXI2KIjFUKuoRVnTVJI1mE4eFYHxzCdMMBXwp89Gnf4lMI=
X-Received: by 2002:a25:810f:0:b0:c62:9634:d39 with SMTP id
 o15-20020a25810f000000b00c6296340d39mr10794429ybk.52.1688980279362; Mon, 10
 Jul 2023 02:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230710172602.05d32c03@canb.auug.org.au>
In-Reply-To: <20230710172602.05d32c03@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Jul 2023 11:11:08 +0200
Message-ID: <CANiq72npQiWMebvYTu8Z+XuJAyUH6-iygGtbF9V6y+R2aD1-vw@mail.gmail.com>
Subject: Re: linux-next: branches to be removed
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:32=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> clang-format            2022-05-20 19:27:16 +0200
>   https://github.com/ojeda/linux.git      clang-format

We will eventually have updates for clang-format -- if it doesn't hurt
too much keeping it, then I would prefer to have it around vs.
creating it again later.

Thanks!

Cheers,
Miguel
