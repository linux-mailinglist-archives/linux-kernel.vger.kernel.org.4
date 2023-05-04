Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFC6F6D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjEDN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjEDN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:56:26 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6207D9F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:56:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344DtMmG030465;
        Thu, 4 May 2023 08:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683208522;
        bh=umEVx7KNQWSDDSFFpZpy630z6K88xRHx+G85wX/qN/s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=VvuDnVk1FQyQqmtSLHL22UEQv6OAVgrYyuWfFZWnG5ojFXdnWuZRmOa/Uaw4r+2NO
         fAmMmefVzZTjGMkfHskBplMWcdVkkLO4SxTNqD3WQuYSkkt3aM8J6E6rXohztl2uQd
         K+100yYgoPj0Kfo6rkecGyd8LGXvqhbycneVXoMM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344DtLWD057451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 08:55:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 08:55:21 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 4 May 2023 08:55:21 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Shenghao Ding" <13916275206@139.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1 3/5] firmware: tasdevice_fmw: tasdevice
 firmware loading lib
Thread-Topic: [EXTERNAL] Re: [PATCH v1 3/5] firmware: tasdevice_fmw: tasdevice
 firmware loading lib
Thread-Index: AQHZfVYbZ97DiMVErUaDioHaf2zIQa9KHCLA
Date:   Thu, 4 May 2023 13:55:21 +0000
Message-ID: <82b9ac35631a4c4993dd2cd75f137273@ti.com>
References: <20230502053235.27066-1-13916275206@139.com>
 <ZFGqhM0VYFdorkRa@finisterre.sirena.org.uk>
In-Reply-To: <ZFGqhM0VYFdorkRa@finisterre.sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.32.82]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Broonie
Thanks for your comments.
In fact, we have a dilemma whether to put the code into firmware folder or =
sound/soc/codecs.
As you know, most cases are audio-related application,  such as a pure audi=
o device or=20
audio2haptics device, keeping the tasdevice-firmware lib into sound/soc/cod=
ecs would make sense.
However, in other cases, tasdevice(such as tas2781) can be used  as pure ha=
ptic to drive the Motor.
moving the lib into firmware folder would make sense, although such an appl=
ication is a niche.
Would you be so kind and give some comments on it? Thanks.

BR
Shenghao Ding
-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Wednesday, May 3, 2023 8:28 AM
To: Shenghao Ding <13916275206@139.com>
Cc: lgirdwood@gmail.com; perex@perex.cz; pierre-louis.bossart@linux.intel.c=
om; Lu, Kevin <kevin-lu@ti.com>; Ding, Shenghao <shenghao-ding@ti.com>; als=
a-devel@alsa-project.org; linux-kernel@vger.kernel.org; Xu, Baojun <x107701=
2@ti.com>; Gupta, Peeyush <peeyush@ti.com>; Navada Kanyana, Mukund <navada@=
ti.com>; gentuser@gmail.com
Subject: [EXTERNAL] Re: [PATCH v1 3/5] firmware: tasdevice_fmw: tasdevice f=
irmware loading lib

On Tue, May 02, 2023 at 01:32:35PM +0800, Shenghao Ding wrote:
> Create tasdevice firmware lib.

>  drivers/firmware/Kconfig            |    1 +
>  drivers/firmware/Makefile           |    1 +
>  drivers/firmware/ti/Kconfig         |    5 +
>  drivers/firmware/ti/Makefile        |    3 +
>  drivers/firmware/ti/tasdevice-fmw.c | 2380=20
> +++++++++++++++++++++++++++
>  5 files changed, 2390 insertions(+)

Given how large this part of the code for these devices is it definitely ma=
kes sense to split it into a separate commit like you've done but are there=
 any non-audio devices in this series which will share the same firmware st=
yle?  If not then it probably makes sense to keep the code in sound/soc/cod=
ecs, though a separate file would still make sense.

There's some devices that do keep firmware interface code in the firmware d=
irectory but in those cases the devices have other, non-audio, functionalit=
y which also uses the firmware (eg, always on monitoring) but I've not seen=
 any of the tas devices like that.  If there are some then the split you've=
 made here makes sense.
