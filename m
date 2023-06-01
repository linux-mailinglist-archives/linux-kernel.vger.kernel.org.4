Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15709719F09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjFAOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjFAOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:05:34 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3E184;
        Thu,  1 Jun 2023 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3pKXbgDS50T7cX8cx3AOsjTCNJZJgcQdP+NdH8iRmm8=;
        b=b1OkxWRdokcxygc1Q5Hzbwfiv5N4WRXEqLdhRDoGQiuQIg2HV93EKZ4nfQFQ2KqIYY00scFnj92
        Q/qyKiF1/SnTEHnaa4/fKQu6xza5uxJexSDX0R0WGGDcV8Rbitue0ZdG9dTIfI/sNfdfj7D3TjPul
        3KZRKV3Xq80fjN8Hm7TIlauULojE33O2CKNKn+jt2OeJAqFcvxWeeCAAGaQzJpSgMTHBlpzjSIoA+
        WRlHVNYCfuanz5agVOedxSytpv5mcHR5oJw5ErSLOGHMjPwHWRVAb6Pv0bHXRE9i2G8C5U5Juyn1T
        n4h+FSmckxl2ag/UxHkJNxEMvfDtZT8sH+dw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q4ivg-0008Qm-TR; Thu, 01 Jun 2023 16:05:28 +0200
Received: from [2a06:4004:10df:0:65f3:6f7d:6ccb:3076] (helo=smtpclient.apple)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q4ivg-000NCt-Cs; Thu, 01 Jun 2023 16:05:28 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <b9297205-82fa-8cdf-550e-a53c073e0a9d@linaro.org>
Date:   Thu, 1 Jun 2023 16:05:17 +0200
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BD5682B-1A36-427A-8BDA-3159182DA057@geanix.com>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
 <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
 <20230524-ellipse-dagger-72f850253ea0@wendy>
 <24418459-DE19-4575-835B-8673F279993C@geanix.com>
 <b9297205-82fa-8cdf-550e-a53c073e0a9d@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26925/Thu Jun  1 09:27:46 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> On 1 Jun 2023, at 09.12, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 24/05/2023 12:30, Sean Nyekjaer wrote:
>>=20
>>=20
>>> On 24 May 2023, at 12.08, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>>>=20
>>> On Wed, May 24, 2023 at 10:16:13AM +0200, Sean Nyekj=C3=A6r wrote:
>>>> Hi Conor,
>>>>=20
>>>>> On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
>>>>>=20
>>>>> On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=C3=A6r wrote:
>>>>>>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
>>>>>>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
>>>>>>>> Document the new optional "fsl,pmic-poweroff" property.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>>>> ---
>>>>>>>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 =
++++++++
>>>>>>>> 1 file changed, 8 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git =
a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml =
b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>> index 9573e4af949e..5183a7c660d2 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>> @@ -26,6 +26,14 @@ properties:
>>>>>>>>=20
>>>>>>>> interrupt-controller: true
>>>>>>>>=20
>>>>>>>> +  st,pmic-poweroff:
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>> +    description: |
>>>>>>>> +      if present, configure the PMIC to shutdown all power =
rails when
>>>>>>>> +      power off sequence have finished.
>>>>>>>> +      Use this option if the SoC should be powered off by =
external power management
>>>>>>>> +      IC (PMIC).
>>>>>>>=20
>>>>>>> Just reading this description, this is sounding quite like a =
"software
>>>>>>> behaviour" type of property, which are not permitted, rather =
than
>>>>>>> describing some element of the hardware. Clearly you are trying =
to solve
>>>>>>> an actual problem though, so try re-phrasing the description =
(and
>>>>>>> property name) to focus on what exact hardware configuration it =
is that
>>>>>>> you are trying to special-case.
>>>>>>> Krzysztof suggested that the samsung,s2mps11-acokb-ground =
property in
>>>>>>> samsung,s2mps11.yaml is addressing a similar problem, so that =
could be
>>>>>>> good to look at.
>>>>>>=20
>>>>>> Better wording?
>>>>>>    Indicates that the power management IC (PMIC) is used to power =
off the board.
>>>>>>    So as the last step in the power off sequence set the SWOFF =
bit in the
>>>>>>    main control register (MAIN_CR) register, to shutdown all =
power rails.
>>>>>=20
>>>>> The description for the property that Krzysztof mentioned is
>>>>> samsung,s2mps11-acokb-ground:
>>>>>  description: |
>>>>>    Indicates that ACOKB pin of S2MPS11 PMIC is connected to the =
ground so
>>>>>    the PMIC must manually set PWRHOLD bit in CTRL1 register to =
turn off the
>>>>>    power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD =
pin goes
>>>>>    low, the rising ACOKB will trigger power off.
>>>>>=20
>>>>> In other words, I am asking what (abnormal?) scenario there is =
that means
>>>>> you need the property, rather than what setting the property does.
>>>>> Or am I totally off, and this is the only way this PMIC works?
>>>>=20
>>>> Indicates that the power management IC (PMIC) turn-off condition is =
met
>>>> by setting the SWOFF bit in the main control register (MAIN_CR) =
register.
>>>> Turn-off condition can still be reached by the PONKEY input.
>>>>=20
>>>> ?
>>>>=20
>>>> I must admit I=E2=80=99m somewhat lost here :)
>>>=20
>>> Sorry about that. I'm trying to understand what is different about =
your
>>> hardware that it needs the property rather than what adding the =
property
>>> does. If you look at the samsung one, it describes both the
>>> configuration of the hardware ("ACOKB pin of S2MPS11 PMIC is =
connected to
>>> the ground") and how that is different from normal ("Usually the =
ACOKB is
>>> pulled up to VBATT so when PWRHOLD pin goes low, the rising ACOKB =
will
>>> trigger power off.")
>>>=20
>>> Looking at your datasheet, you don't have such a pin though - just =
the
>>> sw poweroff bit & the PONKEY stuff. My angle is just that I am =
trying
>>> to figure out why you need this property when it has not been needed
>>> before. Or why you would not always want to "shutdown all power =
rails
>>> when power-off sequence have finished". I'm sorry if these are silly
>>> questions.
>>>=20
>>=20
>> No silly questions, maybe they trick me to come up with the correct =
answer :D
>>=20
>> Basically without this, you won=E2=80=99t be able to power off the =
system
>> other than hitting the PONKEY.
>> So it=E2=80=99s a new feature that wasn=E2=80=99t supported before.
>> Maybe this feature should not be optional?
>=20
> You are still describing what driver should do with registers. What =
you
> are missing is describing real cause for this. It's exactly the same
> case as was with s2mps11.

I didn=E2=80=99t mention anything with registers in the patch:

if present, configure the PMIC to shutdown all power rails when
power off sequence have finished.
Use this option if the SoC should be powered off by external power =
management
IC (PMIC).

^^ That=E2=80=99s is exactly what is happening if the option is enabled.

Do you have a suggestion wording?
What do you think about removing this option and make it default =
behaviour?

/Sean

>=20
> Best regards,
> Krzysztof
>=20


