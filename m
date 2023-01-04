Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A265D8C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjADQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbjADQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:17:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957CCD2;
        Wed,  4 Jan 2023 08:17:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC5BC617A9;
        Wed,  4 Jan 2023 16:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AED1C433D2;
        Wed,  4 Jan 2023 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672849062;
        bh=PXjg8l9xNNWMxJbfGxkrZ5VoCzj53LmR0NTnWk0bFOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCc9rTUgLcNfiEG2oQB6HMDo1nBojPYPe8espWSXK9QYcoruovIrI5On8IV8+mrd+
         2mQwDrbYEB7i4lEE2H7h8ESEqTclcLCeIde+E8zxg7mmgmVioTcea1D+UIhRZvn6+2
         oVe+NxDv35pzlQhlIJ9b7h/boosEe3qvzu+5reDIBQtSIAes/O6o3VFpn/m2hyjQ3w
         mdH/XPAADk9HM9L/MW5R+qjwPx/IAJ0iA+9JmMnu6ROy8SVXHYMOQjUlq8d1pTIq+i
         /+92aLdfWNO4ZTpQfJ7ITUkK4rOi7HJrKPriSHn1nFsUTgdZOY9H8k2NPdYgqGA+/E
         gQzW+ePQhpXkA==
Date:   Wed, 4 Jan 2023 16:17:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2] mfd: twl: fix TWL6032 phy vbus detection
Message-ID: <Y7Wmn06iHri/hfzC@google.com>
References: <20221208215723.217557-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208215723.217557-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Andreas Kemnade wrote:

> TWL6032 has a few charging registers prepended before the charging
> registers the TWL6030 has. To be able to use common register defines
> declare the additional registers as additional module.
> At the moment this affects the access to CHARGERUSB_CTRL1 in
> phy-twl6030-usb.  Without this patch, it is accessing the wrong register
> on TWL6032.
> The consequence is that presence of Vbus is not reported.
> 
> Cc: Bin Liu <b-liu@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  - remove comment
>  drivers/mfd/twl-core.c  | 9 ++++-----
>  include/linux/mfd/twl.h | 2 ++
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
