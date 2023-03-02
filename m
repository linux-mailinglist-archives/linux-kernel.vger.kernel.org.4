Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81E6A85CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCBQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCBQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:04:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5EA18B33;
        Thu,  2 Mar 2023 08:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0657615F3;
        Thu,  2 Mar 2023 16:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C2BC433D2;
        Thu,  2 Mar 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677773071;
        bh=jBtL4yxIYG0lXE20Kh9eNgExexa/lorfkanKaYeucsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDLJ2jv7BL0kSBPrpWzeyv4YVnK2aVeM2k5522SDhwpQ/oJSBle3pBe4cd/I/IW3o
         JwEPKRA5YkJrc3YhmAXdjyd91gCxxvUXy14HE1p3KQ7m/DCJ4dUcaJefdg4zNg3CFx
         OPkPkWfd9nOmiFSYsvYITEzFeAHgb5RJnu6VwByy9oTOEzMU5pJyPHji3ETv7qxVL/
         oVQIeuxJVRF2atQ8B7stPlcE3jqWKGEjaqNm13V3vIa+pQFdOJXb2b0hhokqrWFT7H
         nMXGHv8r00cIeKqMw9lxPwd5zEwQZ2hcMeVHusjUS4UWF5OkeM94BvgB301KX3IKth
         GskWoeJP5sfaQ==
Date:   Thu, 2 Mar 2023 16:04:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kabel@kernel.org
Subject: Re: [PATCH v13 0/2] Introduce block device LED trigger
Message-ID: <ZADJCmMSCSuWFavm@google.com>
References: <20221227225226.546489-1-arequipeno@gmail.com>
 <Y/9gvmPwcTaY3pRA@google.com>
 <a7ff3338-3d5e-4402-aaba-16e740f4ed5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ff3338-3d5e-4402-aaba-16e740f4ed5b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023, Ian Pilcher wrote:

> On 3/1/23 08:27, Lee Jones wrote:
> > Pavel,
> > 
> > I see that you are active now - could you please prioritise this one.
> > 
> 
> Lee -
> 
> Just FYI, Pavel did respond.  Unfortunately, he doesn't feel that this
> can go in with its current sysfs interface, and making the change that
> he wants would require changes to the block subsystem (adding an in-
> kernel API to look up a block device by its kernel name, rather than its
> major & minor numbers or a special file path).
> 
> Similar changes have been rejected in the past by the block subsystem
> maintainers.  The position I have seen is that major & minor numbers,
> or device special files from which they can be determined, is *the*
> interface to block devices.
> 
> I've also had some pretty negative experiences when interacting with the
> block subsystem community - unnecessary profanity, etc.
> 
> Given that history, I don't see much prospect that I (an unknown newb)
> would succeed in convincing the block subsystem maintainers to add the
> API required to implement the interface that Pavel wants.  So I'm pretty
> much done trying to push this thing unless something changes that leads
> me to think that there's actually a decent chance of success.
> 
> Hopefully that makes sense.

I understand and empathise with the situation.

Pavel is the boss here, so I cannot over-rule the decisions he makes.
Hopefully the two of you can find some middle ground and work something
out between you.  Best of luck.

-- 
Lee Jones [李琼斯]
