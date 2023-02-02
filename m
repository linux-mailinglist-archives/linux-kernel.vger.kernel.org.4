Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6E6872FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjBBB2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjBBB2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:28:48 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A6D586ACAF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:28:47 -0800 (PST)
Received: (qmail 510475 invoked by uid 1000); 1 Feb 2023 20:28:46 -0500
Date:   Wed, 1 Feb 2023 20:28:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: do not clear gadget driver.bus
Message-ID: <Y9sRziGWT+WyGRwn@rowland.harvard.edu>
References: <20230201220125.GD2415@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201220125.GD2415@darkstar.musicnaut.iki.fi>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:01:25AM +0200, Aaro Koskinen wrote:
> Before the commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> gadget driver.bus was unused. For whatever reason, many UDC drivers set
> this field explicitly to NULL in udc_start(). With the newly added gadget
> bus, doing this will crash the driver during the attach.
> 
> The problem was first reported, fixed and tested with OMAP UDC and g_ether.
> Other drivers are changed based on code analysis only.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>
