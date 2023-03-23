Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2576C6C16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCWPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCWPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:17:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529D1D93C;
        Thu, 23 Mar 2023 08:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F378CE2255;
        Thu, 23 Mar 2023 15:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C316C433EF;
        Thu, 23 Mar 2023 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584659;
        bh=UvxNcK4/+uJUVQAwHV59ob1sSYqIJJVRO17OF1ZimtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6ERglOB8KBv4mZsYyVPVZZIK8IuLu32K/YLscxjiyUgX6ySUlxEYPJDfhvzpy1LE
         dDtleXezIO+szV6VMu7eIHLmwXiUY0J1OCS+EdU1kDJhxDr+fqpI8zjdf9kE8NkSCN
         SGfgK7EhPomAMtyRT3XV7D4Nt30MOikrz3JvCi4kUgx/uDdNKb3eId/nZ7pDf2p1f5
         RnwsBY7vuMYEyvjo0+615Snqje+Macb2gmnnF0Vb5UFASMRiWNGh9rfoay2YGuXeP6
         EacdATPvV/sb5zOIucXImKRBuiF921mWbJI26+j6AstJr6jBZ/HZn7P6i2GH/+qsI7
         Tgz0tDspaeFAw==
Date:   Thu, 23 Mar 2023 15:17:33 +0000
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
Subject: Re: [PATCH 2/3] Documentation: leds: MT6370: Properly wrap
 hw_pattern chart
Message-ID: <20230323151733.GQ2673958@google.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
 <20230319074903.13075-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319074903.13075-3-bagasdotme@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, Bagas Sanjaya wrote:

> The pattern diagram (chart) of /sys/class/leds/<led>/hw_pattern is
> wrapped in literal code block. However, the block indentation is
> interrupted by Icurr axis label, hence below warnings:
>
> Documentation/leds/leds-mt6370-rgb.rst:39: WARNING: Literal block ends without a blank line; unexpected unindent.
> Documentation/leds/leds-mt6370-rgb.rst:41: WARNING: Line block ends without a blank line.
> Documentation/leds/leds-mt6370-rgb.rst:46: WARNING: Unexpected indentation.
> Documentation/leds/leds-mt6370-rgb.rst:44: WARNING: Inline substitution_reference start-string without end-string.
>
> Fix the chart indentation by adding 4 more spaces so that the axis label
> is in the code block.
>
> Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
> Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/leds/leds-mt6370-rgb.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
