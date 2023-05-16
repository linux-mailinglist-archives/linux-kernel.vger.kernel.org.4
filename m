Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442007045CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjEPHKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEPHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A718E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D73B61731
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C0C433EF;
        Tue, 16 May 2023 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684221044;
        bh=itgY1OoynJ33UD7YWBBTynOLyfv2xqaDwaXmK/eyuU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyR5BEfOEcsXZpc75NFptQlSfsF58e1Cgh40e+FYp5zqc+2zkGmWj2t2i8bdNFW1S
         merOTTCap76rN05c++hHmX5AhUlTz0fZCSrDlq1k0cFRMkvGzIm/7Eoyw29eIyuRFY
         ZbNQ+8z0lqot8Xyi6uzfBzw2ysBTaKklGGEoCikqpXhm+p4llQQKt4nZ+rgfUkKdXP
         GodayOBy9mpQt5Nd8qAJysK4lDWdTFHuyjoe0/Dc7QkRVNri1xQXc1oA0vOQigeuvR
         cT/ikWPPfubXNDlhaUoXp45cEcs2NjP5xzieC82NliyxlgNfnYfDUXDio9FWC/3xp7
         cumzgsik/NFXA==
Date:   Tue, 16 May 2023 08:10:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] mfd: Switch i2c drivers back to use .probe()
Message-ID: <20230516071040.GD10825@google.com>
References: <20230515182752.10050-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515182752.10050-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Uwe Kleine-König wrote:

> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1:
>  - Rebase on top of mfd-for-next from
>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git and resolve
>    a conflict with commit c20e8c5b1203 ("mfd: rk808: Split into core and
>    i2c")

Good work!

Applied, thanks

-- 
Lee Jones [李琼斯]
