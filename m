Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C164945D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLKNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiLKNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:07:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE811178;
        Sun, 11 Dec 2022 05:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C7CB80AC6;
        Sun, 11 Dec 2022 13:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FA4C433D2;
        Sun, 11 Dec 2022 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670764020;
        bh=zlEEnDEYnGZC8VDXKbRLr8RsO6R1qwR+5PT7aelj26I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7PHIb/JYq4vvmARmt9XhYN6Oi/mPw8cbE4/yNGB0x6SjAMg0zeOK4wt3il7WJL/s
         dyuOeuUm7eQA8lA1Iyxn1yMej738KnrpoYQMjG/BKOd9I9hwpXDXVRV3CIM+dZ3547
         o6kgKBu1O1jINsGB/yevapnSxJlwbCWcSzs5JNltOvYP/kdGnM/NH1o8jJW76kiBXz
         ZCBJtzR8yFIyEiQfhex8CkfikJdaVZwPcMYOq7r6TcI5BoJAmR01A2cc4gRS5cXKtz
         d+K4Lb4M0L6UD8R5oZRCOkMkLjxg7GUSjSUPBF2CYi/8TQ3MQd9aRtP3qsksRrVQel
         YFUBPp4rx8S7w==
Date:   Sun, 11 Dec 2022 13:19:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 04/11] iio: light: tsl2563: Make use of the macros
 from bits.h
Message-ID: <20221211131954.6cfceef9@jic23-huawei>
In-Reply-To: <20221207190348.9347-4-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
        <20221207190348.9347-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed,  7 Dec 2022 21:03:41 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Make use of BIT() and GENMASK() where it makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Ferry Toth <ftoth@exalondelft.nl>
Hohum.  I did look to see if there was a GENMASK() patch before
the comment on previous one, but apparently my eyes skipped
this one! Ignore me as this is exactly what I was suggesting.

J
