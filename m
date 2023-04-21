Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1E6EA67A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDUJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDUJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:04:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87228691;
        Fri, 21 Apr 2023 02:04:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso1475239e87.0;
        Fri, 21 Apr 2023 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682067865; x=1684659865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GD+kPjbrYOpAZ5eEFt/aG7lSE+x3V2Tz7Zj3HJKlsWE=;
        b=IQBfC7RLkilRMtCYiEcDkvo09J8JyR1j0INIjE/SJ/fi0WUOHhDuz5HEWOxs8pPCA/
         wkQcvof39Gly8MHYMak5oxg7TF8x/X7A/yJ+OLD6Qujj/Xhe0SBUI9Zld/glCU1eSM7I
         ln0DCz2FCDzBUqd6MHMcJB/44CEd9Sr5M2QqcfitUepulc9Kx1J2/1MZ12lYLpdM76jw
         ipM+HHrdW+4ptedQXpdgyqGAa+Ri699aqQd2kVFungN66QJ8AEnwWZowrtL8k1Ug8xTC
         w4AkaORA6gmIQbuVncLsYu9ZWSOl/CWIoIfa/xStTGaxj2nkQfgOL7DFlHboPPjRniXk
         jLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067865; x=1684659865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD+kPjbrYOpAZ5eEFt/aG7lSE+x3V2Tz7Zj3HJKlsWE=;
        b=DP8NphRSqTaYXWZ+KNOiEGSbjG8GbMxi9LMjIuznX6azbbXCqfczWajpxV5pG9hd8r
         ySs+M0A0q+RTQh0yameZXMOAh/OuwkQFkZo2h2eoJCZ2x7/09LrS8WNH71YkSzAsN3r8
         0M9aF4TzPFNByDnQXRHSK8/oOM5bZo6s1QX7DTIREuuc7rIQI1t/wpZg/w1Z7K16uIi+
         thgLHEELvtsaZqGjT5/ojKPwg73iqCOnJBl/DIQMB6PK8pk55f50lbyHpYqU3B7adhf8
         bAX+xDAHWFKAy1/JVNIyxnnYgZ4btkCMXZMqexJQpaQxzQg3UCU38CV7b4bJuO0mjB2l
         WIqg==
X-Gm-Message-State: AAQBX9ecdrdYHzqs+dsNM7iT1/yPr66/BD8LWmU7xVZ6E2GOp8PdrokF
        dCpfvaZySRpwNZm2A68YHJs=
X-Google-Smtp-Source: AKy350b73lGa6EYgToUGZU3RxFCZJndbtfCcOwL70CGkEcByRSNhGgk7mM1xrzRIPWcJWHPJhmqxFA==
X-Received: by 2002:ac2:4e49:0:b0:4ec:a18e:f985 with SMTP id f9-20020ac24e49000000b004eca18ef985mr1211349lfr.13.1682067864875;
        Fri, 21 Apr 2023 02:04:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ac02000000b004ec87cf6b69sm495878lfc.169.2023.04.21.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:04:24 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:04:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v8 0/5] spi: dw: DW SPI DMA Driver updates
Message-ID: <20230421090422.grujbps24fckewxb@mobilestation>
References: <20230420055131.2048959-1-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:51:26AM +0000, Joy Chakraborty wrote:
> This Patch series adds support for 32 bits per word trasfers using DMA
> and some defensive checks around dma controller capabilities.

The series looks good to me except a small nitpick described in the
patch 5. Just a note for future patchset it's preferable to have the
fixes-patches placed at the head of the series thus it would minimize
a possible to catch merge-conflicts on the patches backporting. In
case of your fixes patch it won't be relevant since the change is
independent from the rest of the series updates.

So feel free to add the tags:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.

Note before moving further we'll need to wait for @Andy response.

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
> 
> Joy Chakraborty (5):
>   spi: dw: Add 32 bpw support to SPI DW DMA driver
>   spi: dw: Move dw_spi_can_dma()
>   spi: dw: Add DMA directional capability check
>   spi: dw: Add DMA address widths capability check
>   spi: dw: Round of n_bytes to power of 2
> 
>  drivers/spi/spi-dw-core.c |  2 +-
>  drivers/spi/spi-dw-dma.c  | 76 +++++++++++++++++++++++++++++----------
>  drivers/spi/spi-dw.h      |  1 +
>  3 files changed, 60 insertions(+), 19 deletions(-)
> 
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
