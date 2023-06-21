Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641B738DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFUR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFUR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:57:30 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DB273A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:56:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687370178; x=1687629378;
        bh=wHGz+4iR1yJG9gev8O3hnv7/wXS8nRLc1LqeNaYELLY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=C1t7orL4szd8vpbKBwn3Elu1XUCxBcxpLieV4Lz2uU2B5139AlxRAPyHQ1L53omPn
         5N7m5AmgqctYsTY1+OdnHrdwF5w1+JXSi5t3wK1m7ILC1sPT4J4ngrUSMMKOLP6OUD
         /hneIEimXPWLdi/F4bEzbqkC3wAzZ/DRkMRRqkxJ+3KDUZwoBSJVPfDEq7xRzX1+qF
         +cd+j/q67IpSrwUfwyUBer3AyA33ecn5kxqgn8VLoGVyjlq/9QLqEdBuDWwt3XuvAX
         bZ3X/qZroBN8QSCpPrSDqGxECj9OWSYI6k5SXaPQ4jxLTpdu1lE5uN4hmIJ8d/p1dK
         Cq4BdDZ+3HVZw==
To:     lee@kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        luca@z3ntu.xyz, pavel@ucw.cz, raymondhackley@protonmail.com,
        robh+dt@kernel.org
Subject: Re: [RESEND PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033 compatible
Message-ID: <20230621175600.1209-1-raymondhackley@protonmail.com>
In-Reply-To: <20230621150141.GE10378@google.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com> <20230602131009.260239-1-raymondhackley@protonmail.com> <20230621150141.GE10378@google.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

