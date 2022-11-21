Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA46321D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKUMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKUMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:23:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B10EB742EC;
        Mon, 21 Nov 2022 04:23:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75A61FB;
        Mon, 21 Nov 2022 04:23:41 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.69.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FC53F587;
        Mon, 21 Nov 2022 04:23:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:22:44 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
Message-ID: <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:

[...]

> v3 -> v4:
> - remove the chunk of code skipping metrics updates when the CPU was utilized
> - include new test results and more benchmarks in the cover letter

[...]

It's been some time so I just wanted to bump this, what do you think
about this v4? Doug has already tested it, resuls for his machine are
attached to the v3 thread.

Thanks,
Kajetan
