Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764B6FCEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjEITjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEITi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:38:57 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD349E4;
        Tue,  9 May 2023 12:38:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683661126; bh=phU5h8y0oMRwi2ThZZnGKdLtQF3CnRbkMjIYN0/eHWI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=iMrlfDHQSCycs969tMDE/i71ih4h1OCAaIBdjXCG+X7OlAbzEvK6YBwS3w12gdsnY
         YG7Aux2+inDEd3XHCTKrxrFa+V9oyf8Lw/xBbA7p1mhWPKzIvUdp2n4fGrMF6gNgvB
         JngPMVGxtpaTa5f1XA1MHrOww6w+evnSb0GzLG0U=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20230509-marxism-plug-759c99ac601c@spud>
Date:   Tue, 9 May 2023 21:38:46 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0216884B-A6F4-46B0-AEB9-AA16B3F24C8C@cutebit.org>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <20230509-marxism-plug-759c99ac601c@spud>
To:     Conor Dooley <conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

> On 9. 5. 2023, at 20:25, Conor Dooley <conor@kernel.org> wrote:
>=20
> Hey Martin,
>=20
> On Tue, May 09, 2023 at 06:38:27PM +0200, Martin Povi=C5=A1er wrote:
>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
>> mono amplifier with digital input.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> .../bindings/sound/adi,ssm3515.yaml           | 66 =
+++++++++++++++++++
>> 1 file changed, 66 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml =
b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>> new file mode 100644
>> index 000000000000..19b7185ae8e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019-20 Texas Instruments Incorporated
>=20
> Copyright here looks a little odd, copy & paste from the TI bindings =
you
> send patches for earlier, or intended?

Yeah, that must have been a copypaste from the other schemas. Not =
intended
in any case. Thanks for the catch.

>=20
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/sound/adi,ssm3515.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>=20
> Drop the quotes on these please.

OK

>> +
>> +  adi,ana-gain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    description: |
>> +      The value to be set in the ANA_GAIN register field on the =
codec. This determines
>> +      the full voltage span of the codec's analog output.
>> +
>> +      To quote the datasheet on the available options:
>> +
>> +        00: 8.4 V Full-Scale Gain Mapping
>> +        01: 12.6 V Full-Scale Gain Mapping
>> +        10: 14 V Full-Scale Gain Mapping
>> +        11: 15 V Full-Scale Gain Mapping
>=20
> Putting register values into the DT does not seem correct, although
> I know nothing about sound and will have to defer to Krzysztof & Co. =
on
> that front.

It=E2=80=99s an analog gain selection, it just seemed most honest and =
convenient
to defer to the register field in describing of what this property does.

I thought this should be here, and not with the other gain controls to =
be
exported to userspace, since it relates to the supply voltage. You =
probably
can=E2=80=99t select a gain value close or over the amp=E2=80=99s supply =
and expect proper
functioning, so the value here should be the system=E2=80=99s integrator =
choice.

On second thought there doesn=E2=80=99t seem to be any risk of damage to =
the amp
itself, so the knowledge of what=E2=80=99s the optimal value could be =
left up to
ALSA use-case configuration, and there=E2=80=99s no real downside in =
treating it
like other gain controls.

I think I will remove it in the next iteration.

> Cheers,
> Conor.

Cheers, Martin=
