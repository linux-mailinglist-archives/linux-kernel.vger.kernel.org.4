Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86C6D029C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjC3LJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjC3LJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:09:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55073729B;
        Thu, 30 Mar 2023 04:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E421661FF9;
        Thu, 30 Mar 2023 11:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E8AC433D2;
        Thu, 30 Mar 2023 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680174567;
        bh=T8wE467vI6c2rOTs4uLiM+lJm0atJvuyplLSCeGyWeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZXjMY3dHV1zJfTJi+5ymyZQras+LrYmlZClMDQqhTbHuHCgfqptzDOEUQEcMQnI+
         fBbcIztBJCkTPwkWx/Ued9KSN2T/fPvVNZ1o5VnER70BlO4Elg1lQUGmvb6yC8ITJm
         r9epJJJp+VutlrxRsgDH+phUX5dgrF5xQPrRmhxkQsFA8hkJ4akhOYq4zBOaL+2inc
         vJJLVR9zO5VP1H6h4ksPS3/hYtnAuvConewY54fONAnbhodWa65FVVqu86/rw7bkt5
         Xuk+C+YcDvAsNNgydhxQWJsMGanZhsMmbdhJgEnpVSKBPwrAOP/J/RH9/qgrM9jAc/
         WuAkOE1yjmRnw==
Date:   Thu, 30 Mar 2023 12:09:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux LEDs <linux-leds@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] MAINTAINERS: Add entry for LED devices documentation
Message-ID: <20230330110922.GZ2673958@google.com>
References: <20230319084604.19749-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319084604.19749-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, Bagas Sanjaya wrote:

> When given patches that only touch documentation directory for LED
> devices (Documentation/leds/), get_maintainer doesn't list mailing list
> for LED subsystem. However, the patch should be seen on that list in order
> to be applied.
>
> Add the entry for Documentation/leds/.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
