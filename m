Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640E621901
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiKHQEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiKHQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:04:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A3EB140FF;
        Tue,  8 Nov 2022 08:04:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334E223A;
        Tue,  8 Nov 2022 08:03:35 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB0E3F73D;
        Tue,  8 Nov 2022 08:03:25 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:03:23 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/5] cacheinfo: Use riscv's init_cache_level() as generic
 OF implem
Message-ID: <20221108160323.kqotjshjxr67muaf@bogus>
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108110424.166896-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:04:17PM +0100, Pierre Gondois wrote:
> Riscv's implementation of init_of_cache_level() is following
> the Devicetree Specification v0.3 regarding caches, cf.:
> - s3.7.3 'Internal (L1) Cache Properties'
> - s3.8 'Multi-level and Shared Cache Nodes'
> 
> Allow reusing the implementation by moving it.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
