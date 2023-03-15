Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0AF6BBB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjCORwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCORwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BADBEE;
        Wed, 15 Mar 2023 10:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D27DEB81EC0;
        Wed, 15 Mar 2023 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F58BC433EF;
        Wed, 15 Mar 2023 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678902751;
        bh=uNIDTklAm0VX532rqiud/ChQv2ijOR1x2sVqooHl9dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4ci+3wjw0bYfqJEYljk7a+iqFgCjvBKEAedHNMNYrtn/HxeontxDk3wkoCWxVhLt
         Njb8s80U45UFUJIYn54CAT4Htuddc2EyvOVc8q6GoYodPPowgrsMFLWiKeRxgjwn0q
         IbPnun+EIlgc1tRGFA2cTMDPLxB2LXKqUdXsgNjqF0JTvotViK8dSWWkVXi8FoWSPk
         uhnpRZ1FiReYtlYdbEB6+JPFeVTWjekl4LVxKRchwT0hYn4EqfvADtPQl9Oobys3O1
         g4z0cJqB0YKgfSDI8eeKZH5rIzPNwqtdycZEXTV64xCf016PMNSGlR8tc+2K/+ns0y
         1Od5dwNcgXcFA==
Date:   Wed, 15 Mar 2023 17:52:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230315175223.GI9667@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307112835.81886-6-okan.sahin@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Okan Sahin wrote:

> MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
>
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
>
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
>
> They have same regmap except for ADC part of MAX77541.
>
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  drivers/mfd/Kconfig          |  13 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77541.c       | 224 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77541.h |  97 +++++++++++++++
>  4 files changed, 335 insertions(+)
>  create mode 100644 drivers/mfd/max77541.c
>  create mode 100644 include/linux/mfd/max77541.h

FYI: I'm not re-reviewing this since you've chosen to ignore some of my
previous review comments.  Issues highlighted by review comments don't
just go away on resubmission.

--
Lee Jones [李琼斯]
