Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91525601628
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJQSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJQSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:20:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C7A61A3A9;
        Mon, 17 Oct 2022 11:20:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D90B1042;
        Mon, 17 Oct 2022 11:20:45 -0700 (PDT)
Received: from bogus (unknown [10.57.36.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9A7B3F792;
        Mon, 17 Oct 2022 11:20:37 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:20:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manank Patel <pmanank200502@gmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes: 91cefefb6991 ("ACPI: PCC: replace
 wait_for_completion()")
Message-ID: <20221017182035.3g67uudttl6k5gag@bogus>
References: <20221013130311.1433314-1-pmanank200502@gmail.com>
 <20221017174915.45916-1-pmanank200502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017174915.45916-1-pmanank200502@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:19:15PM +0530, Manank Patel wrote:
> Fixed unintentional u32 overflow by changing PCC_CMD_WAIT_RETRIES_NUM to 500ULL
> 

You just need to add the below fixes line above Signed-off tag. You seemed
to have changed the $subject. Please retain the origin subject

Please post it again cleanly marking it as v2(as in the subject must be
[PATCH v2] "ACPI: PCC: Fix unintentional integer overflow" 

Fixes: 91cefefb6991 ("ACPI: PCC: replace wait_for_completion()")
> Signed-off-by: Manank Patel <pmanank200502@gmail.com>
> ---
> 
> Sorry for the spam, I made a mistake in the previous patch (I had a confusion 
> in your suggestion about the Fixes tag).As you would have realised, i'm new 
> to this, and not so familiar with the workflow (Though I have read the 
> Documentation). Let me know if you have any suggestions.
>

Add a text here pointing what changed from v1->v2
v1->v2:
	Change the macro itself ULL instead typecasting in the code

Hope this helps.

With all these changes incorporated in v2, you can add my
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
