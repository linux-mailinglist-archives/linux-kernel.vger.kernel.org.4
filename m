Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44F6E8FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjDTKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjDTKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7396EA5;
        Thu, 20 Apr 2023 03:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92709646EA;
        Thu, 20 Apr 2023 10:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68BBC433D2;
        Thu, 20 Apr 2023 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681985699;
        bh=Dht1VDndpJ9CVznJlmqNT0nK2LqIk10aXDzqxZ5D5U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfs5EuEpbHLAZutfEYw9KRWGb3FPgXikzd+1xkVJGINzfQy1KoBWYnpgmv1IGWtUF
         8n7kdxWiHzaeTnHYmzIHvmOW/lrwiHLKdCeo4dpOWmtzHezBSh9e9zGlnoKCFXwWz0
         y78v7uY0Zs6pa+1SCJFfwH1m6v8sPLm/2vay6UhA=
Date:   Thu, 20 Apr 2023 12:14:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
Subject: Re: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
Message-ID: <ZEEQoHY12zfLM7Yd@kroah.com>
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <ZEEF9E4Mmeg5hRWu@kroah.com>
 <b65291ea-acca-7cd4-b5f5-f5bb46e679b4@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b65291ea-acca-7cd4-b5f5-f5bb46e679b4@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:08:14AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On 2023/4/20 17:29, Greg KH wrote:
> > On Fri, Apr 21, 2023 at 01:21:27AM +0800, Weitao Wang wrote:
> > > Fix some issues of xHCI for zhaoxin.
> > > 
> > > Weitao Wang (3):
> > >    xhci: Add a quirk for zhaoxin xhci to fix issues.
> > >    xhci: Add zhaoxin xHCI U1/U2 feature support
> > >    xhci: Show zhaoxin xHCI root hub speed correctly
> > > 
> > >   drivers/usb/host/xhci-pci.c |  5 ++++
> > >   drivers/usb/host/xhci.c     | 49 +++++++++++++++++++++++++++++++++++--
> > >   drivers/usb/host/xhci.h     |  1 +
> > >   3 files changed, 53 insertions(+), 2 deletions(-)
> > > 
> > > -- 
> > > 2.32.0
> > > 
> > 
> > Do these replace:
> > https://lore.kernel.org/r/20230420093603.3344-1-WeitaoWang-oc@zhaoxin.com
> > or are they on top of them?
> > 
> 
> This [patch 2/3] and [patch 3/3] share a xhci quirk flag XHCI_ZHAOXIN_HOST,
> So I put these independent functional patch in this set group.
> Above url and below url are independent xHCI patch for zhaoxin.
> Is it more suitable to put all the patch for zhaoxin xhci in one group?
> I Hope to receive your guidance. Thanks!
> 
> https://lore.kernel.org/all/20230420104826.4727-1-WeitaoWang-oc@zhaoxin.com/

Please resend them all as a patch series so we know what we are supposed
to be reviewing and accepting.  Otherwise it's quite confusing.

thanks,

greg k-h
