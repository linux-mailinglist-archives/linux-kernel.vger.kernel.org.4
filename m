Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041E765B6D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjABTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjABTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:02:57 -0500
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E4B19
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=IA046r3t4ojlYOK2avqOmrzgZG5LI6FsuTZMjboQR3Y=;
        b=1t48Hx8/4po34l4T+FGCoaw0/xSJ6Jcw87XfKkq7jNEff3VLg5XGrndwLDeQBxD1JGbY8KItCYz+c
         ZOjD7oXANLepGuO0bPfh0n1UdxIDhWjAqXOcmu5FHyKnzcR9Xid7qv1NCxxg+Lh7BqZp/ddMXgTqIy
         H2MYoh7Y4jXarbaTNEjqQRWKjXbiiF4QhwJpVYzcPGiYjNXID6S8yfs8WMSR3IM91e5gU4uoNSd7S8
         j0BXK9dYryiIMcawEtz34xNns7CZvoC8PGc+WsTmx4Po+DalWnX46i5ESGbm9y/FfAXSZ2r3SizBlG
         ip+Rb7MiIYEekwY8j62ddkNxNrmBLVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=IA046r3t4ojlYOK2avqOmrzgZG5LI6FsuTZMjboQR3Y=;
        b=OGZhQDS4j50WDnCmGXpHc+0Da1AGjUkxraBpUC++x47c/ev1pibQXHePDcPAICMgN5zPxw6Y+qp3q
         mrff5pRCQ==
X-HalOne-ID: 0e911d60-8ad0-11ed-af86-11abd97b9443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 0e911d60-8ad0-11ed-af86-11abd97b9443;
        Mon, 02 Jan 2023 19:02:54 +0000 (UTC)
Date:   Mon, 2 Jan 2023 20:02:53 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/14] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Message-ID: <Y7MqXbQLzpbVI5V7@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-2-javierm@redhat.com>
 <Y7MkzucDEdsYenqX@ravnborg.org>
 <8de738ef-588b-1c59-6e97-c0277eb313b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de738ef-588b-1c59-6e97-c0277eb313b1@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

> > (If you align '\' under each other it would be nicer, but I could see
> > that mipi_dsi_dcs_write_seq() do not do so).
> 
> Yeah, I was actually thinking about doing like you suggested for this macro
> but preferred to keep it consistent with the existing mipi_dsi_dcs_write_seq()
> macro definition...
> 
> Maybe I can add a preparatory patch that just fixes the backslash characters
> indent for mipi_dsi_dcs_write_seq() to be all aligned?
Yep, that would be nice.

	Sam
