Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D26E8E10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjDTJ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDTJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:29:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C630E73;
        Thu, 20 Apr 2023 02:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3857961239;
        Thu, 20 Apr 2023 09:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC7C433D2;
        Thu, 20 Apr 2023 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681982967;
        bh=MMMl7kH1YtbeKQgLBTGDIf6d7RIzlMxyfIZqKKutXn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajy9RP4liIVsSd4FNmCVmHRPbg1Ex6Fet6qwQKXEkz1hh7Iy/AFXrsdRGxYh4rE3X
         G+SMZ88F1+ETk1WnENG+pe13uldOmNvGekwdKOrYQ7W+Abtw5vx8vIYiubWllYjrLc
         oze1LJBED8sefzgzo9lYzTRkmlCZmAH31AOn5Lkc=
Date:   Thu, 20 Apr 2023 11:29:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
Subject: Re: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
Message-ID: <ZEEF9E4Mmeg5hRWu@kroah.com>
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:21:27AM +0800, Weitao Wang wrote:
> Fix some issues of xHCI for zhaoxin.
> 
> Weitao Wang (3):
>   xhci: Add a quirk for zhaoxin xhci to fix issues.
>   xhci: Add zhaoxin xHCI U1/U2 feature support
>   xhci: Show zhaoxin xHCI root hub speed correctly
> 
>  drivers/usb/host/xhci-pci.c |  5 ++++
>  drivers/usb/host/xhci.c     | 49 +++++++++++++++++++++++++++++++++++--
>  drivers/usb/host/xhci.h     |  1 +
>  3 files changed, 53 insertions(+), 2 deletions(-)
> 
> -- 
> 2.32.0
> 

Do these replace:
https://lore.kernel.org/r/20230420093603.3344-1-WeitaoWang-oc@zhaoxin.com
or are they on top of them?

thanks,

greg k-h
