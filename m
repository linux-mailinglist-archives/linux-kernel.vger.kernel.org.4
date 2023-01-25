Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7967B346
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjAYN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjAYN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:26:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC94556EC6;
        Wed, 25 Jan 2023 05:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC506144D;
        Wed, 25 Jan 2023 13:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0C1C433EF;
        Wed, 25 Jan 2023 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674653194;
        bh=sqyg1zMxlyeUEzcZmZghkm9zP9wjx0nm8jN3yvQKmyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6afgZ33AaVvLMQJaaG0MJ74rhswWCkT1CBMHJo1q7qAAg5fnj7Pqbg4j3jszkN2C
         PantCgsqVK8qr6Ej8M/gSXpr/LqMttfdtokwrY9z/miQ186Tt2CkinJGY1umtS/gxI
         Bpp+rOQ6JZzp+D/h7IrrmDuGP1xgKh+zgZS/xHV8=
Date:   Wed, 25 Jan 2023 14:26:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y9EuCGT2KkGfYrVf@kroah.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
 <Y7WHjD4psjgAAyPd@kroah.com>
 <Y9EpNfZJ5irXZqvR@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9EpNfZJ5irXZqvR@fedora>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:05:57PM +0100, Martin Zaťovič wrote:
> Hello Greg,
> 
> thank you for your insights! The static lists are needed
> for matching wiegand_board_info structures to
> wiegand_controller structures for drivers of devices that
> do not use devicetree. I have seen this approach in the
> SPI bus driver, so I assumed it was okay. If there is
> a better way, please let me know.

I have no context here at all, sorry.

Remember, some of use get 1000+ emails a day and do hundreds of reviews.
our ability to remember a random review done at a random time with no
context at all would be taxing even if we only did one review a day,
right?

thanks,

greg k-h
