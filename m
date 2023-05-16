Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B54705051
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjEPOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjEPOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:15:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7777EFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:15:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7577ef2fa31so276487085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1684246502; x=1686838502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MjmWo+hCpEtivWOwri7/iADoZ8E9ycZlQARPYEOsBeY=;
        b=afSUZJeraE4UXuA9KVN1ySJjEKq3ywhpoGJL+kSOCkxHroh8Tts50u/trVlmLUkGuw
         fxZEtbMs0Pf2xg7vQ1t4106ZLILJpzhQ879/C96SPU7fZ42mBXATWzkj3KYOvO1J5/Tu
         j3eanUCd5R6IaQrESgZJaf67f44HQts2P2zwTns2bqxbOQzj+b+0ZaTySHMTwAA7Fmzh
         DYlPGfIbtSI3AzxuPALs84Akj50j4lLLfkWugNfAvYgWeajKxA/vLM5NEvkJ++mMS7pq
         4lkHnv+onGhYmjsbQNlZOuk0rUzPs48NMzSTFjQl70O+nqNkWJKOzIPF3UPK/+IRKSFK
         1wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246502; x=1686838502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjmWo+hCpEtivWOwri7/iADoZ8E9ycZlQARPYEOsBeY=;
        b=BXhaAUMPrH2c70GMkwPvSc3HwADN5XFLsmRjA+/2KYUZQoB2AMkPSBDjdpnAnA7Ksc
         XI1FneDch+kJt5V9P/8Y8zAZxLk9cfzu2m2/gljeBQWY8s+CwRfLNZMgjHBAHOBQmy9k
         uxakMuPkCPRaw/BkZWzBb6iKMHNZcvBduk4DbnlgN6S4nZdNzjB446R5Xph9Idb8iIVJ
         /epTk9SfD/f4HRrlcLezel5xnyU1YG5vy44kqxoCbLcxoUYvmXScWw++1x+ONN3rsKmc
         ylk5fwyz5qgzaK1K9xjbDAQ1iNPI03pJBvPUFwYGsJlQfIZampiAjP5asD6x+oWvmsqv
         f8Jg==
X-Gm-Message-State: AC+VfDwH5wPZi5Vpl30xfcy4toE1kAJNA42msZqYLg23U8eqrC6f1Z6D
        LVlGmqLuTc0q/msFvvK1JrvWPTB8cwN5gcWJvsXJy1vnitPNCqOF
X-Google-Smtp-Source: ACHHUZ57FJsfJFFk4qJNOuOhjLPxnKXdzMSpLYiGr7X8IDSjhV+PkeEn4XFSMuguWShJVzNJ1+1AdvhqFy+Uf+Vr+4o=
X-Received: by 2002:ac8:7d10:0:b0:3f5:2582:65db with SMTP id
 g16-20020ac87d10000000b003f5258265dbmr15289020qtb.29.1684246502695; Tue, 16
 May 2023 07:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130958.32471-1-lrh2000@pku.edu.cn> <20230515130958.32471-5-lrh2000@pku.edu.cn>
 <CA+CK2bBD_fdmz1fFjB8MXBGMHf4jzRWeBRirH3HdWRLqY7cmtw@mail.gmail.com>
 <mgnjfbklr6ew7p4utamdidrvdtchaazovfuduaabplwtpq3se2@uamamaee3rlk> <c60d3aa9-f8cd-6c78-3004-8017d7c95443@redhat.com>
In-Reply-To: <c60d3aa9-f8cd-6c78-3004-8017d7c95443@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 16 May 2023 10:14:26 -0400
Message-ID: <CA+CK2bAcnEm+2mUM0EbkeDZzRSS8qUWzi0nQhnHpb9+=b1Sf-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm: page_table_check: Ensure user pages are not
 slab pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >>
> >> I would also update order in mm/memory.c
> >> static int validate_page_before_insert(struct page *page)
> >> {
> >> if (PageAnon(page) || PageSlab(page) || page_has_type(page))
> >>
> >> It is not strictly a bug there, as it works by accident, but
> >> PageSlab() should go before PageAnon(), because without checking if
> >> this is PageSlab() we should not be testing for PageAnon().
> >
> > Right. Perhaps it would be better to send another patch for this
> > separately.

Yes, as a separate from this series patch would work.

>
> Probably not really worth it IMHO. With PageSlab() we might have
> PageAnon() false-positives. Either will take the same path here ...

That is correct, it works by accident, but it is not a good idea to
keep a broken logic at least because it may be copied into other
places.
