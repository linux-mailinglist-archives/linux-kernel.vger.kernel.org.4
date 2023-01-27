Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA8567DECC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjA0H6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjA0H6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:58:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A49757BE;
        Thu, 26 Jan 2023 23:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD721B81FB5;
        Fri, 27 Jan 2023 07:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E0FC433D2;
        Fri, 27 Jan 2023 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674806316;
        bh=+xGfgZ52XjiZhKUOGjZzfcMrLXyy17b39/lbWM5JSh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o93ahkChla0cB2SOur6to4dXtZiaBRzlBM6tyMKPBKJ7TNvur4q2xYTi/+PhEpdbb
         YkmYHcdbxMwozdg6bY2wjR1S9lN9gcU+tWQPMIO25/iNr9t80gQH8soYIvDvwZHnz/
         +WeCT4iwJoRK2+mv8EVOWT0WxGoamrbPxBw0uQZz/luquxEj7zdK1fo6lUHiEjsiY9
         eHr9PRONSVuj8PnLM9ifn1ZSppvVY5eZczfuqEELuwsLIYBZcMASjh7zoFJHauUgQl
         h38LebDcl7mq6lh77tGNkdkGbsON0TnZe90R9LuOAlpxDyMhuYdH/ulxX56ROyUOh+
         +XkMA+UMN172w==
Date:   Fri, 27 Jan 2023 15:58:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the imx-mxs tree
Message-ID: <20230127075827.GN20713@T480>
References: <20230127110833.6cb7f4c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127110833.6cb7f4c8@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:08:33AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in arm-soc tree as a different commit
> (but the same patch):
> 
>   b82765d04e37 ("ARM: multi_v7_defconfig: Enable wm896x audio CODECs")

Dropped it from imx-mxs tree.

Shawn

> 
> This is commit
> 
>   74ab23d5a7fc ("ARM: multi_v7_defconfig: Enable wm896x audio CODECs")
> 
> in the arm-soc tree.
