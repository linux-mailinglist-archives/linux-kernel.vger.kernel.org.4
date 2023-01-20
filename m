Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39D67564C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjATOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjATOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:02:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA28C45B1;
        Fri, 20 Jan 2023 06:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62DD9B8283E;
        Fri, 20 Jan 2023 14:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2EAC4339B;
        Fri, 20 Jan 2023 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674223338;
        bh=KRMFuk1bGCIviy/RhxXj4mxeIn4OVOHzt2ewftmaexM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQhg0bCZLY49ie0MIElWcCcTHJ8ram1Aj+alBttz6SMF2j8mwc4TYMksVqWY6CHG+
         Kl+vi0AZ923oeu0UWDccRlQqWRY46Ll8E37YJFZjDhrhvUbMXFlNxLaDT3t/5EEHKM
         YOvvqTtWwqfSrapTx3/bdEYuwZb6uRK3dXHnd1K22KdyTkNTd4xJaYntsUkqo5t3vG
         vg+iIYLxPkfKdUfZWm9gx3fEIboZfXppyCAW3cKHTp9P1gtydMyyVLFbXvk+ELvVHK
         NgWL3R9eiZxZ4Gqsi3JDk0lE6ysAqUe+kPdJyE2PyjzaohDCLvKRtcKN7TwfEIf7wz
         AqeEZkK+dhBYg==
Date:   Fri, 20 Jan 2023 14:02:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Parsons <lost.distance@yahoo.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 24/27] leds: remove asic3 driver
Message-ID: <Y8qe5GYk5oZLkpo5@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-25-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-25-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since ASIC3 MFD driver is removed, the LED support is also
> obsolete.
> 
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/Kconfig      |  11 ---
>  drivers/leds/Makefile     |   1 -
>  drivers/leds/leds-asic3.c | 177 --------------------------------------
>  3 files changed, 189 deletions(-)
>  delete mode 100644 drivers/leds/leds-asic3.c

Applied, thanks

-- 
Lee Jones [李琼斯]
