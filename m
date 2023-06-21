Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F46738DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjFUR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjFUR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:58:16 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A321FF7;
        Wed, 21 Jun 2023 10:57:50 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687370215; x=1687629415;
        bh=wHGz+4iR1yJG9gev8O3hnv7/wXS8nRLc1LqeNaYELLY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=tbrO/bcpzOfBc7Yum/nWOy0bJ3CmwnIO7AXP3tq+xAjz8fFi6Zdacii4PSrKoPDbH
         g6qp5uw/I2cGFfEeyA8nqL1OuqHV+VRu0cvWICUOTxMjg4kA5kfKs4g2Odbok3mUkD
         hMLJmRQa7ogY8baGnbtM9MlFkKAr0ut0AyPu4OTryVBnSzNb2RsOPvFIIBxIYT7m/v
         UsEnV94qxpAGCGI8kuush9cInjpI+VPQHS+NjrELpAfzQ/ukJkNqSMktq/9UKxilh9
         6M7ASrf9sBb1AcSAD3GnV6c9roS1sQG4k1yjzEVVenf5KYD78f225lQL94RYdL9x7E
         DvC+lKLv7X7JQ==
To:     krzysztof.kozlowski@linaro.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, luca@z3ntu.xyz, pavel@ucw.cz,
        raymondhackley@protonmail.com, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033 compatible
Message-ID: <20230621175626.1229-1-raymondhackley@protonmail.com>
In-Reply-To: <5cb59a5e-0ce5-7215-a14a-2ca2c1505b53@linaro.org>
References: <20230602133533.260502-1-raymondhackley@protonmail.com> <20230602133714.260556-1-raymondhackley@protonmail.com> <5cb59a5e-0ce5-7215-a14a-2ca2c1505b53@linaro.org>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sunday, June 4th, 2023 at 10:43 AM, Krzysztof Kozlowski <krzysztof.kozlo=
wski@linaro.org> wrote:

> On 02/06/2023 15:38, Raymond Hackley wrote:
>=20
> > Add devicetree binding for Richtek RT5033 Flash LED charge pump used fo=
r
> > camera flash LEDs.
>=20
>=20
> What are the similarities? Same register interface? Same pins? It's not
> obvious and your commit should clear explain this. It will be also
> justification why you did not make devices compatible.
>=20

There is a similar way to control with 2 GPIO pins, strobe and enable,
which is not described well in this patch set.

Regards,
Raymond

