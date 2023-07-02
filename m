Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F07744D84
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGBMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275DE72;
        Sun,  2 Jul 2023 05:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9241D60B6A;
        Sun,  2 Jul 2023 12:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EA3C433C8;
        Sun,  2 Jul 2023 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688299356;
        bh=8bLEnUYc7wEzh+SSE9/0jlwi4h6W7dJNNRt3uf4BLDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUrM5RxqjUF/JOgKqmDozbciP2lgT9QI5eOe32JYsSTsSUxEYuQ8wCsz6LtY+Ecmx
         D7LJO1zjDaIPNeAWHDJRoMog2JVK+kubREifRIvGskNmugyjp7R0rfnHaYJssVAo6N
         w1dV0S/TE13204CvGS/4f0qjlp73UxyvcXzzOaRA=
Date:   Sun, 2 Jul 2023 14:02:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: ili9341: use macro
 FBTFT_REGISTER_SPI_DRIVER
Message-ID: <2023070254-embark-subplot-4dd4@gregkh>
References: <20230702080324.120137-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702080324.120137-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:03:24AM +0200, Raphael Gallais-Pou wrote:
> Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
> ultimately causes the module to an early exit at probe time.

So this doesn't work at all today?  Has it ever worked?  What commit
does thi fix?

> In addition the MODULE_ALIASes can be dropped.

Why?  When you say "also" or "in addition", that's a huge hint it should
be a separate patch.

thanks,

greg k-h
