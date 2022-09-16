Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A55BADBB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIPNAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIPNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:00:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF62E9E6AD;
        Fri, 16 Sep 2022 06:00:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03EF1153B;
        Fri, 16 Sep 2022 06:00:46 -0700 (PDT)
Received: from bogus (unknown [10.57.48.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1274E3F71A;
        Fri, 16 Sep 2022 06:00:37 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:00:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        thomas.abraham@arm.com
Subject: Re: [PATCH] coresight: acpi: add support for amba dma-330 controller
Message-ID: <20220916130035.pbavnjlkh4envc4u@bogus>
References: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:49:12PM +0530, Vijayenthiran Subramaniam wrote:
> Add ACPI ID for ARM DMA-330 controller to AMBA id list to allow the
> probing of the device.
>

$subject pattern is simply wrong and I see this is just copied from the
previous commit which makes no sense here. You can see other commits
and their patterns too.

Use prefix something like:
ACPI / amba:
or
ACPI: amba:

Also "Add .." in the $subject sounds like you are adding the support for
the controller here which is not the case.

Enable support for Arm Primecell PL330 dma controller
Or
Add Arm Primecell PL330 dma controller to the supported list

-- 
Regards,
Sudeep
