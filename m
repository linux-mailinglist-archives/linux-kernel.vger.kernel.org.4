Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15E55F7C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJGRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:51:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80370D25B5;
        Fri,  7 Oct 2022 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WpLPULCGom74clmD3yH2xg/VRGobfFWKQal67/aC74I=; b=DDQfN3+uh+ZMNBOlAj74K5X5fm
        Bq3Z1lv8z87IiybLdzwrR1/xUVAxx8nv/Zjs0hhfNPDyMAokTdtgg/lUIKnj5ieIqXxfNewNUjb/P
        lwMPA8GScXGwxRVxRhVTWHCknRFD3Xt3hMeEMyQ7yjVXzQVGqpKH0OzgoRiQ762LOeDB0KlM+1S19
        eQC+bwTkSlePec7Mvk47bOOWxnaOgnvh8rlPt8oC26/wiaJTOPI3Vfi2Gon9pDRUflBG+NcTd8Xt7
        NbvvQ55Oxh9NVfC0e9wRuPBTsEkglcsj9joShOd5ksn6bPbol1OhaxAOJK20e733+cvOSUsb1c+iH
        XCcod2nw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogrV0-009xVC-3R; Fri, 07 Oct 2022 17:51:02 +0000
Date:   Fri, 7 Oct 2022 10:51:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [PATCH modules-next] module: tracking: Keep a record of tainted
 unloaded modules only
Message-ID: <Y0BnBlEdTro9DpfY@bombadil.infradead.org>
References: <20221007133812.804837-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007133812.804837-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 02:38:12PM +0100, Aaron Tomlin wrote:
> This patch ensures that no module record/or entry is added to the
> unloaded_tainted_modules list if it does not carry a taint.
> 
> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Linus, this is the patch I mentioned Aaron was going to post, if I can
trouble you to merge that after my pull request, that would be great.

Thanks!

  Luis
