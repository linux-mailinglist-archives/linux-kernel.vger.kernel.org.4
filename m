Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A996493EB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLKLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLKLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:33:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B0BC3B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:33:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1694CE0B1A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 11:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931BFC433EF;
        Sun, 11 Dec 2022 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670758414;
        bh=yXxiBhh4kn8sPgZWQf/bxgFMPGx3iwySDzRuKdth0gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/GE4d4nEldb5laZOZUau/uWRTOeoyVvI8z4zwkpGd6wyxgQvpMBkg1cHSkqBDuG5
         Ertaw8WfJ4oiQtYsQedg75lcpb3DifuYCyLmqjPr0hogcgrF2G7Vnd6/mb+H4M/QO4
         eICd3mi+/ko3G1AbdijxRQF6NEA8At7D9Ce/LY2Q=
Date:   Sun, 11 Dec 2022 12:33:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dalvin Aiguobas <pharcodra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: fix checkpatch error for spinlock
Message-ID: <Y5XACri80rFeamVy@kroah.com>
References: <20221211105649.GA4683@koolguy>
 <Y5W5nKtLMV9b4xnm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5W5nKtLMV9b4xnm@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 12:06:04PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 11, 2022 at 11:56:49AM +0100, Dalvin Aiguobas wrote:
> > Checkpatch Styleproblem fixed by adding comment.
> > 
> > Signed-off-by: Dalvin <pharcodra@gmail.com>
> > ---
> >  drivers/staging/wlan-ng/hfa384x.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> > index 0611e37df6ac..ad117d570bb6 100644
> > --- a/drivers/staging/wlan-ng/hfa384x.h
> > +++ b/drivers/staging/wlan-ng/hfa384x.h
> > @@ -1171,6 +1171,7 @@ struct hfa384x_usbctlx {
> >  };
> >  
> >  struct hfa384x_usbctlxq {
> > +	/* lock: Protect structure fields */

Also, does this comment really make sense?  To properly document a lock
takes a bit more text, if you read this would it help out in
understanding the code any?

thanks,

greg k-h
