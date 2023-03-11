Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0E6B5B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCKMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:19:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6010D322
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20F7CB824FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 12:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484DC433EF;
        Sat, 11 Mar 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678537177;
        bh=4sbylCb/mm440LN5XYoNkavJNTXzJfG4XaJMNkX4Tk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPzZiremg3kg23hgzi99VDF/vuDf7YHzI0EHaerOR9XsW4tPTZJypltYSvtQJFuQq
         cvjRui7W1IJariS4PoGQiCZjK3xh/O0H3R9m8trdBZF+uveLSfJCY7dtfw0hS3zqPp
         ogvQKez3UVTkJdJXd0kUAE5Yqsdg3RN6omDjUP4Q=
Date:   Sat, 11 Mar 2023 13:19:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: r8188eu: delete driver
Message-ID: <ZAxx1kYjVKFRE3kz@kroah.com>
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
 <660ef0b7-fb09-5a72-57b1-3b57ddee924e@gmail.com>
 <ZAxZCJn7AN/yWSRh@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAxZCJn7AN/yWSRh@equinox>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 10:33:44AM +0000, Phillip Potter wrote:
> On Fri, Mar 10, 2023 at 10:08:49PM +0300, Pavel Skripkin wrote:
> > Hi Greg,
> > 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> says:
> > > Now that the same hardware that the r8188eu driver supported is
> > > supported by the real wireless driver rtl8xxxu, the r8188eu driver can
> > > be deleted.
> > > 
> > > Also the rtl8xxxu driver supports way more devices, and is a fraction of
> > > the overall size, making this a much better overall solution.
> > > 
> > > Thanks to the r8188eu developers and maintainers and reviewers over the
> > > years, your work allowed Linux users to use their hardware before the
> > > real driver was implemented properly.
> > > 
> > > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Martin Kaiser <martin@kaiser.cx>
> > > Cc: Larry Finger <Larry.Finger@lwfinger.net>
> > > Cc: Phillip Potter <phil@philpotter.co.uk>
> > > Cc: Pavel Skripkin <paskripkin@gmail.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > 
> > I guess, I am late to the party, but if it matters
> > 
> > Acked-by: Pavel Skripkin <paskripkin@gmail.com>
> > 
> > 
> > 
> > 
> > With regards,
> > Pavel Skripkin
> 
> Same here, won't make it into the deletion commit log entry, but:
> 
> Acked-by: Phillip Potter <phil@philpotter.co.uk>

Thanks, the link in the commit will point to this thread for the
archives, so it still does matter :)

greg k-h
