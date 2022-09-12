Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E85B5A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiILMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:33:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573F19C0C;
        Mon, 12 Sep 2022 05:33:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [89.101.193.67])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74E8E59D;
        Mon, 12 Sep 2022 14:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662986034;
        bh=OCONmltQ48JY/YT9CDPBBkFazBRp8ZnFJ3hSFJK1fdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPVtIkUEjXS4bAh+FpQWcljgMTF8Yu0sGxpznz++6eX4xXaNb0kp+yDCR1m54/oIK
         3LgUXp2+3lZm7yK5+29RSjQ3iZhh1zmaMI1Q2IlYmkGxWufXJupFchAg+OVI9K4fGt
         +ASpBdLYh5up9lRx2MRWvyVd/LjJjOoonXfH7EfQ=
Date:   Mon, 12 Sep 2022 15:33:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dianders@chromium.org, lkundrak@v3.sk,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, tzimmermann@suse.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: Re: [PATCH v1 0/2] Revert chrontel-ch7033 byteswap order series
Message-ID: <Yx8nI/AMk/Gu8o/J@pendragon.ideasonboard.com>
References: <20220912113856.817188-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220912113856.817188-1-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Sep 12, 2022 at 01:38:54PM +0200, Robert Foss wrote:
> After applying the "chrontel-ch7033: Add byteswap order option" series,
> Laurent reported an issues with the approach. Since no fix has been submitted
> for the issues outlined in time for the next kernel release, I'd like to
> revert this series for now.
> 
> Just to be clear I would very much like to see a v3 of this[1] series, where the
> issues outlined have been fixed.
> 
> [1] https://lore.kernel.org/all/20220902153906.31000-1-macroalpha82@gmail.com/
> 
> Robert Foss (2):
>   Revert "dt-bindings: Add byteswap order to chrontel ch7033"
>   Revert "drm/bridge: ti-sn65dsi86: Implement bridge connector
>     operations for DP"

For the series,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  .../display/bridge/chrontel,ch7033.yaml       | 13 ---------
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         | 28 -------------------
>  2 files changed, 41 deletions(-)

-- 
Regards,

Laurent Pinchart
