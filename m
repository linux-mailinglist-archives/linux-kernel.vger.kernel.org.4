Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0200A68E856
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:34:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33884393E;
        Tue,  7 Feb 2023 22:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KfRMBg4CzYtj+benVK+2W+ZZGetxwWvKyYl10wPn8Yc=; b=AEPY5VXGgcifz++PHtrWkUAjxP
        I0j5692Ve6F3OUI3qgJHP1lvyq47iwtCZa0VtoU1vz1TGIop0pnnOztIuGwv4Osetntxw+2nwJLdJ
        HtFmVSS6rkFZwBkeex9uxkELb4fQekBfKPC1YMQvzedaVBYe3ogDj9j6GWl3EtmF9JVzw1InjUz3u
        uxSlQA4NLatw9xxS598A8kkF2b144Iepok1ZDtI9a1CFeV4Fz3i8FNXM62CbBlmYSxXDiIj7yaenF
        2D0nY//OOb/S5EaEonC6dOy+kRTkO5s9/Pp5CRPK3fa89MiL15ig+AaDwcO0EJmdAGDFFNUTq7x4j
        kyscAOaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPe1v-00EJRl-79; Wed, 08 Feb 2023 06:34:07 +0000
Date:   Tue, 7 Feb 2023 22:34:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pstore/blk: Export a method to implemente
 panic_write()
Message-ID: <Y+NCXyT8EM0G0xU3@infradead.org>
References: <20230206061813.44506-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206061813.44506-1-victor@allwinnertech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:18:13PM +0800, Victor Hassan wrote:
> The panic_write() is necessary to write the pstore frontend message
> to blk devices when panic. Here is a way to register panic_write when
> we use "best_effort" way to register the pstore blk-backend.

This looks like a really awkware interface.  And without also posting
the users it not only has no chance to ever be merged, but also robs
us of a good way to try to help you to find a better interface.
