Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88ED7244BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbjFFNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjFFNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAFE6B;
        Tue,  6 Jun 2023 06:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 949E4627CE;
        Tue,  6 Jun 2023 13:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170F9C433EF;
        Tue,  6 Jun 2023 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686059193;
        bh=68eaGrLGrnORDP1z2Q9crKD3m6oo24cQZZ0jGyTzM9g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oWB9VCBzGWlONboGUB2EfG9Dpzthr9066iDyJx6GNNpEi4Zfwl5Gu0tYTMMmnJpdk
         pmm3kAY+jeWGHqKKt5VyzWzzmnyRhMR8Cj87ISDaRjMWSko7WO+uBmeSEGYhi5y4py
         z6Rqimlc+UD62AyS1YplgBIDcGeqTM/8wE1mIQZ7vxC3dryFTv1HRm8E7bSClm6qLc
         CIHxj/SM5muMKaf6mq6YZyJ/ShZ0BdS3Hh9KQp/n9+36ObkIMNhq+8Kx8TODcTCLaa
         efx8uSFDZdWVxLFF4hxA+xI+uUkXyPrehTB/4LKWCcUQBkPxfdeZPs9qSnuAfyCqO1
         3eav54GnVKIfA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Willy Tarreau <w@1wt.eu>, Randy Dunlap <rdunlap@infradead.org>,
        James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
References: <20230603151447.29288-1-james@equiv.tech>
        <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
        <20230603160659.GA5182@1wt.eu> <20230604112644.49ac2035@kernel.org>
        <20230605041258.GA22604@pendragon.ideasonboard.com>
        <87v8g2hwm1.fsf@kernel.org> <20230605103029.3fb821db@kernel.org>
Date:   Tue, 06 Jun 2023 16:46:25 +0300
In-Reply-To: <20230605103029.3fb821db@kernel.org> (Jakub Kicinski's message of
        "Mon, 5 Jun 2023 10:30:29 -0700")
Message-ID: <87ilc0itzi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 05 Jun 2023 16:22:46 +0300 Kalle Valo wrote:
>> > Note that some maintainers process pull requests from patchwork, not
>> > from their mailbox, and prefer not to be aadressed in the To or CC
>> > headers. I don't know how widespread that is.  
>> 
>> FWIW I belong to this group and prefer not be in To or Cc, I'll always
>> check the patch from patchwork.
>
> Ah, I didn't realize this. 

So no action needed for this, I'm sure I'm in a very small minority and
I can handle the mails with my filters just fine. Just wanted to comment
that such maintainers do exist.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
