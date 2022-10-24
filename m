Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D74609AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJXGw6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJXGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:52:56 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805CA4C63B;
        Sun, 23 Oct 2022 23:52:54 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 272A41C6390;
        Mon, 24 Oct 2022 06:52:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id C59E933;
        Mon, 24 Oct 2022 06:52:32 +0000 (UTC)
Message-ID: <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
From:   Joe Perches <joe@perches.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 23 Oct 2022 23:52:46 -0700
In-Reply-To: <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
         <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C59E933
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: r6jppkzu4gn6ykse86y6nysh5ggpgdue
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18i7acdCVqDQczurIaC7NfxKgmGLPF6OmA=
X-HE-Tag: 1666594352-636914
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 14:23 +0300, Matti Vaittinen wrote:
> Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..3ab9c5f97dfe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
>  F:	include/linux/mfd/khadas-mcu.h
>  F:	drivers/thermal/khadas_mcu_fan.c
>  
> +KIONIX/ROHM KX022A ACCELEROMETER
> +R:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Supported
> +F:	drivers/iio/accel/kionix-kx022a*

How is this "S: Supported" without an M: maintainer?

> +
>  KMEMLEAK
>  M:	Catalin Marinas <catalin.marinas@arm.com>
>  S:	Maintained
> -- 
> 2.37.3
> 
> 

