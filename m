Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD5674BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjATFPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjATFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:14:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3E4393A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 094CBB8274D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC4DC433D2;
        Thu, 19 Jan 2023 21:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674165262;
        bh=xbA3jkRHQB6FSdMxXXzlMiF/zynJqMr7bdo92WzPWSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlDidypZ/SD9ztXZP9UBgwpwXZSXjhypSs0Vul8PN5ebZpsgdZJEUhmj8NmNv2tCL
         N6oRx4/7HyBa7K576+2BbRSFZfPQAqC8Uwh96ZUjdftxTvQjulmz++FwX442yRwrZk
         wwQCMRaPqGzpTPis3p2x7lG/SrdhAnemvXA8rBvyPcV3c2fqtzy2DLLUg4P6uj+B0E
         Bz6/nYmJC9g9kYM6wpJVbPAdgfAa5LUhNAbi05jqqqjY0SjIRQXvxvCFexcUkjezIV
         e3yQcJWYkslA1Y04V8is5Wiufi2NGqPNbwfTZzRFfE76yzBpqs/qPTFFTkju9593v8
         JowhOYb1ZrIfA==
Date:   Thu, 19 Jan 2023 21:54:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     sam@ravnborg.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, users@linux.kernel.org
Subject: Re: [PATCH 13/15] backlight: omap1: Use backlight helpers
Message-ID: <Y8m8CM35ku+Fuppc@google.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, 07 Jan 2023, Sam Ravnborg via B4 Submission Endpoint wrote:

> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Rework backlight handling to avoid access to the deprecated
> backlight_properties.fb_blank member.
> 
> The rework includes removal of get_brightness() operation,
> because there was no read back from HW so no use for it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/omap1_bl.c | 67 +++++---------------------------------
>  1 file changed, 9 insertions(+), 58 deletions(-)

My tools appear to dislike the line break in the Message-Id header.

This isn't something I've encountered before.  Is this a B4 thing?

Is this standard?  Should I adapt my tooling to scan over line breaks?

-- 
Lee Jones [李琼斯]
