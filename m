Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1E61F719
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiKGPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiKGPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:05:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 49C07B49F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:05:11 -0800 (PST)
Received: (qmail 436479 invoked by uid 1000); 7 Nov 2022 10:05:09 -0500
Date:   Mon, 7 Nov 2022 10:05:09 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     gregkh@linuxfoundation.org, m.grzeschik@pengutronix.de,
        albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [Patch v5] usb: core: stop USB enumeration if too many retries
Message-ID: <Y2kepYpgenoFOVnH@rowland.harvard.edu>
References: <20221107072754.3336357-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107072754.3336357-1-raychi@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:27:54PM +0800, Ray Chi wrote:
> When a broken USB accessory connects to a USB host, usbcore might
> keep doing enumeration retries. If the host has a watchdog mechanism,
> the kernel panic will happen on the host.
> 
> This patch provides an attribute early_stop to limit the numbers of retries
> for each port of a hub. If a port was marked with early_stop attribute,
> unsuccessful connection attempts will fail quickly. In addition, if an
> early_stop port has failed to initialize, it will ignore all future
> connection events until early_stop attribute is clear.
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---

This looks good.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
