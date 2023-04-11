Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F96DD076
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDKDo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDKDn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377C3C3E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272CF60B84
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C36C433D2;
        Tue, 11 Apr 2023 03:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681184524;
        bh=BH853ksF+Pk0Yh2Gu1eyzRmpE0u1ojn0DmQMDFJE++g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D+KRIE7dLoxov5J8xTSwSNmibcgtqT6YRsiN5cuSHCJ6eqZ86tLaQyLDgvYPX2yc5
         mWlC8Vl/OS95TBQJPyixwo41cc4UE38miY4FDru0t0mQXtkz+MMx4zlL/jk6BVo9p3
         ut1bd47eV8ehEbNQV4A65QDZXly9FTSmPzQdbnCk=
Date:   Mon, 10 Apr 2023 20:42:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Minchan Kim <minchan@kernel.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Message-Id: <20230410204203.159f1cb70f7beb48cdf3a49a@linux-foundation.org>
In-Reply-To: <8ba3f700-19a6-e7fd-c51f-cd277ff7a439@quicinc.com>
References: <cover.1676378702.git.quic_charante@quicinc.com>
        <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
        <ZC9ZYAp8a46dILdO@google.com>
        <8ba3f700-19a6-e7fd-c51f-cd277ff7a439@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 19:22:22 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> @Andrew: I am not sure If this update to commit message requires respin
> of the patchset. Please let me know If it required so.

Please just send us the new text and I'll do the copy-paste.
