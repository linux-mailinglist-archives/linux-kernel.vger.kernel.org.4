Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5374BE5E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGHQEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGHQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6D1BB;
        Sat,  8 Jul 2023 09:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7638260D54;
        Sat,  8 Jul 2023 16:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7644C433C7;
        Sat,  8 Jul 2023 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688832258;
        bh=MRhyEB9kNam7Mn6pjt39h7NCBpwSVZ2sV/31d3TWsT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WBaBCvfJ5SZxWZmS9gM8T+dgSVlm4vLE3uBMNDOqq2zASPQR+rY+l7MghHzeIGjdM
         z1VenmrZMJzOtg5TOYgvz2oB30fKJaTFIQhFxEgLxZtbUVf45bhw0c7faV4TYycqp1
         ySjMrO+8Pw3P5Pm6Koa6QssrkFH6HFQj6Bp2znW3WA/exIx2qKDOL8acWNXRpcXGGD
         I6ykfPYexuooDFVSOqNrMaTZ4MK62k9gQXH5hCCiyZ8tARRssjE41UPCu8CrrVx+aH
         ZvBHtVbSNFuloNmy5T55piakA71M8YhMc9elgzDTuYDoPS/OzKJcnc5Nz3PZaCOity
         HqVcUxQzkerPA==
Date:   Sat, 8 Jul 2023 17:04:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 0/6] iio: adc: meson: add iio channels to read
 channel 7 mux inputs
Message-ID: <20230708170410.0885b8e4@jic23-huawei>
In-Reply-To: <20230707153322.114302-1-gnstark@sberdevices.ru>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
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

On Fri, 7 Jul 2023 18:27:37 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> From: George Stark <GNStark@sberdevices.ru>


All looks fine to me.  However, given earlier versions had various other reviewers
I'd like to leave it on list a little longer.

Jonathan

> 
> Changelog:
> 
> v1->v2:
> split refactoring patch [1] into 4 smaller patches, fix comment style
> 
> [1] https://lore.kernel.org/lkml/20230621062715.455652-2-gnstark@sberdevices.ru/
> 
> v2->v3:
> remove patch 'meson saradc: unite iio channel array definitions' [1] after discussion
> 
> patch 'meson saradc: add enum for iio channel array indexes'
>   - change enum items prefix from INDEX_ to NUM_ since name 'channel index' is
>   more relevant to channel array index in iio world and with 2 tables our array index is
>   not always equal to channel number
>   - resolve conflicts after deleting [1]
>   - update commit message, previous patch [2]
>   - return channel number for temp channel. It wasn't used and isn't used currently
>   but may need later
> 
> patch meson saradc: support reading from channel 7 mux inputs
>   - resolve conflicts after deleting [1]
>   - update commit message, previous patch [3]
>   - add routine find_channel_by_num to get channel by channel number
> 
> [1] https://lore.kernel.org/lkml/20230623022334.791026-4-gnstark@sberdevices.ru/
> [2] https://lore.kernel.org/lkml/20230623022334.791026-5-gnstark@sberdevices.ru/
> [3] https://lore.kernel.org/lkml/20230623022334.791026-7-gnstark@sberdevices.ru/
> 
> v3->v4:
> add new patch 'iio: adc: meson: remove unused timestamp channel' [1]
> 
> patch 'iio: adc: meson: move enums declaration before'
> 	update commit message, previous patch [2]
> patch 'iio: adc: meson: move meson_sar_adc_set_chan7_mux'
> 	update commit message, previous patch [3]
> patch 'iio: adc: meson: add enum for iio channel numbers'
> 	update commit message, previous patch [4]
> patch 'iio: adc: meson: add channel labels'
> 	update commit message, previous patch [5]
> 	change sprintf(label, "%s\n", "temp-sensor") to sprintf(label, "temp-sensor\n")
> patch 'iio: adc: meson: support reading from channel 7 mux'
> 	rewrite enum meson_sar_adc_chan7_mux_sel definition and
> 		read_label routine proposed by Andy [7], previous patch [6]
> 
> [1] https://lore.kernel.org/lkml/20230705160413.000062e7@Huawei.com/
> [2] https://lore.kernel.org/lkml/20230627224017.1724097-2-gnstark@sberdevices.ru/
> [3] https://lore.kernel.org/lkml/20230627224017.1724097-3-gnstark@sberdevices.ru/
> [4] https://lore.kernel.org/lkml/20230627224017.1724097-4-gnstark@sberdevices.ru/
> [5] https://lore.kernel.org/lkml/20230627224017.1724097-5-gnstark@sberdevices.ru/
> [6] https://lore.kernel.org/lkml/20230627224017.1724097-6-gnstark@sberdevices.ru/
> [7] https://lore.kernel.org/lkml/ZJwGCNA+ZURri24i@smile.fi.intel.com/
> 
> George Stark (6):
>   iio: adc: meson: remove unused timestamp channel
>   iio: adc: meson: move enums declaration before variables declaration
>   iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
>   iio: adc: meson: add enum for iio channel numbers
>   iio: adc: meson: add channel labels
>   iio: adc: meson: support reading from channel 7 mux inputs
> 
>  drivers/iio/adc/meson_saradc.c | 173 +++++++++++++++++++++++++--------
>  1 file changed, 134 insertions(+), 39 deletions(-)
> 

