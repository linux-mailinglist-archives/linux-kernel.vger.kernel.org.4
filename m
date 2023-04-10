Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583C6DCD62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDJWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:20:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9AD1FF9;
        Mon, 10 Apr 2023 15:20:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5D0106D9;
        Mon, 10 Apr 2023 22:20:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5D0106D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681165225; bh=LuRsNKjkb+NUZ3zVG1+d02enL9jGANZrCsc3PC/NrcE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XOS2PtEljfm6dC30KimThDbyw7j5myZMX3SoUI1FMm6JJhixDSoyn0NeqF6iAJGGi
         soUAHycvvET5UeCASQPzvJRN+wQ7sIjjEu6ZqAkbOih6FRUzomySnldlYTl8DSSKxE
         RgZEMK29k6KEv8vbZBgIwsGKwcIe6dtL3ZM8oeBccphZPa1Wi2Ir/iyKJZCpUCvo34
         mIJTv8TrXSnUJZoKMTZ6w+Wn35OMfQEolWYKOwVieUBowN6cozfCdIXiHTY80o2wtI
         CA+ibDtKQGg1/PnYn9EAhWR1m2Zq4D+eitDUtSr9IRTibYsVvbdez4eW+W1zIn9UQO
         M5Y2a/aYm9jVw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org
Subject: Re: [PATCH] dma-api-howto: typo fix
In-Reply-To: <af1505348a67981f63ccff4e3c3d45b686cda43f.1680864874.git.mst@redhat.com>
References: <af1505348a67981f63ccff4e3c3d45b686cda43f.1680864874.git.mst@redhat.com>
Date:   Mon, 10 Apr 2023 16:20:23 -0600
Message-ID: <87bkjve5w8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Stumbled upon a typo while reading the doc, here's a fix.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/core-api/dma-api-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index 828846804e25..72f6cdb6be1c 100644
> --- a/Documentation/core-api/dma-api-howto.rst
> +++ b/Documentation/core-api/dma-api-howto.rst
> @@ -185,7 +185,7 @@ device struct of your device is embedded in the bus-specific device struct of
>  your device.  For example, &pdev->dev is a pointer to the device struct of a
>  PCI device (pdev is a pointer to the PCI device struct of your device).
>  
> -These calls usually return zero to indicated your device can perform DMA
> +These calls usually return zero to indicate your device can perform DMA
>  properly on the machine given the address mask you provided, but they might

Applied, thanks.

jon
