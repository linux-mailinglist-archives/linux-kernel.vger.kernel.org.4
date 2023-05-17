Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F4706500
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjEQKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjEQKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:19:14 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9943A80
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:19:12 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-77d53b41485so216078241.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684318751; x=1686910751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrHrY3AWtq70CRoLtNhxsvgCg243JPmz7/kyzBYJpQA=;
        b=gx73QOkq3byJIA/Bb/mmsN9l7Oz6EDJzEum6sbZ3Du/ESMpCrjyioyH0N9FWcwijXM
         +NyJZyziL7HGeGgIkhmTVFF0Qxb40NcFuFoneKGdSAjo/1DnKBfOyuTM4rRaYqLJGq7c
         QIWiNpi/sxFZ5zHKF245m3qOEb4GeX48lYZ0jZ3ToNt2qfbLERFcdBQpsOuXB971LJJ7
         gl2zBEpZdKtjmNHs5ZJTLJdlRa86JMIdfwyOCHNDFpkxpKv9op0twjBO9rBNxlovc578
         foz1HwAK7hRLdoQVMoQIhAwfd/88fHF1+KlE0VSxD4KtH6Mjwt29JraZjX23m7C0xtsb
         xSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684318751; x=1686910751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrHrY3AWtq70CRoLtNhxsvgCg243JPmz7/kyzBYJpQA=;
        b=Be3Vpga/FnPTrQ6y41ITqJLDlwMA5waxkQznhDfqCmZi5Dp9f6WTQ1+v46xQMkFS3B
         Iy+kyCD9P8CovoJsrN8qMPIXOhp4Dk3owZj02ANIWLtEG2dRLVyu8/WELV3FVfrzyM05
         uRwLMYFgsQ/bEtIRshxDDF5lo5CIisI9K+FyXbiskM73b2ZSMAdXGgTYKc1frrRV53VI
         9XK+vl5aKCo03Yy0VW8X77IxDdxWSdzz6ytISvx6gfLWOHFquSoRdKs8cv5Gwbwj5u0S
         12syVUSlrnwCHhKtvVZtDeO/RSQD32WJyaOj3pAd5w3nePWcvah+hRgfFiLaned3M2Dh
         gBkg==
X-Gm-Message-State: AC+VfDz3i3lyC7YiNRwKNbGRLC8C86eZhw3sa/OIE7QNfqMOw1DivKNQ
        1GeaZAJlciqOdGhtqyvuktHS4zyS+M4RflM9wXalZQ==
X-Google-Smtp-Source: ACHHUZ5Mb/NeiO/iDJb+RFsGn+oHgCv/thgz5utXRC5vjJkVkqjaX/1mVMnKg6tlXR15pAZMUKKT+mZqUv4DrifFGrs=
X-Received: by 2002:a67:f94b:0:b0:436:5a8b:14e0 with SMTP id
 u11-20020a67f94b000000b004365a8b14e0mr4386138vsq.26.1684318751690; Wed, 17
 May 2023 03:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org> <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org> <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
In-Reply-To: <ZGSgCZrg+RjAbGO1@infradead.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 May 2023 15:49:00 +0530
Message-ID: <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
To:     Christoph Hellwig <hch@infradead.org>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 15:06, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
> > Do you mean a pinned user-space page can be paged out automatically?
>
> No, pinned pages can't be paged out.
>
> But a short term pin implies it will be release after a short delay,
> and it is feasible for wait for the pin to go away.

Okay, I see. I would be interested to know the ranges for that short
delay. I guess it may depend on how much memory pressure there is...

>
> For a long term pin waiting is not an option, and anyone wanting to
> do something with the pinned page that requires it to not be pinned
> must simply give up.
>
> > Just FYI, the underlying use-case for TEE registered shared memory is
> > that the references to pinned pages are provided to TEE implementation
> > to operate upon. This can happen over multiple syscalls and we want
> > the pinned pages to be always in RAM as otherwise the physical
> > addresses may change if they are paged out in between.
>
> That's a very use clear case for a long term pin.

...however, thanks for the insights.

@Xiaoming,

Please use the following fixes tag for the v2 along with extending the
commit description regarding the reliability provided by the long term
flag.

Fixes: 033ddf12bcf5 ("tee: add register user memory")

-Sumit
