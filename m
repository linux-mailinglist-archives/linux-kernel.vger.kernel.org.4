Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D057619A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKDOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:54:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD212EF48;
        Fri,  4 Nov 2022 07:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BD8B82E10;
        Fri,  4 Nov 2022 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4EC433C1;
        Fri,  4 Nov 2022 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573649;
        bh=GI0z9yOWEheAT9rWm3eZD+z+H5fsvDLn/t0L/B+368E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GXuGtyGbs3aFDrbSF7fgR5dmfYYA0qAjxxfw9NWqWQu2+wVvr9TR3Zc8/mktkO69/
         Lzormhb+/KogWJvqBqg/eQvqhOYfmYhpY8bYUpU/qJPe+qJ5hCNMP7WaO0OifRMMtl
         M+R3WToZEdXefdI0ek55M7TdFSM1MB3U5228Mr5+h0VFQgHEdqnBCU4K/UMs4pl1+I
         xiF7plN0w9/8k549+1FUoZLXfutv61xpKTW++gRGnMXOcDw85c4Spx5SrYxGEK02T5
         xsnwXtiQsJb7CNHgnh74JALwC7aiz0r+as/HkroP+gLaHRCbVEihaM63wX/MXARokW
         ul7XGEtbOsC9w==
Date:   Fri, 4 Nov 2022 15:54:06 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for XP-PEN Deco LW
In-Reply-To: <20221029161240.15548-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211041553500.29912@cbobk.fhfr.pm>
References: <20221029161240.15548-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022, José Expósito wrote:

> v1 -> v2: https://lore.kernel.org/linux-input/20221028081656.GA19766@elementary/T/
> 
>  - Barnabás Pőcze: Use strstarts() instead of a custom implementation
> 
> v2 -> v3: https://lore.kernel.org/linux-input/20221029145511.GA7941@elementary/T/
> 
>  - Mia Kanashi: When using the USB dongle, do not fetch battery until
>    the tablet is paired
> 
> José Expósito (2):
>   HID: input: do not query XP-PEN Deco LW battery
>   HID: uclogic: Add support for XP-PEN Deco LW
> 
>  drivers/hid/hid-input.c          |  6 +++
>  drivers/hid/hid-uclogic-params.c | 73 ++++++++++++++++++++++++++++++++
>  drivers/hid/hid-uclogic-rdesc.c  | 34 +++++++++++++++
>  drivers/hid/hid-uclogic-rdesc.h  |  7 +++
>  4 files changed, 120 insertions(+)

Now in hid.git#for-6.2/uclogic.

-- 
Jiri Kosina
SUSE Labs

