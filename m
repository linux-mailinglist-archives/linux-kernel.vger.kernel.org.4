Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15186646FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLHMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:37:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9563F0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:37:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AC861EEE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D8FC433D6;
        Thu,  8 Dec 2022 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670503029;
        bh=fXyzH1LH5lU+poyHpZ/O1MGVuOSm8R3U0I37gOgLsMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLW8JdnADsQOuqU2FDudUAvCv7OfN8pMv9/Cb2SRVjlUIPvWjQUP8K8JKbuaiZgzA
         apCWlr4Yt/fBjXLy1fDzs9TvESUIrvnIaKcb1Tw8sn3GUuCtPgs6xxSIxOJypa2cjM
         duXDAYF1qB/EP0c90XX+0XocFFOCykTJUOwT527do+WPb1de14U2OKDubUkT7NxGti
         i+NVbeqELXH72dB0fyhv8uC8uS9ZJoN9OMKO6ToR5T3pvW/QC9e3nALmQK54JWAeiw
         u+LnAx0m7L5GlD3UK3CWdDaDoHKHfsIDL/zz2/phkHOAOjRNrgCRXvj/kJ6cgyk7fI
         taspwFmva8aKA==
Date:   Thu, 8 Dec 2022 12:37:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mfd: rohm-bd9576: convert to i2c's .probe_new()
Message-ID: <Y5HacR5Q1LTk4JJH@google.com>
References: <20221121102454.15664-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121102454.15664-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022, Uwe Kleine-König wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/rohm-bd9576.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
