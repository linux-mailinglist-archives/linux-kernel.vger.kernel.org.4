Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63444624302
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKJNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:13:05 -0500
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954DFDEA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:13:00 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id 9AEABB4459C;
        Thu, 10 Nov 2022 14:12:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1668085977;
        bh=wnyRjP05NOalbuodb9ezcZdhq1sgmGCz40yFIQIKdPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Kac9sCqezf3Caoz7tLxpn7x5JeotDLlLwnJmA6+2YhMIU6sUjSbTvQRx+PbgATj6x
         IYcahf8fCalEMFiHwNxIE5VJGeyeBJyCkE3h3byIHPeYRhReHvg1K30krZlZOie7yQ
         hE/EtHcpa0kmRn4CW+iDk1u2FaThu5fqENVGj/XRad1zAq/mq1/IL2F5swVIhZCz+M
         8Rz3em7PTK0a8uNUNnkTpMkpEW1NPutwQxX6EA7mnimb7R7XZCjA9Bnq/C2JekmcoG
         lvNz/490YUXIC0q622/l0shymGmcZys08nkfGPJjYHkvKrSHhH4hhFQTveYNrKJAhg
         MCfvMmP0g/tDQ==
Date:   Thu, 10 Nov 2022 14:12:46 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1] drm/panel: simple: set bpc field for logic
 technologies displays
Message-ID: <Y2z4zoYU2rxrOKPC@francesco-nb.int.toradex.com>
References: <20220831141622.39605-1-francesco.dolcini@toradex.com>
 <Y01kJbZjkwo1A8l1@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01kJbZjkwo1A8l1@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:18:13PM +0200, Francesco Dolcini wrote:
> On Wed, Aug 31, 2022 at 04:16:22PM +0200, Francesco Dolcini wrote:
> > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > 
> > In case bpc is not set for a panel it then throws a WARN(). Add bpc to
> > the panels logictechno_lt170410_2whc and logictechno_lt161010_2nh.
> > 
> > Fixes: 5728fe7fa539 ("drm/panel: simple: add display timings for logic technologies displays")
> 
> Hello,
> just a gently ping on this. It applies cleanly on v6.1-rc1, anything I
> should do?

Hello Doug,
can you help on this patch? I am not sure who is supposed to pick this
small fix, but it looks like you recently took patches on
"drm/panel: simple:", so maybe you can help.

Francesco

