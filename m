Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B46C6C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCWPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCWPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313110A99;
        Thu, 23 Mar 2023 08:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B338C6279F;
        Thu, 23 Mar 2023 15:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A1FC433D2;
        Thu, 23 Mar 2023 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584701;
        bh=Ot5j+e02uJgVNJB1slYlPg2ieWZZtdLFrPg+gk+GtR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0kQfA1TUx4841Dq9a/DC61t5fJPvk/9GatAS59QD4fZN21plBCclCYXZs7XXNp7P
         G7wpnN+17ZnkJa4TcbQbG08LozmjY3Z25PtYrY1YVz4Eu2Uie1zi43iC0x5i0Ha16j
         wKQL38EVfy4ZBmzk1QCX9Tj2jnLn5Jx55FmjulveaqC9B1zPz6Xd/1UnR+4Fz0YNx1
         aaHYqPsNURZhAvMOxkF+9fJqXJ60/QA9/oxOw8cLVLNDuc9HOWXYylCha8mprE9+0Z
         QnAyXcxd+Gd0dyKQXLSNIQa9j/Zl0tXW/V+o6oza1YEljmUoYmZMvCc8IJSwZ8Yvai
         6MLuLJBnUwSQg==
Date:   Thu, 23 Mar 2023 15:18:15 +0000
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
Subject: Re: [PATCH 3/3] Documentation: leds: MT6370: Use bullet lists for
 timing variables
Message-ID: <20230323151815.GR2673958@google.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
 <20230319074903.13075-4-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319074903.13075-4-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, Bagas Sanjaya wrote:

> The timing description contains list of timing pattern variables, but it
> uses code block without indentation instead. Switch to bullet list as it
> is better fit for this purpose.
>
> While at it, substitute "load" for "duty" because the variables control
> timing for current load into the device.
>
> Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
> Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/leds/leds-mt6370-rgb.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
