Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF9614572
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKAIID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:08:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63A1834E;
        Tue,  1 Nov 2022 01:07:59 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o2so7409469ilo.8;
        Tue, 01 Nov 2022 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NziJY6/fyP+utH+wONN+4YTM+lMaIKC/fH0mKgAarmA=;
        b=YXlrNLxqzKzYUVnb3wco5w3HzIK2/t3QuwRIhttCmLZzPf0ZpKreSxnnGh4YJm2gqS
         OlIjdQp8GB3y0CcAtQ+JP0nq60wD66CmiopFiTg5Hm9TtFdI+mB6nmhVBzMyLU0TfPvt
         I3l0Q6nfGYhz8ejdib3Mv6OnReRJGcxDfOITODinYLNJ0isX0J2t+QlNvgQkZzbbMoe1
         5RYKqCpJJPa8uZpFN5CwKOrujMQ95rhRsf2duJusno8klWUCI2BZDsfI699mVCwf2G8y
         Ap07BMeCrMktsAJBSUte7W/GgokSBi3W0yG0iv4VoS6UqcpBusKiZSRHzd/yt3LEyyv6
         erBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NziJY6/fyP+utH+wONN+4YTM+lMaIKC/fH0mKgAarmA=;
        b=WVBC1Y/ce1MkEdhvnJB/t6LMcdsY+A5Udr/TsqVZjC5ziDOukttCbk7rrwh3US85PZ
         H1k5WaCmJcMcRGlRhVXulA5I8RZwJXAZtxCeNX7Jv8tSIPk+zLkcKz1z/EoC2FQR/td/
         ge5i4PVi/aBsO8a/nHVjte/YeBlHsJ+va4ZL9eGy9eA5ux86n7NTH5JPvs7EuMFE9BIW
         TrVZThc1hguqNxzUCfyX4nsPp/k7PfFG7muKnXI/H3OaLgn1XRe2yUZspQCCrMgchllk
         DOre3UvMU64NwKOn+fItcLaToZIBTOz3yskj7drNpgftc6NHSypN2a+8j8paRb5uXhPG
         +zug==
X-Gm-Message-State: ACrzQf3vzu+1rxgqeUJEOblMoIMOtw1QrarwARLfBVe9DEBDTWuxH80o
        PgITfXiAmbty6mjnZmqT6/DccBOD0YsVUMjGe7IMwXnLPMS1zCkw
X-Google-Smtp-Source: AMsMyM5FqKTLQ4YFREilyxrr3PyG2tVv4MFHjVwm0WhqmZEE07K4C3m/MZDXaZPfV2iizknDneQmjcZTrQicHwG9yWY=
X-Received: by 2002:a05:6e02:b22:b0:2f9:b864:f1ad with SMTP id
 e2-20020a056e020b2200b002f9b864f1admr10472437ilu.298.1667290079191; Tue, 01
 Nov 2022 01:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221031190159.1341027-1-lis8215@gmail.com> <20221031190159.1341027-2-lis8215@gmail.com>
 <166725358721.3638147.11464755727689545438.robh@kernel.org> <20221101010834.GA4034975-robh@kernel.org>
In-Reply-To: <20221101010834.GA4034975-robh@kernel.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Tue, 1 Nov 2022 11:07:48 +0300
Message-ID: <CAKNVLfagXrTmwAPX3019SgMSOJ+BMQ1KfQV2LjOSrUA6+ZiFSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: adc-joystick: add valid-range
To:     Rob Herring <robh@kernel.org>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 1 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 04:08, Rob He=
rring <robh@kernel.org>:
>
> On Mon, Oct 31, 2022 at 05:05:54PM -0500, Rob Herring wrote:
> >
> > On Mon, 31 Oct 2022 22:01:58 +0300, Siarhei Volkau wrote:
> > > The valid-range property aims to cover detachable/lock-able
> > > joysticks where measured value goes outside valid-range.
> > >
> > > Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> > > ---
> > >  .../bindings/input/adc-joystick.yaml          | 62 +++++++++++++++++=
++
> > >  1 file changed, 62 insertions(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/input/adc-joystick.example.dts:82.28-=
104.11: ERROR (duplicate_label): /example-1/joystick: Duplicate label 'joys=
tick' on /example-1/joystick and /example-0/adc-joystick
> > ERROR: Input tree has errors, aborting (use -f to force output)
> > make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindin=
gs/input/adc-joystick.example.dtb] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1492: dt_binding_check] Error 2
>
> The examples aren't completely independent, so you can't use the same
> labels.

Good explanation, thank you.
