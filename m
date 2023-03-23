Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5AC6C63D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCWJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:39:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B336E9E;
        Thu, 23 Mar 2023 02:39:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ja10so21763075plb.5;
        Thu, 23 Mar 2023 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679564386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx1cWbW8skW+J91S4nIUH2+PrWy6/cJUo3hRxlmG+G4=;
        b=pCQdPrCYjY2EZyqDFB6ur/y+zD7pfxrqPKXJ6qROgn8YzstnagOQ80gua0e1yJf5be
         Iio59oXde7Wup+LLoxrsV6D9TeOXDdjIwSR0uzeN8xXXiJrpqDFsl3PPA9Bn/1zF3BIo
         YLwOlu/RQCnP/HzzbsPc80+gLMzoDTJiFBHeGDoqzkTbPeTcgvhX6vrX/IYCDMIOQ+lF
         oU3W9kqDe16PxbF7PpEZ1wobldylApgBPHSg1aCrJv/TSvboroNCYTId4WKXpZR8qvGg
         BPHyb212ZPe8k9S2ggTMwGgiVnV72nO1xLe9xzULnDLsdD1LalTMpJY686VYZd+oZ85l
         A86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679564386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx1cWbW8skW+J91S4nIUH2+PrWy6/cJUo3hRxlmG+G4=;
        b=01Z6A2u3tRgTUhDxrhIZy6Fk3M24es8sOC/vb2QlpUU3YYd6nZJv/o3pl3bH+cyBmS
         E3Lx8Eqx6P/HsAraN65FAgI0WfbXbXh3ItQbtpp97GYqGO4dsBqKUmyVOpUKOx7dqnes
         w/zV8J3B0XuFzAg3kZh8zf+55tRRH2Vt0f4wiXPKP/Ug1lnq93saYaa4/xvYLKgZbz8q
         SeCIovxWhMYQNWIxn8Fh2YRgKFU14tElIR92QjXWlhSCJme3eoJqei+bQEcaUYNO21ad
         By67qTAqmecGM8sm++CVGStGXiElQwyQ8jFyCFRAj695qWXg/H9jJNvsAXttZ8mRayzl
         VVMw==
X-Gm-Message-State: AAQBX9dpK3GyeHvYnf6UsqhbyknCosthKN6Zly1f3FzqPQ9Z9K5mvSq7
        09rblEsHTU66A02exX84XCfCS7/yAPTGqf6dv5M=
X-Google-Smtp-Source: AKy350bCAexRMlOcrYwrCk12cMPtsoPYJWZ/XiHrtIhAZ4B6tk5Hhx8gC4VdgE3XYHEjClHtI+16JTGrwgF9+BfNLfM=
X-Received: by 2002:a17:902:b687:b0:1a1:ffc5:1e8d with SMTP id
 c7-20020a170902b68700b001a1ffc51e8dmr942230pls.3.1679564386271; Thu, 23 Mar
 2023 02:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230323092156.2545741-1-rppt@kernel.org> <20230323092156.2545741-15-rppt@kernel.org>
In-Reply-To: <20230323092156.2545741-15-rppt@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 23 Mar 2023 02:39:34 -0700
Message-ID: <CAMo8BfJtCgak4mbeZ2R61EEWz+HYYhK-KOz+XJ+fhLY+zFgajA@mail.gmail.com>
Subject: Re: [PATCH 14/14] xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:24=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The prompt and help text of ARCH_FORCE_MAX_ORDER are not even close to
> describe this configuration option.
>
> Update both to actually describe what this option does.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/xtensa/Kconfig | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
