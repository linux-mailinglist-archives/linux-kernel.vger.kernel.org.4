Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158F85FB2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJKNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJKNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:10:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B82840E06
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yD6dq6mWv/oAZeVLBkOfygELdSpwFWFvf2UNh0QXmhw=; b=3KmgPpQ+qdLELXp4Q7YF/YWWj/
        UapXkf6EUUYOzdkxDeUEiF2SHQE2Is26bJy4IJHez2sMYGHI9FXh2KOdghGPhc0/yrXpyj41ysjQU
        IInXFZ0rDbud2dP55UklOi7BNkxdJPUjo/kxSb8lC1DBhDmMsOox8MBMnbs80xmPOcg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oiF1N-001iI5-J0; Tue, 11 Oct 2022 15:10:09 +0200
Date:   Tue, 11 Oct 2022 15:10:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     yexingchen116@gmail.com
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] soc: Use generic_handle_domain_irq()
Message-ID: <Y0VrMUB3gNhrpXCR@lunn.ch>
References: <20221011032050.322951-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011032050.322951-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:20:50AM +0000, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>

Please make your subject line more specific. soc: dove: would be
better.

/linux/drivers/soc/dove$ git log --oneline .
ec8f24b7faaf treewide: Add SPDX license identifier - Makefile/Kconfig
dc37a2525271 soc: Convert to using %pOFn instead of device_node.name
b24413180f56 License cleanup: add SPDX GPL-2.0 license identifier to files with no license
f2591b993ec9 soc: dove: constify reset_control_ops structures
67098119abeb soc: dove: add legacy support to PMU driver
2376692416b7 soc: dove: Let genpd deal with disabling of unused PM domains
bd0b9ac405e1 genirq: Remove irq argument from irq flow handlers
b838c950b397 soc: dove: Prepare irq handler for irq argument removal
5230347ea70a soc: dove: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
44e259ac909f ARM: dove: create a proper PMU driver for power domains, PMU IRQs and resets

dove is an important keyword to get the right people to look at your
patch. Few people are interested in soc, they are interested in a
specific devices within soc.

> 
> Replace generic_handle_irq(irq_find_mapping()) with
> generic_handle_domain_irq().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
