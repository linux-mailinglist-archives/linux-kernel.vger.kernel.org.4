Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF267184E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjARJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjARJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:55:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A9917E9;
        Wed, 18 Jan 2023 01:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D55BCE1B7B;
        Wed, 18 Jan 2023 09:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFCDC433D2;
        Wed, 18 Jan 2023 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032791;
        bh=3rR5NFZPdgUltcrnDeHPchHniZSq12mFPgNrAtdt01w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BYe0e2lYMHa18C150XrQbce2OxC0YxzULr0oNljzENHcgQqBD6rs7Qw1JkMY+EyI5
         8hlOxd2TTsPiACwS+NAmIIyBQwmBwwdvfJBoDyprLmbo7s0bMU5JnCP45u8y0P2woJ
         9iOCS/x6H4o2g0WgnQbyh9pd7xBfkx1HaP0DVUj0WT+CNMjJYYyM4/EIDvGTWJtr+R
         XlaFqagcQON4tdqaPBOSRUZhCjiSFY/6HPZiqfKMDM+LvFlLKG2yxV1bNoAlmHAH9N
         ICFs5zp8HPK3YB04y9Ubjtzwd8IS0yfsTeQ9aLcRsBNJaUrpBRMBDzFfODEN1WHmT/
         ame4lXeq/kYMg==
Date:   Wed, 18 Jan 2023 10:06:32 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of
 adev
In-Reply-To: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2301181006170.1734@cbobk.fhfr.pm>
References: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023, Andy Shevchenko wrote:

> The driver is enumerated on ACPI platforms, so adev is valid.
> Since there is no valid I²C ID table provided, there is no
> possibility to bind a device to this driver via user space.
> Hence, drop unneeded NULL check of adev.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied both to hid.git#for-6.3/i2c-hid. Thanks,

-- 
Jiri Kosina
SUSE Labs

