Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25089681CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjA3Vaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjA3VaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:30:25 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494D38B4C;
        Mon, 30 Jan 2023 13:30:22 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so499860otq.13;
        Mon, 30 Jan 2023 13:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiqzkzUxt8/xNcC+60X48Uy9vsc/Fvpd3yplhrNClzI=;
        b=Ne4yJs5hDgAvZp3W2tHqfVA+fzw1guibnqbxUUdwLiAQkT/CRGWOlM8yvDYpfCsodH
         +e9z7sJFqjLZ5PGho2FBoYWnQI7244/dNyOyowrfat3Sb8opgFLeUbjD76ameWQVQ0li
         WTZc2C2Mxxs49sJH0FtFHBdQdT8u7iQZW4pQGpuPPrtjmp6M8sUzqpjqrAS3J+Davw9Z
         PjMLq/qm3LAStxcyissX8eFJHaMX7DSg3bZHKJk2cSA1PxqJNuD4BcHKiAEUosp4SyW1
         impD1anRkawkPKlS1l0AofQ08fPZRNdZXOUXcWTQEEfwp0ueOiz4l0q4QDTUsgvWssU3
         RYdA==
X-Gm-Message-State: AO0yUKWKgFh51bP4i32g8erf05yxyM6jCi0AnaitiOEzGYl1weAqMmPx
        bxIDcTNDVvlcdp8c91qhWg==
X-Google-Smtp-Source: AK7set+6elnwmrJx/eaOfyIFc6WxpSKhpCfomvw9nxGz714z5NUpgPl/HV2aAEHWF/qfxPSAKsxSfA==
X-Received: by 2002:a9d:6f93:0:b0:684:c309:def3 with SMTP id h19-20020a9d6f93000000b00684c309def3mr4545109otq.12.1675114222006;
        Mon, 30 Jan 2023 13:30:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id df17-20020a056830479100b006884c42a38asm4331361otb.41.2023.01.30.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:30:21 -0800 (PST)
Received: (nullmailer pid 3563341 invoked by uid 1000);
        Mon, 30 Jan 2023 21:30:20 -0000
Date:   Mon, 30 Jan 2023 15:30:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
Message-ID: <20230130213020.GA3541260-robh@kernel.org>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
 <Y9YwbiJz9vOBejdL@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9YwbiJz9vOBejdL@gofer.mess.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 08:38:06AM +0000, Sean Young wrote:
> On Sat, Jan 28, 2023 at 11:11:32AM +0100, Krzysztof Kozlowski wrote:
> > On 28/01/2023 04:41, Christian Hewitt wrote:
> > > Add a keymap and bindings for the simple IR (NEC) remote used with
> > > the Beelink Mini MXIII Android STB device.
> > > 
> > > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > > ---
> > >  .../devicetree/bindings/media/rc.yaml         |  1 +
> > >  drivers/media/rc/keymaps/Makefile             |  1 +
> > >  drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 +++++++++++++++++++
> > >  include/media/rc-map.h                        |  1 +
> > >  4 files changed, 57 insertions(+)
> > >  create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> > > index 266f1d5cae51..f390a5d2c82d 100644
> > > --- a/Documentation/devicetree/bindings/media/rc.yaml
> > > +++ b/Documentation/devicetree/bindings/media/rc.yaml
> > > @@ -39,6 +39,7 @@ properties:
> > >        - rc-avertv-303
> > >        - rc-azurewave-ad-tu700
> > >        - rc-beelink-gs1
> > > +      - rc-beelink-mxiii
> > 
> > Bindings are separate patches. Didn't you get such feedback already?
> 
> The only change for new keymaps is an added entry to the rc-map-name enum.
> In the past, new keymaps have been accepted with that single line in the
> same commit.

It's been a checkpatch.pl warning since 2018. The separation is so that 
commit messages in the DT only repo[1] make sense.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
