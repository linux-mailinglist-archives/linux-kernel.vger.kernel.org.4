Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1BB6F89E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjEET5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjEET5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA82108
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1048E60DEA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496ADC433D2;
        Fri,  5 May 2023 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683316628;
        bh=Vpnm3W/mk9L0Pet1LdbTJMkXxLMwC77xS1ahWNrR8rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=reslcu5ItnF0jC7Hn/XI4jUiQBGXt6FlsvYL3mnFRx2VOdFYYcyDr1aJrpk+5FkIX
         IZhOiPqNeIqJZRSx0ypvCYnBFSO/F+V9btL7k5N/IpMpwg+rtqHjje6RiKOIljonD4
         8YcUpbzvDSQFdP/FiYlts+ddhEYaIWHV4pfC6CmE=
Date:   Fri, 5 May 2023 12:57:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 36/36] maple_tree: Add gap to check_alloc_rev_range()
 testcase
Message-Id: <20230505125707.dfc3c4d08aef35a833585581@linux-foundation.org>
In-Reply-To: <20230505192929.52z5qfnvbdhoe627@revolver>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
        <20230505174204.2665599-37-Liam.Howlett@oracle.com>
        <20230505192929.52z5qfnvbdhoe627@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 15:29:29 -0400 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:

> Ah, I meant to squash this into patch 0025 "maple_tree: Revise limit
> checks in mas_empty_area{_rev}()" of this series.
> 

I made that change.
