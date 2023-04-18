Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A99F6E6A17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjDRQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDRQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:47:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2586413F8C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:47:01 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fbee98814so217398677b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681836365; x=1684428365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZRNuvpYmPgzgb9JaiuV4RW67h1IFb6pBTSO2dSAGgo=;
        b=loJ4tD9iiALqUaEHCxhFD8la/Ru1P2vdaO01NY952pB9j7EY1MsStuiIpdNY2xyAkW
         wL7q/GWJewpwMcjGkha03Id+jx2b9ZtYwazICqiRcN77gaQfx04hN6mHP2m1zrjuICeU
         YTfylyXSbMyvInRKZqOvfP/CaebhW3mumg1mTEANRaIXsvXhArUCd6qTPHiLEywTfUVY
         VMFiDFD4MvAXmIU5um1e4Pr+qWAoRuhVgNBTPNyc4w7rlYFYm8Yb+0mIFOrKfutyXsSL
         eiy9Onsd77b+w9C5WwW649m4U/md9JSf5BstPb91liW/a0aKnkAOTnjW6vMZEBGbQUSU
         nBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681836365; x=1684428365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZRNuvpYmPgzgb9JaiuV4RW67h1IFb6pBTSO2dSAGgo=;
        b=Rk+ug9h35RwYtgTeAxFNd9MGFl8pVNIFZVLVd+0hlxvRiYX+4eyYvad5vWTuCMY0XX
         iTwWYHVUajGKvPyNhSueztQsYg4h5oqXXD5q/UrIqRnjljzslggJXMXJ68yHNDEslOkT
         Goai5130h5sMwCXGfuNDVBkrZ9fhXxK1VRkxmKhPXjy8CCEJ394Y7QoFeGEHu/7lQCsa
         fn5ltcdXg4Q1IVa2CdxG2k/6YBSKijLag7AYubfGQC1BuOODGe5Z+KEegeYsHnyk5/vZ
         YzFu4TCCJ4NcVfOiao0tbJmnNb1MJob7k1rzbrOZmmL9ct5hOU02M0dUmD7wmj4kadHa
         /uvg==
X-Gm-Message-State: AAQBX9dNH3qLH0lzeTmrZz8blp8PYb/Z/DurFgZMc2pNVMVpMZP54oh6
        lQcrtsVlKd4B0sUYUjOmpp/f8KJtoXpAEWXk5QRMgQ==
X-Google-Smtp-Source: AKy350YCN/tqF7xIynM64BgwzU0KY90HxtWs+ncREDH+yXnMl7ZR4q58AvQ8wuLAlA6V2PT6J9UGrOIExj7k0egOkfA=
X-Received: by 2002:a81:af08:0:b0:54f:9e1b:971c with SMTP id
 n8-20020a81af08000000b0054f9e1b971cmr305886ywh.1.1681836363269; Tue, 18 Apr
 2023 09:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD25bBPbZYSb7grA@x1n>
 <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
 <ZD61DLJNilUeDCnC@x1n> <ZD64C3R6BzqpSfYX@casper.infradead.org> <ZD672ewd4j/1v2IQ@x1n>
In-Reply-To: <ZD672ewd4j/1v2IQ@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Apr 2023 09:45:52 -0700
Message-ID: <CAJuCfpGuF_kKXMSx2bHNC7FprOfqbCp+cfdsoct9sN=1+wqtAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 18, 2023 at 8:48=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 18, 2023 at 04:32:27PM +0100, Matthew Wilcox wrote:
> > ... when we called clone()?  A thread by definition has a reference to
> > its own mm.
>
> Ah yes.. thanks!

re: I also had a quick look on do_exit() but I also didn't see where
do we e.g. wait for all the threads to stop before recycles a mm.

We recycle mm after all refcounts are dropped in the exit path:
  do_exit
    exit_mm
      mmput(if !mm->mm_users)
        mmdrop(if !mm->mm_count)
          free_mm

>
> --
> Peter Xu
>
