Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE570A8AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjETPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjETPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43115C3;
        Sat, 20 May 2023 08:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A66616CF;
        Sat, 20 May 2023 15:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A9C433EF;
        Sat, 20 May 2023 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684595034;
        bh=gyuwKPF2eZmr67cziBgbCtNCIZf4XORtVi0uqxs6nRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u9IV7X6pPuCH91E7rDRFUYXprYnYt/6UyvH5y8xhIE2akpKghnQTWi7TfDp8mTnBM
         RWVzSUyzYmsHsKB1B8bZJgZDo0B3H3uFc1l9SbDn0qYQ1ai+JDIZbS7m8xwNp/Vclc
         m+kBI5Z08CUm3iymWGVSHpHhGDfvQrnfaiuWNnwxPAUxEfkjdWx8H2su/ZbMk9Jd1k
         yIqt3mU4wEaE1Q9mr6yxMIDQRhcm7pqXF20fZhlQ1xgZ5wXmeQHGxb0tKsyODE18Qs
         8SB304quYd6S232/hnYR9Q8wpqk3iLi4VL8yIVDrZZyowhMBx+AMaKj7wcoaTP98ul
         gWzSOu5NyV0nw==
Date:   Sat, 20 May 2023 16:20:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add dt-binding support for ti tmp006
Message-ID: <20230520162002.7aba7c04@jic23-huawei>
In-Reply-To: <cover.1684579603.git.anupnewsmail@gmail.com>
References: <cover.1684579603.git.anupnewsmail@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 16:21:50 +0530
Anup Sharma <anupnewsmail@gmail.com> wrote:

> These patches introduce device tree binding support and
> add an of_device_id table entry to the driver.
> 
> Changes in v2:
> 	- Keep the exsisting MODULE_DEVICE_TABLE entry.
> 	- Removed the inner comma in of_device_id.
> 	- Order the included header to improve code organization.
> 	- Adding missing semicolon to fix syntax error detected
> 	  using dt_binding_check.
> 	
LGTM - I'll leave them a little while though for others to comment before
picking them up.

Thanks,

Jonathan

> Anup Sharma (2):
>   dt-bindings: iio: temperature: Add support for tmp006
>   iio: temperature: tmp006: Add OF device matching support
> 
>  .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
>  drivers/iio/temperature/tmp006.c              |  8 ++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> 

