Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33492710B55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjEYLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjEYLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2C97;
        Thu, 25 May 2023 04:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B114D618CA;
        Thu, 25 May 2023 11:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8FC433EF;
        Thu, 25 May 2023 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685015088;
        bh=71BsJdnKW/WEGexND9TRGaKmOZUEitfHsN3iyll87Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZKCwLZjrwoIVjN3vCMq7cFaHUH3af3Dlz6KJMSGHjaltt4JKX1XdfNyJgbbUevic
         0kjf53YMRxGSn8p0MkRkZJDvjj2g3k9ZfhzCJx3SQBWeJNTd8oU5LnFP1eI1vTsoi7
         tJWY+GM32/L/IumPzuWwQG0vX46vkoTa8fcMoiRVMacyXKa3u+be+4MHwhoXC98bLh
         LCGlH8zdjJB62hPq0rYD6sgLe/kTJcZD/l470ib6BVDfDEDeR68MEHc+LZ1TIQR+X8
         VKsnNK77od41xcRqxLTUbU5MW+ipj0qVnU7TVAwa0HXqXIGjZ34yMxy6bJ6G6Nh2b8
         DAM2EJTAd6V8w==
Date:   Thu, 25 May 2023 12:44:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] leds: as3645a: Replace strlcpy with strscpy
Message-ID: <20230525114444.GI423913@google.com>
References: <20230524144824.2360607-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524144824.2360607-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Azeem Shaikh wrote:

> Part of a tree-wide effort to remove deprecated strlcpy()[1] and replace
> it with strscpy()[2]. No return values were used, so direct replacement
> is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20230523021150.2406032-1-azeemshaikh38@gmail.com/
> 
> Changes in v2:
>  - Updated subject and commit log.
>  
>  drivers/leds/flash/leds-as3645a.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
