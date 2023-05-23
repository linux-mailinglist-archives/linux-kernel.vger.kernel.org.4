Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB670DD56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjEWNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjEWNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F2FF;
        Tue, 23 May 2023 06:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EC163254;
        Tue, 23 May 2023 13:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEBAC4339B;
        Tue, 23 May 2023 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847876;
        bh=vxl5bCUQozOg0lQEVTKyxWkdWVuZfH+OvLvE8rLc2TI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Njkqwv/YF/gfaD4a7t6Lti63d52FQZzvFS1M/ZRu13pLErKt7d+U0kDdpzBcK1OWC
         n026yb3PLX6t7X4LNgLHWt882JFw3PRqQFcRNexCFB7eH56ZqhTWvmpUfiadHQ0GHw
         AoycxfZTWGpjNOb9awfVxS6CuVQuGngLwB3oBTbXly5steCL/7dkvfoDC9HGe/1Q8N
         QLp6rdfDXqpJKydTPH8+kFKaMlqWOGLc0zx8bYk9bTOgTYPtmKMBpwFQ+QHDbBZdv6
         GS9zk8j2iiw7SKz7jLnnTXxun+M9ON9E3lqysbbMiwcB+7q1+YKpcS6Mh8oZbNRvsd
         /02/EzAXrmQEw==
Date:   Tue, 23 May 2023 15:17:52 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Luke D. Jones" <luke@ljones.dev>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: asus: Add support for ASUS ROG Z13 keyboard
In-Reply-To: <20230503034711.253439-1-luke@ljones.dev>
Message-ID: <nycvar.YFH.7.76.2305231517430.29760@cbobk.fhfr.pm>
References: <20230503034711.253439-1-luke@ljones.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023, Luke D. Jones wrote:

> Add support for the ROG Z13 keyboard. This is a variant of the last
> few ASUS ROG keyboards and has much of the same functionality.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Applied, thanks Luke.

-- 
Jiri Kosina
SUSE Labs

