Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473445FAF37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJKJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:21:07 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0A5FAEA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:20:54 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id 99543FA7B7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:20:52 +0100 (IST)
Received: (qmail 28527 invoked from network); 11 Oct 2022 09:20:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2022 09:20:52 -0000
Date:   Tue, 11 Oct 2022 10:20:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Intermittent boot failure after 6492fed7d8c9 (v6.0-rc1)
Message-ID: <20221011092050.gnh3dr5iqdvvrgs5@techsingularity.net>
References: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
 <CAJZ5v0j9JyDZupNnQUsTUVv0WapGjK7b5S-4ewZ8-b=HOret2Q@mail.gmail.com>
 <20221010174526.3yi7nziokwwpr63s@techsingularity.net>
 <CAJZ5v0je1dS4xSG46r64s8G5sJHjiziX92GBaKXaxueTim3wJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0je1dS4xSG46r64s8G5sJHjiziX92GBaKXaxueTim3wJA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 08:29:05PM +0200, Rafael J. Wysocki wrote:
> > It failed 3/10 times.
> 
> This is still not acceptable.
> 

Agreed.

> > That's less than the previous 5/10 failures but I
> > cannot be certain it helped without running a lot more boot tests. The
> > failure happens in the same function as before.
> 
> I've overlooked the fact that acpi_install_fixed_event_handler()
> enables the event on success, so it is a bug to call it when the
> handler is not ready.
> 
> It should help to only enable the event after running cmos_do_probe()
> where the driver data pointer is set, so please try the attached
> patch.

Looks good and it booted 10 times successfully.

-- 
Mel Gorman
SUSE Labs
