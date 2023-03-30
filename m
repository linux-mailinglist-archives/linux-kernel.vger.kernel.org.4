Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896DC6D0ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjC3QQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjC3QQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:16:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295C1BD5;
        Thu, 30 Mar 2023 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qxjy9npEOSNQ7FbMTN+XDOzAotM3oO5AVB3MNbdAtEk=; b=7wT5Gl+NRs3Oh9pQjgs7+KDz+h
        d1KLC+SlerbCw7DZ5mCTYMiFpG1vciqCMNzBVHGfboV5O8TNkIhp7otwKSpyZx2Koer9qsGvcGnUy
        MTI4bJQVgB99S2eo1TzGT5G1pbTTlxkuYkX6te2P3x+Ma7d3m3FDjGA+9ys3p5Og1E3+d/cIh1kwK
        11dUcB83iIRl/H33rpRq6xIqqp+/kDJiLrRpm6IG4Y6z+HRiXi5jWwo+XUT+Ag/hlJkXkpvKOJIaN
        0pe6jiUlo8J4eQauUuLdxx+xuMEKSGUw9iDmJ2kCldXc94S12IIAq0U/mkeRfbzZo1uXN6N8fzWOu
        +tyvft4A==;
Received: from p200300ccff10a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff10:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1phuvb-0007Tj-68; Thu, 30 Mar 2023 18:15:07 +0200
Date:   Thu, 30 Mar 2023 18:15:06 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230330181506.4d5fcf51@aktux>
In-Reply-To: <20230330113918.GS7501@atomide.com>
References: <20230329222246.3292766-1-andreas@kemnade.info>
        <20230330113918.GS7501@atomide.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 14:39:18 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [230329 22:22]:
> > From: Andrew Davis <afd@ti.com>
> >=20
> > Convert omap.txt to yaml.
> >  Documentation/devicetree/bindings/arm/ti.yaml | 157 ++++++++++++++++++
> >  1 file changed, 157 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml =20
>=20
> Great, can we also drop the old txt file or is more changes needed before
> we can do that?
>
we have still=20
- ti,hwmods: list of hwmod names (ascii strings), that comes from the OMAP
  HW documentation, attached to a device. Must contain at least
  one hwmod.

Optional properties:
- ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
  during suspend.
- ti,no-reset-on-init: When present, the module should not be reset at init
- ti,no-idle-on-init: When present, the module should not be idled at init
- ti,no-idle: When present, the module is never allowed to idle.

These optional properties are not in the root node but in subnodes.
=46rom my guts feeling this belongs in a separate file and should
be somehow dealed with in a second step.

So how to proceed?

BTW: I think this file then also belongs into
OMAP2+ SUPPORT section of MAINTAINERS

Regards,
Andreas
