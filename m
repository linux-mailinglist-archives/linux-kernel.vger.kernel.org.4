Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAF5BFC24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIUKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIUKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:18:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD78F954
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:18:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so5150851plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=CheM2RfPoPlkSbVJu5LyCMgu7Hxu4K9Qy8tFdBeZziE=;
        b=lE6RKJ/6d5j9WD3Bf7aQt0+g8nUKbtlwo8YoMaqAJOQpRfR9TFCOfYE/rjfkOkUFIK
         97MA8ZRTvIFljvKQH7/2SIiIK4kznsOrzPyeWQ3pN3+Nw9VngSg8L/qNDlP9ZOJBg8sI
         hwC3tQtLGYkvfhjFUfNabMk5rk0OdLBcyweJvBZsqoFeOp44mfkkClhNiJtUmzbmN6U8
         Qo/sRgj9yJlrqzd6IyxTgO0DUtfnU+zrias77DMpe5r2VXf7yqxQtNVVINLtBNFKuYJk
         PFGGKjWCoPSYLfRdUlYeFZTSyZvdOAllvRSJD8StCDXG39O5g7dPzHNopPKo5zy/7iw/
         TNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CheM2RfPoPlkSbVJu5LyCMgu7Hxu4K9Qy8tFdBeZziE=;
        b=nloggM8OH9g41DFMFnd39yGO6UilX5x7z2LAcf1ekys/jpLi+l85guhyarrJwh4Gr2
         i7gxuSbhANLz4njmmt9d4faHU8jtaoxOfuUCEFsYW1uNCwwywwV4ZRls3CWEwLfmvyRX
         fv7pBiS46S8BRNK9MFb1LrmMvJlJU+7ml+JPMQcKBqePzJ/x2oZP+T5A2eHzntyaJMCR
         GyCnPldtGEDRmf2LUmwrHiPbQ82Mc4UJ0x37zoByJnWhQuWO8sCFZezZSA0QfwNAElVa
         DHFzHeysgvpGaTNecSnNgGYAhvB0klvI3hlrwOgvvBrODdxMcyoDU5Q4AF2MT2m0GWxp
         77tw==
X-Gm-Message-State: ACrzQf1R2lKMkdG8VV3GWcGWu4uX24lNsulOX1tKisjQJx/wJkUxs7Wb
        agl5irTYWBYjd41gfcZVeIlPrn6Lx3jKaDnQz8Q=
X-Google-Smtp-Source: AMsMyM7PrLkUt2hpjb7E2cbflLdAyHHy+sHo9oxeKkRu7GQXr+RyTdWAQASJ66ohe6Od4iHggX91FPbJVScVkovuAFA=
X-Received: by 2002:a17:902:f782:b0:173:1206:cee0 with SMTP id
 q2-20020a170902f78200b001731206cee0mr3996984pln.130.1663755490047; Wed, 21
 Sep 2022 03:18:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:4f20:b0:96:8c3c:e824 with HTTP; Wed, 21 Sep 2022
 03:18:09 -0700 (PDT)
Reply-To: brunoso@currently.com
From:   Annah <woalbou@gmail.com>
Date:   Wed, 21 Sep 2022 10:18:09 +0000
Message-ID: <CADZJH_W9gi5PO=ygN1QcAvEQFdU0RxJF165cWsnYPTc8y0z4Bg@mail.gmail.com>
Subject: Please Help me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sincerely,

Please exercise a little patience and read through my letter. I feel
quite safe dealing with you
I will really like to have a good relationship with you and I have a
special reason why I decided to contact you.

Due to the urgency of my situation, my name is Miss. Annah Saitoti, a
21 years old female I'm from Kenya in East Africa.

My step-mother has threatened to kill me because of my inheritance
($10.6 Million Dollars), please reply ( brunoso@currently.com ) and I
will explain all to you.

Your Sincerely
Annah Saitoti
