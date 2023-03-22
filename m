Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F56C4F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCVP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCVP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:28:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C891ACF1;
        Wed, 22 Mar 2023 08:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79C68B81D2F;
        Wed, 22 Mar 2023 15:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019FCC433D2;
        Wed, 22 Mar 2023 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679498906;
        bh=OW047WPI6zvHu/88euN076kTfIj+YhMA4lo+cPDZRxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEqSOnQ6rG+DM+ETzAI8Ojs5BzsIOxDEdjNuXkbD8spRecYkPhg0eHzAAjL36fDkY
         KSJUPJI8kmlHpdmXpCKdsf8D8ZSqxWVUqQM4uRngRjKpvH0giOiDO10SEQzgdZUgpx
         t1MsbNJuQauEhSWgZsULcjv3ds3IlQOsvNO5L1ME72y4VX5l+SxEZvf+pLfvuqXcDf
         N10tllodkUA7vXf4Q2tytTfZg8zwAgXtiLb+XFUUX+ekAIjOWxl0z94TsqGt0mZyss
         ObHEXlvxUVauR5k+dVa4TuQF2JJl0jadEhWGfrlVAo39DhKGZuztqajysoVnCaei0b
         pXNBGkMfbTHVw==
Date:   Wed, 22 Mar 2023 15:28:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     cy_huang@richtek.com
Cc:     pavel@ucw.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chiaen_wu@richtek.com,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] leds: rgb: mt6370: Fix implicit declaration for FIELD_GET
Message-ID: <20230322152820.GG2673958@google.com>
References: <1679067760-19098-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1679067760-19098-1-git-send-email-cy_huang@richtek.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023, cy_huang@richtek.com wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>
> 0-DAY CI Kernel Test Service reported the implicit declaration error below:
>
> drivers/leds/rgb/leds-mt6370-rgb.c: In function'mt6370_check_vendor_info':
> >> drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit  declaration
>    of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>   889 |         vid = FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
>       |
>
> Add the missing header 'bitfield.h' to fix it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303171729.CcgyFx17-lkp@intel.com/
> Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/leds/rgb/leds-mt6370-rgb.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
