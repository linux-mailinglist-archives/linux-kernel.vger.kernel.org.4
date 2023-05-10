Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626AB6FD953
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjEJI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEJI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:29:34 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33828F;
        Wed, 10 May 2023 01:29:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683707358; bh=5RZw6OLzkF81T9qBCgl/kjGdza5GpI9DB8+PLpboHg8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=rUOzP4+D/25FepXKIIga+lR4GsBEH1La1wV6TDHRT5M83z9wFU6j5d+t8JsYygVbw
         FdAGJxdzxWb0beuPIAYW2bJGb9pb6ye6hg893N0j3iczva7DTriLXEMsQVRA1u2r5C
         pukl8a3drROy3U7JgZwV3YBrXcZ+jKS4W5UxbUPk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <627f1739-98b4-9576-4b11-887c8f7e0c52@linaro.org>
Date:   Wed, 10 May 2023 10:29:17 +0200
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
Message-Id: <5FC57F67-CC16-4DA4-9A0D-9F9A0539EE67@cutebit.org>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
 <04BB0158-6C7B-400C-A87A-6E9B2835FDC7@cutebit.org>
 <627f1739-98b4-9576-4b11-887c8f7e0c52@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 10. 5. 2023, at 10:23, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 10/05/2023 10:15, Martin Povi=C5=A1er wrote:
>>=20
>>> On 10. 5. 2023, at 9:51, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>>>=20
>>> On 09/05/2023 18:38, Martin Povi=C5=A1er wrote:
>>>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a =
simple
>>>> mono amplifier with digital input.
>>>>=20
>>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

>>>> +additionalProperties: true
>>>=20
>>> uinevaluatedProperties: false instead, so users can have =
name-prefix.
>>=20
>> I actually tweaked this to have the example passing, which has =
sound-name-prefix,
>=20
> true is not allowed anyway - it makes your schema simply not effective
> almost at all as it allows anything...

That makes sense.

>> which I guess is what you have in mind. Not that I exactly understand =
what these
>> options do (both additionalProperties and unevaluatedProperties), the =
schema docs
>> didn=E2=80=99t enlighten me right away when I looked into it.
>=20
> The way to go and to start always is to look at example-schema. It =
tells
> you explicitly to use additionalProperties:false and switch to
> unevaluated "If and only if another schema is referenced".

OK. While I have you on the line, what does unevaluated do? In what =
sense are props
unevaluated?

> Best regards,
> Krzysztof

Regards,
Martin=
