Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1ED6DFD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDLSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDLSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:24:43 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9ED40F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:24:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v9-20020a05683024a900b006a42896c456so936183ots.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681323882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VezbKOf2ys8mmlrW6/XtyNOzwlQ4f87v3oaLK1/JLPM=;
        b=MKMmL4qsxYweKgbBB8dZXQi1smZzm0GDc189NTjo11JN2ANzLN30asgL0PsSjobj98
         ZxF8tZYGp5md2wpMol9mZsLAm1pcYoTl9OQl/STRTATgbygj+M+t0on8MSi2UPplq/Ze
         jqqtVG0YW07aRRlYzeF/bu5RtDnrWc/MldeaZStwdz3vGEPCYSuEWd4Nkh0pRcrdZB4q
         hK9rxct2rIWOvChr7iAPe8Gzxy9j6QZT/nC/bByo/iZAExQA0iogpaIB4IQUahrr0x14
         KRpZayB70+dPEgYiCkAbV8r2ldkXR1+Nc3diuC21RMhL4twCHV7vZU3eB68ME1v+mxVZ
         /How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VezbKOf2ys8mmlrW6/XtyNOzwlQ4f87v3oaLK1/JLPM=;
        b=JOwSffV8pYSAMkfBciOJoa/lvbdwKKJyE4c+4o8psbgBmbWox19+n2DfF1K4JHKl0A
         s2eCXFRJS7yOO9JL4l0ZW3Kfmx4MLwb91xmiH8NK1BIQK10Pjx9TK/KcuaUV2eYnkqM/
         5WsMHPWis8/GHNR+O7YYtrKLoWdK1j2C6n/zZEoKhhw77W90FEmVYIk8do+WrgI3m4W4
         NLl7VizuRVC3HURqg5sHIO/2IqK2rZ798Vw4KFrVhF8hc0SASC51YFBv2kB1uygG+Erf
         wpz18vSiSrTDnrdg5nhnXtVHB3GjZt0oZIYOiwuIpBICqxFQTKSJDZXc/nZ7Eaw7r8GE
         tobA==
X-Gm-Message-State: AAQBX9dX0zCtdqQI+UbksmmhR6JpL6rGIR6bozLqHw7XQJKbqCsxVnFc
        muhfh4mkWavnH4+tzgC7uWfjE61BXDbpRnfr54E=
X-Google-Smtp-Source: AKy350agXQoqrStNoK+a4M8juveptTO6TX1XHMLicnMICjI9Slx/36oQxmNLKwpInNOMiOLDOrh8u7xkHp4jdFrZPnA=
X-Received: by 2002:a05:6830:114e:b0:6a1:3fd6:5a0b with SMTP id
 x14-20020a056830114e00b006a13fd65a0bmr4189583otq.2.1681323882121; Wed, 12 Apr
 2023 11:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com>
 <CAG_fn=V57m0om5HUHHFOQr9R9TWHtfm4+jO96Smf+Q+XjRkxtQ@mail.gmail.com>
In-Reply-To: <CAG_fn=V57m0om5HUHHFOQr9R9TWHtfm4+jO96Smf+Q+XjRkxtQ@mail.gmail.com>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Wed, 12 Apr 2023 11:24:31 -0700
Message-ID: <CANX2M5bWPMDJGgD=xq33A3p96ii3wBOuy9UKYAstX4psdAGrrA@mail.gmail.com>
Subject: Re: Possible incorrect handling of fault injection inside KMSAN instrumentation
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
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

On Wed, Apr 12, 2023 at 7:39=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:

> Here are two patches that fix the problem:
>  - https://github.com/google/kmsan/commit/b793a6d5a1c1258326b0f53d6e3ac8a=
a3eeb3499
> - for kmsan_vmap_pages_range_noflush();
>  - https://github.com/google/kmsan/commit/cb9e33e0cd7ff735bc302ff69c02274=
f24060cff
> - for kmsan_ioremap_page_range()
>
> Can you please try them out?

The second patch needs a small modification.

The return value of `__vmap_pages_range_noflush` at Line 181
(https://github.com/google/kmsan/commit/cb9e33e0cd7ff735bc302ff69c02274f240=
60cff#diff-6c23520766ef70571c16b74ed93474716645c7ba81dc07028c076b6fd5ad2731=
R181)
should also be assigned to `mapped`. With this modification, the patch
works.

--=20
Thanks and Regards,

Dipanjan
