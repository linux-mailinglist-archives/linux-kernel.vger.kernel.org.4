Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606B6F0A94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbjD0RPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjD0RPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31B1993;
        Thu, 27 Apr 2023 10:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B33963BB9;
        Thu, 27 Apr 2023 17:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5ABC4339E;
        Thu, 27 Apr 2023 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615749;
        bh=6lphV+9yp+4j33QChmFrKQxUY8ArwGcehoykxFMj7QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1pfzL4mwgyxQN6l2n2mNG8FVUxAqYlre5o1+veoWSGdtDsrOuCSCKnXwI2486SKW
         BzkN3jVHdx81+gNh9VWnGcZkr788fptNJXiG5h2+YNf4PXeXNC/m8WjSmQBoUDSQRR
         60fEt/SOURAFBZRNIaFXqZCheH6XEU77uX+HfuaWursAcb3sIaIcYjXbFstLgoqGox
         Tsa1aUEQl6Y4y2/LbM9BQe4caqngSMZOi3SGam/ud9/CYtNLKBwd5wx4ldJsZB4BR7
         ZwI8ngMpIN4thRLHYlRnpt0vPCt2CbHjhCg76KVPVLUAibhNFEpcl8DAONcmKwIwPT
         tKP6nNaC7Jjjg==
Date:   Thu, 27 Apr 2023 18:15:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        michael.wang@yunjingtech.com
Subject: Re: [RFC RESEND 3/3] leds: Add support for UP board CPLD onboard LEDS
Message-ID: <20230427171544.GF620451@google.com>
References: <20230425152135.30745-1-larry.lai@yunjingtech.com>
 <20230425152135.30745-4-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425152135.30745-4-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, larry.lai wrote:

> The UP boards come with a few FPGA-controlled onboard LEDs:
> * UP Board: yellow, green, red
> * UP Squared: blue, yellow, green, red
> 
> This patch depends on patch "mfd: Add support for UP board CPLD/FPGA".
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Lee Jones <lee@kernel.org>

Definitely not.  Please try again after reading:

  Documentation/process/submitting-patches.rst

> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> ---
> RFC 2022/11/23 --> RFC 2023/04/25: Refer 2022/12/08 Lee Jones review,
> cleaned up coding style.
> PATCH V3 -> RFC 2022/11/23: Update the changes Copyright.
> PATCH V1 -> V3: There is no change.
> PATCH --> PATCH V1: Refer 2022/10/03 Andy Shevchenko review, cleaned up
> coding style.
> ---
> ---
>  drivers/leds/Kconfig        | 10 +++++
>  drivers/leds/Makefile       |  1 +
>  drivers/leds/leds-upboard.c | 79 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/leds/leds-upboard.c

-- 
Lee Jones [李琼斯]
