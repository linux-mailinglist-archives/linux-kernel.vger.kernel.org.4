Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976036030DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJRQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:39:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BBE4C18;
        Tue, 18 Oct 2022 09:39:03 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4DD4B24000A;
        Tue, 18 Oct 2022 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666111142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVf/LFQwTDxYim0lXIuNtjFeL0tUH+DcAxTcPv+CPgA=;
        b=SUBWz/s3Y+gGBGTL1P64sWl35eh9uS5ayeC3LEveE1hBUgEK7YY7IGoMdVfGH8zkiZB66F
        q9AVsdngr9WmRAZLU8HJtPd5FrjzX0SLcm/EOuYNNEjZ24AIdRBP8XZcO4k4uQN3MR3rPF
        oenXNv0C9hf9jxe11D9tmK9ZsNH61zysxKvGM4lJgtDZRq4EeYB3XR93wfx7LsA1xMul83
        uHXvebmSf+is8/gnUv4GcbJlIfbtpjabeWu3rKVcYJkj/4DUQF6mtaZo2BagObvJduHmyS
        4xCJKcfj9MMAAEu0bJjqcFX7yTQnM3js/qCAf0p4k4Q7yXVUOqOMH3mMwivCfQ==
Date:   Tue, 18 Oct 2022 18:38:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
Message-ID: <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
References: <5887691.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5887691.lOV4Wx5bFT@kreacher>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> ordering issue") overlooked the fact that cmos_do_probe() depended
> on the preparations carried out by cmos_wake_setup() and the wake
> alarm stopped working after the ordering of them had been changed.
> 
> [...]

Applied, thanks!

[1/1] rtc: rtc-cmos: Fix wake alarm breakage
      commit: 0782b66ed2fbb035dda76111df0954515e417b24

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
