Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD2730722
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjFNSLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjFNSKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111530D1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A34C76458F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF487C433C8;
        Wed, 14 Jun 2023 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686766164;
        bh=+nxesi73rHt30BcL4CzJywspddkR9ibaByigPS/fPBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kiva6gK7MHUYL0CxOWup6G0c1iUNZxcgNyRtbLccepIEW9XIsERqtTwtmhufzdk8D
         tL1fJjZqqtgVCYCr03ofsn/4dYBh7I9kARA8qLfI8/SNX311/bI06DIe663INP1v6J
         fdqtvJ7J/3R8p6TS5f/0JQkeEl68nnuADOkb8EaM=
Date:   Wed, 14 Jun 2023 11:09:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     hexingwei001@208suo.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_io: Prefer 'unsigned int' to bare use of
 'unsigned'
Message-Id: <20230614110923.b5ac015ac6e9a2d97f3b40c3@linux-foundation.org>
In-Reply-To: <1e132a6416d673e285af610ff185fa5f@208suo.com>
References: <20230614071804.13110-1-panzhiai@cdjrlc.com>
        <1e132a6416d673e285af610ff185fa5f@208suo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 15:23:44 +0800 hexingwei001@208suo.com wrote:

> Fix the following checkpatch warning:
> 
> mm/page_io.c:87: WARNING: Prefer 'unsigned int' to bare use of 
> 'unsigned'.
> mm/page_io.c:89: WARNING: Prefer 'unsigned int' to bare use of 
> 'unsigned'.
> mm/page_io.c:109: WARNING: Prefer 'unsigned int' to bare use of 
> 'unsigned'.

I'm counting 55 of these in mm/*.c.  If we're going to do this then it
wouild be better to do all at once, plus the header files.

I don't believe that is worth the churn.
