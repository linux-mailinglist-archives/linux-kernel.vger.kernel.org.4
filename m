Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57506617370
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiKCAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:40:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69B2AEB;
        Wed,  2 Nov 2022 17:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84F5BB82544;
        Thu,  3 Nov 2022 00:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A872C433C1;
        Thu,  3 Nov 2022 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667435999;
        bh=YKWn58dmDD7dizOwkZI+UoBBgnZZBQrAVh6R22M5RZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEiJthF07Dhd9guFACsmUO1uBNYiWT7YGUmDQcsGIv3q5OK9nm0MXRvOMGGMvPKii
         k9E8JkMz1RMoPqkf4cM4QySGvCjiR8WrLo7s4z6N1+sfpITb1jun0eKslKA2VQo4L0
         MMHFC3z1RDZrcHOtcgC/usF5ZejdDFOZJUHCUaJA=
Date:   Thu, 3 Nov 2022 01:40:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] staging: media: atomisp: make hive_int8 explictly signed
Message-ID: <Y2MOFrprCkZVAiCr@kroah.com>
References: <20221103001914.81849-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103001914.81849-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:19:14AM +0100, Jason A. Donenfeld wrote:
> The current definition of hive_int8 is a naked char, without any sign
> specifier. This is incorrect on platforms such as arm, where char is
> unsigned. Fortunately nothing in the kernel actually uses a hive_int8
> type, but in case it gets used later rather than removed, this makes it
> explicitly signed.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Greg - if you're going to take this for 6.1, that's fine with me.
> Otherwise, if it's for 6.2, I'll take this in my unsigned-char tree to
> keep all of these fixups together. -Jason

I don't take drivers/staging/media/* patches, they go through Mauro's
tree, so I'll let him and you fight it out here :)

thanks,

greg k-h
