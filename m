Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AB69E9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBUWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:00:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A02CC4F;
        Tue, 21 Feb 2023 14:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=UOyYgs/WNQxXaRUxn1yv69HyJ0IFvIfWeGNyfcXmXCs=; b=4fGi74uqbGWlH8CLuUsrnk3PWK
        bM8n4HwFwCiChV2bHBhv+Vnh8kJb4EAHcT5+o8XdZXKwL5RHYuVO9AHFNacUbgVESSDyVdz9cTpYL
        qG681rSZ0D01kH2SDJ6usgraRr8gYlSP093J9Y0XMeWqZC1Oqwcv/pms7X7QT/IyeJN7FAAD1lDQ7
        sapa8aFFi9vdD+rgzFL+jXevR5hw9WGvkzYvJusZESe2lO4dmnfgGH+vdy64xKlKflB2WltvlxolR
        bm1jjUL5JyDM+YkSCD2B6XYXR4DtTvxoDHS+o4iJTuWdHOU2DQDPhBiYzi2n2pI2qDC+8qKd9T/v/
        0Pil/gLA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUagp-009uIb-Ps; Tue, 21 Feb 2023 22:00:47 +0000
Date:   Tue, 21 Feb 2023 14:00:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: make module_ktype structure constant
Message-ID: <Y/U/D0B7MjhAT+7o@bombadil.infradead.org>
References: <20230204-kobj_type-module-v1-1-40df5b474e9d@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230204-kobj_type-module-v1-1-40df5b474e9d@weissschuh.net>
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

On Sat, Feb 04, 2023 at 05:44:46AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks! Queued onto modules-next.

  Luis
