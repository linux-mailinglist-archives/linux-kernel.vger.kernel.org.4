Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B196717B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjARJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjARJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:21:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1755D113;
        Wed, 18 Jan 2023 00:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FD0EB81B7C;
        Wed, 18 Jan 2023 08:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA4BC433EF;
        Wed, 18 Jan 2023 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674031426;
        bh=uBrpKtIVouSZXTyCK2yKdIiaTlwn4rB2jgmpNTB0o4I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jg4TS+p2YOzL+Y4NZPwiGdT9eF5O24/zevNrrlsYJs+8ClVTaT4P2FlsjAGCfnWNx
         5FtENdQoau/zsHs1uUA/cKxhcWqDoFIEu2PE+1LlQGpyI058XeMFCr/BSMO/fWGn65
         GYCTHH2ZUIE1D+n2IObTGIo+S5MOhQqhssFhKS48eNRU2uY3fKUZJxjNqy2wJL9xD9
         Q8H/Ntu72EYx6ldYMMm5d8kFki0CjA72RQtqjGHVXlil9G+/YmzqRQ94GvDvvaKdDK
         d50iCPmle0dLsjjvY05vKFscffgqCCHHfhusf/TJVWhUalHJ6ypTLJqseaMPxD/M7Y
         xJzVuyc0+39VQ==
Date:   Wed, 18 Jan 2023 09:43:47 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Waddoups <mwaddoups@gmail.com>
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Deco 01 V2
In-Reply-To: <20221226123456.14822-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2301180943340.1734@cbobk.fhfr.pm>
References: <20221226123456.14822-1-jose.exposito89@gmail.com>
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

On Mon, 26 Dec 2022, José Expósito wrote:

> The XP-PEN Deco 01 V2 is a UGEE v2 device with a frame with 8 buttons.
> Its pen has 2 buttons, supports tilt and pressure.
> 
> Add its ID in order to support the device.
> 
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/839
> Tested-by: Mark Waddoups <mwaddoups@gmail.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied to hid.git#for-6.2/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

