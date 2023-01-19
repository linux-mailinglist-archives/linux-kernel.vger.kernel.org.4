Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BEF673BED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjASO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjASO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:27:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD47F9B3;
        Thu, 19 Jan 2023 06:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90AD461ACC;
        Thu, 19 Jan 2023 14:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA3C433F2;
        Thu, 19 Jan 2023 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674138457;
        bh=ATdPVmaH8/3z52/j6Bq9k4EsCVBhII5f9ZpQi4jovsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZ7mHOSyQOvnMZ5T/OGegzZQV1VoKeZ/4Tiur8pim8Vr8z03tHC7kwHgyN7zymyac
         D9O4+pgqg4LtdH+ZDohBLAs8HezUvg6igvyVqOWygIo/8U1qsQCMQa7U5aSVhGaFaq
         ctIHC7lA9IRTq5oy7gYFaoOZXxwM269cnAf+mJSGe8+xxF+KojIzCYt0t+6P5Zlpa9
         AOP9wKIe0Gt0y5iRAogZ1B2BLC6em6aOb1DTmc3edCaISbNMQRwOGyh+NTFea8L1vX
         iwfCHDyN4ln4e6WlOXxrCLJ5RxbydaQD/eE7VEbHOcdtQ4D2yNzETKiGCR2ol9KEXe
         4nYfa6uSX16rw==
Date:   Thu, 19 Jan 2023 14:27:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] drivers: mfd: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y8lTUegNjFZrXh1o@google.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-2-okan.sahin@analog.com>
 <Y8eq0GtVZfVdNKYn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8eq0GtVZfVdNKYn@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Andy Shevchenko wrote:

> On Wed, Jan 18, 2023 at 09:38:08AM +0300, Okan Sahin wrote:
> > MFD driver for MAX77541/MAX77540 to enable its sub
> > devices.
> > 
> > The MAX77541 is a multi-function devices. It includes
> > buck converter and ADC.
> > 
> > The MAX77540 is a high-efficiency buck converter
> > with two 3A switching phases.
> > 
> > They have same regmap except for ADC part of MAX77541.
> 
> ...
> 
> > +/*
> > + * Copyright (c) 2022 Analog Devices, Inc.
> 
> Happy New Year!

If the code hasn't changed greatly since the Copyright, there is no
requirement to update the date.

> > + * Mfd core driver for the MAX77540 and MAX77541
> 
> MFD

Please remove all mention of MFD - it's not a thing - we made it up!

-- 
Lee Jones [李琼斯]
