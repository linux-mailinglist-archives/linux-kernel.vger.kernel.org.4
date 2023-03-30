Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4D6D026C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjC3LDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjC3LDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DC9020
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DBD61FFC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FD1C433D2;
        Thu, 30 Mar 2023 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680174170;
        bh=f9QpxWI9Qa1iXNbKRJEdYmxJfJjp/gUxFVzrKLyjc3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK5C9CR0I7MhVjSZL4OM3bz+bFRiPWt/L6wV+fWBRumYZjqvHOEJrB8oNXigeyU8a
         Erda83JEDNOrv0UQS0s15sO2p+BsMEjED9FO1vbe5vh0jPYJrKLLzSYl8jIQgegthe
         ve6EmwIfPRin0TmQ+nD/JG0C/7yPwpEkqgQmaMgBjECcHyVTh/ef8ozcXYQ29sNneg
         ZjAsZajCJOrKiodyFs/PKRMf+j49I5yAi/B5MJ15X6gPp2uet+q2rt2/AAk2dnMyuR
         zp5PcH6djMkji45Ks+HhsvTTX6hWm4vKWIU15S8fs6OF6nuY6lrUi3GJQ+Qi+S4byJ
         EOW1NE1b4bRzQ==
Date:   Thu, 30 Mar 2023 12:02:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Lizhe <sensor1010@163.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd:mcp-core.c : Remove redundant driver match
 function
Message-ID: <20230330110246.GY2673958@google.com>
References: <20230319040149.216919-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319040149.216919-1-sensor1010@163.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a nice exercise, I'd like you to fix the subject line please.

It should match the subsystem you're applying to, with no errors.

`git log --oneline -- drivers/mfd` is your friend here.

On Sun, 19 Mar 2023, Lizhe wrote:

> If there is no driver_match function, the driver core assumes that each
> candidate pair (driver, device)matches, see driver_match_device()

Attention to detail please.  This contains whitespace issues and a lack
of punctuation.

> Signed-off-by: Lizhe <sensor1010@163.com>

You should really be using your full name.

> ---
>  drivers/mfd/mcp-core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
> index 2fa592c37c6f..281a9369f2b3 100644
> --- a/drivers/mfd/mcp-core.c
> +++ b/drivers/mfd/mcp-core.c
> @@ -20,11 +20,6 @@
>  #define to_mcp(d)		container_of(d, struct mcp, attached_device)
>  #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
>
> -static int mcp_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	return 1;
> -}
> -
>  static int mcp_bus_probe(struct device *dev)
>  {
>  	struct mcp *mcp = to_mcp(dev);
> @@ -43,7 +38,6 @@ static void mcp_bus_remove(struct device *dev)
>
>  static struct bus_type mcp_bus_type = {
>  	.name		= "mcp",
> -	.match		= mcp_bus_match,
>  	.probe		= mcp_bus_probe,
>  	.remove		= mcp_bus_remove,
>  };

The code is fine.

--
Lee Jones [李琼斯]
