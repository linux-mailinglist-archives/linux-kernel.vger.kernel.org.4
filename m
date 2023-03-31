Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B446D1B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCaJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCaJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5984C13;
        Fri, 31 Mar 2023 02:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 919E1B82D7B;
        Fri, 31 Mar 2023 09:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49E1C4339B;
        Fri, 31 Mar 2023 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680253482;
        bh=qklLmKXRzghZt7OhgfJXRO5fuL8vLwwjXsAWaeBPzFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfi5gF6DtXxGC8wDmIfKFNSgd88WcXxfT32yf1qYcJvLUIylTBm5g7ebQtcJlbP1q
         KzFkYRJJAXkYzww5FL1zzMMODXTf4L16IDcX02V+sWxihso21o4hF0DJYjYO+xIsiC
         aBXDxhc8MNkHkLfO3+lw16shDnRDEM8jx7KkFqZY=
Date:   Fri, 31 Mar 2023 11:04:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: pvrusb2: clean up unneeded complexity in pvrusb2
 class logic
Message-ID: <ZCaiJzLYYRt7KrPp@kroah.com>
References: <20230329060132.2688621-1-gregkh@linuxfoundation.org>
 <ee171553-c8e4-1128-2a5a-db2b450f8224@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee171553-c8e4-1128-2a5a-db2b450f8224@xs4all.nl>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:08:43AM +0200, Hans Verkuil wrote:
> On 29/03/2023 08:01, Greg Kroah-Hartman wrote:
> > The pvrusb2 driver struct class logic was dynamically creating a class
> > that should have just been static as it did not do anything special and
> > was only a wrapper around a stock "struct class" implementation.  Clean
> > this all up by making a static struct class and modifying the code to
> > correctly reference it.
> > 
> > By doing so, lots of unneeded lines of code were removed, and #ifdef
> > logic was cleaned up so that the .c files are not cluttered up with
> > extra complexity following the proper kernel coding style.
> > 
> > Cc: Mike Isely <isely@pobox.com>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>a

Great, thanks for the quick review.

greg k-h
