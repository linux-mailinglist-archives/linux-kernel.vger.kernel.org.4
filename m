Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D7B6CCDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjC1Wue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1Wuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:50:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D1EDF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E144B81EFD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDB2C433D2;
        Tue, 28 Mar 2023 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680043828;
        bh=/0unNe68W0weEOmYVQgJVdxeO/Mh+Md9PDJIWCzerpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w9N3wcDePAZGSy3R0YpHW5XlPm9Bg1CDqlvIeJnntkb5QTHFMm9gizXId9fbn+1Lq
         t2ijmGwQfWdf9Du79WUF+QaKgnJh9pNVNI/eEnR2PsxpRaexhnpaFbhmgEedgSlI0q
         jnT9uvN1YalaICUGznD0GfmDhu8ywFNcDjmhMOyk=
Date:   Tue, 28 Mar 2023 15:50:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <hughd@google.com>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <rientjes@google.com>,
        <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED
 for shmem files
Message-Id: <20230328155027.f0f7571bd430e7525481c6ca@linux-foundation.org>
In-Reply-To: <cover.1676378702.git.quic_charante@quicinc.com>
References: <cover.1676378702.git.quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 18:21:48 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the pages of shmem files on their own, like, that are created
> through shmem_file_setup[_with_mnt]().

Could we please have some additional review of this series?

Thanks.
