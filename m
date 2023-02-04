Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218568AA85
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBDOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:12:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FE25E09;
        Sat,  4 Feb 2023 06:12:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384D160C39;
        Sat,  4 Feb 2023 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C52C433D2;
        Sat,  4 Feb 2023 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675519949;
        bh=ufUC96WayEdpAv8BB5eoi2qMm/3HsjKkHmsDBc0cjTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDbCBowk7v5cn3PcB118qyZCmIBiauXAWUMZdw/hVFM1jsggnuB4e1pDjt/XBo58Q
         YreLi3SfhKStLCaZfwpBBOzxcLk7DG34riS4BEs/7RFIzW03m/cDUNBsHJepzj6R0E
         4Vcp8fs2Lbf6QBztV5NxB9XJWIDL2BzojXF5khxchZt07UX5+L3u1gKCRWViDhizW0
         0TYfRRY+RlfalwjVApZ0D4+A5wIA6gNnZb1NHdrKeHZC4TAL8/pz9HU3qvFhlJ5mKN
         MtWzN0+y122btjUq+tcmAOm9yzcMJ9VZAjTSprmKQO4k5Ki9qWiywcp/hrg5weS0QU
         fl7dxrmQ9LM7g==
Date:   Sat, 4 Feb 2023 14:12:09 +0000
From:   Lee Jones <lee@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] leds: remove ide-disk trigger
Message-ID: <Y95nuSEEHj5Ed8kf@google.com>
References: <20230131140304.626779-1-clabbe@baylibre.com>
 <20230131140304.626779-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131140304.626779-2-clabbe@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023, Corentin Labbe wrote:

> No user of ide-disk remains, so remove this deprecated trigger.
> Only a few platforms used this and were fixed in 2016.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - remove also DEFINE_LED_TRIGGER(ledtrig_ide)
> Changes since v2:
> - Added the fact that few platforms used this and it was fixed old ago.
> - Added Rob's ack
> 
> Change since v3:
> - Rebase on top of latest next
> Change since v4:
> - Rebase on top of latest next
> 
>  Documentation/devicetree/bindings/leds/common.yaml | 3 ---
>  drivers/leds/trigger/ledtrig-disk.c                | 4 ----
>  2 files changed, 7 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
