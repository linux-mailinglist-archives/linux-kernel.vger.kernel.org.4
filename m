Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68860CC09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiJYMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:38:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3390189C2D;
        Tue, 25 Oct 2022 05:38:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07AECD6E;
        Tue, 25 Oct 2022 05:38:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F9D3F7B4;
        Tue, 25 Oct 2022 05:38:48 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:38:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] ACPICA: add missing macro ACPI_FUNCTION_TRACE() for
 ns_repair_HID()
Message-ID: <20221025123846.o6ufodigshvyqhqj@bogus>
References: <20221025113643.79743-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025113643.79743-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

On Tue, Oct 25, 2022 at 07:36:43PM +0800, Xiongfeng Wang wrote:
> The following commit add function tracing macros for the namespace repair
> mechanism.
> 
>   commit 0766efdf9a9d24eaefe260c787f49af225018b16
>   ACPICA: Add function trace macros to improve debugging
> 
> But it missed the trace macro for the entry of ns_repair_HID(). Let's
> add it.
>

Generally all ACPICA changes need to be submitted to the upstream project
via GitHub at https://github.com/acpica/acpica. It will be imported to the
Linux project from there.

-- 
Regards,
Sudeep
