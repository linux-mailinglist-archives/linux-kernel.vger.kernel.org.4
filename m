Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074AC5B5C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiILOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiILOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:43:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6464356D4;
        Mon, 12 Sep 2022 07:43:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [89.101.193.67])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BED83415;
        Mon, 12 Sep 2022 16:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662993779;
        bh=ccRPjt0jL/UArIKLQwcpBPxkVwm+dSo2VE+EeGx2Jw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIQgVsn9h1zSrmVuKQzOs283pXk+5ETPcGdanQnVGYGBK1v9q6ejPUBZO4nRzmcn1
         fv/2NJIf7oiAGALopLXDm3v5n0bAtgAKLVmb9H5t2Kg3IOF65H18ZC7yA3GbOPMDx4
         HdpB94ETAodNmFUvXsj2dLnzezfbYwGm+KSRi+3w=
Date:   Mon, 12 Sep 2022 17:42:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH v1 2/2] Revert "drm/bridge: ti-sn65dsi86: Implement
 bridge connector operations for DP"
Message-ID: <Yx9FZDKjOcS9wmcI@pendragon.ideasonboard.com>
References: <20220912113856.817188-1-robert.foss@linaro.org>
 <20220912113856.817188-3-robert.foss@linaro.org>
 <CAD=FV=WrH2AAFxV72FZqk-=xU8jzCn6KtcbZRYJAaCwhmvSWmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WrH2AAFxV72FZqk-=xU8jzCn6KtcbZRYJAaCwhmvSWmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 03:29:52PM +0100, Doug Anderson wrote:
> On Mon, Sep 12, 2022 at 12:43 PM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > As reported by Laurent in response to this commit[1], this functionality should
> > not be implemented using the devicetree, because of this let's revert this series
> > for now.
> >
> > This reverts commit c312b0df3b13e4c533743bb2c37fd1bc237368e5.
> >
> > [1] https://lore.kernel.org/all/20220902153906.31000-2-macroalpha82@gmail.com/
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 28 ---------------------------
> >  1 file changed, 28 deletions(-)
> 
> Any chance you got confused and reverted the wrong patch? This
> ti-sn65dsi86 patch doesn't seem relevant to the problems talked about
> in the commit or the cover letter. Maybe I'm missing something?

Aarghhh I missed that when checking the cover letter :-( This indeed
seems wrong.

-- 
Regards,

Laurent Pinchart
