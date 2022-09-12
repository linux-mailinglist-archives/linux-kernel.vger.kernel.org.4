Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE115B55D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiILIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiILIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:20:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D830120BE;
        Mon, 12 Sep 2022 01:20:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7068E113E;
        Mon, 12 Sep 2022 01:20:28 -0700 (PDT)
Received: from bogus (unknown [10.57.48.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AD063F73D;
        Mon, 12 Sep 2022 01:20:20 -0700 (PDT)
Date:   Mon, 12 Sep 2022 09:20:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PCC: Release resources on address space setup
 failure path
Message-ID: <20220912082017.iuo35tyzwvq3dqfn@bogus>
References: <20220909153320.501347-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909153320.501347-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:33:19PM -0300, Rafael Mendonca wrote:
> The allocated memory for the pcc_data struct doesn't get freed under an
> error path in pcc_mbox_request_channel() or acpi_os_ioremap(). Also, the
> PCC mailbox channel doesn't get freed under an error path in
> acpi_os_ioremap().
> 

Thanks!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
