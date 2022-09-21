Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521B75C0048
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIUOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIUOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:48:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BCAB8E9BB;
        Wed, 21 Sep 2022 07:48:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C63C913D5;
        Wed, 21 Sep 2022 07:49:04 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106183F73B;
        Wed, 21 Sep 2022 07:48:56 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:48:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>,
        rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        thomas.abraham@arm.com
Subject: Re: [PATCH v2] ACPI: amba: Add Arm DMA-330 controller to the
 supported list
Message-ID: <20220921144854.ug2adlz4ofglxp7c@bogus>
References: <20220921143244.16282-1-vijayenthiran.subramaniam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921143244.16282-1-vijayenthiran.subramaniam@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:02:44PM +0530, Vijayenthiran Subramaniam wrote:
> Add ACPI ID for ARM DMA-330 controller to AMBA id supported list to
> allow the probing of the device.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Rafael,

I assume you will pick this up as usual through your tree.

-- 
Regards,
Sudeep
