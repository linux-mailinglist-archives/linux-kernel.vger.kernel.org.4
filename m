Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0247B61930C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiKDI60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKDI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:58:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0042982F;
        Fri,  4 Nov 2022 01:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F16EAB82C4D;
        Fri,  4 Nov 2022 08:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39691C433C1;
        Fri,  4 Nov 2022 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667552294;
        bh=/vXKlhhU+We45RGxL/wdL8ipSsCJDBrJ4C9Xe+tRaP4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PB1zjXNf/x5gl96k+Fh/4c/jOrmMHBPvOiUCG9OgGiEQEd5SSldcWBfjKDneW6WA5
         V9En+oY6+fYJUKm62RlmIVEJlRZqdMl1wMMCSyZypQsYv1/+flmm0bFGHIXWnVkAW0
         NqbhUPVxeKyjse3Cz6vDvE72bLFxu5flw4IaIVjT+BNydBsoQwkm0y/Qipsxaj7ygw
         UBV1CAQa3CDhALquFNhYV903bG+erNXKbWe+44avXt3r9L/3ZTImIbPmQ9BNx5DxOX
         wEpZF8PI+gacwEtUI3utnhJl51NXDXCAAzHCKOi5UHW7MMiSTFlR6HCFKFFMc/PSkt
         OskDBWyUWMDQw==
Date:   Fri, 4 Nov 2022 09:58:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Joshua Jun <joshuajun@vivaldi.net>
cc:     david.rheinsberg@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bogdan Petru <thonkdifferent@outlook.com>
Subject: Re: [PATCH] HID: wiimote: Add support for the DJ Hero turntable
In-Reply-To: <20221022222406.30757-1-joshuajun@vivaldi.net>
Message-ID: <nycvar.YFH.7.76.2211040957560.29912@cbobk.fhfr.pm>
References: <20221022222406.30757-1-joshuajun@vivaldi.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022, Joshua Jun wrote:

> This adds support for the turntable extension for Wiimote devices.
> 
> jstest-gtk and html5 gamepad tester show everything correctly
> but when trying to map the controller in software like rpcs3 or dolphin
> it currently doesn't map correctly

Applied to hid.git#for-6.2/wiimote. Thanks,

-- 
Jiri Kosina
SUSE Labs

