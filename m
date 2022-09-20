Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729E5BEB21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiITQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:33:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95834647EF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D949B826B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3ABC433C1;
        Tue, 20 Sep 2022 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663691587;
        bh=SyW+GjcCjRvE/yEXks2zPGJu/Rt4pnX5r+N3a1uyxRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhErWCSXOBGZYglnFQomPh1MstM47hkNjGtSFgdan3Md7RI2FRukF/duTNdl0C68A
         x5UiXF8ItPbVLg0jQHak3yfVzS4E99Ebn9mfmAzIZnII5mCA/VbK7DHD3YIcME+YWA
         RDTHsOhFZewi3rpaIHKYL658obI0MyrNue5EYyENGO+CSaXHIiCImFATLALPrIzp0J
         ise+R6QUykAYt/mFnaxfNlCJFIKEGbRRswnNePCbElcVV9olZu69MU/GWV1QmN9cxZ
         X/KyWzw4lots2TpacCtsCwBBEdRsmY3lXLgqXnaIFnAxutgs4NDtBVHpYwhl0vlp8S
         j8QIvUl3P20+A==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/sysfs: return 'err' value when call kstrtoul() failed
Date:   Tue, 20 Sep 2022 16:33:04 +0000
Message-Id: <20220920163304.52672-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920025158.70293-1-xhao@linux.alibaba.com>
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

Hi Xin,

On Tue, 20 Sep 2022 10:51:58 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> We had better return the 'err' value when calling kstrtoul() failed, so
> the user will know why it really fails, there do little change, let it
> return the 'err' value when failed.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Looks good to me overall, but...

> Changes from v1
> https://lore.kernel.org/linux-mm/20220919170305.61335-1-sj@kernel.org/T/
> - keep the 'err' variable, and return the 'err' value when failed.

Patch changelog shouldn't be here as a part of the commit message,

> ---

But here.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>

I will revise and post it on behalf of Xin, for reducing unnecessary Andrew's
burden.


Thanks,
SJ

[...]
