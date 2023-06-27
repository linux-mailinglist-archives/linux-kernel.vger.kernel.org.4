Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144673F7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjF0I4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjF0I4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:56:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA88F;
        Tue, 27 Jun 2023 01:56:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98df6bc0048so376096666b.1;
        Tue, 27 Jun 2023 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687856207; x=1690448207;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/PscuUk8Kiipv4zwt68FQ9jdpIXfbCLhmtQ6RSmb1A=;
        b=iklmi/RUx0AqL55xuQrCfcTnc9lvoc9TNRqdWsM8E26IhOJnF1afg9iIZ93oeLaejo
         h5w7WAn5XmSYKIHaM+v65tzVsnwT55KbQQI4pgQKIzAw8sY12JfvZWKudsYDjUaC63v1
         m8p3mqom3t3D4zqsEM7ig6KJUivP5rcC7iW/C4hz6iTYq2/Er9r7SADWvK7rgwgIX6qa
         REz/hubT3jLRmEh7+UJGN7uwxl5gXciwbQ5GvASN18YsweVqp3OHEut3Cx/gdWq42wFp
         DnN67773WZN51M5eDCaU3G6g0/dnwRpEROsRVVumu14CU89rMa1+xVCUlsWU7H6J4e38
         VezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856207; x=1690448207;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/PscuUk8Kiipv4zwt68FQ9jdpIXfbCLhmtQ6RSmb1A=;
        b=LzUvfwGEHSIceVtAdHiCldf9+soub0EnGvv8U1RolS6+dVXvHeXwB0gVvLcB9Q00Iu
         +Zans8axhSNQSz7Dpr+Aps4JfTgrP+L3NIt/pSVbZC//7QqIdltn6Saauch/1B8cSIKb
         e8pK30xvb0/VoQOdOKzJIJw0aw68Kbl95l0LKFsze+CR7fbqTuXU3chZfOkM5l/q7oZw
         /ofrEpY9+gm+1cDdXDufomRwHp7WhgHgNyB0EAZ5y2PuNzvn5ICp3w8KaGCVEJcR/JEg
         ivyl0Nacubqe/NY16sAucBX5VGvG9Y5pcYeQgrsb1gt7Repbb00TqqOfhEiBlkaeimPw
         XA5A==
X-Gm-Message-State: AC+VfDzbZZnFQWKNyDot+dw8XoSjIzks6+5qzLvKdAiOgVtdDMUUCv9c
        Teqb+saPV9L4OK0KHKyX03Y=
X-Google-Smtp-Source: ACHHUZ4OMI9GAwQY/y/YttSFuhosd46Q7vuSFOlipsYh3eBXwzYf5FC1OFX4yp7wvL8e5HDNKyQFVA==
X-Received: by 2002:a17:906:eecd:b0:988:6491:98db with SMTP id wu13-20020a170906eecd00b00988649198dbmr20618073ejb.17.1687856206786;
        Tue, 27 Jun 2023 01:56:46 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906178d00b0098951bb4dc3sm4221891eje.184.2023.06.27.01.56.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2023 01:56:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add T7 based AN400
 bindings
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230626095223.721011-2-xianwei.zhao@amlogic.com>
Date:   Tue, 27 Jun 2023 12:56:42 +0400
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94551B90-19E8-49C7-90FC-FAFA5E5E2D9C@gmail.com>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-2-xianwei.zhao@amlogic.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 26 Jun 2023, at 1:52 pm, Xianwei Zhao <xianwei.zhao@amlogic.com> =
wrote:
>=20
> Document the new T7 SoC/board device tree bindings.
>=20
> T7 is an advanced application processor designed for smart display.
> It integrates a powerful CPU/GPU subsystem, a secured 8K video
> CODEC engine with all major peripherals.

^ please avoid marketing text in commit messages (and same for the
other commits in this series).

> The main system CPU is based on Big.LITTLE architecture,
> with quad core Cortex-A73 cluster and quad core Cortex-A53 cluster.

=E2=80=9CT7 is an Amlogic SoC for smart display applications. The main =
CPU is
based on a big.LITTLE architecture with a quad-core A73 cluster and
quad-core A53 cluster.=E2=80=9D

Christian

> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml =
b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 08d59842655c..79a8b44ffd03 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -218,6 +218,12 @@ properties:
>               - amlogic,aq222
>           - const: amlogic,s4
>=20
> +      - description: Boards with the Amlogic T7 A311D2 SoC
> +        items:
> +          - enum:
> +              - amlogic,an400
> +          - const: amlogic,t7
> +
> additionalProperties: true
>=20
> ...
> --=20
> 2.37.1
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

