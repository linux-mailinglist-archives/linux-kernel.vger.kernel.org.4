Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269C96EE344
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjDYNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjDYNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD1CC10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4100462E74
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C811C433D2;
        Tue, 25 Apr 2023 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682430013;
        bh=FBcOU3ArzB+cQj4nJpiLs6zcMHbZH4Z0/9aOs+7ndho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJesmFyOPJhQ+RYcBeqWIMN453fJ6pyQZoN97EqAbHn1SItoNSeBO58np+ElwJaXj
         Snq4Yp/4NSdtQftbOjyuxuX62bKeEdMbykP1mvEc0RnH9KCv8iMQdXLE9PyiKMnIpF
         uVzslG2q7TH+dwBZGe29tRaj5eYa1htAqo3YjDp8=
Date:   Tue, 25 Apr 2023 15:40:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Message-ID: <2023042502-resolute-divisible-fbff@gregkh>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425115210.GA4151911@angband.pl>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:52:10PM +0200, Adam Borowski wrote:
> On Tue, Apr 25, 2023 at 04:39:23AM +0000, Winkler, Tomas wrote:
> > What is the exact issue you are experiencing, can you add the error message this fixes? 
> 
> The problem doesn't trigger in mainline

Then it's nothing we need to worry about in mainline.  If/when other
changes ever happen to need it here in mainline, we will gladly take the
change.

For obvious reasons, we can't take patches for issues outside of our
codebase.  Nor do you want us to, as that way lies madness and an
unmaintainable mess.

thanks,

greg k-h
