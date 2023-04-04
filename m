Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C838A6D6E02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjDDU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjDDU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2534D2D64
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B37116301E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C90C433D2;
        Tue,  4 Apr 2023 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680640023;
        bh=hK889FfnPbmHGlOcPWfjn8KCUJXv1a5z8MAUTtwBaIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AZT5E5blUUUtD9da16rNfdzTVnwoZzbPEPukd+mKp2csOXKJBGxkf71ImQYcLXTSB
         AyaYqG825qLrg1PQ8wvTzVASP01/+T6GZvtAeClzUG9Ic2LdX8wOhykrIWt1+ddgWu
         dDRnxJu3suqkgQfRAU/BDMmWK4R0fcedFq8V/lms=
Date:   Tue, 4 Apr 2023 13:27:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Some fixes and cleanup for maple tree.
Message-Id: <20230404132702.9240f3a77d0c00fca4b9bf55@linux-foundation.org>
In-Reply-To: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 20:42:00 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:

> Some fixes and clean up for maple tree.
> 
> The bug fixed by [PATCH v2 1/3] does not seem to be triggered due to some
> coincidences, because now the implementation of mtree_lookup_walk() scans
> pivots one by one and exits the loop early. The test cases for the bugs fixed by
> [PATCH v2 3/3] are difficult to write. If I think of how to write them later,
> I will send them out. So I send out the second edition first.

Do we feel that any of these should be backported into -stable kernels?
[3/3] looks to be a candidate for this?
