Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE9637A32
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKXNqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiKXNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:46:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0632A100B3E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:46:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B8623A;
        Thu, 24 Nov 2022 05:46:31 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5873F73B;
        Thu, 24 Nov 2022 05:46:23 -0800 (PST)
Date:   Thu, 24 Nov 2022 13:46:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Cristian Maruss <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm_scpi: modify to support acpi
Message-ID: <20221124134621.tmlfk7pqbmbkmzal@bogus>
References: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
 <Y39PetDhm9fpycwo@FVFF77S0Q05N>
 <tencent_049E1A8275A0742F2374507E@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_049E1A8275A0742F2374507E@qq.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:23:58PM +0800, 王洪辉 wrote:
> When boot from uefi on phytium ft2004(arm64) platform, can't show temp &
> freq of cpu, but well if boot from uboot for same kernel binary file.

Yes the same binary must work if you use right ACPI methods/AML/tables.
Everything needed is there in the kernel, you need to write correct ACPI
firmware/tables.

> So i modified arm_scpi.c and scpi-hwmon.c as patch, and tested ok.
>

Yes tested to be OK, but definitely not acceptable. Please look at the
ACPI spec and improve your firmware to use what you need here. I have
given all the pointers now.

-- 
Regards,
Sudeep
