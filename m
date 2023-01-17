Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB72466E21C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjAQP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjAQP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:26:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0540BF8;
        Tue, 17 Jan 2023 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iQI88h0VSGDg33Wtb/20PzDWWfVjQlopCHtG0vCIRi8=; b=I4srSTwj4EKpgzxIws3jfvmII9
        R7Hab00DMGE3oRqzWTO3xtS5QI/LRV5rxAL1s8gW0256uNUVgkYIlepRLpHJteg1FIBmZh3gWpHPy
        7M8GEUcUipRvjjoxZmFhHGSaIX5w2q+Gln6wVdhWEoJNjMnkU9rVYrAE3sDXQtcyziIrfb5b9aHqF
        FTsEM1SEDp+1KYmBJ7BWrhjYTLW2Zd14tfbd04uNLyvuL+SCq8h5iCeWmgy9Z0Z5M+vv83ltpAt9a
        uMX6xY+k7HjFG8Ah5ZWdJr7aNs63Io7+ckIoIrzQhv/XTRZl0TH2VpTLGNfhAlk91mw3o8EivRsNw
        zrExik8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHnrG-00Epf4-US; Tue, 17 Jan 2023 15:26:42 +0000
Date:   Tue, 17 Jan 2023 07:26:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux@rasmusvillemoes.dk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] kernel/params.c: Use kstrtobool() instead of
 strtobool()
Message-ID: <Y8a+MtWgMfBf378R@bombadil.infradead.org>
References: <a0abd4f77374428bd3c9dd8b69b2afe52544c994.1673687215.git.christophe.jaillet@wanadoo.fr>
 <alpine.LSU.2.21.2301171550500.24433@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2301171550500.24433@pobox.suse.cz>
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

On Tue, Jan 17, 2023 at 03:51:52PM +0100, Miroslav Benes wrote:
> On Sat, 14 Jan 2023, Christophe JAILLET wrote:
> 
> > strtobool() is the same as kstrtobool().
> > However, the latter is more used within the kernel.
> > 
> > In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> > the other function name.
> > 
> > While at it, include the corresponding header file (<linux/kstrtox.h>)
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> 
> Luis, will you take it through your modules tree?

Yes, queued up, thanks!

  Luis
