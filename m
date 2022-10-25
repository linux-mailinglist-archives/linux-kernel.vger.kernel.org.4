Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF07A60C15E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJYBr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiJYBrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:47:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6145227
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8A0B8171B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8800C433D6;
        Tue, 25 Oct 2022 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666662014;
        bh=gkrqEzZjX+JO3SWqKnfGYcSo7apaLNgUd7x3orRf+38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMUJb+pILZBcocldnW+V++nTnRR18GCbdAoOEg2/zweh+aKkfYyuw9WK/rvmNXmTR
         xGOe0KBG2sgPaSV0+Q/37tuLg6ndluXgVUcUjPMog+RrCDL1ITXxvS5pcamuyo4H4a
         F8mNMEw3C6bh1lYosnM3eibI3c6LGPzJr+G/wdTWhIPsrE+mxPguNA6W084yzmkQVv
         w3cWIuj2+jnsZVoEvj2KwBrG5eD12IOBtgIZBu7wP3aAqQyGeXqBwjvEclg2OykC6S
         Nwl3zDXMFzy5oU0Go5i5Im2BsKTCpxaXxF4II2io735qk9tSYcFxL6uOnOU8T8WCpe
         Erw3BnsOau5lg==
Date:   Tue, 25 Oct 2022 09:40:10 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
Message-ID: <Y1c+eheUMjiG/fqh@google.com>
References: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
 <Y1NlwY+RnKth++bW@google.com>
 <Y1bCNs76nTGWcS3l@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1bCNs76nTGWcS3l@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:49:58AM -0700, Brian Norris wrote:
> On Sat, Oct 22, 2022 at 11:38:41AM +0800, Tzung-Bi Shih wrote:
> > On Fri, Oct 21, 2022 at 05:26:47PM -0700, Brian Norris wrote:
> > > +GOOGLE FIRMWARE DRIVERS
> > > +M:	Tzung-Bi Shih <tzungbi@google.com>
> > 
> > Please use <tzungbi@kernel.org>.  I prefer to use it for Linux community.
> 
> OK! I was just imitating your existing entry for CHROMEOS EC CODEC
> DRIVER, which lists google.com email. So you might want to fix that one
> if you want people mailing @kernel.org.

Thanks, I forgot to update that one.  I'll fix it.

> I'll assume you will fix that when applying. I can send a v2 if someone
> else plans to commit it.

Ack, I'll fix it when queuing this.
