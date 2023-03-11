Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951816B5A07
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCKJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCKJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:22:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA48B5BDBD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:21:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g3so7158625wri.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678526482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UEFJUf/50XPFbZEbBNrHNelwsNaADqXuPbC30RmvYQ=;
        b=g/ZsSoibFZdSKaHfzXOViB3vtB61x6tuHDtI9yXxIdNkrPofn4FGnLgiHOybo8L0sy
         mceXXWdzVsgBjjNs8ben4OHGwaF5xMgctEC1JA0MAhRA7345mHy2CzGZNWzLBaoft9yi
         nYhUI+dAFek2sLzyDv56pfweGsN7Bvbgk13oxUqMiijhEJ1+IqpF7XKkIAhjkPdGHo3R
         rk77YIk3/t7IXwOEsB12xD04NIzuQ1aRrTWhPVNNyAapShlSUThLMigGNhhcthij/ddL
         aoy8QniqhC/cQm9/aAcORfuTzv/y8JHA0LpAJjCQeW8nOmnSz+7+aih/YddoqfrQQBE6
         Mmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678526482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UEFJUf/50XPFbZEbBNrHNelwsNaADqXuPbC30RmvYQ=;
        b=3f6RjkU8Uy/6KFBynn43hYbUcplQUHkdVtC0zZRFG5OqZJz36BA2Mf//Y9UrtCAnzE
         zkVdhrWJFxlWFqpq2vk5XqtAh8Xp8i2d2c9bOaUdsb4lc58w/0GgAkagPoPLLJb3wGWj
         5FAKDKzwOFJJXQseySuTGTDnU78+O23f3lHeUVqwfJ0TmcC7tXSuj8z2iS2DAp2cDUTN
         QFnD3zjqz6t+0TVmVarfqEWZm+11XhF6i7wkQsZNiTy61FQU6h4YZtiARrBrGh2CBfuA
         q6YQSvhlWP/us87DNqjqrnLFxNWEk4W2hBZZ2LYhr1rMwND/2+NIncU6b8rEaL6IEsgX
         Wr7A==
X-Gm-Message-State: AO0yUKWUzdxmllj4fGtowvYAIBNuGq4wTKYfz0pE9JSvjEsjoRhvqIUQ
        2MQxvbipqjUjz3UhWmOUp0NHd3UKCFXa8nlg
X-Google-Smtp-Source: AK7set+t2FM614grpTygcTYixhja40uodoYHqbuI6lhG5n5TuBSgKsfYCR87cgp1yI6dgos0nf7FJg==
X-Received: by 2002:a5d:5447:0:b0:2c7:a55:bef2 with SMTP id w7-20020a5d5447000000b002c70a55bef2mr15780331wrv.46.1678526481777;
        Sat, 11 Mar 2023 01:21:21 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id a14-20020adffb8e000000b002c561805a4csm1974358wrr.45.2023.03.11.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 01:21:21 -0800 (PST)
Date:   Sat, 11 Mar 2023 14:21:18 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <ZAxIDlfL/+n4Pkyo@khadija-virtual-machine>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
 <alpine.DEB.2.22.394.2303062202500.3050@hadrien>
 <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
 <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
 <CACcTnM4OHFiGrEez6dMzd4jO4YuQZzqpUK86UBMzhd+nFDWezA@mail.gmail.com>
 <e06f57e6-2a3a-7fde-742d-9d5dd8dd49b0@inria.fr>
 <ZAtUVBbyMw7ine2e@khadija-virtual-machine>
 <alpine.DEB.2.22.394.2303110954590.2802@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2303110954590.2802@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 09:56:06AM +0100, Julia Lawall wrote:
> 
> 
> On Fri, 10 Mar 2023, Khadija Kamran wrote:
> 
> > On Tue, Mar 07, 2023 at 09:13:49AM +0100, Julia Lawall wrote:
> > > There are actually two similar issues in axis-fifo.c.  You could fix them
> > > both at once.
> >
> > Hey Julia!
> > I have a question. Should I send the two fixes as a patchset of two
> > patches, and should I send it as [PATCH v2]?
> > Thank you.
> 
> The two issues in axis-fifo.c are very similar.  They could be in a single
> patch.  And that patch could be the v2 of your previous patch.  Just note
> that you have fixed another instance of the same problem in the message
> under the ---.
> 
> julia

Thank you Julia!
I am sorry about sending another patch before this one got fixed. I
misundertood and wrongly assumed that someone else had fixed it already.
Sorry about the confusion.
