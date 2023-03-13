Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009126B7032
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCMHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:40:08 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EA38E99
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:40:06 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:40:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678693203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8JZphjW0n2op01bARpnHNrvcY7IH/n7CLxamm4rdnY=;
        b=Yw+2ggnAuoTzyU0K3i7WkHmrHAuNZEqxbmMNmfPB9sQmF6Cn11Ikn6T4+tm2HnCFcE0KWP
        mVFYkcJgNg6MBTIAn7Y+wcAFh8jFXV16TeaJLJ4NbFgj6//b7ncUSm7q4+Y9U1//JNDV8i
        i6qLKLYAGOjZdDZ6TkEdw6GXXZobsKA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Leitner <richard.leitner@skidata.com>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: Use of_property_read_bool() for boolean properties
Message-ID: <20230313074001.GA24063@g0hl1n.net>
References: <20230310144729.1545857-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144729.1545857-1-robh@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:28AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c |  6 +++---
>  drivers/usb/chipidea/core.c        |  2 +-
>  drivers/usb/dwc2/params.c          |  3 +--
>  drivers/usb/host/ehci-ppc-of.c     |  6 +++---
>  drivers/usb/host/fsl-mph-dr-of.c   |  7 ++-----
>  drivers/usb/misc/usb251xb.c        | 33 ++++++++++++++----------------
>  6 files changed, 25 insertions(+), 32 deletions(-)

Thanks for the patch. Please feel free to add

Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

for the usb251xb changes.

regards;rl
