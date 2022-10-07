Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3195F7486
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJGHEa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Oct 2022 03:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:04:28 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB481AF24;
        Fri,  7 Oct 2022 00:04:27 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 2D8FAABA2D;
        Fri,  7 Oct 2022 07:04:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 99AB82000D;
        Fri,  7 Oct 2022 07:04:01 +0000 (UTC)
Message-ID: <c83f7ad5b5f67da86bec222f970305a1990e8181.camel@perches.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 00:04:20 -0700
In-Reply-To: <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
         <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
         <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 99AB82000D
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: c1jiphiuugrgpshknkept1gm8aheyjnx
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18zpQ10rQZNQA3E4z97aM0AIla/lSnoV1Q=
X-HE-Tag: 1665126241-288885
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 21:32 +0300, Andy Shevchenko wrote:
> On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:
> > KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
> > include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> > tap/motion detection, wake-up & back-to-sleep events, four acceleration
> > ranges (2, 4, 8 and 16g) and probably some other cool features.
[]
> > +/*
> > + * Threshold for deciding our HW fifo is unrecoverably corrupt and should be
> > + * cleared
> 
> Multi-line comments have to follow English grammar and punctuation,
> i.e. trailing period.

I disagree.  I think that would be a silly rule to enforce.

