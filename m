Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1A731AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjFOONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbjFOONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:13:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFA2684
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:13:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b505665e2fso6300205ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686838401; x=1689430401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA+sOdkXeaOqtYM+9HbR7PDD/Pvr8QBb+Sns/mm9TKc=;
        b=W48NsgGYazSmdCr22LoO9vupuH0SLC4lcoPV5+3nWkkfH4oTHyezaIZdB9qkan3Qz1
         ESUg2iTOq1UFlsZTCPtp7uekNSnfi+XP/b3tItwy6x7hkpXuycvoO/Nqwo3xSKQ1nzw0
         sZhrU+pbuCRNKeW3nzegf434xR3xGsK/00gmhosPUBZyWI/bjSc5kM8UiDyeahnIgy69
         WGqCrTXEkaITcWExAlVInrzcqZdul6NhcT5FHcM5wbUNE0kDO4JcHkiAWOaAPaxyTJ2F
         uXi1pkS2o/itBwxD60aNH/FAIEOwqfvzjB+iVlXEQvd5xYM+E3KEyFgn5IA2mWtl28rf
         QSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838401; x=1689430401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GA+sOdkXeaOqtYM+9HbR7PDD/Pvr8QBb+Sns/mm9TKc=;
        b=iKnhAv/jhtyf6Rfh7BlWhFj5MOr5h7lHZEJu2bqVoOrFaNHLRbDITqG4kaLINaXI5v
         nkPU85G5dp8x6a3ViY2FfXFyOyMhScE+JuWEGkRW5GBSbzSFKeHldTQEO9qQmeGjEQgs
         ipQZVUK6CcBFBwle/AzxJYtwhjnxcrCf8wtXd5OH9wUi2VBCCJlXfJdNFwWTuuAxLmFh
         L6euSkWKegMbx01r2OdTQjwfR4bKRZQaXxp3rBMr4MoAjUpHPsr/tvqnKGrhnNE56kfs
         vFpzHMToV+SZc+fxrOmRIAkkbdfZ1eK50+GVg8/7yVQHIwwTtap4rcxYUkV4EcUq/NFo
         mv5g==
X-Gm-Message-State: AC+VfDzTmA32MTSaGPQH/t+2t3unnLJTzjRaPkFjAMcLmugbDO5WxIDn
        7apMu1a/LUGJ74wS3Rz6jpi90r66nGUa9SUSMQXWzQ==
X-Google-Smtp-Source: ACHHUZ6GN/5aYk1XQT5drKDtzSEXs/CSKlLgNbJdbrIOJnExeJF5me6e5NorAz94rA60cZpxIq0U3pU2Eyu/6+7cMA4=
X-Received: by 2002:a17:90b:158e:b0:25e:6196:ff96 with SMTP id
 lc14-20020a17090b158e00b0025e6196ff96mr5697721pjb.12.1686838400794; Thu, 15
 Jun 2023 07:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz> <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz> <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
 <ZIsR09IkLquV72dj@dhcp22.suse.cz>
In-Reply-To: <ZIsR09IkLquV72dj@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 22:13:09 +0800
Message-ID: <CACSyD1P19kxERKPUAVChjy7AzV6h6RKTV8252ntoK5EUy8uC2A@mail.gmail.com>
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

>
> OK, also make sure that the zsmalloc support is implemented before zram
> depends on it.
>

OK. I got it.

>
> This is not really answering my question though. memcg under hard limit
> is not really my concern. This is a simpler case. I am not saying it
> doesn't need to get addresses but it is the memcg hard limited case that
> is much more interested. Because your charges are going to fail very
> likely and that would mean that swapout would fail AFAIU. If my
> understanding is wrong then it would really help to describe that case
> much more in the changelog.
>

OK, Got it. In many cases I have tested, it  will not fail because we did
not charge the page directly=EF=BC=8Cbut the objects(like  slab,compressed =
page),
for the zspage may be shared by any memcg.

> --
> Michal Hocko
> SUSE Labs
