Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84826F34E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjEARPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjEAROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:14:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D5198D;
        Mon,  1 May 2023 10:14:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so3715800e87.3;
        Mon, 01 May 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682961252; x=1685553252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKNqhZighzBchhB7qljfeHwZ77eebwDDc9Iy9EVIqmM=;
        b=YiLzq1KA2rEOiCTNiyZSaN+QghM+/sIHvuTYQCjSbiyThCa88Rroc2XwCwn30FReLS
         eYXff/D8sQcdMUNPVgZWSb1tdbGkyuGJefxQKaCneDn2hYOcP2ILonXjxEqJzTGGBfJF
         9BYH/uOm/8MwyRqaL5DoyfTAmSJZMXTcSpQTHg7bWSahC2rBOqAIHtdICMgxH0MtG+kO
         ca1KK9cxDo7aMhkJW3sjX/PgRwF4E7GS7o03lySErKNbMkg0mxuRDaOXE8yFwWKV8kbU
         1XInk4TCtqaqzK2F7FzEsHBaIwLSeMRqrM1sokiM0zIuqmhIRPNFEYq9Z7yODO+Tkumm
         5jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961252; x=1685553252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKNqhZighzBchhB7qljfeHwZ77eebwDDc9Iy9EVIqmM=;
        b=lOhgLdphZqQwWlH+J3CH4ZBdPjaJJ0aIQpuKeC1R7pe+yEQqL2U+QwTG8VssvoxgwK
         wPriDB8JDsVWnkKIpvOk7bigScP46zxwilNj8kWNevcXz/RfndKn269YTujWOqRIn3JS
         EkuAwfoI26/x9pVvsRJDD2va7I2eKVTYojXEk0cWzIhq0zfCVMCrNEJU8gKUT5gLW887
         FM8VyCIuqbyjIhFksO4CvP+vt/FNwzWGokA8Y9Gf93tuF6RrJjAVKhy3jjzAJOiH8FSo
         ngDa42QCSjWZRPbmdytGR2t22RX8amlcgXQX51Mjko/ry4H0us5MsuuThzbsrOjN873R
         mOlw==
X-Gm-Message-State: AC+VfDzQFEMLdIthZBKmMeZuMPqj7SfK9rMZ7YyiXT+C8tVIi2YUsL52
        j8ifR7jc+tjhimMFTO7dnSnPu6zKGwk=
X-Google-Smtp-Source: ACHHUZ5XOhiYeDAdYs1Yeg4saEaZXRFid5O8OPd2mXzhya6+hjQszORs7zQF+KFLzXIjkxYYpryk4w==
X-Received: by 2002:a19:c50f:0:b0:4e8:4abf:f19d with SMTP id w15-20020a19c50f000000b004e84abff19dmr3815224lfe.15.1682961252211;
        Mon, 01 May 2023 10:14:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id v7-20020a197407000000b004f00af55561sm2396154lfe.174.2023.05.01.10.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:14:11 -0700 (PDT)
Date:   Mon, 1 May 2023 20:14:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v9 0/5] spi: dw: DW SPI DMA Driver updates
Message-ID: <20230501171409.syub4ro3kb3r6ho2@mobilestation>
References: <20230427123314.1997152-1-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Mark, @Andy

On Thu, Apr 27, 2023 at 12:33:09PM +0000, Joy Chakraborty wrote:
> This Patch series adds support for 32 bits per word trasfers using DMA
> and some defensive checks around dma controller capabilities.

I've done with reviewing and testing the series. My tags are already
added to the patch logs. @Andy do you still have any comments about
the updated patchset? If none, @Mark please merge it in if you are ok
with the changes.

-Serge(y)

> ---
> V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
> ---
> V1->V2 Changes : Add dma capability check to make sure address widths
> are supported.
> ---
> V2->V3 Changes : Split changes , add DMA direction check and other
> cosmetic chnages.
> ---
> V3->V4 Changes : Fix Sparce Warning
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
> ---
> V4->V5 Changes : Preserve reverse xmas Tree order, move direction
> check before initalisation of further capabilities, remove zero
> initialisations, remove error OR'ing.
> ---
> V5->V6 Changes :
> 	-Remove case of n_bytes=3 using 4_bytes buswidth
> 	-Avoid forward decaration
> 	-Break capability check patch into 2
> 	-round n_bytes to power of 2 ( Bug Fix)
> 	-Add more explanation in commit text.
> ---
> V6->V7 Changes : Remove extra spaces, refer to functions in commit as
> func()
> ---
> V7->V8 Changes : Minor commment updates in patch 4/5
> ---
> V8->V9 Changes : Minor formatting changes in patch 5/5
> ---
> 
> Joy Chakraborty (5):
>   spi: dw: Add 32 bpw support to SPI DW DMA driver
>   spi: dw: Move dw_spi_can_dma()
>   spi: dw: Add DMA directional capability check
>   spi: dw: Add DMA address widths capability check
>   spi: dw: Round of n_bytes to power of 2
> 
>  drivers/spi/spi-dw-core.c |  5 ++-
>  drivers/spi/spi-dw-dma.c  | 76 +++++++++++++++++++++++++++++----------
>  drivers/spi/spi-dw.h      |  1 +
>  3 files changed, 63 insertions(+), 19 deletions(-)
> 
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 
