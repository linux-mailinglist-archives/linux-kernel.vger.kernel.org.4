Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11F6FD853
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjEJHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbjEJHei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:34:38 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15B3AB1;
        Wed, 10 May 2023 00:34:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683704028; bh=KX7K3tWMwUSNfSD7Emzei/zBhnBTyUmdhpZWoZTlsNs=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=iSEYaO2/qOoYodN2VM4otWvMXPzcr3UM/htHE9RgNKppQDz60o5VRIVkolATnAH1s
         /Qi1j/leD7dRVRPPLQrC3rdHAG1tT38xg/DIkBoPeB0hH3NOC5xDpP5Y5jbfy3vbo8
         9VFLOc+HJ0uuEGg/PEr8hkwnPgtQ70Dd11SItWy8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] ASoC: dt-bindings: Adjust #sound-dai-cells on TI's
 single-DAI codecs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <A8647EF5-566A-4B99-9020-772810CB2BF7@cutebit.org>
Date:   Wed, 10 May 2023 09:33:47 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Shi Fu <shifu0704@thundersoft.com>,
        Shenghao Ding <shenghao-ding@ti.com>, kevin-lu@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F12DE31C-E167-47F0-BAE0-C09538C5C3C8@cutebit.org>
References: <20230509153412.62847-1-povik+lin@cutebit.org>
 <baf338a7-1e63-4842-32a1-8f63f850bd2d@linaro.org>
 <A8647EF5-566A-4B99-9020-772810CB2BF7@cutebit.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10. 5. 2023, at 9:30, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
>> On 10. 5. 2023, at 9:17, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>>=20
>> On 09/05/2023 17:34, Martin Povi=C5=A1er wrote:
>>> A bunch of TI's codecs have binding schemas which force =
#sound-dai-cells
>>> to one despite those codecs only having a single DAI. Allow for =
bindings
>>> with zero DAI cells and deprecate the former non-zero value.
>>>=20
>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>> ---

>>>  '#sound-dai-cells':
>>> -    const: 1
>>> +    # The codec has a single DAI, the #sound-dai-cells=3D<1>; case =
is left in for backward
>>> +    # compatibility but is deprecated.
>>> +    enum: [0, 1]
>>=20
>> Does it? I see playback and capture.
>=20
> I think so. Playback and capture are not separate DAIs.
>=20
> Martin

I double checked, I am pretty sure. There=E2=80=99s a single =
snd_soc_dai_driver,
which becomes a single DAI.

Martin

>=20
>>=20
>> Best regards,
>> Krzysztof
>=20
>=20

