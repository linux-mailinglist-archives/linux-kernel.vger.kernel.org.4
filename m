Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F383967FDA9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjA2IiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 03:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2IiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 03:38:09 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CE974A;
        Sun, 29 Jan 2023 00:38:08 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id BF820100065; Sun, 29 Jan 2023 08:38:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1674981486; bh=nFCgRLzt2RwhOcZeAYZUtkoppohSIfqzgQUjFWAep0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVL6EWyl0UNgAEvxfgrwtF5P37oAUkXsipKUcmu6Oir9pbpCtXo4nE+NWp8uWZCXB
         BryOaQeQ7lrUJ5hOGSALefkVVzK6+Yq5lZr1ERxqe1h2pqWlgI0KM8vUQEL1nb+fIO
         x08q95u5bT1j/oloDKh5w/fBruj3byJEm4AOyVgciAwmrcC+7YsGEttoIGVmbx8hQB
         dm4zV5x7K0bbAEAqsda5GjlW13LhGwFAzq0kNJvt1VjUI1uvP03hvIrxEDdE1gDTH6
         SRBm41PmoGlI0wWVf1e3m5TH8GJgAzLiXK44SfcCNMWyIP4ZaJhcpevoYEwIBwhilB
         V7YyyG8fVgRqw==
Date:   Sun, 29 Jan 2023 08:38:06 +0000
From:   Sean Young <sean@mess.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
Message-ID: <Y9YwbiJz9vOBejdL@gofer.mess.org>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:11:32AM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2023 04:41, Christian Hewitt wrote:
> > Add a keymap and bindings for the simple IR (NEC) remote used with
> > the Beelink Mini MXIII Android STB device.
> > 
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> >  .../devicetree/bindings/media/rc.yaml         |  1 +
> >  drivers/media/rc/keymaps/Makefile             |  1 +
> >  drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 +++++++++++++++++++
> >  include/media/rc-map.h                        |  1 +
> >  4 files changed, 57 insertions(+)
> >  create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> > index 266f1d5cae51..f390a5d2c82d 100644
> > --- a/Documentation/devicetree/bindings/media/rc.yaml
> > +++ b/Documentation/devicetree/bindings/media/rc.yaml
> > @@ -39,6 +39,7 @@ properties:
> >        - rc-avertv-303
> >        - rc-azurewave-ad-tu700
> >        - rc-beelink-gs1
> > +      - rc-beelink-mxiii
> 
> Bindings are separate patches. Didn't you get such feedback already?

The only change for new keymaps is an added entry to the rc-map-name enum.
In the past, new keymaps have been accepted with that single line in the
same commit.


Sean
