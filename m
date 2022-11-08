Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209EE62192D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKHQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiKHQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:13:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1003BE35;
        Tue,  8 Nov 2022 08:13:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C66B1FB;
        Tue,  8 Nov 2022 08:13:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3373F73D;
        Tue,  8 Nov 2022 08:13:17 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:13:15 +0000
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
        Peter Chen <peter.chen@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/5] ACPI: PPTT: Remove acpi_find_cache_levels()
Message-ID: <20221108161315.lmm3sakza5quyzlv@bogus>
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108110424.166896-4-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:04:19PM +0100, Pierre Gondois wrote:
> acpi_find_cache_levels() is used at a single place and is short
> enough to be merged into the calling function. The removal allows
> an easier renaming of the calling function in the next patch.
>
> Also reorder the parameters in the 'reversed Christmas tree' order.

Not sure if the above is worth mentioning explicitly. Even if you do,
'parameters' sounds very confusing to at-least me. I was searching for
the changes is some function parameters to understand what it was and
finally realised you meant the stack variable declaration order here.
Right ?


Other than that, it looks good.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
