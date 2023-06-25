Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23573D04B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjFYLLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9BA8F;
        Sun, 25 Jun 2023 04:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B213660B87;
        Sun, 25 Jun 2023 11:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C051C433C8;
        Sun, 25 Jun 2023 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687691468;
        bh=VhM2u/8K+2cjFtkN8lnTQi/Z1TLLVbyUDo3IgCP4HZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZOQQ9iX2Dl4Wt4oGKOx1NO9iSvtIn6yYgsmmWVoq4ZDTVXwMTHYqd2B2nsQbrcj5L
         CIbM2q6prMukY59fAYhUWZbyd0A+M8q6x5cf3Qd6aoDVFbCbzOT0+kYw7R7gtgyvRp
         nk9iLiwtit0797MLshadhIgwFVg7C/FIKc+uKvM2VYue2ivZz79B1ejEfH/OgyXF7s
         f/i7nsBASPA5KX7SbdeJOn9tQV/vbRcsdf5aHd9DTm1sbQDEsIEYnayiIhWrVS0vJq
         wmC0WFQwpMRSQ2Mw9NbezeSQ6X70wnMRZoAs5jZ62Mpsfqx0qE8kN1ufm9P/eKGfKK
         jakUyWByF5SHw==
Date:   Sun, 25 Jun 2023 12:11:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu
 entries disappearance
Message-ID: <20230625121108.63ad5e60@jic23-huawei>
In-Reply-To: <ZJIWLYtl6BEHfDZQ@fedora>
References: <20230620170159.556788-1-william.gray@linaro.org>
        <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
        <ZJIWLYtl6BEHfDZQ@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 17:12:13 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> On Tue, Jun 20, 2023 at 02:00:37PM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > On 6/20/23 10:01, William Breathitt Gray wrote:  
> > > The current placement of the I8254 Kconfig entry results in the
> > > disappearance of the "Counter support" submenu items in menuconfig. Move
> > > the I8254 above the menuconfig COUNTER entry to restore the intended
> > > submenu behavior.
> > > 
> > > Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 interface library module")
> > > Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com/
> > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>  
> > 
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > but why is I8254 here at all? Users cannot enable it
> > and nothing selects it.  Is it a WIP?
> > 
> > Thanks.  
> 
> There are pending patches for two drivers to use it: 104-dio-48e[^1] and
> stx104[^2]. Those will be picked up in their respective subsystem trees
> (by Bart and Jonathan I presume).
> 

I missed the IIO patch in that series. Could you resend please.

Jonathan

> William Breathitt Gray
> 
> [^1]: https://lore.kernel.org/all/dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org/
> [^2]: https://lore.kernel.org/all/45d35b6f6e8d51df788b2bc85c456bfd45476b1a.1681665189.git.william.gray@linaro.org/

