Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF56BD81D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCPSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478049897;
        Thu, 16 Mar 2023 11:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43727620DE;
        Thu, 16 Mar 2023 18:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC3EC4339B;
        Thu, 16 Mar 2023 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678991132;
        bh=OI2Ulcxo7phfbJjhEgvVVLJPAd96fwMi7GpTSkmZpoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MMLEL8WJUzEXkO7glK+hQV+88BBnzRyPTtZq6fnaKE9UA5v+wYg6g19ZdHuwZF6Rh
         PUsaGnIbIU72f2bme0RvLZ2EA80BCR3sWRQrOyymL17nKet+wNYZ1mqSqB3ZquULQx
         ibOmke4rJ2Kd57ERM4ESNNb9hvf6k4iGpNUNq2tQRtM/xueu8z6T7l1rNfZ7yrcaGA
         +/w7VSbHIwaQY45yNmIDqMjxVtnyg4qBDUH82Qx4z9cxMNxn6lxX/qGev5xmzlJnsh
         IKjoMYgcaOGfh7lJAgxxeHZojb3HNq3UcAww11Tv6Y3062men50hGNW3XRNr28ozNH
         V9pi8MyOGznwg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pcsI6-000f2d-9f;
        Thu, 16 Mar 2023 18:25:30 +0000
MIME-Version: 1.0
Date:   Thu, 16 Mar 2023 18:25:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        tglx@linutronix.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/bcm-6345-l1: show MMIO address
In-Reply-To: <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
References: <20230316180701.783785-1-noltari@gmail.com>
 <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3950053c3e55fe89f61332c1b24fa0ed@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, noltari@gmail.com, jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-16 18:13, Florian Fainelli wrote:
> On 3/16/23 11:07, Álvaro Fernández Rojas wrote:
>> It's safe to show MMIO address.
>> 
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> 
> This is going to be the kernel virtual address, and while on MIPS it
> is easy to resolve to the physical address because these platforms map
> registers through KSEG0/1, on other platforms like ARM/ARM64 the
> kernel virtual addresses are pretty meaningless unless what you want
> to debug is how ioremap() mapped the address.
> 
> I would rather do the following change:
> 
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c 
> b/drivers/irqchip/irq-bcm6345-l1.c
> index 1bd0621c4ce2..832957d363a4 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -261,6 +261,8 @@ static int __init bcm6345_l1_init_one(struct
> device_node *dn,
>         if (!cpu->map_base)
>                 return -ENOMEM;
> 
> +       request_mem_region(res.start, sz, res.name);
> +
>         for (i = 0; i < n_words; i++) {
>                 cpu->enable_cache[i] = 0;
>                 __raw_writel(0, cpu->map_base + reg_enable(intc, i));
> 
> such that this shows up in /proc/iomem. WDYT?

That's certainly much more useful in general.

Also, the current pr_info() is probably pretty useless, given
that the OP was trying to circumvent the obfuscation. Either
printing the PA or removing the message altogether would be
good.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
