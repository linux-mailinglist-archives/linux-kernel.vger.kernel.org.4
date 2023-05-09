Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726ED6FC12C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjEIIFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjEIIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:04:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264624486
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:03:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683619294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=eMr7kTFMUlmaeQa9Zx7MAkjo9zp42kBtdSCukBJMdQk=;
        b=jjL/Q04F4XW0L1YJU8WTd019Pc7gmtp7TOCwsGaX2QMAUZ6dUvHf+8v26046Hhz9AWhqnd
        3ODDjSDF+hbcnsx5LsnOuZg1SWhyPn55lsY0QGq7/s+s4P8t7At2cWkmjCUpVd5e67M7zJ
        WZiNS7IWt0ab1SM+xxqRhq2uNYVTHlOKdyo7t+pelOulxaWIi6QVft8jGoVGe6687upF9R
        WuFP/GfzYOhhhX8hQFuG1XE8lokvYwWhSDpI3bGG6kCDfWGLB4DY5Gy7UK5mIbdXA52GHo
        ZtNmNSdcm+Xo3nilBsX6bGsOsStawTfNAPEfeYDttZa6StHvr/4YtbCas0Fzpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683619294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=eMr7kTFMUlmaeQa9Zx7MAkjo9zp42kBtdSCukBJMdQk=;
        b=E9vneM9TMksa46ap3gXs/0Icgch4ssdEzPB4AYsSwKdZG8ilzcDLPJCvZIpNwdoPWgKrMA
        ZKO+8iLKlwIk//DQ==
To:     Nipun Gupta <nipun.gupta@amd.com>, gregkh@linuxfoundation.org,
        maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        pablo.cascon@amd.com, Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <20230508140950.12717-1-nipun.gupta@amd.com>
Date:   Tue, 09 May 2023 10:01:34 +0200
Message-ID: <874jom2ash.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08 2023 at 19:39, Nipun Gupta wrote:
> Add CDX-MSI domain with gic-its domain as parent, to support MSI
> for CDX devices. CDX devices allocate MSIs from the CDX domain.
> Also, introduce APIs to alloc and free IRQs for CDX domain.

This lacks any information why this needs to have a separate irq domain
and what this is about. Changelogs need to be self explanatory and
providing a link to some RFC series which might have more information
does not cut it.

Just for the record. I complained about the useless changelog in that
RFC series already.

> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

This Signed-off-by chain is broken. If this is intended to denote
co-authorship, then please follow:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> +static struct irq_chip cdx_msi_irq_chip = {
> +	.name			= "CDX-MSI",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_affinity	= msi_domain_set_affinity,
> +	.irq_write_msi_msg	= cdx_msi_write_msg
> +};

The only real CDX specific functionality here is a CDX specific
irq_write_msi_msg() callback, right?

And I gave you a pointer how this should be handled, but instead of
helping this effort along you go off and implement it differently just
because. Sigh!

Thanks,

        tglx
