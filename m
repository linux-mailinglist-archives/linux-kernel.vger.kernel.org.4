Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F106D533C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDCVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjDCVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:15:34 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8D44B7;
        Mon,  3 Apr 2023 14:15:33 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (unknown [IPv6:2a04:ee41:1:104e:5a23:1854:3475:1ad6])
        by mail11.truemail.it (Postfix) with ESMTPA id 07D4920B6B;
        Mon,  3 Apr 2023 23:15:31 +0200 (CEST)
Date:   Mon, 3 Apr 2023 23:15:29 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
Message-ID: <ZCtB8Vu4Brm3G639@francesco-nb.int.toradex.com>
References: <20230330101752.429804-1-francesco@dolcini.it>
 <20230330101752.429804-2-francesco@dolcini.it>
 <20230403210622.GA1740065-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403210622.GA1740065-robh@kernel.org>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:06:22PM -0500, Rob Herring wrote:
> On Thu, Mar 30, 2023 at 12:17:51PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > SN65DSI8[34] device supports burst video mode and non-burst video mode
> > with sync events or with sync pulses packet transmission as described in
> > the DSI specification.
> > 
> > Add property to select the expected mode, this allows for example to
> > select a mode that is compatible with the DSI host interface.
> 
> Why does this need to be in DT?

> The source and sink drivers should know what their capabilities are
> and pick the best common one.

Is there a best mode? Isn't this a decision how do we want the 2 peers
to communicate?

For the MIPI-DSI Linux/DRM experts: am I missing something? Is there
another way to have a DSI video sink to ask for a specific mode?

(I copied this from an existing DSI panel binding).

Francesco

