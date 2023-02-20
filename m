Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463A669C56B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBTGt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBTGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:49:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE5B77C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 22:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A8C5B80959
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822BAC433EF;
        Mon, 20 Feb 2023 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676875762;
        bh=sVELIR1aCeRiEfB3+3CY4D+1Y+UQ3y/Aa5WRDygQsx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFKqAYWJLEUGMOpsAt7vJc2qCG7PEkaSrv2kWSdHdqh12+mTpQ6euVTBEYA0OHuSc
         25jSHvnFzo+o2a9mFKs142Qztdgttg/Zd1adDxCL+KVCRoT99Iw6LqX4tjrpU/Kd9n
         l/hBe/Z1TIyPq3+XGaB38Y5iiR+u6lTPgu+OSV2U=
Date:   Mon, 20 Feb 2023 07:49:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shibo Li <zzutcyha@163.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix Sparse warning in rtl871x_xmit.c
Message-ID: <Y/MX76sdTPoEuYi4@kroah.com>
References: <20230220060823.11472-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220060823.11472-1-zzutcyha@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:08:23AM +0000, Shibo Li wrote:
> This patch fixes the following warning in rtl871x_xmit.c:
> 
> WARNING: Possible repeated word: 'very'
> + * Must be very very cautious...

Sorry but this text is correct.

thanks,

greg k-h
