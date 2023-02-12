Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A869358D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 02:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBLB6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 20:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBLB6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 20:58:50 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01E15CAC;
        Sat, 11 Feb 2023 17:58:46 -0800 (PST)
Date:   Sun, 12 Feb 2023 01:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1676167124; x=1676426324;
        bh=+Dqy/SLq6BVO3zqJNfQOnEGQobIgzLztHrmlEA53WfM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=efcIyWs10UZZAn/KOimOH28tdACJw6QJJ9sQTM/UxzBu17BqOy4YpS34Y8UZdC93h
         afs4+MrHsJsH4SEhYfef0D6X91dWnBp+aIyTbvPXbDbmpxt9QCt+TNZoTWsAXnaLCR
         GR0j8GgdtPa3WDtLvyjA5Zzw8kX3dmnMSx+1l5ME=
To:     Pavel Machek <pavel@ucw.cz>, Gergo Koteles <soyer@irl.hu>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add tri-state-key
Message-ID: <d1959211-bf33-f4fd-01a8-91dcd247aa70@connolly.tech>
In-Reply-To: <Y+fE7gIMD4BDCffy@duo.ucw.cz>
References: <20230209232556.91554-1-soyer@irl.hu> <Y+fE7gIMD4BDCffy@duo.ucw.cz>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/02/2023 16:40, Pavel Machek wrote:
> Hi!
>
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> @@ -52,6 +52,43 @@ key-vol-up {
>>  =09=09};
>>  =09};
>>
>> +=09tri-state-key {
>> +=09=09compatible =3D "gpio-keys";
>> +=09=09label =3D "Tri-state key";
>> +=09=09pinctrl-names =3D "default";
>> +=09=09pinctrl-0 =3D <&tri_state_key_default>;
>> +=09=09state-top {
>> +=09=09=09label =3D "Tri-state key top";
>
> "top/middle" is not too useful. Do we need the label at all? If so,
> should it say "loud/vibrations only/mute"?

"mute", "vibrate" and "ring" sound good to me.

Although it would be nice if users can easily map the physical key
position to the action when viewing the input device or remapping the
key in userspace.

Do you have any ideas or recommendations on how to do this?
>
> BR,
> =09=09=09=09=09=09=09=09Pavel

--
Kind Regards,
Caleb

