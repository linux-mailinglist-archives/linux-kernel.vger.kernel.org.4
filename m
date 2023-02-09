Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011A690FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBISFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjBISFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:05:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B051EC7B;
        Thu,  9 Feb 2023 10:05:12 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675965910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yitrJTSVgf3Z/6id4va7dmBz3yFsi4rHDr48pn/op6U=;
        b=Bts66rpHIar8KFiHsLUPQHvL6dzUFcCw+F4qR1ydHK3zArsYEBIoDqUM1q+9eOOIn0GAPU
        pCV2gzRae0QYI2BDX035MgNcrTwPGJ+6NRywh0/9cAjDaOgjMH6gzpmsiMwD6iskXzYDb1
        mBhbPI6wTpb66euioTK8VEvUZGUYNuOLOUBljl5sRjkaXrV7cfN60FLga3n5ihdx5WHKU+
        KR/VlkMy12H1DNTze2KG6PZl4SOcI89/ZE9NJ+RqiBKS2rCgjp+HCjqPk+HGkHysYV01t5
        OiNM3td95kLqAUESd0/wiePC9mdsE+iRtuoLNEGHN/AOvvCTIFEck0E6BIsYAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675965910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yitrJTSVgf3Z/6id4va7dmBz3yFsi4rHDr48pn/op6U=;
        b=oCAdkC5e7NfL0Ge92ds3/oJTJiqW37g8YY4ETO+pMJjPkzXnW7y6ri7ULnNCzX94EY4TQV
        NrqJ4/7NMdegGcCA==
To:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used
 for S2Idle
In-Reply-To: <20230209152123.3186930-2-jaz@semihalf.com>
References: <20230209152123.3186930-1-jaz@semihalf.com>
 <20230209152123.3186930-2-jaz@semihalf.com>
Date:   Thu, 09 Feb 2023 19:05:09 +0100
Message-ID: <87ttzu1zqi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09 2023 at 15:21, Grzegorz Jaszczyk wrote:
> +
> +static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {

What is AMD specific about this?

> +	.check = virt_pmc_s2idle_notify,
> +};

...

> +
> +MODULE_DESCRIPTION("Virtual PMC Driver");

Lacks MODULE_LICENSE("GPL")

Thanks,

        tglx
