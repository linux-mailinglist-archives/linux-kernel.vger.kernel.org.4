Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006669913C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBPKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBPKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAE4A1D7;
        Thu, 16 Feb 2023 02:30:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B17261F39;
        Thu, 16 Feb 2023 10:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169CEC433EF;
        Thu, 16 Feb 2023 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676543400;
        bh=pQgiiYH8YW53nQKkaQLS7CH2z7qDXD8pnYiJrlqLTe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9ECIJlv23U8AB1qrZHhoEmOc69Q/y0+VSSr1mWB5yBYoOZ82K2oxgX3KE8yqezqx
         pOZc67EOcazyAx5AJuy3gvvBjJlGxEu+dJPC6+P4rr/Fu+7MKnUPRc5m2qjLG1RyRp
         jKt666HmLGJK5cJLqKvaozTRn9MXEKzCWzP4rULs=
Date:   Thu, 16 Feb 2023 11:29:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb: serial: add support for CH348
Message-ID: <Y+4Fpd0lcJkQrXef@kroah.com>
References: <20230106135338.643951-1-clabbe@baylibre.com>
 <20230106135338.643951-2-clabbe@baylibre.com>
 <Y+30EYVTiAuhj1iK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+30EYVTiAuhj1iK@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:14:57AM +0100, Johan Hovold wrote:
> > +	if (urb->actual_length < 2) {
> > +		dev_dbg(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
> 
> I'm sure I've asked you drop __LINE__. Please be more careful when
> considering review comments.

FYI, __func__ and __LINE__ are included automatically in dev_dbg() calls
so any addition in the string for them is redundant and should never be
there (it's also a hint that no one used this debug statement as the
redundancy would be kind of obvious...)

thanks,

greg k-h
