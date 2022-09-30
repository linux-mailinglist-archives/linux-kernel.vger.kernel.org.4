Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03E5F0C49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiI3NPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiI3NO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:14:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C0273
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:14:33 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d1so2780980qvs.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=oFgRdZyIzKVWolCoIOrA7r+gROHxg2hvwwM8mq/xoA8=;
        b=fynPmiUwelr/m/EIEBYGLd0+/ZZqEmonUDocKdKWfN9VgCdY/ctwUpoQA7Km4GTh77
         DFgdSSvHp8BkLhYXBjHFGvp8u271m/N1O4vDMBCafGOZLGuM+GjNMROAUFO4kICJXDNQ
         tyX3z4LQbJXdCLxve7j7JBhJcWtsU3Mg3yfIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oFgRdZyIzKVWolCoIOrA7r+gROHxg2hvwwM8mq/xoA8=;
        b=XYw2MsdRGGZVvoZEs+ILRlB7xw/BCndixWB/1BxeltivPJOUa++M8nLZQWi5F4k4+w
         zlN/rUdrPEEoH+QNul9AOJuEkajdF7v9O+o0uRCktSBS9dEBjYMhmqf2cgu4jhtrVvuT
         4sAjrJTI7E55e+3oGibwd7sveGK4GmI+MOh8yEuH9S6xDvDn7I/IHEgBqyYqb+X3CuqX
         llN7WviRSQsDlVNbDYvWxDwM3NbGI1D4EeuX8mBasG+X1wEFvFW18nSUhk5lm/R3vgRA
         tGSArwkoboSPsjdSDIsnq7Z8y0J2ITWuk/8Sev1I0I6tJ/BTPrLO4ardiujb8ain6IxC
         7oNg==
X-Gm-Message-State: ACrzQf2V78lccg/SfKIds8cICFf/6jIKr0DzNwzzVmKUiT4VEjScc6Ds
        1I5x2PBrO87rTU00oADzPNhKzQ==
X-Google-Smtp-Source: AMsMyM5JHSnNzLmvXtoqsA3uGQqCnC56G/X/6/R6I0q1OOxsb7/cNNgWW9FAHw25ocY+iCTadzIDcQ==
X-Received: by 2002:a05:6214:20e3:b0:4a7:618d:44d8 with SMTP id 3-20020a05621420e300b004a7618d44d8mr6528207qvk.47.1664543672105;
        Fri, 30 Sep 2022 06:14:32 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8764a000000b0031f41ea94easm1953900qtr.28.2022.09.30.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:14:31 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:14:30 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, tools@linux.kernel.org
Subject: b4 prep range-diff (was Re: [PATCH v4 1/5] dt-bindings: mfd:
 qcom-spmi-pmic: Add pm6125 compatible)
Message-ID: <20220930131430.djqv7brsxgkfoebx@meerkat.local>
References: <20220926190148.283805-1-marijn.suijten@somainline.org>
 <20220926190148.283805-2-marijn.suijten@somainline.org>
 <052630d0-299e-e468-b2dd-266d371e2b0f@linaro.org>
 <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
 <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
 <20220928082340.mkn23ersrtzb5oth@SoMainline.org>
 <2bd60261-a977-3225-8d41-4987252e6abb@linaro.org>
 <20220928154437.if3x2zf5yozhy5kt@meerkat.local>
 <20220930123118.nkmajihodvxgqdvw@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930123118.nkmajihodvxgqdvw@SoMainline.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 02:31:18PM +0200, Marijn Suijten wrote:
> > FYI, it can do just that using "b4 trailers -uF [msgid]". See:
> > https://b4.docs.kernel.org/en/stable-0.10.y/contributor/trailers.html
> 
> That's super cool and will save a lot of time.  I'll also have to get
> accustomed to `b4 prep` and `b4 send`, though typically prefer to look
> at the `diff` between two `format-patch` revisions to make sure the
> changelog is complete and no erratic changes made it in.

(Dropping most people from CCs and adding the tools list.)

Hmm... Yes, we can do this, since we keep previously sent revisions tagged in
the tree. Something like:

    b4 prep --compare v3

to show you a range-diff between v3 and the current revision.

-K
