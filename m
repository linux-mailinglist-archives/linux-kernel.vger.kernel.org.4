Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208672ACB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjFJPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjFJPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:48:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F42D5F;
        Sat, 10 Jun 2023 08:48:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c89c47bdso506989866b.2;
        Sat, 10 Jun 2023 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686412101; x=1689004101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+PV93m/s/NOXGrP+XMGqPRSJ4bMSqkEUav/3Sp/SUo=;
        b=Q34XAtI54cIkhZYDotBTosBNKqeEtdaBGe/lHaZqbJ89DP58Z/qRC8OTHcB46m0Kz6
         tYZDXB+eN1elN5uNcii6qfMo6QKRIew8HjOzxQnKjwfYtI8QH1TzeUvWXuWVjRKibAo5
         oVqMa4yTNjPEnNLgASQGu+aEY31Mbd917fBUDjhMO0Jmw5zvHhRIwxxFUd6iayTCvK9d
         2vdziEGtDX7yJ1vOOUw2skkhT6BdgQ8ZbyeDMLE9Qj8kL9nHchSq7AQxBYFVVRWghCFM
         YkRPhqh9GgQAtJhC/Q9VULCI/TWMOpYGFRb/+xGzdTsj4a39ByFyLMzf8KrZU7Lyb0SW
         OxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686412101; x=1689004101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+PV93m/s/NOXGrP+XMGqPRSJ4bMSqkEUav/3Sp/SUo=;
        b=jblZ8pkPpytCWceQe1hVBDVJvL5HLJqcgeMDFq4XCj8VtVKM7SXJ8J7GSeBMjM9Yzu
         bzdzK647VZvHRsQQGNRiUvmT5GNGu7+3TmHgcI88eZxMLxMCho2ts/2KUMXORpn4FHqQ
         b4F2gi2kVGDLcBzF9KfulPW6rELDdJLKegePAzzMRMVTqBTLg12K82hCcTeto6l29BMS
         u/e9pSL0FDLg2R6MiKjZm7kb/5a8iXS93n/gTIMq5iWetYSae6329hyHYfDt5Q3k6PdN
         qEtp1+rJg8YNPGSUv2u2i96eWNLC4aS3MFmmWxjvfTflKXPgiXcEzNXdmMDA/zv8uf5L
         YOgQ==
X-Gm-Message-State: AC+VfDx89UC1ZPmvMV3VsmpQngtC9Jf/kU6oTv7FNPS3cX+vd54n4xl6
        xBZ9i0X0Fq10sXGLGot4ZG0CllaYkorWYCumwbw=
X-Google-Smtp-Source: ACHHUZ4+yt8TVxdmv/KLF0owdyYhjmUilZj8tEPlviShNxjxsyve8eoayZ040B9uZ/VhtH2U+1jPZUtc7w/UhVrwtao=
X-Received: by 2002:a17:907:728d:b0:96b:6fb:38d6 with SMTP id
 dt13-20020a170907728d00b0096b06fb38d6mr6295931ejc.65.1686412100664; Sat, 10
 Jun 2023 08:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230610122934.953106-1-bigunclemax@gmail.com>
 <20230610122934.953106-3-bigunclemax@gmail.com> <20230610-ranged-outboard-2aaa0cc36cbd@spud>
In-Reply-To: <20230610-ranged-outboard-2aaa0cc36cbd@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 10 Jun 2023 18:48:08 +0300
Message-ID: <CALHCpMhHxAdDMGmpD9i2Kt93XqyrW_ABzr7FZSE-0+54LwgzPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

=D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 18:06, Con=
or Dooley <conor@kernel.org>:

...

> >+
> >+    required:
> >+      - reg
> >+
> >+    additionalProperties: false
> >+
> >+required:
> >+  - "#io-channel-cells"
> >+  - clocks
> >+  - compatible
> >+  - interrupts
> >+  - reg
> >+  - resets
> >+
> >+unevaluatedProperties: false
>
> How come this one changed to unevaluatedProperties: false?
> Wasn't it for the ADC that we previously discussed whether
> additionalProperties: false was correct or not?

Hmm, I changed it to `unevaluatedProperties: false` as you suggested
in this message
https://lore.kernel.org/lkml/20230604-afternoon-frighten-42222010557b@spud/
