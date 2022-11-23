Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1B635A45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiKWKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiKWKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:35:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 762B1EE3B;
        Wed, 23 Nov 2022 02:20:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEBE1FB;
        Wed, 23 Nov 2022 02:20:19 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35CBB3F587;
        Wed, 23 Nov 2022 02:20:10 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:20:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, conor.dooley@microchip.com,
        apatel@ventanamicro.com, anup@brainfault.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Message-ID: <20221123102007.2hrncka2nnpxp75h@bogus>
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
 <57114829-c205-dece-abdb-1100947286d4@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57114829-c205-dece-abdb-1100947286d4@sholland.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:11:23PM -0600, Samuel Holland wrote:

[...]

> While the comment in include/linux/clockchips.h and the name of the flag
> imply that C3STOP is Intel-specific, it really isn't. The flag is used
> on ARM, MIPS, and PowerPC as well.
>

+1. I agree the name is confusing but it used to just indicate that the
timer is not always on and could stop in deeper CPU idle states. It probably
was introduced to be used on x86 for C3 state but it is used for other
purposes as well. May be one should have or even can now rename it to
something more appropriate, but I am sure it might trigger some bikeshedding
discussions 😉.

-- 
Regards,
Sudeep
