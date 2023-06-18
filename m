Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8373482D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFRUao convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:30:42 -0400
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 13:30:40 PDT
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0660F7;
        Sun, 18 Jun 2023 13:30:40 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qAz0g-0003ie-H9; Sun, 18 Jun 2023 22:28:30 +0200
Message-ID: <3dc932ab52fffd1b1b3f0acdb3ac32cacc90411b.camel@apitzsch.eu>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add Kinetic KTD2026/2027 LED
From:   =?ISO-8859-1?Q?Andr=E9?= <git@apitzsch.eu>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sun, 18 Jun 2023 22:28:29 +0200
In-Reply-To: <7cbc6572-6772-64a6-6c91-567d58286426@linaro.org>
References: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
         <20230618-ktd202x-v1-1-fc182fefadd7@apitzsch.eu>
         <7cbc6572-6772-64a6-6c91-567d58286426@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 18.06.2023 um 14:41 +0200 schrieb Krzysztof Kozlowski:
> On 18/06/2023 13:45, André Apitzsch wrote:
> > Document Kinetic KTD2026/2027 LED driver devicetree bindings.
> > 
> > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > ---
> >  .../devicetree/bindings/leds/leds-ktd202x.yaml     | 164
> > +++++++++++++++++++++
> >  1 file changed, 164 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-
> > ktd202x.yaml b/Documentation/devicetree/bindings/leds/leds-
> > ktd202x.yaml
> > new file mode 100644
> > index 000000000000..9868d6f6f147
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml
> 
> Filename matching compatible, so missing vendor prefix. Can be
> kinetic,ktd202x.yaml

Thank you for pointing this out. I'll use kinetic,ktd202x.yaml in the
next version.
> 
> > @@ -0,0 +1,164 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/leds-ktd202x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Kinetic KTD2026/7 RGB/White LED Driver
> 
> Driver stands for Linux driver or for driving a LED? If the first,
> then
> drop.
> 
It stands for driving a LED.
> 
> The rest looks good, so you just need to use proper filename.
> 
> Best regards,
> Krzysztof
> 
Best regards,
André

