Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED56A959D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCCKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCCKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:53:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807851E5D1;
        Fri,  3 Mar 2023 02:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43905B81891;
        Fri,  3 Mar 2023 10:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83419C433EF;
        Fri,  3 Mar 2023 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840826;
        bh=il/hJ1rbXDBFxjUSExTJaS2yi2XYe6jDK2yZ9jjfB/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VStokG36pbq/IJOmywSpgDaF/apZZOQNfsGRsHUuhd2Nwqsmr47te1TVxF12yIgSs
         PebtDrkjX117H4UPOsvLM1ClhfE974/mhNfXFP1lFqiHmuPHc2F75kcMUWmMXv/wmE
         4I6Fcu3jBiQxYTxQUhNRMAEEjhwWm4T6xgzsrI1U1xqmi6SXCr9vMsi4q62inf93ir
         Qk1apjkDbf580T/OQj75p6H7skHTyYOEWmMbWEUzgEHgmGjo/cnbTMIoijECMHXUCh
         lwFlEalaCTjlbHQzUEGl8ljp9RyHx5P2J6GW4FcedEX1th4WhEguwdHTyZE8adMG2f
         ybBQSY5s2CdSA==
Date:   Fri, 3 Mar 2023 10:53:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 10/27] leds: remove MODULE_LICENSE in non-modules
Message-ID: <20230303105341.GC2420672@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-11-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230224150811.80316-11-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Nick Alcock wrote:

> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> ---
>  drivers/leds/leds-asic3.c | 1 -
>  1 file changed, 1 deletion(-)

Mention the driver in the subject line please.

> diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
> index 8cbc1b8bafa5..bc7e96c3732a 100644
> --- a/drivers/leds/leds-asic3.c
> +++ b/drivers/leds/leds-asic3.c
> @@ -173,5 +173,4 @@ module_platform_driver(asic3_led_driver);
>  
>  MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
>  MODULE_DESCRIPTION("HTC ASIC3 LED driver");
> -MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:leds-asic3");
> -- 
> 2.39.1.268.g9de2f9a303
> 

-- 
Lee Jones [李琼斯]
