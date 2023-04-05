Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B046D8000
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjDEOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjDEOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EB4C3D;
        Wed,  5 Apr 2023 07:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC28627B2;
        Wed,  5 Apr 2023 14:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF150C4339B;
        Wed,  5 Apr 2023 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680706180;
        bh=dtWs2DBZbMfNEcGHI7vSPp0brVrBOxnP/46KCX362Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpujxyepqIvuo6rSKqMrQuv8GWrYlsB7Uhs4cUYp5EctFcP9J8k/kyQ3i70Crvg6p
         lOSOkW7dDNTYUVtxW17cZ5fwkfJNZdCkTZYgQu8TLFObbBdPplFyPicGbZGR6SdQfp
         h/yyQgUusougBClRox432qdF6AjP1I2/XoQnXFpM=
Date:   Wed, 5 Apr 2023 16:49:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 0/3] generic-ohci/ehci: add RK3588 support
Message-ID: <2023040524-hazelnut-landfall-7d26@gregkh>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145350.45388-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:53:47PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This increases the max. allowed clocks for generic-ohci from 3 to 4.
> On RK3588 a total of 4 clocks is required to access the OHCI registers.
> EHCI already supports 4 clocks.
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20230331163148.5863-1-sebastian.reichel@collabora.com/
>  * Add Alan's Acked-by to the driver patch increasing the clock count
>  * Update bindings, adding rockchip,rk3588-ohci and rockchip,rk3588-ehci compatibles

This is "v1" according to the subject line, right?

confused,

greg k-h
