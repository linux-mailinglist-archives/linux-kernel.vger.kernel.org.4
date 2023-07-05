Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F67748152
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGEJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGEJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:46:43 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D91712;
        Wed,  5 Jul 2023 02:46:41 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E1B8A12005A;
        Wed,  5 Jul 2023 12:46:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E1B8A12005A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688550398;
        bh=ruyM7/967PkR3Obij04ndcyWIoQTBHGsMkxNaYWC+H8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=hvznwnH+YYIysXV3qrXto4v2qRPeYETSTSzrMHyOGWOCKJFMAX/mrax4QZbCcN1Bu
         /YlE8EjMnnsGSZhrJURP3J8nbe3/O1aVMnM9JWcC3aHEJ4JZgqAQFpFhfJrYljWhpj
         rFeB3CbdyoosyYwDVZ1pIv9IyYoahec68KEwN4t8l/ckPNE2uC2MfSMMUm7PTlMvMW
         o3TYbFObVrXMOwofIkAPk4P+j2vCelBmktG6wj+EiSWcB+jkvZ/zen7JMAuzOSVQIU
         P1m8Y+DlxhEPlWKqadgE18u9LRjVvvoVuNGIl6KqfxkkJVmWj3zVuyeHy9dVTUIcxK
         C2Ni5Op61thdA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 12:46:38 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 12:46:37 +0300
Date:   Wed, 5 Jul 2023 12:46:38 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Conor Dooley <conor@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <kelvin.zhang@amlogic.com>,
        <xianwei.zhao@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 5/5] arm64: dts: meson: a1: change uart compatible
 string
Message-ID: <20230705094638.mosz6wk76ztd5xf5@CAB-WSD-L081021>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-6-ddrokosov@sberdevices.ru>
 <20230704-cannabis-cannon-19397cd806bc@spud>
 <20230704170843.wksxekltre2ob4en@CAB-WSD-L081021>
 <20230704-staff-smilingly-401b99e28edd@spud>
 <20230704171900.ulnnpkuzvtbbqa3d@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230704171900.ulnnpkuzvtbbqa3d@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178440 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 05:28:00 #21565829
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor,

On Tue, Jul 04, 2023 at 08:19:00PM +0300, Dmitry Rokosov wrote:
> On Tue, Jul 04, 2023 at 06:10:46PM +0100, Conor Dooley wrote:
> > On Tue, Jul 04, 2023 at 08:08:43PM +0300, Dmitry Rokosov wrote:
> > > On Tue, Jul 04, 2023 at 06:02:58PM +0100, Conor Dooley wrote:
> > > > On Tue, Jul 04, 2023 at 04:59:36PM +0300, Dmitry Rokosov wrote:
> > > > > In the current implementation, the meson-a1 configuration incorporates a
> > > > > unique compatibility tag "amlogic,meson-a1-uart' within the meson-uart
> > > > > driver due to its usage of the new console device name "ttyS".
> > > > > Consequently, the previous compatibility tag designated for the
> > > > > 'amlogic,meson-gx-uart' configuration has become obsolete and is no
> > > > > longer relevant to the current setup.
> > > > 
> > > > I don't really see why you would remove the gx-uart to be honest, and
> > > > not use it as a fallback. Neil's platform though, so his call :)
> > > > 
> > > 
> > > Because of amlogic,meson-gx-uart has legacy devname, we do not want to
> > > use it in the A1.
> > 
> > Which I did read in your commit message, fallback being the operative
> > word here.
> 
> Although it is difficult for me to envision a situation where we would
> require this fallback, but gx-uart fallback will function from a kernel
> perspective (without taking into account bootloader setup or userspace
> daemon script). I don't have any objections to stay gx-uart as a
> fallback, will do it in the v2.

Unfortunately, it's not possible based on schema rules. During dtbs check
I've got the such error:

arch/arm64/boot/dts/amlogic/meson-a1-ad401.dtb: serial@1c00: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,meson-a1-uart', 'amlogic,meson-ao-uart', 'amlogic,meson-gx-uart'] is too long
	'amlogic,meson-g12a-uart' was expected
	'amlogic,meson-gx-uart' was expected
	'amlogic,meson-ao-uart' was expected
	From schema: Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml

Of course, we can change dt bindings schema, but is it really needed? As
I said before, it's difficult to imagine the situation, when gx-uart
fallback will be helpful.

-- 
Thank you,
Dmitry
