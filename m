Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757B6674578
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjASWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjASWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:02:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F014C2B;
        Thu, 19 Jan 2023 13:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEC661C1D;
        Thu, 19 Jan 2023 21:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB970C433EF;
        Thu, 19 Jan 2023 21:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164475;
        bh=VhT//xdaFJPL+dSaI47Z5lILBjkKNuCbZfXeuUicLJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuXpGV1gFsGP6Vt1PI8UcWgi4x+iHPLQ2GhQyJCPCcS5NtMAJrcoTNG8bKnV+6XA7
         VTY1lhJK5jZt7/WZbL4cgaQi2gxlb9bPcGTRK10xcDcekU+MlG8IBpB5/sscFoOWsC
         h9ga5iUbMBihFJcfj0QjKzIr3HV4GrwseDTJQVgX1DyurpLTL7mjVNVit+V5UW8NVw
         onL3FbbfEJ/tLmpebZGR4PUiwiDf2Er+2wv3LYQIF9wvbaAIkXt0qcGEOI0/aknnYr
         ozmT8Xw9BqNp8GADORcZ29uKlJmHx2Gn04kxdDRhkBdBxh1JGp/SZumQB8p0MdsknL
         FmnMSbBvaBI+Q==
Date:   Thu, 19 Jan 2023 21:41:10 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y8m49nsyR0B9vcbX@google.com>
References: <20230106164856.1453819-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106164856.1453819-2-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2023, Stephen Kitt wrote:

> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/video/backlight/aat2870_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
