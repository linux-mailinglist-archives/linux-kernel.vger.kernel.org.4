Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB46B42CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjCJOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCJOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEC116C27;
        Fri, 10 Mar 2023 06:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13E060D29;
        Fri, 10 Mar 2023 14:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D880DC433EF;
        Fri, 10 Mar 2023 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678457176;
        bh=Gnnoq5rEYTSfL1/eq63BF8ajSPWfoKqKskp1qaY3HZk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=a3FuLhyYzJLFSEL31cmNveXLmKYk0B8wPFoTWb1FaoLyG8eJbC7DVvJhSx+bv9iX+
         yfF/MWA7GbE6j21DZDG3xhfGHG7ikMuA+DZBFDR68hjcLFMZuDaOTjQkbTKIlT7Sk7
         x0knL8VOCtgUpEHbJ++rxPan/7fuKiodOIgBltOHAdPXiRSVy1te70sRnCS8MwHreR
         +LtAba3D2pqv5ZIInMsK9tUps1GpC2Ue38CoeEUwoAe53js6Q2BthFCSJ5P6fEIlKM
         Q0Bsoufve+BHTRUb/icNtvr5UttbxYEU0W54CzFO87Q7iJhNT+9aEamhHBTI2nGTj2
         utBHdghrBdwbg==
Date:   Fri, 10 Mar 2023 15:06:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] HID: kye: Add support for all kye tablets
In-Reply-To: <20230207043318.23842-1-mmyangfl@gmail.com>
Message-ID: <nycvar.YFH.7.76.2303101506030.1142@cbobk.fhfr.pm>
References: <20230207043318.23842-1-mmyangfl@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023, David Yang wrote:

> This series refactor kye tablet descriptor fixup routine, by using a
> template and filling parameters on the fly, and add support for all
> possible kye tablets.
> ---
> v2: fix missing rsize assignment
> v3: fix geometry
> v4: split patches
> 
> David Yang (4):
>   HID: kye: Rewrite tablet descriptor fixup routine
>   HID: kye: Generate tablet fixup descriptors on the fly
>   HID: kye: Sort kye devices
>   HID: kye: Add support for all kye tablets
> 
>  drivers/hid/hid-ids.h    |   9 +-
>  drivers/hid/hid-kye.c    | 917 +++++++++++++++++----------------------
>  drivers/hid/hid-quirks.c |  14 +-
>  3 files changed, 414 insertions(+), 526 deletions(-)

Now queued in hid.git#for-6.4/kye, thanks David.

-- 
Jiri Kosina
SUSE Labs

