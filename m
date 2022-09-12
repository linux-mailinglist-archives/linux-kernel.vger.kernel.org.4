Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D105B5231
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 02:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiILAVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 20:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiILAU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:20:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542623BD9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 17:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11FB5B80B06
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989F9C4314F;
        Mon, 12 Sep 2022 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662942052;
        bh=92DzcdjbsPUURIRASglYfOD4UNbXb4nDeCZZ4LtwC10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W4kbBgsCWl+V4ahbLC1hWobrq5rVclNM1+u49bMBWdJ+YpuI6/3FQsxOGdjiqS/Ii
         NLFXg1BxWjsrlwUrBwYBwEu6QF5dOC/J2v5TGOySu/HWEBL2c7gMyJFzoVn0KcsmL6
         lImb/TGLmMyNBM26nzWFjMbiCHdpnqN5QkL2zfvY=
Date:   Sun, 11 Sep 2022 17:20:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 00/70] Introducing the Maple Tree
Message-Id: <20220911172051.ff5faed962c365e203790137@linux-foundation.org>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 19:48:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Patch series "Introducing the Maple Tree".

I haven't seen any issues attributed to maple tree in 2+ weeks.  Unless
there be weighty objections, I plan to move this series into mm-stable
soon after mglru is added.  Perhaps a week from now.
