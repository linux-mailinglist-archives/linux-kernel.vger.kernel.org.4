Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D56E8EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjDTJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjDTJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:51:39 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825D2D44
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:51:37 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 36C8021540;
        Thu, 20 Apr 2023 11:51:33 +0200 (CEST)
Date:   Thu, 20 Apr 2023 11:51:29 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/6] drm/bridge: tc358768: Add
 atomic_get_input_bus_fmts() implementation
Message-ID: <ZEELIaSFhZkyofh9@francesco-nb.int.toradex.com>
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-7-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330095941.428122-7-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Thu, Mar 30, 2023 at 11:59:41AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add atomic_get_input_bus_fmts() implementation, tc358768 has a parallel
> RGB input interface with the actual bus format depending on the amount
> of parallel input data lines.
> 
> Without this change when the tc358768 is used with less than 24bit the
> color mapping is completely wrong.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Just a gently ping on this specific patch.

Other patches on this series received some comments that should be
addressed, however at the moment on that I am quite stuck.

On the other hand this patch is completely independent.

I do also have queued multiple fixes on the same driver that I
would need to send and would love to avoid conflicts between my own
patches.

How would you suggest to move forward? Can someone have a look at this
patch and if deemed fine can someone just pick it up?

Francesco

