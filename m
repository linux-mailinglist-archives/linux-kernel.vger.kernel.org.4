Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6195B8FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiINUtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiINUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:49:28 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657D72ED6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:49:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d16so8644659ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3mV+8hivhbbPWMIU69Q7PYVjXSPqTMHW70DKIKwtAgA=;
        b=l5Bp25Iv500wTd6MmHDbFfof87eWDydEutYpcO6vnWH8bh4KiA7+t6qY9YzAe/2zKu
         ztvdRBLFtT0pzCeqRzMTVLopOkPSh+mx/6XPVHMVMg0hky/xGCw+M07cE2PxZ+jwSP96
         /jeCq/dBPMvP5MkxmOttK9uWOTz2ir17r51Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3mV+8hivhbbPWMIU69Q7PYVjXSPqTMHW70DKIKwtAgA=;
        b=yeBnYaVb01Nv8czzmWO2CdHLJ5DDTc2EI79JWYJ+0NfQXjlcL1Z94/gQWjgiQHafFo
         U+UwSntaebL0mku2WhBKwMsRtAQNrSrRepuO9vuhmotAk7FmvZZwF8lujG+LjHilQndI
         KVpLK5VbesPo6RWIq2GzyFbNt5YipR4l4wrg6lqkUbIf9G/mXUEnu2Yl9CxOrsdWuPfa
         3Yoe44QCBzfuWciCaZ+wsrjbpapSzWWyooGy/IPionY5DwRxsJqD8g6ecTCdWqBFwwlC
         5RS4AgVHhZHE7Qg8OctulziMXgMun9aUb8im2mBCRue6tbWW2iuniLCT5MmZamUt66OR
         ERrQ==
X-Gm-Message-State: ACgBeo3zoaiHY+xV3GIRLmiFqPu3RM8ft+y/aYI/zgC+Qil1mu2x2CMe
        10zaIQTgIOOLt7pSvOVEtRQgbF4sPwncIA==
X-Google-Smtp-Source: AA6agR4WPOHQL+6SLMBIOnBeUsFgw9xlYC62YmwWEJJrmUVgv5NXlXdb8y/LyJtcHmrCr6IBjRk62w==
X-Received: by 2002:a92:dcc7:0:b0:2f1:6fd6:4e61 with SMTP id b7-20020a92dcc7000000b002f16fd64e61mr15287521ilr.89.1663188565142;
        Wed, 14 Sep 2022 13:49:25 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id s2-20020a02cc82000000b00349ba0d1137sm130424jap.24.2022.09.14.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 13:49:24 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:49:22 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YyI+Un/1O36Zkuko@google.com>
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <YyC8C+ZH57xHYLQd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyC8C+ZH57xHYLQd@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 08:21:15PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 12, 2022 at 04:13:10PM -0600, Raul E Rangel wrote:
> > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > interrupt should wake the system. This change exposes that bit via
> > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> > before arming an IRQ to wake the system.
> 
> ...
> 
> >  static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
> >  					    u32 hwirq, u8 triggering,
> >  					    u8 polarity, u8 shareable,
> > +					    u8 wake_capable,
> >  					    struct acpi_irq_parse_one_ctx *ctx)
> 
> This function is used only in scope of a single C-file. Why instead not
> converting it to use some internal structure and acpi_irq_parse_one_cb()
> becomes like:
> 
> 	struct internal_struct s;
> 
>         switch (ares->type) {
> 	case ACPI_RESOURCE_TYPE_IRQ:
> 		...fill internal_struct...
> 		break;
> 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> 		...fill internal_struct...
> 		break;
> 	default:
> 		return AE_OK;
> 
> 	acpi_irq_parse_one_match(&s);
> 	return AE_CTRL_TERMINATE;
> 
> ?
> 
> ...
> 
> > +			acpi_dev_get_irqresource(res,
> > +						 ext_irq->interrupts[index],
> > +						 ext_irq->triggering,
> > +						 ext_irq->polarity,
> > +						 ext_irq->shareable,
> > +						 ext_irq->wake_capable, false);
> 
> Ditto.
> 
> Actually it can be shared structure for these too.
> 

I tried your suggestion, but I honestly think it hurts readability. It's
also a little scary because the compiler doesn't guarantee all the
members of the struct are filled out, unlike having the explicit
parameters. Here is the patch:

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 5483cf9a28e3a0..8549ccefa5d03c 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -139,35 +139,37 @@ struct acpi_irq_parse_one_ctx {
 	struct irq_fwspec *fwspec;
 };
 
+struct acpi_irq_parse_one_match_params {
+	struct fwnode_handle *fwnode;
+	u32 hwirq;
+	u8 triggering;
+	u8 polarity;
+	u8 shareable;
+	u8 wake_capable;
+}
+
 /**
- * acpi_irq_parse_one_match - Handle a matching IRQ resource.
- * @fwnode: matching fwnode
- * @hwirq: hardware IRQ number
- * @triggering: triggering attributes of hwirq
- * @polarity: polarity attributes of hwirq
- * @polarity: polarity attributes of hwirq
- * @shareable: shareable attributes of hwirq
- * @wake_capable: wake capable attribute of hwirq
+ * acpi_irq_parse_update_ctx - Handle a matching IRQ resource.
+ * @params: IRQ parameters
  * @ctx: acpi_irq_parse_one_ctx updated by this function
  *
  * Description:
- * Handle a matching IRQ resource by populating the given ctx with
- * the information passed.
+ * Update the given ctx with the IRQ information passed.
  */
-static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
-					    u32 hwirq, u8 triggering,
-					    u8 polarity, u8 shareable,
-					    u8 wake_capable,
-					    struct acpi_irq_parse_one_ctx *ctx)
+static inline void
+acpi_irq_parse_update_ctx(const struct parse_one_match *params,
+			  struct acpi_irq_parse_one_ctx *ctx)
 {
-	if (!fwnode)
+	if (!params->fwnode)
 		return;
 	ctx->rc = 0;
-	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable,
-					     wake_capable);
-	ctx->fwspec->fwnode = fwnode;
-	ctx->fwspec->param[0] = hwirq;
-	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
+	*ctx->res_flags =
+		acpi_dev_irq_flags(params->triggering, params->polarity,
+				   params->shareable, params->wake_capable);
+	ctx->fwspec->fwnode = params->fwnode;
+	ctx->fwspec->param[0] = params->hwirq;
+	ctx->fwspec->param[1] =
+		acpi_dev_get_irq_type(params->triggering, params->polarity);
 	ctx->fwspec->param_count = 2;
 }
 
@@ -182,7 +184,7 @@ static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
  * might contain multiple interrupts we check if the index is within this
  * one's interrupt array, otherwise we subtract the current resource IRQ
  * count from the lookup index to prepare for the next resource.
- * Once a match is found we call acpi_irq_parse_one_match to populate
+ * Once a match is found we call acpi_irq_parse_update_ctx to populate
  * the result and end the walk by returning AE_CTRL_TERMINATE.
  *
  * Return:
@@ -195,7 +197,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 	struct acpi_irq_parse_one_ctx *ctx = context;
 	struct acpi_resource_irq *irq;
 	struct acpi_resource_extended_irq *eirq;
-	struct fwnode_handle *fwnode;
+	struct acpi_irq_parse_one_match_params params = {0};
 
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
@@ -204,11 +206,13 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 			ctx->index -= irq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
-		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
-					 irq->triggering, irq->polarity,
-					 irq->shareable, irq->wake_capable,
-					 ctx);
+		params.fwnode =
+			acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
+		params.hwirq = irq->interrupts[ctx->index];
+		params.triggering = irq->triggering;
+		params.polarity = irq->polarity;
+		params.shareable = irq->shareable;
+		params.wake_capable = irq->wake_capable;
 		return AE_CTRL_TERMINATE;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		eirq = &ares->data.extended_irq;
@@ -218,16 +222,22 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 			ctx->index -= eirq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source,
-						      eirq->interrupts[ctx->index]);
-		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
-					 eirq->triggering, eirq->polarity,
-					 eirq->shareable, eirq->wake_capable,
-					 ctx);
-		return AE_CTRL_TERMINATE;
+		params.fwnode = acpi_get_irq_source_fwhandle(
+			&eirq->resource_source, eirq->interrupts[ctx->index]);
+		params.hwirq = eirq->interrupts[ctx->index];
+		params.triggering = eirq->triggering;
+		params.polarity = eirq->polarity;
+		params.shareable = eirq->shareable;
+		params.wake_capable = eirq->wake_capable;
+
+	default:
+		return AE_OK;
 	}
 
-	return AE_OK;
+	acpi_irq_parse_update_ctx(&params, ctx);
+
+	return AE_CTRL_TERMINATE;
+
 }
 
 /**

