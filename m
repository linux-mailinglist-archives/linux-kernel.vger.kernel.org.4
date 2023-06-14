Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5098F730265
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbjFNOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbjFNOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D46B5;
        Wed, 14 Jun 2023 07:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40726431E;
        Wed, 14 Jun 2023 14:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDA4C433C8;
        Wed, 14 Jun 2023 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754415;
        bh=elELjTb5CnmTM2XaxI5ZmqLsRLHJSh0zLpyqDqLqeo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iTzA02CnNktI4jteOUeJAOBEh97nLdnvqQ0t4r6fLZx494kfNYI98Fgcg9MGcfjjb
         V5YeSym8TiiZVP7kVWEJ3TzeWS+SvyO4ASrq9m01PHUnfo4Wneu1spNNx11ibG1yRK
         PzBJYZaYi1emlmEKM5I2jh1I6A7MRo2ubdb+fetsHShXAvDpcI/IM5DBFU6bZlzsjA
         KhJF4NlnseDCqmQYFk6eWxpd5i7mS0cTP+a/qkZviHmfYTDibA6FYXcoJM6Te0Y8B9
         1YnijUlDt327FmyRnlXnJcQutNuQOgc/RUCSxkYiSgVUHJqAREUCQ8e+eFK/l0iWfJ
         Ok1HNPkHUadZw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b1a66e71f9so10741731fa.2;
        Wed, 14 Jun 2023 07:53:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDzgsQuPzSqgCWpJzuqcG//uWIXfau1zCo5I2cW1ZlXVJ4lhAfyD
        s6X0CnHBqUbzhLZhx47VN3blct6Gq/RWUzyi9Q==
X-Google-Smtp-Source: ACHHUZ5aR+XP7RGKR8+NYMzGzPjE2EL3zthsqJqokval211gOAcriEHJNBqyqtqLG+07Dr56T7OrilwKEd3Dp2vZQ4g=
X-Received: by 2002:a2e:9d15:0:b0:2b3:43e6:4335 with SMTP id
 t21-20020a2e9d15000000b002b343e64335mr2222354lji.11.1686754413281; Wed, 14
 Jun 2023 07:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230613201231.2826352-1-robh@kernel.org> <20230613201231.2826352-2-robh@kernel.org>
 <20230613-sculptor-prepaid-9dc5afcc2dcc@spud>
In-Reply-To: <20230613-sculptor-prepaid-9dc5afcc2dcc@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Jun 2023 08:53:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFT630XJ8xOrz47w5bMbGv12koCHc1NdhQQANdTrE4ow@mail.gmail.com>
Message-ID: <CAL_JsqJFT630XJ8xOrz47w5bMbGv12koCHc1NdhQQANdTrE4ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add
 "linux,keycodes" and deprecate "linux,keycode"
To:     Conor Dooley <conor@kernel.org>
Cc:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 3:11=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Jun 13, 2023 at 02:12:30PM -0600, Rob Herring wrote:
> > The "linux,keycode" property is non-standard. Add the common property
> > "linux,keycodes" and mark "linux,keycode" deprecated so that the mistak=
e
> > is not propagated.
>
> This is actually used in the driver for this device, should the driver
> not also be updated to use the corrected property?

Yes, but that doesn't have to be in sync with the binding change. I
mainly want to add this so it doesn't get propagated to new users
rather than move this case off of linux,keycode. Also, the input
subsystem should probably have a common function to read
linux,keycodes as right now every driver does it.

Rob
