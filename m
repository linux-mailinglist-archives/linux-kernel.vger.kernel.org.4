Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D5D5FEB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJNJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:16:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408A1C3E49
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dKptVZ0v/uMf1m3dDlGPfB9gu6br+nyQ+uvjcRxQDQE=; b=jPiEZhYQwAmq9Ntm6MSS5Nyq3/
        FC4zx02kIU90tppvGxn3loSTVlRR9G8kUkgq+K3FvYWuf3S5QjaSpFIuHnnCitDnqi0Mn1kNoZ8k6
        JA+dW0UpIJB3+4FXnLYY3w4snmFgYPcpN6LbKL4U37OU6zH5JMClVpZ0POjDE0f1xGjqEtUP2lLbw
        d3qJ/AmogtQFy/w64C0+Ie5Tvi4C/8rjFqRM/PQNgU3F9ViMD/2gCa2GqazGGJZ5WwOMOz50YY4Sw
        zzH5MlnBQIYevPfj3WDAO4DtQy4vAUaXzPqplh3lTqifX9TlRuVy1iNf3YB7HUwINP1603MTa7hQv
        a4/ED7cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojGny-003NMs-Gw; Fri, 14 Oct 2022 09:16:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4DC530008D;
        Fri, 14 Oct 2022 11:16:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9141A2C15A62B; Fri, 14 Oct 2022 11:16:32 +0200 (CEST)
Date:   Fri, 14 Oct 2022 11:16:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:x86/mm.pae 5/9] mm/khugepaged.c:865:16: error:
 implicit declaration of function 'pmd_read_atomic'
Message-ID: <Y0ko8GLvpO31qTCr@hirez.programming.kicks-ass.net>
References: <202210132122.DnShsQeP-lkp@intel.com>
 <CAAa6QmTMa76hsaN_RDkkQRpEcH8VV-RqHY=MXWjk36eMX49Ppg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmTMa76hsaN_RDkkQRpEcH8VV-RqHY=MXWjk36eMX49Ppg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:15:13AM -0700, Zach O'Keefe wrote:
> Seems like this was just due to local "mm: Rename pmd_read_atomic()"
> conflict after merging Linus's tree (which introduced another
> pmd_read_atomic() callsite). Peter already seems to have rebased and
> made the fix - thanks Peter.

Yep, just needed a fixup. Patch applied but didn't build. Arguably I
should've compiled before pushing, but meh :-)
