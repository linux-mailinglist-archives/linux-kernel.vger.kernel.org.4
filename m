Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536E862FF08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKRU5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKRU46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:56:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14D8DA75
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5HlQMf1pHiWyVIWRy/3IEyaj2qJC5y248ub4QyKc4w8=; b=TiWcG/OKBuLsjW+hJMlyUyZHoi
        prZF6GWvU8GgLeDnvu+G8FHKUPhH9GsvpUpq8VW5/tQ4YY+1wPfDeo9i/85NAgpunb2q5wZrP4yMC
        owdN2S8MfgJ8hl/Fm6QDuiS5UWbXui8QYacjt3n/tzS8t48n0CGqxdDZHQ09+4Smv6zMPXq50YVCS
        UQQowjXPNAhXMZDl+qAdln5LVxch3E/rPjw19XxZ50jImuCTyETznPeVXiBQLYXhWCosJsHR4d+VP
        rqz8VNkdl+gtk07frIHcPRze2j2zZqQ2VJV6hcuB1wH5+L7VI0rsc5bVezEjWcRfgdv05HCqOhBLf
        ClE02Ivw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ow8Ps-0083Xv-Ar; Fri, 18 Nov 2022 20:56:52 +0000
Date:   Fri, 18 Nov 2022 12:56:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] kallsyms: Remove unneeded semicolon
Message-ID: <Y3fxlIvuKxKWKRQZ@bombadil.infradead.org>
References: <20221118005852.65028-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118005852.65028-1-yang.lee@linux.alibaba.com>
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

On Fri, Nov 18, 2022 at 08:58:52AM +0800, Yang Li wrote:
> ./kernel/kallsyms_selftest.c:136:2-3: Unneeded semicolon
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3208
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/kallsyms_selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks! Queued.

  Luis
