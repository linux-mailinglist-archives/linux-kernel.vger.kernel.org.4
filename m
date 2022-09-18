Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE35BBE69
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIROdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIROd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:33:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F401F602;
        Sun, 18 Sep 2022 07:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0B84CE08CB;
        Sun, 18 Sep 2022 14:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5447C433D6;
        Sun, 18 Sep 2022 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663511600;
        bh=XEQaAbKO4JRklsuepue2nJS2tct/eD81nhfKowWer48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThbV+GEMWA4Ad8gJP1Oec6m/KJ1ip9vFgxxkC0LElKhZqveB8OTOvYiLQKyJEz93Q
         HJNYRa+JyPsSfjv3Xsra7aYnZoRpf2zY4Z8c3HEDzbgHubPL6PcBzBnY9+9UswYrQk
         oFmIpURLsK+0js1LJwXpeCTed+bsCZ62bdP6schcoSd533WeJ4Y534scHRwkzka2kv
         A2O0CrNv0PAJx70KZqzaCTIKQMvsg9qC5avjYoFKWJLpW+9cTB8knfriqps9Cq8GlL
         F93p4tiz0z7oVcPm8zYBgmtEnExp5ZotLDU1IQRlJxaBWKSy2FtSEpfNZLjUblNVDS
         n8grGziPVX91Q==
Date:   Sun, 18 Sep 2022 15:33:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add support for LTC2499 ADC
Message-ID: <20220918153325.2c8d0d6c@jic23-huawei>
In-Reply-To: <20220916140922.2506248-1-ciprian.regus@analog.com>
References: <20220916140922.2506248-1-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 17:09:17 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The LTC2499 is a 16-channel (eight differential), 24-bit,
> ADC with Easy Drive technology and a 2-wire, I2C interface.
> 
> This adds support for the LTC2499 ADC by extending the LTC2497
> driver.
> 
> There is also a removal of a MAINTAINERS entry duplicate.
> 
> Note: This fix is required to be applied first:
> https://patchwork.kernel.org/project/linux-iio/patch/20220815091647.1523532-1-dzagorui@cisco.com

Hi Ciprian,

This lost it's version number which may confuse some scripts etc.
Anyhow, I think b4 found the right versions.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look.

Note I plan to rebase that tree sometime this week so don't use it
as a stable base.

I tweaked a few patch descriptions to make it clearer what driver was involved
and wrapped long lines whilst applying.

Thanks,

Jonathan
> 
> Ciprian Regus (5):
>   Remove duplicate matching entry
>   dt-bindings: iio: adc: Add docs for LTC2499
>   Add MAINTAINERS entries for LTC2497 and LTC2496
>   drivers: iio: adc: LTC2499 support
>   drivers: iio: adc: Rename the LTC2499 iio device
> 
>  .../bindings/iio/adc/lltc,ltc2497.yaml        |  8 ++-
>  MAINTAINERS                                   |  3 +-
>  drivers/iio/adc/ltc2496.c                     |  9 ++-
>  drivers/iio/adc/ltc2497-core.c                | 12 +++-
>  drivers/iio/adc/ltc2497.c                     | 63 +++++++++++++++++--
>  drivers/iio/adc/ltc2497.h                     |  6 ++
>  6 files changed, 90 insertions(+), 11 deletions(-)
> 

