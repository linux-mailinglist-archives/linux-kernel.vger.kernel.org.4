Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533DF640DF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiLBSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiLBSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:53:41 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28295F1150;
        Fri,  2 Dec 2022 10:53:11 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C7ED85FD0D;
        Fri,  2 Dec 2022 21:53:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1670007189;
        bh=iQuycMZtPbvV3NkGCSrY+6L3hWEFkqI8nUbsdweZv5I=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=PdwMshCwBMAKVTGNeWOXTPj2ABBu4B+QFW/VUvJDRztT4++AWjxWutSaFASALLwZq
         bEqT3rHN2CxVJ/8lDehljuoOWlksuKZxT9z0J5iCqVcjteJoW7fuJO761V9kbO4oxK
         eoftSwrKuQWrXBbx4qZEoj0/rPdL2l3x/ScJdW9I+aLvhWKvUwVsEWJLTj8LJrfE/C
         Jl1diTs38oUToyIcP70K51f3x8I3ahf7X+mXWL0IU+fpn1VRX/mg9dDP3rOe+N3s1J
         eYJo1Iy1ZWotOurCndP1VDqbU+rPgqoJRFEODrVMJ9dSuo+hfdEnHVT1dUcqWRQ9la
         WxQUF/1jlhtlg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 21:53:08 +0300 (MSK)
Date:   Fri, 2 Dec 2022 21:53:08 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Martin Kurbanov <MMKurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Message-ID: <20221202185308.zh5kesfxvyrco2cr@CAB-WSD-L081021>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
 <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
 <0a9e7d65-4ad7-b753-ec9b-8e58a549b5db@sberdevices.ru>
 <620b19f5-2202-21a5-7e3b-816dcd42d1b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <620b19f5-2202-21a5-7e3b-816dcd42d1b4@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 17:01:00 #20638911
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Fri, Dec 02, 2022 at 05:41:37PM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2022 18:43, Martin Kurbanov wrote:
> > Hi. Thank you for quick reply. 
> > 
> > On 25.11.2022 11:29, Krzysztof Kozlowski wrote:
> >>> +
> >>> +  imax:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      Maximum supply current, see dt-bindings/leds/leds-aw200xx.h
> >>
> >> No. Use existing properties from common.yaml. This looks like
> >> led-max-microamp and it is per LED, not per entire device.
> > 
> > The AW200XX LED chip does not support imax setup per led.
> > Imax is the global parameter over the all leds. I suppose, it's better
> > to add vendor prefix or take minimum from all subnodes?
> > How do you think?
> 
> Have in mind that led-max-microamp is a required property in some cases,
> so skipping it and using per-device properties does not solve the
> problem of adjusting proper currents. What if each LED you set for
> something which in total gives more than your imax?
> 

You are right. From my point of view too, we must build our solutions from
HW capabilities. In the current situation, AW200XX chips support global
Imax value, so it's acceptable decision to use vendor prefix for global
imax parameter, why not?

...

-- 
Thank you,
Dmitry
