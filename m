Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A36284B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiKNQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiKNQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:12:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57D2425C42;
        Mon, 14 Nov 2022 08:12:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6196F23A;
        Mon, 14 Nov 2022 08:12:17 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4655E3F663;
        Mon, 14 Nov 2022 08:12:09 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:12:06 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Enable FPDT on arm64
Message-ID: <20221114161206.5sspq25v57ddco4o@bogus>
References: <20221109174720.203723-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109174720.203723-1-jeremy.linton@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:47:20AM -0600, Jeremy Linton wrote:
> FPDT provides some boot timing records useful for analyzing
> parts of the UEFI boot stack. Given the existing code works
> on arm64, and allows reading the values without utilizing
> /dev/mem it seems like a good idea to turn it on.
>

FWIW, this looks good to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Rafael,

Just saw this marked as "Handled Elsewhere", do you prefer to be merged
via arm64 or other tree ? This doesn't have any arm64 changes, just Kconfig
and doc changes. Let us know.

-- 
Regards,
Sudeep
