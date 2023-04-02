Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41E6D365F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDBI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9FEAD1B;
        Sun,  2 Apr 2023 01:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782BC60F7D;
        Sun,  2 Apr 2023 08:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8466FC433D2;
        Sun,  2 Apr 2023 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680425861;
        bh=2Sp/WGMz3fqu0IaXp63wNcBNSGfhlqXDZ2bdpCKy3QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRXTcZE3mYfA7PFSOhgoQRvNu2hl66627nKgFVoEkrtOXff0lKGsaPS2a9VguB77m
         ZyRjfqO1xodz/u05Do9gX9pyJ/kbag6WxBBe6sUQlDTcjl6qVG3mzPyX8bWDo9DxRm
         AjNiDSm/ogxaogNW5RevI3uddevvVX3DKBXhie8c=
Date:   Sun, 2 Apr 2023 10:57:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: simplify the class_pktcdvd logic
Message-ID: <2023040213-plop-krypton-b853@gregkh>
References: <20230331164724.319703-1-gregkh@linuxfoundation.org>
 <87e110f9-a57d-520b-6fae-f75d16a71108@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87e110f9-a57d-520b-6fae-f75d16a71108@kernel.dk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:25:10PM -0600, Jens Axboe wrote:
> On 3/31/23 10:47 AM, Greg Kroah-Hartman wrote:
> > There is no need to dynamically create and destroy the class_pktcdvd
> > structure, just make it static and remove the memory allocation logic
> > which simplifies and cleans up the logic a lot.
> > 
> > Cc: linux-block@vger.kernel.org
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, I would like to take this through my driver-core tree as it is
> > needed for other struct class cleanup work I have done and am continuing
> > to do there.
> 
> I'm going to defer to you on this kind of stuff, so if you think it's
> fine, then go for it.

Thanks!  And sorry for sending this twice, I forgot I had previously
sent this a few days prior.  Too many patches to juggle over here...

greg k-h
