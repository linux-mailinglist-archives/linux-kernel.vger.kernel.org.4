Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049A6450B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGBEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGBEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:04:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A5185
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC928B81B2C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6010C433D6;
        Wed,  7 Dec 2022 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670375068;
        bh=9gwl0LY/3FMbEpKl4mJ8EGxqS2Ahze8GFg5DkQ1lXFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nx8dow7qTQelkxuvV+u0My9Ah8byYNPpFh2MzfcY/5IsiC0S1JD8bJQMe/E0YsvN6
         JMf8VyRP8T7ELx18r8FdupsBAnNDiNS31D5ayi9FbgZJv04VPPF+fjg0Y1NWPAx1l9
         gJW0GMSMHeXBFyU0MPxABCLd47CEbDG0oTuBq+nEDWMU5ilOxWQWoRmm8rNTV3mYOg
         grssA3lnRJlbZGVdsZOc2m8o5VGg0GFhGc76pvrDGjY+eHzyKtNd5EF8CDp83EKUrl
         W9kbKGj9EgZVqDQw8soSembvxkb17CShe8TtmnbwJ+OK386hC7brKi4Dt+z/mF8t1J
         vvULbIa2FDRKA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Wed,  7 Dec 2022 01:04:26 +0000
Message-Id: <20221207010426.146353-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207005624.146281-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 00:56:24 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Vishal,
> 
> 
> Thank you for this patch.
> 
> Nit pick.  Could we please replace 'damon:' on the subject with 'mm/damon:' to
> look more consistent with other DAMON patches?
> 
> On Tue, 6 Dec 2022 16:21:57 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> 
> > This change replaces 2 calls to compound_head() with one.
> 
> I guess you mean _compound_head() calls in page_folio() that called from
> mark_page_accessed() and folio_mark_accessed().

s/folio_mark_accessed()/deactivate_page()/

Sorry for the typo.


Thanks,
SJ

[...]
