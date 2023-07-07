Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5037B74AAF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGGGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB38170F;
        Thu,  6 Jul 2023 23:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752726173E;
        Fri,  7 Jul 2023 06:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D74C433C7;
        Fri,  7 Jul 2023 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688710042;
        bh=JhEBn0qEOFdcXVib1fxTfQTD7bx7a81j0l/ZYChOydU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk5JYd4/IVtVzvJbhIY+JM6q9CHF3AqYShe7uxeE0aoFtBkiu6Q/LhPAxddC5F2t3
         bcl9+WRNoVSLWuwusmgNi2x/LMlBKvtvs2djYncYpZzupdhCOrvMLEFQT/IW9eBC5b
         u0LU9P3r4i9I3S3S5BaM98d5P/1QNkH35DC12zuM=
Date:   Fri, 7 Jul 2023 07:07:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.yu@hpe.com
Cc:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB support
Message-ID: <2023070707-earthen-chafe-7b15@gregkh>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-3-richard.yu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706215910.78772-3-richard.yu@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 04:59:09PM -0500, richard.yu@hpe.com wrote:
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 83cae6bb12eb..c01eb2a2c7db 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -461,6 +461,12 @@ config USB_ASPEED_UDC
>  	  dynamically linked module called "aspeed_udc" and force all
>  	  gadget drivers to also be dynamically linked.
>  
> +config USB_GXP_UDC
> +        bool "GXP UDC Driver"
> +        depends on ARCH_HPE_GXP || COMPILE_TEST
> +        help
> +          Say "y" to add support for GXP UDC driver
> +

You need a real help text here please fix this up.

thanks,

greg k-h
