Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D65B9910
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIOKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIOKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:47:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C94B6B647;
        Thu, 15 Sep 2022 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9shrMoMEdVp1fWqocdrf3xkQME07ASxRQ6wXCVEM85w=; b=UsEowSmwJKRDasNR4xv/sp+PJQ
        s0/tVkNBPM9sNcmSO/L61ZAGJhavKVCFZ/hlrhjGrCNTcOZqFLcBvheMHlEMd2YzAc9322EbO6IWl
        Sw/8B4OdePyCY3THqG/VOeJDFyVTR1uBpbxEbbIRmCHbH84uCWXt5ukvGWT0DsUU42olHWRQmw/AZ
        0cZiyD1YTCzktebtQbpB2b5FRvcYWiSrJ+eNUH5crj0SnxnDbdSED9XtL2T37YTz2mkvg17FQGpDH
        SLyOPp1yGO9wsHhy9H90QdY0Hb9/fUMhw/4gowIntKhKwgdDogO7HrmLhuUzXI3JjdrJH4eBZpWf/
        wK8+zOWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYmOc-0010VB-1d; Thu, 15 Sep 2022 10:47:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD34E30013F;
        Thu, 15 Sep 2022 12:46:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E6FD2BA78C3F; Thu, 15 Sep 2022 12:46:57 +0200 (CEST)
Date:   Thu, 15 Sep 2022 12:46:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <YyMCofXNVEylE2D8@hirez.programming.kicks-ass.net>
References: <20220912161812.072aaa3b@canb.auug.org.au>
 <Yx7iEv/wy5Olgu0M@hirez.programming.kicks-ass.net>
 <Yx9+IIQqizUB/DJu@slm.duckdns.org>
 <Yx+vwLUYNl4U3IAv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx+vwLUYNl4U3IAv@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:16:32PM -1000, Tejun Heo wrote:

> 1. Leave it as-is. Stephen's patch is correct and we can just let Linus know
>    how to resolve it on the pull requests.

> I'm leaning towards #1 but #2 is fine too. Peter, what do you wanna do?

Works for me; I'll make a note for the pull req.
