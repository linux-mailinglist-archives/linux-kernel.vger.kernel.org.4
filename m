Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F2671C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjARMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjARMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:35:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 679AE577E0;
        Wed, 18 Jan 2023 04:00:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600C51477;
        Wed, 18 Jan 2023 04:00:44 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17CEF3F71A;
        Wed, 18 Jan 2023 03:59:59 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/6] arch_topology: Build cacheinfo from primary CPU
Date:   Wed, 18 Jan 2023 11:55:59 +0000
Message-Id: <167404285593.885445.6219705651301997538.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104183033.755668-1-pierre.gondois@arm.com>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023 19:30:23 +0100, Pierre Gondois wrote:
> v2:
>  - Applied renaming/formatting comments from v1.
>  - Check CACHE_TYPE_VALID flag in pppt.c.
> v3:
>  - Applied Sudeep's suggestions (for patch 5/5):
>    - Renaming allocate_cache_info() -> fecth_cache_info()
>    - Updated error message
>    - Extract an inline allocate_cache_info() function
>  - Re-run checkpatch with --strict option
> v4:
>  - Remove RISC-V's implementation of init_cache_level() as not
>    necessary.
>  - Add patch: 'cacheinfo: Check 'cache-unified' property to count
>    cache leaves' to increase the number of leaves at a cache level
>    when no cache-size property is found.
>  - In cacheinfo: Use RISC-V's init_cache_level() [...],
>    make 'levels', 'leaves' and 'level' unsigned int to match
>    of_property_read_u32()'s parameters signedness.
> 
> [...]

Applied to sudeep.holla/linux (for-next/cacheinfo), thanks!

[1/6] cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
      https://git.kernel.org/sudeep.holla/c/c3719bd9eeb2
[2/6] cacheinfo: Return error code in init_of_cache_level()
      https://git.kernel.org/sudeep.holla/c/8844c3df001b
[3/6] cacheinfo: Check 'cache-unified' property to count cache leaves
      https://git.kernel.org/sudeep.holla/c/de0df442ee49
[4/6] ACPI: PPTT: Remove acpi_find_cache_levels()
      https://git.kernel.org/sudeep.holla/c/fa4d566a605b
[5/6] ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
      https://git.kernel.org/sudeep.holla/c/bd500361a937
[6/6] arch_topology: Build cacheinfo from primary CPU
      https://git.kernel.org/sudeep.holla/c/5944ce092b97

--
Regards,
Sudeep

