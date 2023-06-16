Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761DC733656
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjFPQow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjFPQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:44:43 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384330FC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=B7SGOkiscnERiAu/chzqiMg1nhVPxRPZ/YgqKvyvPsE=;
        b=pSmSd9+anlIP0e76+zXPTo/HA52x7Mm5ZEZqKmavfPuFcWVHLZqD2Uu3jQ4271LzkQwPnkhp20hUi
         i0DTepyLcVhdSS6XYQ/UiYDDmXgITvT7kKRLrloQlzBBoHdRfRmvxrhyMspaR0C3mYNtnSQZW/WJ9F
         CGbC61h/v6eLoKak1Dpn/ePWS6DM+yRiatk+o8ihPYa+HXi8+uU0cEPX0vIRyaRjsZV0t934nnliWu
         Mmmt48+WhUOZ6L8vLWvjC+XytoNuuuSCM7cdLCIhgb2yArbmXZOWu8q5pKHA90QyAN9k6WH7W2oktA
         itGo9HvDQo+472k2ZddrPZl3qkF+p4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=B7SGOkiscnERiAu/chzqiMg1nhVPxRPZ/YgqKvyvPsE=;
        b=xjRbRyrFD+VqtofV2snBUmCgShetOF1iVZX/2RRz6cM3nEtzIVAAWqqzlY3u1wWWr6hmbMPLeUJ7V
         6Ycf0bECg==
X-HalOne-ID: 13ef398d-0c65-11ee-9b26-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 13ef398d-0c65-11ee-9b26-99461c6a3fe8;
        Fri, 16 Jun 2023 16:44:38 +0000 (UTC)
Date:   Fri, 16 Jun 2023 18:44:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: boe-tv101wum-nl6: Drop surplus prepare
 tracking
Message-ID: <20230616164437.GC1697490@ravnborg.org>
References: <20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org>
 <20230615-fix-boe-tv101wum-nl6-v1-2-8ac378405fb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-fix-boe-tv101wum-nl6-v1-2-8ac378405fb7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

On Thu, Jun 15, 2023 at 10:21:38PM +0200, Linus Walleij wrote:
> The DRM panel core already keeps track of if the panel is already
> prepared so do not reimplement this.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

It would be good to rip it out for all panels so people do not copy
less optimal code.

	Sam
