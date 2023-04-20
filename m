Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0486E6E9A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDTRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDTRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:01:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEB423C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:01:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f6a796bd0so50053867b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh-com.20221208.gappssmtp.com; s=20221208; t=1682010083; x=1684602083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMADD16mbnU9U9nwmJ1TEHgIp8QQ7hr++iHttnQXxms=;
        b=lTWCDRi+/9/ifvYhq+aqhiFxzjtzbv5y5nVijD4wOkSgdy90iPSEas7W4Hgu04eW9t
         FmGr4VBDXg8FH1FcfuRgPOVnmfhfBwly8qjA63vcB2HT0EBVcLcg8DGGc25KcSp2mGDx
         o7dBLh7aZ9pn3iXMdbWyxb4QpbBe5YyL2+bcsqcc9n4j7vk0PRl+FzGYN1v56iMIeKTn
         Ks9XNIxuA1+oP1FR+VwZ0l56jlk1l1DC075BAlHJZGR8Satod/z+ZLVn7rNP1pzQhqDT
         rbWiL2Z8ttehufjNFghHoTLx/4AvDs0tYAVZ8ak+G8kqtpaFeaGVcJDxjodYFmC5GJxI
         nrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010083; x=1684602083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMADD16mbnU9U9nwmJ1TEHgIp8QQ7hr++iHttnQXxms=;
        b=jwLiQmmzH7TZVsMyWGGUqqRpVZ1P5wgOdgfjSlTuKNivPU8aRBxaDJ6VAlPKGOujA/
         3RVypF0FdCnqHmCihgolexbtR54VqNvg2ZRe7216Lfv5cL4yioZpW7Y9xtmW1174TOEC
         1hgL/137m/CYYcxFmJPYXt5HQfyVM4TUwLc7pDlqSUqR1DNXPe7LkIzXP/i1ebipUTtK
         M56eITuvWbKKZGi+RYpi8SuTNIgce38ymK8VJVJv7qT4WDK3zwMSrxLFkcYjfsz8hbFu
         Zvq6h+JAiz50lPBsnrfqDFPffBox6SLhClxLJGs81vNm1nNfTwGKdEL1JvOfxgbjD7f2
         mdfw==
X-Gm-Message-State: AAQBX9eCRG/9N/i/hIQiF5muW044kEjz/Qd74xXOp1gS481kIEfuxY8C
        1O4o/XnUM3FPP2OElt9KJ48ef8DEUGerc8jBgdkNV6hcBZTcdpvd5+A=
X-Google-Smtp-Source: AKy350bdKlWJ3mUZYcfNH5+6kLsgrjcqPufwnq2jGFda8xb8CP+RhVG1NR1ezPFxdvHR+KMEJGITrsU9rzF22PaoKeE=
X-Received: by 2002:a0d:e60b:0:b0:54f:8b56:bb2 with SMTP id
 p11-20020a0de60b000000b0054f8b560bb2mr1413715ywe.9.1682010083088; Thu, 20 Apr
 2023 10:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205631.1956027-1-arnd@kernel.org> <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com> <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
 <d1e719ea-95bf-bb96-62db-e550cefe0a80@linux.alibaba.com> <20230419142159.fd5ca2e91658fe304e317a72@linux-foundation.org>
 <20230420-wetten-aneignen-8324959e629d@brauner>
In-Reply-To: <20230420-wetten-aneignen-8324959e629d@brauner>
From:   Mark Fasheh <mark@fasheh.com>
Date:   Thu, 20 Apr 2023 10:01:12 -0700
Message-ID: <CAGe7X7mLU0JOftGVA+NHabu-9a=fuaofy+KhpvCJFnkRz5ANtQ@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 2:34=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> I think I might not have communicated as clearly as I should have.
> Simply because I naively assumed that this is unproblematic.
>
> By "we" I mean people responsible for "fs/" which now happens to also
> include me. So the goal of this is for patches falling under fs/ to get
> picked up more quickly and broadly and share the maintenance burden.

Did you get buy-in from other folks in 'fs/'? What other projects are
you carrying? Granted I'm a bit out of the loop these days but this is
the first I'm hearing of this.

Andrew has a well oiled machine going, so if he's still ok carrying
the patches then that's where I'd like them until such time that you
can provide a tangible benefit.

Thanks,
   --Mark
