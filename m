Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F97267B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjFGRqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjFGRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CDC1BFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B016664221
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FCBC433EF;
        Wed,  7 Jun 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159964;
        bh=w4lH+1m5uA5ObF5GBeQgMdYOBG42Ypds2O9e4uqOF/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jLQ+buIz34E+qg1PACQhLICnu5B6TtOgF/vjMrcRG7OMSFslvfXQE0GsZCYYEKiRt
         AAFIBglsDG2yisi3goMFVCP1DscLH172Ta7SigN64q2JKdkDvKj8PUCEX5wUBpeUlQ
         3SmWhs7IWg0OdZl1fzkmlGcfUVWOYXj4pHm25WXlucrzJAM8jRu/JynxZA4bDdS+ec
         6rVt24N0nMKYTkc+YTku1vkVqv6kMcZjYtryd9t+HfE3WnAHZRUze/4drOb47l4SzE
         08pa1cce10zLKXH/DmZgV4raPPZxkEHske9Wg5ZyUQD8rB30gS27UFPhWPiReQL13d
         Bjhu2oVRRHtFw==
Date:   Wed, 7 Jun 2023 10:46:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 14/14] tls/device: Convert
 tls_device_sendpage() to use MSG_SPLICE_PAGES
Message-ID: <20230607104602.17488bf3@kernel.org>
In-Reply-To: <2293519.1686159322@warthog.procyon.org.uk>
References: <20230607102600.07d16cf0@kernel.org>
        <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-15-dhowells@redhat.com>
        <2293519.1686159322@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023 18:35:22 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > Acked-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Did you mean Acked-by rather than Reviewed-by?

Yeah, looks mostly mechanical, I trust you did the right thing.
