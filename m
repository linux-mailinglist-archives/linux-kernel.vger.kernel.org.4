Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7D6B9F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCNS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCNS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40062AD00E;
        Tue, 14 Mar 2023 11:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D62E56195A;
        Tue, 14 Mar 2023 18:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B01C4339B;
        Tue, 14 Mar 2023 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678820229;
        bh=KmEh4pTBQMrg0Y8FTX/QjQEhBAXXbRindsRNaUzezPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0yJwq/6RRbRXI1CHDsb51XWTerbY/DIc0Yb2kmBUURFW+HmW8iozWdCI+JAJlxvf
         5ot+wtI/xbX9GqRnvwsc+0WN2xeo2NVNZKU9rgmtEWSDYNJbsqptZpF8jdOPQI40cT
         ygYUPrmsEJ2Q7eqxhD1WYXfGjJDY0bXDQO/eBZ2RK2xLV5L5Fs2/P073XkT+YIb402
         zl+A36RUkDsEAntnZG4vv4tRe0tV46jEUOcfz+pTrYNdeHIrk/3MrujjeF+zBn00me
         FZsBv52u9YC3nKYJbN45+RSbZhTDoYqlMD+yRd4GXZIOlnVdakVXz0akNAfbPIvD44
         ZTMGOyjxYCCkA==
Received: by mail-ua1-f53.google.com with SMTP id i22so6785134uat.8;
        Tue, 14 Mar 2023 11:57:09 -0700 (PDT)
X-Gm-Message-State: AO0yUKW29TJH0tfu+W9MgveBQws+LShvq5TOQPnnRc62gdsvzvqXCPeh
        iR94Aq3eHMQo50BZ1E9D1LSn8OuJI7UcRv5iyQ==
X-Google-Smtp-Source: AK7set+sXKo/5ss3HXPOBIKIyymPw83xzP60c5RH+zvuBezt29Oc92Fk+zqugNllEYKIGygsWGis5C6ohHyAr2elrwk=
X-Received: by 2002:a1f:cec4:0:b0:40e:fee9:667a with SMTP id
 e187-20020a1fcec4000000b0040efee9667amr23992692vkg.3.1678820228060; Tue, 14
 Mar 2023 11:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
 <167543212276.4084541.17286318072815310709.robh@kernel.org> <DU0PR04MB9417FD3A56076FC789D2719688D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417FD3A56076FC789D2719688D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 13:56:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7_v91+c52fDWDTvv657D=JkEGN0kSCTOEZwnkaksRug@mail.gmail.com>
Message-ID: <CAL_JsqL7_v91+c52fDWDTvv657D=JkEGN0kSCTOEZwnkaksRug@mail.gmail.com>
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

On Fri, Feb 3, 2023 at 5:49=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
> >
> >
> > On Fri, 03 Feb 2023 09:45:26 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
> > > compatible.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Rebased on linux-next, remove power-domains from v1
> > >
> > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12
> > > +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> > dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
>
> The error is not related my patch, I could help add rochchip and LSx supp=
ort later,
> this patch is just for i.MX8MQ.

It is related. You must pass 'make dt_binding_check' without setting
DT_SCHEMA_FILES. Your schema is being applied to the
rockchip,dwc3.yaml example. Most likely you need a custom 'select'
entry to avoid applying to all 'snps,dwc3' compatibles.

Rob
