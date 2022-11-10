Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212862488B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKJRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:45:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691172FC0A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0433761D39
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BE3C433C1;
        Thu, 10 Nov 2022 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668102331;
        bh=gcfr3cqbpjX+l801BHNeYhV2mJZm6tFatWVs8ZnZO1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wn7QnfeQRlbLYLgZH3+ZNHxPr7iGlaH5WDNm0nInMA+Cxj8ievKreKsFGn0omxOkA
         6QUukwjnVFrun5ShcxhxgDfT0U0GIgqY2xhwwjOgZMUH7FGG7h6KWbbsXEeOI1HlLO
         42cDdtxU5V49uPMgUd+B6uEygldoX1X6ieHbj518=
Date:   Thu, 10 Nov 2022 18:45:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: lan9662-otp: fix compatible name
Message-ID: <Y204uFULhjqUe17l@kroah.com>
References: <20221025072217.3715634-1-claudiu.beznea@microchip.com>
 <20221025234405.wr3copoyi4mj472t@soft-dev3-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025234405.wr3copoyi4mj472t@soft-dev3-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:44:05AM +0200, Horatiu Vultur wrote:
> The 10/25/2022 10:22, Claudiu Beznea wrote:
> 
> Hi Claudiu,
> 
> > Documentation of lan9662-otpc driver (namely Documentation/\
> > devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml) express that
> > compatible for this driver contains "otpc" string at the end but not "otp"
> > as currently present. Fix this typo.
> 
> Thanks for this patch.
> I have also sent a patch for this some time ago[1], but there
> is no reply on this.
> 
> Anyway for this patch:
> 
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [1] https://patchew.org/linux/20220928195112.630351-1-horatiu.vultur@microchip.com/

I have queued up your first patch as you were here first, thanks.

greg k-h
