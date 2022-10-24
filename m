Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE84A609B61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJXHdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49374606AC;
        Mon, 24 Oct 2022 00:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85BB61041;
        Mon, 24 Oct 2022 07:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10AC433D6;
        Mon, 24 Oct 2022 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596812;
        bh=Z5bekQSKrYzHGTZOlKlwYyGtxSzdUaSdXQNgvADi9dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omongc1vs4zrp3heY+kBWJ/vrLmNJ/pzoGpiezXvYOoqAv0OFjQVGrjxPj5YMdRA1
         I1cgiPhh9f+anxA3GFuifWbV0yKvAp7GLdeg5uK5+tMLh8j3gp9ypGqn9NNEd2FIAP
         jwXAU2ffXCDXYsAn4FWwc0RFE8RsJUwlOxWCz6hkN9BANN9PtU1bjFTkXewHn8tqCK
         3Hn/3fFitAfcwO7E9XRjQ8lKqDOVfLSRKMExGe6maehWdlNxLLvW/49k0y+BHGOXsk
         9IYwo2VUCyGwcQjw3Xj9mswX82UxJi+X4q1aaaRQHVBecHt54adDcC6BXaxO42QLlw
         Su+KSkNYIZuVQ==
Date:   Mon, 24 Oct 2022 08:33:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: palmas: stop including of_gpio.h
Message-ID: <Y1Y/xj3nLt3pCyP4@google.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
 <20220926054421.1546436-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926054421.1546436-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022, Dmitry Torokhov wrote:

> It does not appear that any of palmas sub-drivers are using OF-based
> gpio APIs, so let's stop including this header.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/mfd/palmas.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
