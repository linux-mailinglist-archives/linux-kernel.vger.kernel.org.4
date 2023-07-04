Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF0747671
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGDQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGDQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:25:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83EDC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:25:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4357619f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688487919; x=1691079919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6XAzfa0AL030g6ifAQiJNhROl73dItLhZ+SNNO+bSGo=;
        b=VNMb8hDTHQXgh27fMtSJDQaeKeXo3N7ViDpsJ5PBXLnNdzgOKZArhJrwA1Slk8yqUA
         GQYqYWcE4BMYxLER1YY4d2qDLQu6jTL3GlCPvUUhdaPLaSfNXPmZvA/kDy9h511YrSQS
         fF+7GwJJBxCWRvdB089x38q1phL/ZToCIG7B1Z07V5KHMk2Sb9ZEYJM8IGzUiMw9gIv+
         yVtxK8rJnnnzxko8gjy23QBroBb4FfyGkwUYYCinhm8bC7KP9C3aX8oR9Iy8Q1mHoY3l
         rKNyTTX3c5jVFKyMx8yyEfcJ8pQqLfp7KBebAsJ3WtBycC+hKt6KsJ6QLBchY9045qp2
         F6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487919; x=1691079919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XAzfa0AL030g6ifAQiJNhROl73dItLhZ+SNNO+bSGo=;
        b=Ut2QwtKHRX9lxPuk/G6kowsfwFPelXofqMkUI+1MXGGRBf6lIAvN1XdH2udNfnkS7a
         5d5fOQLivjxihr1uhxxpvMHv/ZaDVwZ+GtkElu+fEbrhaPMuNEHQzF2+uhoF8SCV8A03
         tlLRr28V3GO4Wpyk++Wvxao+48ucAmLDZ3fp3L+j3dXSP3Q+RH0L4Mv3+mfFT1vn/N6m
         ONhBJ8lB0eij1/3oXNNhNhAEdqUGGPYavd8m2uVyrJeOoxlg3AMie6+2ds33um2/aJd/
         9dLApokqSz6djMn9+p4tefNtRsyKxVqk4Hg58Mq/E5HtQq+sgiBEhVYUMOi3AbYxtFXW
         FM4Q==
X-Gm-Message-State: ABy/qLaQYHwb03sp7g78PBOirquLjVjs/9m50ACymqA7np1CvVV/FPtw
        qpkfMxZtYvbfvT6Zt9kVjE5RZr4V7gORRH26FAkUbC/f2+VqVzo1
X-Google-Smtp-Source: APBJJlEkQ5vFgoXajAJ707PhJuPueGtz/EMKGz5jRQugQFGun91qTlVMP/vZg8ekFg9YvhbfvovbRxgek2RRpQw+NnA=
X-Received: by 2002:a5d:6305:0:b0:314:1e86:e75d with SMTP id
 i5-20020a5d6305000000b003141e86e75dmr10993197wru.34.1688487918688; Tue, 04
 Jul 2023 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230627152449.36093-1-dg573847474@gmail.com> <ZJwd0UDKYcK9AvSf@mail.minyard.net>
 <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com> <ZKQsY3DXXDbxy0om@mail.minyard.net>
In-Reply-To: <ZKQsY3DXXDbxy0om@mail.minyard.net>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 00:25:07 +0800
Message-ID: <CAAo+4rW8uNf14BQYYYH3oiymSv=tSo5iBnPaaeefJWWif46mXA@mail.gmail.com>
Subject: Re: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
To:     minyard@acm.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks so much for the reply!

> Will this tool be available for general use?  It's obviously quite
> handy.

And also thanks for your interest! I am still optimizing the tool, so far
it still can report some false positives in some cases and require a certain
effort of manual checking. Would let you know once I finish my work and
open-source it later!

Best Regards,
Chengfeng
