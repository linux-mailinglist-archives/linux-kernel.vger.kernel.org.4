Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D061E4F7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKFRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:40:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0763D5;
        Sun,  6 Nov 2022 09:40:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 235ABB80C81;
        Sun,  6 Nov 2022 17:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AA5C433D7;
        Sun,  6 Nov 2022 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667756446;
        bh=q/yAJG+gPPwQsHpI0BDyRwMkyjUzzL21ov3sPjMsNJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WCfgzYSscEuCtTd8yXBem5vLLMAzsO9bMMWxKsajo7rHSSPzwng/6JlTDVG9gvGwu
         qCLbbLXCsHaPBpfUAjKRjUjgbE1iRrCQAa9LdO7dQB0OZ66DQUBEfGqxQAvbIXHLwR
         NW1IGwJxBpfd1FTK3rio3EH/gcqmEz1xqrpNTSko4TGBxxkuujwduRdxT4L50krI9L
         nFQfrzneMIEhTuDpivWYoLxjtGFEydlK51LzJMDYvzKlmVOOhejg/qiesjlaBC0HJx
         MhTKHy0NP+ba5wdFb5EsQWUAWC1PoGSnFDT5bnlBZJzdpzdM2vft0915C4plyuQWyU
         4dhyJIDyGdrrg==
Date:   Sun, 6 Nov 2022 17:40:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add support for ADF4377
Message-ID: <20221106174038.20866863@jic23-huawei>
In-Reply-To: <20221104092802.90725-1-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 11:27:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> phased locked loop (PLL) with integrated voltage controlled oscillator
> (VCO) ideally suited for data converter and mixed signal front end (MxFE)
> clock applications.
> 
> Antoniu Miclaus (3):
>   dt-bindings: iio: frequency: add adf4377 doc
>   iio: frequency: adf4377: add support for ADF4377
>   Documentation: ABI: testing: adf4377: add ABI docs

4 patches in series. I guess you cut and paste from a different version
and overwrote that bit...

J

> 
>  .../testing/sysfs-bus-iio-frequency-adf4377   |   32 +
>  .../bindings/iio/frequency/adi,adf4377.yaml   |   78 ++
>  drivers/iio/frequency/Kconfig                 |   10 +
>  drivers/iio/frequency/Makefile                |    1 +
>  drivers/iio/frequency/adf4377.c               | 1155 +++++++++++++++++
>  5 files changed, 1276 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
>  create mode 100644 drivers/iio/frequency/adf4377.c
> 

