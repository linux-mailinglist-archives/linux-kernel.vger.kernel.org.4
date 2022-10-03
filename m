Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566C35F39FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJCXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:43:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767E41D08;
        Mon,  3 Oct 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gwGVH40lApPNMqa2bDiJVGCrfKhOLgLuTaCOdT4sR6c=; b=kH6VyNF0sa6QIxkK/MAchvATc7
        6vYKiYrk0dFv5uuXEMIImHPLGvGpejXUrw9Xe3YOm8a5dBcoN4otZaumx6ay3vF+GYYdynB+FJ6Ev
        FxdUY2weFbM79sTu7+4ZgxtnPRKGe7Tt4SeqluImGD3ENJXT9/pKON9Cbvy3jnaYXeNmzckQA1WHR
        39HfwM5cA0vbMJwInYsarL0I4dsGBTAL3AmokLagRoS1iEE3fr/HH4WawOVpnCWrymuu66ru1jCVZ
        bp/bnytP0E15y+OcXbap2gNCLiRtpPmIO/jZx3v1RHXJognRZrsKjsyPZ0Y5IRsm2awKVno0ShP37
        /uIgBqWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofV68-0085RW-6i; Mon, 03 Oct 2022 23:43:44 +0000
Date:   Mon, 3 Oct 2022 16:43:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH -next] module: Remove unused macros module_addr_min/max
Message-ID: <YztzsFsytGnMtQAq@bombadil.infradead.org>
References: <20220924072216.103876-1-chenzhongjin@huawei.com>
 <alpine.LSU.2.21.2209301329490.11771@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2209301329490.11771@pobox.suse.cz>
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

On Fri, Sep 30, 2022 at 01:37:25PM +0200, Miroslav Benes wrote:
> Hi,
> 
> On Sat, 24 Sep 2022, Chen Zhongjin wrote:
> 
> > Unused macros reported by [-Wunused-macros].
> > 
> > These macros are introduced to record the bound address of modules.
> > 
> > '80b8bf436990 ("module: Always have struct mod_tree_root")'
> > This commit has made struct mod_tree_root always exist, which means
> > we can always referencing mod_tree derectly rather than using this
> > macro.
> > 
> > So they are useless, remove them for code cleaning.
> 
> a nit, but I would rephrase the changelog a bit...
> 
> "
> Commit 80b8bf436990 ("module: Always have struct mod_tree_root") made 
> "struct mod_tree_root" always present and its members addr_min and 
> addr_max can be directly accessed.
> 
> Macros module_addr_min and module_addr_min are not used anymore, so remove 
> them.
> "
> 
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> 
> Anyway
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Thanks all, I've changed the commit message as suggested by Miroslav,
and will queue this up for 6.2.

  Luis
