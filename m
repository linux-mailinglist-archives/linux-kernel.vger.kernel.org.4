Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7976C6C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCWPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCWPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:16:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965430F0;
        Thu, 23 Mar 2023 08:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D719B82166;
        Thu, 23 Mar 2023 15:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD38CC433D2;
        Thu, 23 Mar 2023 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584577;
        bh=UAGXMd7qHQxvTeJ3ngAjhXp0j0EEZ5bXpvg6k1yIYuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvRkr1o1RIzXOG5vuSqux6xLPrE3g6IOAmh2G92oDA0OvmhjPf/VTembJirigwo5K
         rozJO50LKhXPv296i/HSI8VQuHVWMxQ78O0bkdAQkImpySnLpfYgP5YbpJS3zBLB3i
         9kCY5kqo/a9uTGgOrEy5Kl+AJ/XpAlNzrxq3idlxUKRBgP7DW6TZZavtUP0x5vOUWO
         iXR4lm3IwiaTLdkeXF/qXz6MM6uIJg0fEViwKBA0a7NaefK772uKgzVz+b5gFRk5se
         ZY5mnD0XOrOqs/zRATFDt/P0BxBdLhdnBvTl0T3nDKZMAl4xbnKH9D4Pd3AuSxRle+
         58sFa7tuUB27A==
Date:   Thu, 23 Mar 2023 15:16:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] Documentation: leds: Add MT6370 doc to the toctree
Message-ID: <20230323151611.GP2673958@google.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
 <20230319074903.13075-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319074903.13075-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, Bagas Sanjaya wrote:

> Commit 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
> adds documentation for Mediatek MT6370 RGB LED device, but forgets to
> include it to leds toctree index.
>
> Add the missing entry.
>
> Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
> Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/leds/index.rst | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
