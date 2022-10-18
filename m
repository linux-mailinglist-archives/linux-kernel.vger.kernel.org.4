Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB61602AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJRL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJRL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FEBBF10;
        Tue, 18 Oct 2022 04:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F31A7B81DC8;
        Tue, 18 Oct 2022 11:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56134C433B5;
        Tue, 18 Oct 2022 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666094249;
        bh=8FvsBR6Slh211VH//PgMr8gLUn1AriwWsp/r5EzAR2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgwZ8+5KsXgCkl0mxD2grR0K16fef+34Y53L3T06C5PsfW1AwcNOxJvOnw+FuuWa2
         GuL513ohD9wuwACFeNRxPBcNxYh4jvqwkKC7CLhw5F0eamVZZH5DExbL8YkkkkPw6y
         2A0+JlOdMhVfXxAB46gaVamlg/phgRHaT/7YhhsM=
Date:   Tue, 18 Oct 2022 13:57:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v2] usb: ehci-orion: Extend DMA mask to 64 bit for AC5
 platform
Message-ID: <Y06UpnF6kgCdsiN7@kroah.com>
References: <20221018113401.32229-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018113401.32229-1-vadym.kochan@plvision.eu>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:34:00PM +0300, Vadym Kochan wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> AC5 is a 64-bit platform so extend the dma mask accordingly.
> 
> Checked this mask on armv7 a38x SoC (which has this
> USB controller) platform with simple fs ops on the storage device
> but on older 4.14 Linux version.

Odd line-wrapping.

That aside, I have no idea what this changelog text means at all.  What
is 4.14 here for?  Does this fix a specific commit id?  What is being
changed?  Why is it being changed?  What is happening?

confused,

greg k-h
