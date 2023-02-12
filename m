Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1E6939DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBLUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:35:09 -0500
Received: from smtp-out-05.comm2000.it (smtp-out-05.comm2000.it [212.97.32.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F619E3A6;
        Sun, 12 Feb 2023 12:35:06 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-05.comm2000.it (Postfix) with ESMTPSA id AEE67822C7E;
        Sun, 12 Feb 2023 21:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1676234102;
        bh=7Lx22zUQi0g/ZwZL9hzv0bvKFvbvJqfOahGwdFTb6H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XyUJbVRtWfXWqevva7BQqHzziTysrAb9tJX37hbyqwDJZJ7AVAUSzvhIzAVS8lVC9
         d3Ud4d1Zab/vmlDCaIf3r2SE6V+XrA8bEVW+ytcOb0mk6GSg9HoUQdJK6YdeEvMWb/
         ZntZDbOTLpncQCJFc8qekylSnuDdTjgpRQwQbuPDscRrUYVcj7e8qdmDhQmSjfJOLL
         x2YW3BnCamVzTImrUG2dzvwIOwrVwq601kWRmINm0n0qPMGWXhQNWro0I442CVLmyG
         uJYuVhDcnK1ui0h2N4bR3YOZjCrBsmbBe4+VOZg2tNg7TvDo2rzJXDS6WVslmuZUDl
         MMR2NyY7Q4uUg==
Date:   Sun, 12 Feb 2023 21:34:57 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Mark Brown <broonie@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH -next] spi: spidev: fix a recursive locking error
Message-ID: <Y+lNceqOoWgqncOZ@francesco-nb.int.toradex.com>
References: <20230116144149.305560-1-brgl@bgdev.pl>
 <167395356741.524535.13729434862127399808.b4-ty@kernel.org>
 <Y+exzSwy1UJQCUKg@francesco-nb.int.toradex.com>
 <Y+ghH6yUARqinhuJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ghH6yUARqinhuJ@sirena.org.uk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 11:13:35PM +0000, Mark Brown wrote:
> On Sat, Feb 11, 2023 at 04:18:37PM +0100, Francesco Dolcini wrote:
> > Any plan to have this fix sent to Linus for v6.2? The reason for asking
> I already did.
Thanks a lot - appreciated!

Francesco

