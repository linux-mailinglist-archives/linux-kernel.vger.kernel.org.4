Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508496C35A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjCUP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCUP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F349D5;
        Tue, 21 Mar 2023 08:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0179261CE1;
        Tue, 21 Mar 2023 15:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6944FC433EF;
        Tue, 21 Mar 2023 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679412488;
        bh=iH3z298JWSvq6k/cW7wC07iImWkkHlsSWa287nIZg8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nGK3SBNBQV2mkoMnGp+g/dvfYHN5AfgYASxOxSNftFLOFTczeg+Poi9xL3zyDLSPV
         sj2SiNpZRJvioRIzW6xvcHIR4a7K0y0DhtRNCCsK6OeBrhV67YSy/0N7DoCoPYPUyt
         WfjdlVBWg+CupB5LV1TdlvbfuSCMfQoc0Izn0n2B9TEZgZ0JBf79FYtD1Kf8BdeLbZ
         IufmyJXUEeg4pFNX+Kb3Vn+usCxOF8COf/Cs34OXb/eMEwJbK5wkRLLR+i5ysfzMkj
         opJpNwf2NOl5ge+MHWWjICKXEy6YdfMcbXiUT3JDy13xsIULU6bRh0ZC8UGArjGwW5
         Cf/G/u7+/Lccg==
Received: by mail-yb1-f171.google.com with SMTP id l16so8033375ybe.6;
        Tue, 21 Mar 2023 08:28:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9fcRKNuLozi45DqHKDW2QhfRJYOkYk+m+PGb3OxD/876SK9oXFf
        xoadswsR/OKpI9/NEw+ee4H87x5Gryoxnvpt+Q==
X-Google-Smtp-Source: AKy350YcjYxKGk56fFGmnrWvtKLcXfaPTWtsdZipY3tK2gi+/vlECx3Lb/W8tjJZZABLM1tgylwuJZTT51Jt6KkswGM=
X-Received: by 2002:a05:6902:18c7:b0:b6a:9ef0:2060 with SMTP id
 ck7-20020a05690218c700b00b6a9ef02060mr1882988ybb.1.1679412487464; Tue, 21 Mar
 2023 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org> <167940239018.531701.12929244936825953214.robh@kernel.org>
 <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com> <ZBmzZBYUFXlTX08i@hovoldconsulting.com>
In-Reply-To: <ZBmzZBYUFXlTX08i@hovoldconsulting.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Mar 2023 10:27:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKOSQJBVAaDVrAze6VZe9XHaY7AMs_pM=f3Pgto6UDDqA@mail.gmail.com>
Message-ID: <CAL_JsqKOSQJBVAaDVrAze6VZe9XHaY7AMs_pM=f3Pgto6UDDqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:37=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 21, 2023 at 08:20:55AM -0500, Rob Herring wrote:
> > On Tue, Mar 21, 2023 at 8:17=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > >
> > > On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> > > > Add an 'nvram' pattern property and a reference to the correspondin=
g
> > > > SDAM DT schema.
> > > >
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > >
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > >
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_che=
ck.
> > > This will change in the future.
> > >
> > > Full log is available here: https://patchwork.ozlabs.org/project/devi=
cetree-bindings/patch/20230320135710.1989-4-johan+linaro@kernel.org
> > >
> >
> > This is a long list of warnings. Can you all fix some of them before
> > adding on to this binding.
>
> Note that this patch is only making the list of warnings shorter so I
> don't think addressing the remaining issues should block this one.

How can you tell sorting thru the 100s of warnings? It sounded like a
new feature to me, not a fix for something missing. Anyways, I've
gotten 2 patches today for this binding and I don't see patches for
fixes. Which is a bit surprising because you all generally are fixing
warnings on the QCom stuff.

I didn't really mean to block this one, but I don't really want to see more=
.

Rob
