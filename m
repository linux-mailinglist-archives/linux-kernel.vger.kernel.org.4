Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E15F6397
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiJFJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiJFJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:25:23 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9C6C745;
        Thu,  6 Oct 2022 02:25:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 58EF33200945;
        Thu,  6 Oct 2022 05:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Oct 2022 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665048320; x=1665134720; bh=PDJN5drlFIgF1wf1zolVhehgPHyW
        o6xzy+C4FPyCMwk=; b=rX48AQn/zQ2vS6B4NwzWYDHstsYZKWy/VutXfvsOk/Lg
        WOCNCWcm8GALu3dibJWVpx8TJPwqSn28ic+mXmzZ7jqeUGDraeYGJcuf7LSn+WCh
        OLVg7sBktmb8GgShdsrJVYTz47Ute3nbUB1md8x69WDl+BoNMYOk9IRXEQeuymYv
        tEMJ3e2eyXQGslV/LuV1vzKSv+Y0dU5ixJBOmyf/LL7WUMEcIbr3MWbOPzdXmxFM
        dyBomaHbMHWtPyVFJ1sfK/iOqT4N2Qn+ukj3A55aWui/fJIbfh8GL6+w3Oa4HaaP
        9CnJ+criHPGDuYmtmI2YXSNgTm86wL1EeaK2h35GbQ==
X-ME-Sender: <xms:AJ8-YzUvWGapfAxgVhNQnjUi8sUYcWdrr31Zb6xHlTloKkd10TZunQ>
    <xme:AJ8-Y7nTx5AnYXiM8djN5v2mnxuGHL-au-VIHqv082AYZ9vc9_W__PCnrgdv6Qf8j
    GzuyOLeE-uinhqyGkE>
X-ME-Received: <xmr:AJ8-Y_azOcHcI0GqiyAneRuhbm6X0jzUZrYFaFJI137iYhQ4rxE5jyF6_68BQW9lZqJPBOeZ6OQtZ67SvpK1pNfLffu36FeSnL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:AJ8-Y-UP7JxC0JII1qjg7eU2MdLVZChVHQIyIYdlaxqOEE1EHsjIsw>
    <xmx:AJ8-Y9lGKmCDgTeTdoT6x_Q8lKZm4UR5rsA4Em9uKhOwO3GHf7ZmiA>
    <xmx:AJ8-Y7e8mezkLaRf8_wXyLl1R9BmJU4Ml_Qp49exskT2qY-b9LB4cw>
    <xmx:AJ8-YzhiItF6dHMWwRxMJ4puBMNEncBQDvJplzgFD9fxJ0YILe0tzw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 05:25:19 -0400 (EDT)
Date:   Thu, 6 Oct 2022 20:25:16 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mac_scsi: Replace NO_IRQ by 0
In-Reply-To: <f11593e75ba2e18e3b76989255cbb2e53a0213b4.1665034244.git.christophe.leroy@csgroup.eu>
Message-ID: <5fb75ac2-678a-dd6e-2e68-7485b2d2ce5f@linux-m68k.org>
References: <f11593e75ba2e18e3b76989255cbb2e53a0213b4.1665034244.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022, Christophe Leroy wrote:

> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 

Yes. The core NCR5380 driver is used on ARM etc. where NO_IRQ is -1 as 
well as on powerpc where it is 0.

> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 

Sorry, I must be missing something.

You seem to be saying that this driver could be re-used in the context of 
openfirmware/device trees if it avoided using the NO_IRQ. Do I have that 
right?

Or are you changing NO_IRQ semantics tree-wide for some reason explained 
somewhere else?

If it is the former, shouldn't you reverse the comment in 
arch/powerpc/include/asm/irq.h, which says the macro is to be used in the 
way this driver (and others) use it?

If it is the latter, shouldn't you address the use of NO_IRQ in the core 
NCR5380 driver rather than just this wrapper?

Moreover, wouldn't it make more sense to fix the callers of 
irq_of_parse_and_map(), since they appear to be abusing the NO_IRQ macro?

For example, drivers/ata/sata_dwc_460ex.c actually does #define NO_IRQ 0 
and then expects irq_of_parse_and_map() will somehow use the same value to 
mean the same thing...

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/scsi/mac_scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
> index 2e511697fce3..e4df2b501e8b 100644
> --- a/drivers/scsi/mac_scsi.c
> +++ b/drivers/scsi/mac_scsi.c
> @@ -478,7 +478,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
>  	if (irq)
>  		instance->irq = irq->start;
>  	else
> -		instance->irq = NO_IRQ;
> +		instance->irq = 0;
>  
>  	hostdata = shost_priv(instance);
>  	hostdata->base = pio_mem->start;
> @@ -495,7 +495,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
>  	if (error)
>  		goto fail_init;
>  
> -	if (instance->irq != NO_IRQ) {
> +	if (instance->irq) {
>  		error = request_irq(instance->irq, macscsi_intr, IRQF_SHARED,
>  		                    "NCR5380", instance);
>  		if (error)
> @@ -514,7 +514,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  fail_host:
> -	if (instance->irq != NO_IRQ)
> +	if (instance->irq)
>  		free_irq(instance->irq, instance);
>  fail_irq:
>  	NCR5380_exit(instance);
> @@ -528,7 +528,7 @@ static int __exit mac_scsi_remove(struct platform_device *pdev)
>  	struct Scsi_Host *instance = platform_get_drvdata(pdev);
>  
>  	scsi_remove_host(instance);
> -	if (instance->irq != NO_IRQ)
> +	if (instance->irq)
>  		free_irq(instance->irq, instance);
>  	NCR5380_exit(instance);
>  	scsi_host_put(instance);
> 
