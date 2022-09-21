Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0C5BF370
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIUCW5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Sep 2022 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:22:55 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 19:22:53 PDT
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529C49B79;
        Tue, 20 Sep 2022 19:22:53 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 4A97C120DD9;
        Wed, 21 Sep 2022 02:06:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 4158C2003A;
        Wed, 21 Sep 2022 02:06:54 +0000 (UTC)
Message-ID: <19451295e1563de5e6628e51fa8222b843f55eed.camel@perches.com>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: add maintainer for thermal driver
 for loongson2 SoCs
From:   Joe Perches <joe@perches.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>
Date:   Tue, 20 Sep 2022 19:06:55 -0700
In-Reply-To: <20220921015605.17078-1-zhuyinbo@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4158C2003A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: at3trdms4184ip35153phfm8wty56ds6
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18vk2v0h79TMwArk0zyIJjHZvYwoZxRoW0=
X-HE-Tag: 1663726014-147625
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-21 at 09:56 +0800, Yinbo Zhu wrote:
> Add zhanghongchen and myself as maintainer of the loongson2 SoC
> series thermal driver.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -11899,6 +11899,14 @@ F:	drivers/*/*loongarch*
>  F:	Documentation/loongarch/
>  F:	Documentation/translations/zh_CN/loongarch/
>  
> +LOONGSON2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> +F:	drivers/thermal/loongson2_thermal.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>

From the MAINTAINERS headers:

	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.

If you both are being paid to maintain this driver,
this S: entry should be Supported.


