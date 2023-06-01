Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25671F253
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjFASrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFASrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AE134;
        Thu,  1 Jun 2023 11:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43BF9648FF;
        Thu,  1 Jun 2023 18:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C38C433D2;
        Thu,  1 Jun 2023 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685645222;
        bh=7hUAGbr9RVd5xxY7KJ0giO7dZSBPaVt+/ij4dmRrwXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3oP1GfneAo4/coUi5NUoMPGbju4mM0do35Bvy0WcgYxEv0s14RYctQP7TQVEq/hf
         uKJt0I43RQRc3JPjLxZt8tRVg8iQ82JpD3+oYFeWu/AfOJfGXJwysYV//voJklgMh1
         C7WbNo9e20K7JBYgDUpZHmHHMGfM9WYXS9raJG9soR6jQ7owKACJPptTPcfoOrkhjw
         nmNmnxiveaC1g4lQg0ZeGsdCvWBW27QYVHxczBDDwwJ/hN9hPfq1Qy7vDvgY855prk
         SmQm9JrpS9TX/CcvxLS29hi4ymPfW8LFoHhSWQ15nU0eNpfAR344y2d5VjydSEfkNA
         RkklAtMvBnMCg==
Date:   Thu, 1 Jun 2023 19:46:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v5 2/2] leds: add aw20xx driver
Message-ID: <20230601184658.GI449117@google.com>
References: <20230519130403.212479-1-mmkurbanov@sberdevices.ru>
 <20230519130403.212479-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519130403.212479-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Martin Kurbanov wrote:

> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - Individual 64-level DIM currents
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../testing/sysfs-class-led-driver-aw200xx    |   5 +
>  drivers/leds/Kconfig                          |  13 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-aw200xx.c                   | 594 ++++++++++++++++++
>  4 files changed, 613 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
>  create mode 100644 drivers/leds/leds-aw200xx.c

Applied, thanks

-- 
Lee Jones [李琼斯]
