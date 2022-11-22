Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672C2633603
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiKVHl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiKVHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:41:47 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10430557;
        Mon, 21 Nov 2022 23:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669102896; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YqA87QW/3JpiBXgyEi1gDKmIXTOzfkgeskrWThHVTE0RU4KYBbUSNif8Yq3An2qcs6xPdK+de0Uq0akZOx6zd6elX4WnE4uj6F41Kx1qiPo40yjj+QuF663EwFt6y8bCPOwQM7c4ZOsqQXfQ4alnyxi6oUw1VqaUE6ItRGgIc00=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669102896; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=b7Rx3DilGCP5lCz1j9EnhzYAfhA1dEnQkYpfsFyULHI=; 
        b=cO7egFhVwCWN1RbtDPLu8iKeqwMuCrqrCstEi/qtFyXJnQQt7fGUUmrIRIB/JGajK2Cq7nIMTlp7pQcK7mq0tlXsGHiQFeh+SQtLqv/NlWy3e4u8+FCeFf+tYiLbXeZOEO4ZJk6R0Ts4qg9mMBOOTXeZ0qrDx99AjTxX6nsdnfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669102896;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=b7Rx3DilGCP5lCz1j9EnhzYAfhA1dEnQkYpfsFyULHI=;
        b=QGs2QRaSj4ngLjmlTGF03F2rC6ETgz/rwmuxWNjPybZ3seTFe5ktcgC+muA7qRfs
        +VRS/cQffh9aLTVBt7HrZt2P0YX6G0q7wbFRCle038WN1Zyv9C1H5tbY67otH9MNJjo
        MKadpz7RZ2mNgx9JbscAoCJYULO9PRJMLc7GJE0w=
Received: from [127.0.0.1] (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669102895638415.06106473348734; Mon, 21 Nov 2022 23:41:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:41:27 +0800
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_dt-bindings=3A_timer=3A_si?= =?US-ASCII?Q?five=2Cclint=3A_add_compatible_for_OpenC906?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
References: <20221121041757.418645-1-uwu@icenowy.me> <20221121041757.418645-3-uwu@icenowy.me> <98005150-83a7-5439-0db1-d93d459c3809@linaro.org> <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me> <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
Message-ID: <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2022=E5=B9=B411=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
3:35:48, Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg> =E5=86=99=
=E5=88=B0:
>On 22/11/2022 08:18, Icenowy Zheng wrote:
>> =E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:06 +0100=EF=
=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
>>> On 21/11/2022 05:17, Icenowy Zheng wrote:
>>>> T-Head OpenC906 is a open-source-licensed fixed-configuration of
>>>> C906,
>>>> which is now public and able to be integrated=2E
>>>>
>>>> Add a compatible for the CLINT shipped as part of OpenC906, which
>>>> should
>>>> just be ordinary C9xx CLINT=2E
>>>>
>>>> Signed-off-by: Icenowy Zheng <uwu@icenowy=2Eme>
>>>> ---
>>>> =C2=A0Documentation/devicetree/bindings/timer/sifive,clint=2Eyaml | 1=
 +
>>>> =C2=A01 file changed, 1 insertion(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/timer/sifive,clint=2Eyaml
>>>> b/Documentation/devicetree/bindings/timer/sifive,clint=2Eyaml
>>>> index aada6957216c=2E=2E86703e995e31 100644
>>>> --- a/Documentation/devicetree/bindings/timer/sifive,clint=2Eyaml
>>>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint=2Eyaml
>>>> @@ -35,6 +35,7 @@ properties:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const:=
 sifive,clint0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - thead,openc906-clint
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-clint
>>>
>>> Add entries sorted alphabetically=2E This should be squashed with
>>> previous
>>> patch=2E
>>=20
>> I make it a seperated patch because I think it's a questionable
>> approach=2E
>>=20
>> If you think it's okay, I will just squash it and put it as the second
>> patch in the next iteration, with adding openc906-plic as the first
>> one=2E
>
>What is a questionable approach? Why commit msg is not saying this?

Ah I mentioned it in the cover letter=2E The problem is just I doubt wheth=
er
binding strings for single SoCs are necessary=2E

>
>Best regards,
>Krzysztof
>
