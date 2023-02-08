Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCA68EE62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBHL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBHL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:59:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0AD146160
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:59:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B63CF1477;
        Wed,  8 Feb 2023 04:00:22 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3703F703;
        Wed,  8 Feb 2023 03:59:39 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:59:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ye.xingchen@zte.com.cn
Cc:     liviu.dudau@arm.com, lpieralisi@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] bus: vexpress-config: =?utf-8?B?dXNlwqBkZXZtX3BsYXRm?=
 =?utf-8?B?b3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Message-ID: <20230208115936.odlv7rvn6adziemv@bogus>
References: <202302081538546730084@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302081538546730084@zte.com.cn>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:38:54PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>

LGTM,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Not sure if you plan to take all such changes together or you want individual
patches to be picked up by respective maintainers, let me know.

-- 
Regards,
Sudeep
