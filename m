Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65E682C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAaM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaM2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:28:51 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C74AA7A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:28:50 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E3E8C100065; Tue, 31 Jan 2023 12:28:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1675168124; bh=03l1i5KMWTYFOtEVWuqkQUS4MN/8sH2rZL5RFoUKuyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJiMFsDxd2jA+xb0yGRf2FrBS5wLVMgHc4Fh32Y+Lhg+afUuoUJ6KIN04mST5xDKE
         SO/VQT+u4zFRTmAStqho5O2uJmiEGbDg6TKS6XB7d4ESmVG4VqkKzijfaIu6BuieSG
         LsBMuZCSnPEvCbfpxZ/WgQoDE5gLcciqv9lXEIKLxvS4559Hd7AVh/MQdZWQ82dFpe
         WbSZzyg5XzZQwc1X/t+Feg9hS+60dPfyFJgF1U6LIjTVhU9JLdYUilm3hdzWxO9zXw
         5wb97k/3CnBym/gvgYl+XLH+iSfVTZ6VPBt4KxxJdUdP88v8Bp/hSjF7zaV69sp2vU
         895NyKdBkcAlA==
Date:   Tue, 31 Jan 2023 12:28:44 +0000
From:   Sean Young <sean@mess.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
Message-ID: <Y9kJfPqtd98wIQ6r@gofer.mess.org>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
 <Y9YwbiJz9vOBejdL@gofer.mess.org>
 <20230130213020.GA3541260-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130213020.GA3541260-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:30:20PM -0600, Rob Herring wrote:
> On Sun, Jan 29, 2023 at 08:38:06AM +0000, Sean Young wrote:
> > On Sat, Jan 28, 2023 at 11:11:32AM +0100, Krzysztof Kozlowski wrote:
> > > On 28/01/2023 04:41, Christian Hewitt wrote:
> > > > Add a keymap and bindings for the simple IR (NEC) remote used with
> > > > the Beelink Mini MXIII Android STB device.
> > > > 
> > > > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/media/rc.yaml         |  1 +
> > > >  drivers/media/rc/keymaps/Makefile             |  1 +
> > > >  drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 +++++++++++++++++++
> > > >  include/media/rc-map.h                        |  1 +
> > > >  4 files changed, 57 insertions(+)
> > > >  create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> > > > index 266f1d5cae51..f390a5d2c82d 100644
> > > > --- a/Documentation/devicetree/bindings/media/rc.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/rc.yaml
> > > > @@ -39,6 +39,7 @@ properties:
> > > >        - rc-avertv-303
> > > >        - rc-azurewave-ad-tu700
> > > >        - rc-beelink-gs1
> > > > +      - rc-beelink-mxiii
> > > 
> > > Bindings are separate patches. Didn't you get such feedback already?
> > 
> > The only change for new keymaps is an added entry to the rc-map-name enum.
> > In the past, new keymaps have been accepted with that single line in the
> > same commit.
> 
> It's been a checkpatch.pl warning since 2018. The separation is so that 
> commit messages in the DT only repo[1] make sense.

Ok, makes sense. 

Thanks,

Sean
