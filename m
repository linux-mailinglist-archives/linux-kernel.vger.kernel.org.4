Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09448606075
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJTMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJTMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:41:51 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8EB199899;
        Thu, 20 Oct 2022 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666269708; x=1697805708;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xupf1KQwyV2mbhTxs19/2TF/yr69owxHO+mNwUFBTB8=;
  b=fp1EXe79G+iVW6EJF7OhJL04wbuOFJTYvmcLONxfSdBGbYK9WU7mcODg
   c9x5wDSlGkJ4MMqqJrjLP4j706nFgSPG+33kKCd70Ua0kHw7irIvAxm9O
   +M9pVQ/6wb1E3IDp3igo3a+0qm9zOMZSIWIj/Mxw/jrZuERISFdZ82uZw
   qU9ka4y/tdffa3JHTB3v7T00ViG+euJqXiyZBSM/2ZK7aE9sMdSiZtvGz
   07OSI+IYtDeWLnpiCnVnttDhjwX0kJJnDvyKcrKdn91lb2MXpS7bzGHT4
   qIPfVOvQqiV4G9zgq+c5BbbftZRgSzqTrfrjAM3XRHA86T81ZaITPgqQp
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="26874055"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Oct 2022 14:41:45 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 20 Oct 2022 14:41:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 20 Oct 2022 14:41:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666269705; x=1697805705;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=xupf1KQwyV2mbhTxs19/2TF/yr69owxHO+mNwUFBTB8=;
  b=XB0vunWBS0onXLGDJJJ69h+zgXKra9ZtYYfoQyLU+TY4rdLF/DAjoXSs
   Bt6SpA1CReCYYwydSEzH2drjGaEqNJbdzdvdQfTnHMBT+pUlirMwAghTU
   7EkvX8WTf6gmNdrHjcZg76P97XTwEjuHhLGdhJhYtf8WcC284AUBdm+SL
   vFrWybiqReOB/Z0kyMSv36JMv8AohYojQKqqbxI7buxdKJiCd28vsREW8
   ZcAYL65bKaeD5q9CZm9g1E2CkY+fl11lA5+8aAedAGjq4IvivQq6JHpaC
   yAh38uFWyb2fx+njjJuV8J3iTGUaRVFjDwqVhavNSNoT/NKYE8Ozbw2tD
   w==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="26874054"
Subject: Re: Re: [PATCH 2/3] dt-bindings: watchdog: fsl-imx: document suspend in wait
 mode
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Oct 2022 14:41:45 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F0457280056;
        Thu, 20 Oct 2022 14:41:44 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Date:   Thu, 20 Oct 2022 14:41:40 +0200
Message-ID: <24401572.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <143f1466-e34a-254d-4e6e-fefa17ad1390@norik.com>
References: <20221019111714.1953262-1-andrej.picej@norik.com> <ea6893f6-be39-697c-4493-7f1c0ed6708d@linaro.org> <143f1466-e34a-254d-4e6e-fefa17ad1390@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. Oktober 2022, 14:36:10 CEST schrieb Andrej Picej:
> On 20. 10. 22 14:18, Krzysztof Kozlowski wrote:
> > On 20/10/2022 02:23, Andrej Picej wrote:
> >> Hi Alexander and Krzysztof,
> >> 
> >> hope I can reply to both questions here.
> >> 
> >> On 19. 10. 22 17:51, Krzysztof Kozlowski wrote:
> >>> On 19/10/2022 09:00, Alexander Stein wrote:
> >>>> Hello Andrej,
> >>> 
> >>>> Am Mittwoch, 19. Oktober 2022, 13:17:13 CEST schrieb Andrej Picej:
> >>> Missing commit msg.
> >>> 
> >>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> >>>>> ---
> >>>>> 
> >>>>>    Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml | 5
> >>>>>    +++++
> >>>>>    1 file changed, 5 insertions(+)
> >>>>> 
> >>>>> diff --git
> >>>>> a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> >>>>> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml index
> >>>>> fb7695515be1..01b3e04e7e65 100644
> >>>>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> >>>>> 
> >>>>> @@ -55,6 +55,11 @@ properties:
> >>>>>          If present, the watchdog device is configured to assert its
> >>>>>          external reset (WDOG_B) instead of issuing a software reset.
> >>>>> 
> >>>>> +  fsl,suspend-in-wait:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>> +    description: |
> >>>>> +      If present, the watchdog device is suspended in WAIT mode.
> >>>>> +
> >>>>> 
> >>>>>    required:
> >>>>>      - compatible
> >>>>>      - interrupts
> >>>> 
> >>>> What is the condition the watchdog is suspended in WAIT mode? Is this
> >>>> specific to SoC or platform or something else?
> >> 
> >> Sorry, what exactly do you mean by condition?
> > 
> > Ugh, I also cannot parse it now...

Sorry, Krzysztof already asked the right question: When does one want to 
enable/disable this feature?

> >> When the property
> >> "fsl,suspend-in-wait" is set the watchdog is suspended in WAIT mode, so
> >> this is defined by the user. Didn't want to apply it for all the
> >> supported machines since there could be devices which depend on watchdog
> >> triggering in WAIT mode. We stumbled on this problem on imx6 devices,
> >> but the same bit (with the same description) is found on imx25, imx35,
> >> imx50/51/53, imx7 and imx8.
> > 
> > I meant, what is expected to happen if you do not enable this bit and
> > watchdog triggers in WAIT mode? IOW, why someone might want to enable or
> > disable this property?
> 
> If this is not enabled and you put the device into the Suspend-to-idle
> mode the device resets after 128 seconds. If not, the device can be left
> in that state for infinite time. I'm guessing you want me to better
> explain the property in device tree docs right?
> I can do that in v2.
> 
> >>> And what happens else? When it is not suspended in WAIT mode?
> >> 
> >> When you put the device in "freeze"/"Suspend-To-Idle" low-power mode the
> >> watchdog keeps running and triggers a reset after 128 seconds. So the
> >> maximum length the device can stay in this mode is limited to 128
> >> seconds.
> > 
> > And who wakes up the system before 128 seconds? IOW is there a use case
> > of not enabling this property?
> 
> Well I can think of one, system can be woken up by some other interrupt.
> Like RTC which triggers interrupt (for example every 10s). So if this
> property is left disabled the watchdog can handle errors where other
> wakeup sources don't trigger interrupt or if the system is unable to
> wake from low-power state. In that case the watchdog will do a hard
> reset of the device.
> 
> But I'm not really sure if anybody uses this, just wanted to make sure
> that we keep the default behaviour as it is, since this driver is used
> by many devices and for quite some time.

This sounds more like (application) configuration. If so this should not be 
configured in device tree, IMHO.

Best regards,
Alexander



