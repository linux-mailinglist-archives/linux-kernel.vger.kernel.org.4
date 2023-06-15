Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE9731813
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbjFOMDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFOMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:02:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DA4493
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:58:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25c101bf7deso2298148a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686830329; x=1689422329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNHs/NR0g3CX4rW6Ho5JPY5yd2snM7LkZeKUoyaN2ks=;
        b=WV1XjiHElJw1Dt3NqHZK44RMlOQSXYmk9mEYfzgObb3VsK8oAGUb+OAM2MLVaU/tg5
         G12vn9VD7ij3vcUmK9wtMNlp19C8vMlDfkHAdmGbI5YMONVbhGcoLpUvuaoRh7kF6PNv
         A9UoEHfRvVPVitjoMsuGncjnAgkyACv525U31JYBkMmqLXMnEZOhxNI4pYU6RZHmPAPZ
         LHPdfQ+b1e+Y/Q5lQ4p+kstmmpl+B13kTv/ai8ePLcHL997uUqAmbOoULuIuHiW7vqRs
         opzj5nFbzlgGlKw6+IbURjL+8S0ZuwCUtZl5eLxeMSBDX+DqSM1Yeyn7O0veq6KqDhQs
         zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686830329; x=1689422329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNHs/NR0g3CX4rW6Ho5JPY5yd2snM7LkZeKUoyaN2ks=;
        b=Phb4QBoRJfSmbUYLAwZuswDyqB0lfZ/G7I1PHoUgm4dyDIyUOiETCG4ySWX4YKnmvR
         5R0uKUHYFYxE0FvXLz7DHMWakvR9ilybbvRXbtDiPpbQXdVHaI+j+oWjvf11eZrHPSs5
         h2RkATOi3eIg0uBIJ2X5Sum9X3MpF0Tm2a5Yl75wDwAnQCFCUPO+OyqczWB8QKNYNOrS
         x+QiW/8qSYjdd6dtpUJFfh1wSEExgFaaWWeQgco8OUz+XywFMLfRQc0g73cR15cphsEA
         1Rc2En1RZcy7QQx+4WE5kUfrjTphBHxt7ydU/0QsJAkOIxO6lN1lWrnlYW1jPX3Rc8+J
         ewEg==
X-Gm-Message-State: AC+VfDxay8RkoqCkWRraBZ+IRY9EX8oWN37FtGqG/eEHvdMNKp4hQ168
        PoyCszBgi4a29YYPpzUqtMGXHy0yQMfcEs4ZYsNRTg==
X-Google-Smtp-Source: ACHHUZ7H84huBYjF2DEKDb9mSSjBrZREUPgUPr4YGUukPXUxSgt0KbpwnJnKEx26CCSb63p91mc7xHdbX27D8ZU26X0=
X-Received: by 2002:a17:90a:804a:b0:25c:7f2:2e5d with SMTP id
 e10-20020a17090a804a00b0025c07f22e5dmr4083701pjw.13.1686830329333; Thu, 15
 Jun 2023 04:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com> <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
In-Reply-To: <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 19:58:37 +0800
Message-ID: <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi michal,  glad to hear from you.

> I am not really deeply familiar with zram implementation nor usage but
> how is the above allocation going to be charged without __GFP_ACCOUNT in
> the gfp mask?

Yes=EF=BC=8Czs_malloc() did not charge compressed memory, even if we add th=
is gfp.
so we need to implement this function in this patchset. But this flag shoul=
d be
used to enable this feature.

> Also what exactly is going to happen for the swap backed by the zram
> device? Your memcg might be hitting the hard limit and therefore
> swapping out. Wouldn't zs_malloc fail very likely under that condition
> making the swap effectively unusable?

This is the key point, as i said above, zs_malloc() did not charge
compressed memory,
so zs_malloc will not fail under that condition. if the zram swap is
large enough, zs_malloc
never fails unless system OOM.   so memory.max will be invalidated.


> --
> Michal Hocko
> SUSE Labs
