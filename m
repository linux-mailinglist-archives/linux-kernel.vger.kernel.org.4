Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55470F06C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbjEXIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEXIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:16:28 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9AC0;
        Wed, 24 May 2023 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1NwnIlTOqdPMfCb/zd+hT2W58rXXL5MXAz8bOWIpyp8=;
        b=mOl1DhJgCAVRYSAsI/pI3+XI0qfVkyyyS1ZjPSkF2wJwwsgITfqRFT/cp8z/ZtunBPWJbMCmE26
        HSWGJfRbMdtPl6iy4jATOF4uA+BMhtAQnY8mlJqeCPYX4kVb2JHUF3W2kVvDl7fhtvnRiWGZIaPoI
        0RUGFBLQBbtMMyMyECJYjCvVjvzFJrVgMHiIk+EKacp9HaGogjuh+gA2+vwCcPGpBP4PD7Y6eXrpi
        gY44PtUdKRzJJkwd3UedeiJkrwHRmISS6Vax9aGSUsmaiQ58AnjmgAre9/0gaLrzq3aFxhIgOkvJB
        8qL1/vw+LDtLO7/8WlEzKpPZYZAc1rEQkddg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q1jfV-000I86-29; Wed, 24 May 2023 10:16:25 +0200
Received: from [185.17.218.86] (helo=smtpclient.apple)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q1jfU-000Trg-MJ; Wed, 24 May 2023 10:16:24 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
In-Reply-To: <20230523-flaccid-fossil-c9d09838dc64@spud>
Date:   Wed, 24 May 2023 10:16:13 +0200
Cc:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26917/Wed May 24 09:28:43 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

> On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=C3=A6r wrote:
>>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
>>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
>>>> Document the new optional "fsl,pmic-poweroff" property.
>>>>=20
>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>> ---
>>>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>=20
>>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml =
b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>> index 9573e4af949e..5183a7c660d2 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>> @@ -26,6 +26,14 @@ properties:
>>>>=20
>>>>  interrupt-controller: true
>>>>=20
>>>> +  st,pmic-poweroff:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description: |
>>>> +      if present, configure the PMIC to shutdown all power rails =
when
>>>> +      power off sequence have finished.
>>>> +      Use this option if the SoC should be powered off by external =
power management
>>>> +      IC (PMIC).
>>>=20
>>> Just reading this description, this is sounding quite like a =
"software
>>> behaviour" type of property, which are not permitted, rather than
>>> describing some element of the hardware. Clearly you are trying to =
solve
>>> an actual problem though, so try re-phrasing the description (and
>>> property name) to focus on what exact hardware configuration it is =
that
>>> you are trying to special-case.
>>> Krzysztof suggested that the samsung,s2mps11-acokb-ground property =
in
>>> samsung,s2mps11.yaml is addressing a similar problem, so that could =
be
>>> good to look at.
>>=20
>> Better wording?
>>      Indicates that the power management IC (PMIC) is used to power =
off the board.
>>      So as the last step in the power off sequence set the SWOFF bit =
in the
>>      main control register (MAIN_CR) register, to shutdown all power =
rails.
>=20
> The description for the property that Krzysztof mentioned is
>  samsung,s2mps11-acokb-ground:
>    description: |
>      Indicates that ACOKB pin of S2MPS11 PMIC is connected to the =
ground so
>      the PMIC must manually set PWRHOLD bit in CTRL1 register to turn =
off the
>      power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD =
pin goes
>      low, the rising ACOKB will trigger power off.
>=20
> In other words, I am asking what (abnormal?) scenario there is that =
means
> you need the property, rather than what setting the property does.
> Or am I totally off, and this is the only way this PMIC works?

Indicates that the power management IC (PMIC) turn-off condition is met
by setting the SWOFF bit in the main control register (MAIN_CR) =
register.
Turn-off condition can still be reached by the PONKEY input.

?

I must admit I=E2=80=99m somewhat lost here :)

/Sean

