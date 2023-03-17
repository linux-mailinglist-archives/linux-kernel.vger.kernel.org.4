Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996C16BF597
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCQW6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCQW5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAD33B66D;
        Fri, 17 Mar 2023 15:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C3A60B38;
        Fri, 17 Mar 2023 22:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F9DC43446;
        Fri, 17 Mar 2023 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093841;
        bh=encxLzCe9LxaId/xxN4fKI71fK8XV5gG2gefzr7qlyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0PA8uMitrl7abldOvvBlitUAEbb9b0a25HcyQZmv3C5UJLjh2aMg4eB0QPlOv5M8
         1S3tFPUDb0CgSiJk2x6TwSWWnyijOX3KrKPbn0JDercjiUXfrEoB24XeV1KXNctbws
         Dgm2beKP6OOZ1QIDopxsQ129jaHiKPPuLXjVgBb4y10gi+e2NtN+8KaW7UdA6MQl+2
         iQw+qKgayG+fwtS9CYb+aWR4MocxedCDZY4xYc5d4+urAu2yxMsNfHbM2wh0Vb2Hfp
         OzAK22MpqeMflSRS5u6V8/Fb+Q9J6r6F7rJQiPqB+QjRW1R0WjhdozxSrhgbSFVelt
         ysuXoYkKw4FxA==
Received: by mail-vs1-f50.google.com with SMTP id f13so5822233vsg.6;
        Fri, 17 Mar 2023 15:57:21 -0700 (PDT)
X-Gm-Message-State: AO0yUKXyvVO6qT6o9XMaREpfSDo7RL1XiWcLkpoM2Z4yIgWq9C2Kd2to
        NIr1teXfpCQ4r95oARr6GqridD4JV851fPmpyg==
X-Google-Smtp-Source: AK7set+pXFOi9tiOFDnzXgTcKzg0ePHREvSRtw7Kqh9xmtljiwQ0myf2wduLF+FooERM0gKVnVi4VVhaBq9SlTXKnVc=
X-Received: by 2002:a67:d881:0:b0:425:bbea:6605 with SMTP id
 f1-20020a67d881000000b00425bbea6605mr47517vsj.3.1679093840028; Fri, 17 Mar
 2023 15:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
 <167543212276.4084541.17286318072815310709.robh@kernel.org>
 <DU0PR04MB9417FD3A56076FC789D2719688D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAL_JsqL7_v91+c52fDWDTvv657D=JkEGN0kSCTOEZwnkaksRug@mail.gmail.com>
In-Reply-To: <CAL_JsqL7_v91+c52fDWDTvv657D=JkEGN0kSCTOEZwnkaksRug@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Mar 2023 17:57:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nrqTX5ND3=+kFUmStx-+b=qpE_WsL_Le-YX8c285-5A@mail.gmail.com>
Message-ID: <CAL_Jsq+nrqTX5ND3=+kFUmStx-+b=qpE_WsL_Le-YX8c285-5A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Jun Li <jun.li@nxp.com>, "balbi@kernel.org" <balbi@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 1:56=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Feb 3, 2023 at 5:49=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > Hi Rob,
> >
> > > Subject: Re: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
> > >
> > >
> > > On Fri, 03 Feb 2023 09:45:26 +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
> > > > compatible.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Rebased on linux-next, remove power-domains from v1
> > > >
> > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12
> > > > +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> > > dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> >
> > The error is not related my patch, I could help add rochchip and LSx su=
pport later,
> > this patch is just for i.MX8MQ.
>
> It is related. You must pass 'make dt_binding_check' without setting
> DT_SCHEMA_FILES. Your schema is being applied to the
> rockchip,dwc3.yaml example. Most likely you need a custom 'select'
> entry to avoid applying to all 'snps,dwc3' compatibles.

This is now failing in linux-next. Please send an incremental fix.

Rob
