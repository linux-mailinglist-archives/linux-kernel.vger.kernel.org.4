Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C144636B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiKWU30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiKWU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:28:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017326580;
        Wed, 23 Nov 2022 12:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0431AB8247C;
        Wed, 23 Nov 2022 20:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9788C433D6;
        Wed, 23 Nov 2022 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669234956;
        bh=uABD5zhOnxuybVnqVEWMhMVs8HTJrHo49h2z8JUBLFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gPJwb5Q4GbKGxwpiyFJWt3wCmeVuscemeSro1WzSD5lFZUssmJioEJaDrvR4HWIqn
         GZDJmFAC6Pl966g244sWqBsZyqWibmVau7OaXh8+/cWkzI1nizzEMZsnt9jtktuGcZ
         LkoGkI3ISodKni45MbhMrdiRJbOZ6Von+LM6bCIYD1bycKfOt8Odf9c1p0d6XIeoJR
         ps1SAtNMDnJfDtPnpB6uyNKn0kCvEIlvPmwbvOhz4xxILNX6EvgXNzdkLXxVyW5Pa1
         0l2s15vt1mdPjcoF998aQMl1bcUsa+J2JWda3lCUhZlSH3TzJQG/kOx1S6jKAw9uhW
         6RSIx1xP6RRWQ==
Date:   Wed, 23 Nov 2022 20:35:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/9] Add '__adis_enable_irq()'
Message-ID: <20221123203510.28333ef0@jic23-huawei>
In-Reply-To: <20221122082757.449452-1-ramona.bolboaca@analog.com>
References: <20221122082757.449452-1-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 22 Nov 2022 10:27:48 +0200
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Added implementation for '__adis_enable_irq()' and called it instead of
> 'adis_enable_irq()' inside '__adis_initial_startup()'.
> Replaced 'adis_initial_startup()' calls in probe, with its unlocked
> variant.

Given how near we are to the merge window I've queued this up on the
togreg branch and marked the first patch for stable.

Thanks,

Jonathan

> 
> changes in v3:
>  new patches: 1,2
>  changed commit message for patches 2-9
> 
> changes in v4:
>  squashed patches 1 & 2 from v3
> 
> changes in v5:
>  fix compilation error
> 
>  changes in v6:
>   changed commit message of patch 1: added more information related to the fix
> 
> Ramona Bolboaca (9):
>   iio: adis: add '__adis_enable_irq()' implementation
>   iio: accel: adis16201: Call '__adis_initial_startup()' in probe
>   iio: accel: adis16209: Call '__adis_initial_startup()' in probe
>   iio: gyro: adis16136: Call '__adis_initial_startup()' in probe
>   iio: gyro: adis16260: Call '__adis_initial_startup()' in probe
>   iio: imu: adis16400: Call '__adis_initial_startup()' in probe
>   staging: iio: accel: adis16203: Call '__adis_initial_startup()'
>   staging: iio: accel: adis16240: Call '__adis_initial_startup()'
>   iio: imu: adis: Remove adis_initial_startup function
> 
>  drivers/iio/accel/adis16201.c         |  2 +-
>  drivers/iio/accel/adis16209.c         |  2 +-
>  drivers/iio/gyro/adis16136.c          |  2 +-
>  drivers/iio/gyro/adis16260.c          |  2 +-
>  drivers/iio/imu/adis.c                | 28 ++++++++++-----------------
>  drivers/iio/imu/adis16400.c           |  2 +-
>  drivers/staging/iio/accel/adis16203.c |  2 +-
>  drivers/staging/iio/accel/adis16240.c |  2 +-
>  include/linux/iio/imu/adis.h          | 17 ++++++++--------
>  9 files changed, 25 insertions(+), 34 deletions(-)
> 

