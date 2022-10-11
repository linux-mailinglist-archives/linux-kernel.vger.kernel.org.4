Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED65FB7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJKP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJKP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:59:08 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084B33E0C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:59:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d64so16317939oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hCRaapQLVmEofLP4NgKlOxU1foJi+Wo9dhzQ90svRlY=;
        b=bnbrdNLdT/bUPd0qhqZflGfE0jb110BVyq5iZfWoFq/M1zGduhnVg/vJ6erAnWFVi0
         deI+RfMqMTmYGZ0mw4be3stcKCcAaUfcgv83ld/iToqMsDm396BrQ2mfKex9UrOAdfUK
         SrZfd/FrkJ56a6s/rHvp0yMLdUHnXhbGrb54vMEOxKPfC+mNZWtoYTWirLlX1x6GBao4
         dcIvEifUKLE/8P4HSRH7XSxJjO2pEjFpxtZUDdJpGHBSDMW2hWpWNKj7TZCa+eCGBQtH
         3zn8vNhkuwuUGFyu3hEyn5xQcLop2mUoPhXPjfze8XTFIRxN+BPqpDdXE1Jdsd0lkOTN
         hdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCRaapQLVmEofLP4NgKlOxU1foJi+Wo9dhzQ90svRlY=;
        b=gfvgCjwcg6MpZZc1BVhYHelqDjb/cnqBgxwIJRCo/LTY8keOAh7kbf5B/BwEne+1pq
         rhnpNpcbiEyTkIQTL7Ob5uBRHf4c9boZ/D0InW+3iS0Ux8yXhYJd+SIc/SpKwY23QLZw
         ybX/2l5TelSu+i+yDqSVpOvlc6kzjT9ZCm/9nhxA6MctYTPEmG6Us9fxNoICaThHwF4y
         fLOLHhcnTDDCKDEbsIL74uoqmQTMhvKC18djnio3+Qfud99ewFkB3rVgwriCcKIlE1k1
         T07GIefhdNsgxn6MyZiiFXc9wGF2QZCF0Kp1UWtiTsBCwkD1nu7WczSQUFoJF80+vCRV
         aRVA==
X-Gm-Message-State: ACrzQf3K7vO6ClXRPGDsrqmPwMgTTxQ372jpKp+xEYq0yrLUyXR/xdgp
        AuKNXSkPyfOPqzDFDbLiLV8bZjJ/CXavuZsUdHk=
X-Google-Smtp-Source: AMsMyM7bwOho1qC7OTbxH6DCCxTstEkqnH7nzwHY1xa44J0GzA+KA77eabXicN9UxDao65ssP4ZBPY2SB3/kE+Q7qFE=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr1202719oiw.96.1665503946454; Tue, 11
 Oct 2022 08:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221010073803.88244-1-yang.lee@linux.alibaba.com> <41663e73-6eb6-3624-7e7e-661745a72193@amd.com>
In-Reply-To: <41663e73-6eb6-3624-7e7e-661745a72193@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 Oct 2022 11:58:54 -0400
Message-ID: <CADnq5_My7KXYqQ1SrGqK2nj4P67NUh1hoYD+C+BngRJNC9YcCg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Simplify bool conversion
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, alexander.deucher@amd.com,
        sunpeng.li@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
        Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Oct 11, 2022 at 11:27 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-10-10 03:38, Yang Li wrote:
> > The result of 'pwr_status == 0' is Boolean, and the question mark
> > expression is redundant.
> >
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2354
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > index 955ca273cfe1..cbda458bf040 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > @@ -1401,7 +1401,7 @@ bool dcn32_dsc_pg_status(
> >               break;
> >       }
> >
> > -     return pwr_status == 0 ? true : false;
> > +     return pwr_status == 0;
> >  }
> >
> >  void dcn32_update_dsc_pg(struct dc *dc,
>
