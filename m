Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92549700D28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjELQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjELQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:38:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8B8A7E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:38:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so6969794b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683909514; x=1686501514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI3VClWXDuKTFGWdg3vQHVn8mYYEQYaV3Uoj0tZUhr8=;
        b=rtNlldmsz3ctSPubKMZIs9MSHIgEjW+zWdMumyfKBtQa33xEAw8RKJWeJ2DGLaoOBK
         WGKHOpufyc6MSqWqHlJv9SzUeIBxzz72WSgqejMFt9CDZgPTdKUMX+LhBs+0MJWYO/5a
         JIDkP3LE4sFEbglJdH6kN1QmYtn78//5j77HPybCI4D7ojcRoB5fZEBYtO/Lwm+DWZT2
         ps5XFQ6cGjiBbrzbQRqKN5f50mm4ByXgBcU8uZ13NycPg+8LCsTcVXD5byqU4qQdvpuZ
         S7objJdTGXnGzRWkpoTBgr2BNUTZzsc3Dp12Y+BJKTuqYfj9g32UU8Ea4oJ0iPDHUEiO
         6+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683909514; x=1686501514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI3VClWXDuKTFGWdg3vQHVn8mYYEQYaV3Uoj0tZUhr8=;
        b=P1qMrpa5BRQEOymOJDkIWm84m8DCIP8nldF9XudH8F9dADL/g3+hUy4ElNKNlcgJpG
         qWEj2CVhLog9jmb3n9IyAQmYrXEto7LOWKMZsK7ZDkB6AH20FR8ftuk1boIYIJ+4XfUQ
         DRd7SQrpMeCHOLeH3lYCK0gcE+c3qMM0T5jVdf+bR65zxMvmyQTrmgQD79Jjueptad91
         wkiF0TBFd+DkZ6PSm+rmnPuoaQyYtv59kZglX+d46q8SyK6IEj9tyf3M8P4XS5tT96sS
         sLkwRjiqiMSP0pQ9vCEKQnUlYRNeu/qZiVy292WTwhWqQkf2s2B2OQSXhuD/RMnJbZGs
         UpoA==
X-Gm-Message-State: AC+VfDxLXlQNhGURtEg3g2wij31kRiQI10v7nkDodkt4vHehh3PnCJb7
        qeVkH+8qV1B/qeCS58JGAnvDwKXLIEKRZ2eQCXA=
X-Google-Smtp-Source: ACHHUZ6GWMdYadfeRV/qZ24bVy+eXwpBauXEuaI7sUETSLNb7cFw5fkqX+OZ4FeF59Wg9oTW7cKjs4y8H/suDYvU2iw=
X-Received: by 2002:a17:90a:9f87:b0:24e:201e:dcbd with SMTP id
 o7-20020a17090a9f8700b0024e201edcbdmr30692013pjp.21.1683909513955; Fri, 12
 May 2023 09:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683892665.git.christophe.leroy@csgroup.eu> <a6834980e58c5e2cdf25b3db061f34975de46437.1683892665.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a6834980e58c5e2cdf25b3db061f34975de46437.1683892665.git.christophe.leroy@csgroup.eu>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 12 May 2023 09:38:21 -0700
Message-ID: <CAMo8BfLYp6yKC6o8Z8qSYQq3BhBmHfQ32F_ShsgqRbfVepkv1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] xtensa: Remove 64 bits atomic builtins stubs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        Rohan McLure <rmclure@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 8:31=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The stubs were provided by commit 725aea873261 ("xtensa: enable KCSAN")
> to make linker happy allthought they are not meant to be used at all.
>
> KCSAN core has been fixed to not require them anymore on
> 32 bits architectures.
>
> Then they can be removed.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/xtensa/lib/Makefile      |  2 --
>  arch/xtensa/lib/kcsan-stubs.c | 54 -----------------------------------
>  2 files changed, 56 deletions(-)
>  delete mode 100644 arch/xtensa/lib/kcsan-stubs.c

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
