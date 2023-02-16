Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0E698FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBPJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBPJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:21:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893D4A1F7;
        Thu, 16 Feb 2023 01:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E674B8269E;
        Thu, 16 Feb 2023 09:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D54C433EF;
        Thu, 16 Feb 2023 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676539278;
        bh=iLqghkxusX0o8rGr4tqOPw8yQl0PffBo54iGt3geCwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kseNlNLKqXOLdaRerpLiRtO97HH9WMJ2o0rcKyXHeiEEU0PmOznCFWmhhpVxFE6jx
         2mbZnnMRhamR6ORlFPQVaMHvCegAp2yeew5+K/mJ+iKYSpatOEKm4hY/wo0bbjS/vV
         hg6ZKE55BTAjNnRdSZvXy8LsPzyhyydQBBr6uLq7TRM3MsFWZqXcsY84HFzamFqhE0
         SJPAf9Tk99IRfixdgyVNbHTJyClx3oZz1ASww5JZ3k4h4HOVPL1gUkTR7OIkbIa9IX
         iC4ZllZQtTmpqcDtfyJ9cYLyRITLRsVxcvGesX2AMvlAvpLCoKEYJkyyqTTf4FsBG2
         kr7gYqaGUjteA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSaT3-0002OF-Al; Thu, 16 Feb 2023 10:22:17 +0100
Date:   Thu, 16 Feb 2023 10:22:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: serial: add myself as maintainer of CH348
Message-ID: <Y+31yXddQiWhz5rn@hovoldconsulting.com>
References: <20230106135338.643951-1-clabbe@baylibre.com>
 <20230106135338.643951-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106135338.643951-3-clabbe@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 01:53:38PM +0000, Corentin Labbe wrote:
> Since I did the driver and have hardware to test, set myself as
> maintainer of it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7729a30b9609..71b63b174703 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4915,6 +4915,11 @@ S:	Maintained
>  F:	drivers/auxdisplay/cfag12864bfb.c
>  F:	include/linux/cfag12864b.h
>  
> +CH348 USB SERIAL ADAPTER

Please name this

	USB SERIAL DRIVER FOR CH348

to keep related entries together.

> +M:	Corentin Labbe <clabbe@baylibre.com>
> +S:	Maintained
> +F:	drivers/usb/serial/ch348.c
> +
>  CHAR and MISC DRIVERS
>  M:	Arnd Bergmann <arnd@arndb.de>
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Johan
