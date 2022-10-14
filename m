Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95E75FE978
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJNHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJNHYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:24:24 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7721BF21A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:24:22 -0700 (PDT)
Date:   Fri, 14 Oct 2022 07:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665732259; x=1665991459;
        bh=TGUdxn23TFMtmW8ERauoStRg6kRXdVxb0gsOuzCan3c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=nZ9F+ovlE8hrK/h97XiF/fIJsJZyoqiMCXI88g67ya4ctVDZZhco4g7vTvYjD/MtK
         OHTzDaX4VeJP4dDrpWIK5zFzEA9fPJfhB0NCon3RDE9AVjJ5jae7wlaI2ZbPiq6Ppb
         FhKnMtmbNCpwQHyVD/mltUTLE4cSukGlmxzz84Q8nH6Y9r9aG0fCiJ9YwD3GxukPoq
         E5r6WZGcnJeFTsGT1l6FfIR0GiMHrRoT6qnRcxiGwu7+nT/m3ot9zHkNgdgKrX1kHA
         jo9B8fizpdmbCJ8zKDsNbVeLZw+17QQjrjSqF+X7gZ4mzexpHopoabLEtW+2B7y9ki
         JXKyD0hJtT2Ng==
To:     Rob Herring <robh@kernel.org>
From:   Job Noorman <job@noorman.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v2 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Message-ID: <CNLGSQCYFNR1.3HBI9N3N0A77B@ancom>
In-Reply-To: <166569274210.175113.9615851655183284739.robh@kernel.org>
References: <20221012202341.295351-1-job@noorman.info> <20221012202341.295351-2-job@noorman.info> <166569274210.175113.9615851655183284739.robh@kernel.org>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for you review!

On Thu Oct 13, 2022 at 10:25 PM CEST, Rob Herring wrote:
> On Wed, 12 Oct 2022 20:24:06 +0000, Job Noorman wrote:
> > This patch adds device tree bindings for Himax 83112b touchscreen
> > devices.
> >
> > Signed-off-by: Job Noorman <job@noorman.info>
> > ---
> >  .../input/touchscreen/himax,hx83112b.yaml     | 61 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/himax,hx83112b.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

The next version of this patch will make the properties touchscreen-size-{x=
,y}
required. Can I still attach your "Reviewed-by" tag to this updated patch o=
r
would you like to have a look at it first?

Kind regards,
Job

