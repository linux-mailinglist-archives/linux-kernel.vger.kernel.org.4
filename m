Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB6606C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJUAsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJUAsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:48:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41B22EE2C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:48:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m6so1166103pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOqvC+hTi4zTSUUcSTVGH72B8E67tk2smw1EdPE9cGg=;
        b=VCM9OW9qUkRAMM2h1Dd3Jtq2+RTUtBCaQiPC7T/jYmBFqCy0LrxXQT6XzuZaySsfAW
         sORGSIi2AJMbdp3Vv7mopZ3qGKzCLsFrPrd+286n7ySgU/YG4C9Wes7UNTIy2Sdkow+s
         nsok50RuGtQc60+RUhvzwQG0gCOkMrcpEp/blYfPXj2pwUKecKBugXiAfxGwy/iRSD7X
         oDBBtR48ElQKlX969sL9xQur39fn/wSG9Txbk9XCmjxiG7TaFezl65CxLkba4hZgxRH1
         dbvUVeTLJiRA2bv//RHSu6VGVGhqfxqSwQtC/WeKXDXKHI//r8nmpi2eajWtYSuLQyt1
         7ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOqvC+hTi4zTSUUcSTVGH72B8E67tk2smw1EdPE9cGg=;
        b=UmkEYN+ZFVaC6QzpK7+BhnDOwXbGBlozvVsn/rUb90CJNVVQDDT5FRtsSIGN5e4KA4
         uGLMZL7+/WfuWDIFpXJdVFV674FN5utZ+EaDD94ORaKKtu00vllZFSTPkheaA9j9Psnd
         K0dtoQY082X2pk/pULuq6s7rmdxXLp+jwUBkoyMRp7NIL0xT6LE7KhaN9oEe00jTOTig
         9bMxE6toPHK2KBIz9M2jqn/rY5SWuUIbiVUOZ7N78YARZZoKuW+0mJWsdc4C449xwz9o
         Vb52mU1KzZgKoXaiJC6PchKJ+luFUF8W0sU+vrjxmoEnRsrpFtdOJaxQ7dnzV43buKtN
         so+w==
X-Gm-Message-State: ACrzQf0tGR/WOWRlzizV7L+gN6hlkgzfXlsCu/T2pLE0kZ/TVo3Nmkpr
        PD+gNXsQAP6qwC4ira43JvA=
X-Google-Smtp-Source: AMsMyM73oMcfd5UYUoWunNWYmnkWPidj0oOD+v0CkBqeC/yhZvWNAPO0+GOCuHSbU34cybXrC02ykA==
X-Received: by 2002:a05:6a00:a96:b0:558:8915:2f0e with SMTP id b22-20020a056a000a9600b0055889152f0emr16548613pfl.38.1666313308701;
        Thu, 20 Oct 2022 17:48:28 -0700 (PDT)
Received: from gmail.com ([2a00:79e1:abc:1e04:de9a:68c:c1e8:7e8f])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm13588426plf.219.2022.10.20.17.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:48:27 -0700 (PDT)
Date:   Thu, 20 Oct 2022 17:48:25 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kees Cook <kees@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
Message-ID: <Y1HsWddXgnYNH0aa@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
 <20221020011048.156415-3-avagin@gmail.com>
 <714DD165-E237-4599-9EE8-477B01AB4365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <714DD165-E237-4599-9EE8-477B01AB4365@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:54:15PM -0700, Kees Cook wrote:
> On October 19, 2022 6:10:45 PM PDT, Andrei Vagin <avagin@gmail.com> wrote:
> >From: Peter Oskolkov <posk@google.com>
> >
> >Add WF_CURRENT_CPU wake flag that advices the scheduler to
> >move the wakee to the current CPU. This is useful for fast on-CPU
> >context switching use cases such as UMCG.
> 
> UMCG is https://lwn.net/Articles/879398/ ?
> 

Yes, this is it. https://lkml.org/lkml/2021/11/4/830 is the most recent
version that I've seen.

> >In addition, make ttwu external rather than static so that
> >the flag could be passed to it from outside of sched/core.c.
> >
> >Signed-off-by: Peter Oskolkov <posk@google.com>
> >Signed-off-by: Andrei Vagin <avagin@gmail.com>
> >---
> > kernel/sched/core.c  |  3 +--
> > kernel/sched/fair.c  |  4 ++++
> > kernel/sched/sched.h | 13 ++++++++-----
> > 3 files changed, 13 insertions(+), 7 deletions(-)
> 
> This would need an Ack from the sched maintainers...
