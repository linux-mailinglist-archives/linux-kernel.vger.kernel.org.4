Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69D47355F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjFSLhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:36:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29318C9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:36:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b475b54253so16056251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687174616; x=1689766616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FvbuaaSlDBqWb5lPKsIhoBijmFdvxXqOiBhjtzjptTs=;
        b=GmVrGv8DUt0/UIzYHV7LoaYoTMEobq2qs8xsfKhSEH2CDK/YmxFQxL9p1XYI0p36VO
         2MX0y1ziSurytO3Z8bAAgI9i86qTcDxjUnqs+ml6t7hnFd8iB+s0IDi5T5RdnzVcLWYC
         T99IKNnTy27cVR57dOBvSaibI6oLrx9fumpqKLekyoY5lq9Wrt+nzeRz2DFFAjagZ1qB
         ohFBz/7DXc0jl7cTIYycN5/xNkynU3iAQaBEzd+NeshrxW7JUadykXbpH1y4RszyBZ4H
         aciTdcct4AupyDpm9ZhL0QQSMEGUvdRKUoFMD4i54tVqY4LsM6s+YLhfl7XTOz9yNOgV
         2Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174616; x=1689766616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvbuaaSlDBqWb5lPKsIhoBijmFdvxXqOiBhjtzjptTs=;
        b=VRh9p6/exj0YChggcIofSY9Ptg8QF5anIxDBCDHC2ADc7dGjABlc2XYJJHD0vP7iRl
         vWy4rGOHIy0xTx0U3eU5oJOgPSjcKf3/rJ/50/amJn8wGVOuUSgW/i6TBVN7iyoTce2u
         j7v9Q8DdPAus2bfHeCa7I4HzFzZv/ISJnwRP5M7Jee468YwSgYhKS3MY92b2Rr/bRmin
         NbHG3btVDvknd2mWk4j8bPrhRM9GJ9/4nD1p8fLoor13OnNifLBPFDRBV84f2R97P5l6
         HCKXwf/lj6JnTjyS9zKLbJwj5F42K0kqhV9eV9bjmxOLXseOxYmMranIPLs+KCP4I8s3
         Mcfg==
X-Gm-Message-State: AC+VfDyexTqrI1YvzEEfCiM7829ffytBNkusvgi+rr4amqG4At2Yu7AZ
        HS93A1+xy/48axC2L87ReKSbRGuA5aRH/r/hzrdH0w==
X-Google-Smtp-Source: ACHHUZ75k3RleqyJd/MrNvXKUK57iavnh8cQiGzOQwP95XHmyzUpBB+l0IFLNT4tBG85iWMV90foHUn/Wb39rq92HbE=
X-Received: by 2002:a19:5f07:0:b0:4dd:9f86:859d with SMTP id
 t7-20020a195f07000000b004dd9f86859dmr5082021lfb.13.1687174616231; Mon, 19 Jun
 2023 04:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230619101224.22978-1-chanho.min@lge.com> <CACT4Y+Zn49-6R00buq-y_H0qs=4gBh6PBsJDFBptL8=h6GPQYA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zn49-6R00buq-y_H0qs=4gBh6PBsJDFBptL8=h6GPQYA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 19 Jun 2023 13:36:19 +0200
Message-ID: <CANpmjNMSfVeDa-YC-RQcZ-V=wvHGi43xvXSvaR0GQkEP0OOmOQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix mention for KASAN_HW_TAGS
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Chanho Min <chanho.min@lge.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 at 12:15, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, 19 Jun 2023 at 12:12, Chanho Min <chanho.min@lge.com> wrote:
> >
> > This patch removes description of the KASAN_HW_TAGS's memory consumption.
> > KASAN_HW_TAGS does not set 1/32nd shadow memory.
>
> The hardware still allocates/uses shadow in MTE.
> Though, it may be 1/16-th, not sure.

I think the point is that it depends on the hardware implementation of
MTE. There are a range of possibilities, but enabling KASAN_HW_TAGS
doesn't consume any extra memory for tags itself if the hardware has
to enable MTE and provision tag space via firmware to begin with.

> > Signed-off-by: Chanho Min <chanho.min@lge.com>

I think you just have to be a bit clearer in the commit description,
just briefly mentioning how/where the tag space is allocated in
hardware that do support MTE. Then removing this line is probably
fair, if KASAN_HW_TAGS isn't the direct reason for tag memory being
allocated.
