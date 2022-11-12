Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258C626AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiKLRbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKLRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:31:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E817435;
        Sat, 12 Nov 2022 09:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F0B60D37;
        Sat, 12 Nov 2022 17:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27439C433D6;
        Sat, 12 Nov 2022 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274310;
        bh=cm/vCNFoAmqrRWjUO3GSy2Eoq3mXhsMtfQIsxJGJdm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=maZz3BxIgwe66xQgurHD2RbeiQvvROXNSa5HjzqHqtXaHEK7yQgNDJ4P7bQHbAKwQ
         KHbbytygnYtQVaMW40sm4g0VByDDymj5ZH5mfiO8CNOaYcBTRM5sDm1JkjGklcxlha
         kkMzBMJhHmZYNycmq0TLe7OFmv5lkvtoFzLFaHHx0w1Mmhd6H9exumz/y9H5iLgci8
         blVGsK8QOfeZzFxJanlft8fTNtCP6wS+IJr990DVRm4mlVKx8UgwtN+ngoIxk0jfEl
         TKR9rQep7n9/FU8SQzY4ZZPCogfL99zuR0bAJBbh7aFgAoaPLOnPslf2dXwK3IALEF
         DJonhPYnGp1Sg==
Date:   Sat, 12 Nov 2022 17:44:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jay Greco <grecojay@amazon.com>
Cc:     <linux-iio@vger.kernel.org>, <jorcrous@amazon.com>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iio: imu: inv_icm42600: Add support for icm42631
Message-ID: <20221112174404.54ea36d0@jic23-huawei>
In-Reply-To: <20221110192933.13616-1-grecojay@amazon.com>
References: <20221110192933.13616-1-grecojay@amazon.com>
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

On Thu, 10 Nov 2022 19:29:31 +0000
Jay Greco <grecojay@amazon.com> wrote:

> This patch adds support for the invensense icm42631 as part of the
> inv_icm42600 family driver within the IIO subsystem. The patch series
> also includes the requisite changes to the dt-bindings documentation.
> 
> Changes in v2:
> - Fix documentation subject prefix per Krzysztof Kozlowski
> 
> Changes in v1:
> - initial patch submission

Hi Jay,

Applied to the togreg branch of iio.git which I will shortly push out
as testing to give the various automated build systems the opportunity to
see if they can find anything we missed.

Welcome to IIO btw.

Thanks,

Jonathan

> 
> Jay Greco (2):
>   iio: imu: inv_icm42600: Add support for icm42631
>   dt-bindings: iio: imu: Add inv_icm42600 documentation
> 
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
>  5 files changed, 14 insertions(+)
> 

