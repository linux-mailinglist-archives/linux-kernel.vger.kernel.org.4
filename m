Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72A5B3AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIIO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIIO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:27:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F45AA34B;
        Fri,  9 Sep 2022 07:27:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d68so1526000iof.11;
        Fri, 09 Sep 2022 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=4j6yKaic5oazyrfOzloSvEnmZiVIQ82dAZTjcffuWZg=;
        b=UiiAI9XyEeR/oqwkvPuc94AtrS6oWDXhykkIlAoDa8w9HH/WegNqVN0v1sCJq6I6a9
         r8WGcDpMIM9zkNteK7ldn8TFZrVfShoRhF5pPOytP1BKIotrlSCwACqOphvjokwCHIrx
         gNSHg4A0PE9PfUlkjNKwfUzYRzPba1cDRbjVsinojglTZaUJ7AB2OmOjqvIi4Qk3sjHp
         cJgZgim1voRO1bEttDw0dcPqIXVt6zODhSHK89ESkKepxQe8mcwyZaQvJ5jid4RLXMFg
         Rd1kHrAS1gwvE0zaIRR/cSaGlGTQyxCVLPwzZ1sncSS4Ltnb6avqlWyryVcgKowKxB1g
         DkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4j6yKaic5oazyrfOzloSvEnmZiVIQ82dAZTjcffuWZg=;
        b=uNj2O1jAhtHYDEAS4r0BQc+m5aZnoWZrnOCORVml6V31aVpUoAzXB8yy8W2AcR0UHv
         BssbMmAJ9lvG+1MdSrQw0IT6X3NzuCNd+RF9uMRBRSU1a7mLgWp2VVjUqFs2pCtl8wrW
         Um4R2G1P2w+Hy5aSMiyJPysUXfMBZVKXkOMHyoHiGRB+/aObiBfpE+jO9cfrORvuzQB8
         mcskCZAR2Gswn9XFJ47YRR90UvLZucIN8QZ9KMIaNL8C36u2Y4o5DmKKjXhe9dm524cH
         Ie698+mdfAUkuIPs7c7ro3NmeFJ4+QxNE479uv0qqkkLsba+xosqrxFNw9CFdjUe6V2L
         Ui0Q==
X-Gm-Message-State: ACgBeo039DbILvl4cKw9ubEBfoYb30PfxZv8ZVv7UOfxH1RJ6oiLDZBr
        1l6Cyf5Z2Pf0raXE2JOT/642EnQO3OjkONn683bDybRnZUSo4w==
X-Google-Smtp-Source: AA6agR4pz0L5yvddtwv72CCCdzO6a3EN4ynaOMKwWs5GvwYO0ZR81ZO9gHHGEY1wt4jRVKYW4rO3TjMNYXvHNrkxFEg=
X-Received: by 2002:a05:6638:160c:b0:343:4cdd:8fe5 with SMTP id
 x12-20020a056638160c00b003434cdd8fe5mr7865935jas.299.1662733647201; Fri, 09
 Sep 2022 07:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073456.239668-1-gengcixi@gmail.com> <20220909073456.239668-2-gengcixi@gmail.com>
 <Yxr0+LJWWsF53dr2@google.com> <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
 <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org> <CAF12kFt95PYcK249Zm8r+jZtEm3vGTd3AXn2DB_CG0Xf=3xeFQ@mail.gmail.com>
 <fe1838eb-8ec5-62a9-3d90-bf2fe4070535@linaro.org> <YxsofwCfTZqqJOiK@google.com>
In-Reply-To: <YxsofwCfTZqqJOiK@google.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 9 Sep 2022 22:26:51 +0800
Message-ID: <CAF12kFsGytPEqwDXiR+f7coKHeJp5vNP6EPzbcqUPDAggc5_yg@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        baolin.wang@linux.alibaba.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee@kernel.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=97=A5=E5=91=
=A8=E4=BA=94 19:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 09 Sep 2022, Krzysztof Kozlowski wrote:
>
> > On 09/09/2022 12:16, Cixi Geng wrote:
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=
=B9=B49=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 17:57=E5=86=99=E9=81=93=EF=BC=
=9A
> > >>
> > >> On 09/09/2022 11:50, Cixi Geng wrote:
> > >>> Lee Jones <lee@kernel.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=94 16:10=E5=86=99=E9=81=93=EF=BC=9A
> > >>>>
> > >>>> On Fri, 09 Sep 2022, Cixi Geng wrote:
> > >>>>
> > >>>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >>>>>
> > >>>>> Add bindings for Unisoc system global register which provide regi=
ster map
> > >>>>> for clocks.
> > >>>>>
> > >>>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >>>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > >>>>> Reviewed-by: Rob Herring <robh@kernel.org>
> > >>>>> ---
> > >>>>>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++=
++++++
> > >>>>>  1 file changed, 68 insertions(+)
> > >>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,um=
s512-glbreg.yaml
> > >>>>
> > >>>> I'll take this when the clk driver changes are merged.
> > >>> this patch is depends on the clk dt-bingdings, which is already mer=
ged [1]
> > >>
> > >> which is merged to different tree, so this one here cannot go via MF=
D
> > >> tree without cross-tree merges.
> > > Hi Krzysztof:
> > > I test on the latest kernel 506357871c18e06565840d71c2ef9f818e19f460
> > > (torvalds/master) version:6.0.0.rc4
> > > what you mean is I must warting your branch upgrade the cross-tree?
> >
> > Ah, you linked email message so that rather indicated applying to clk
> > tree, but indeed it is already in the mainline.
>
> ... and also, I'm *still* not playing that game with DT bindings.
>
> It's bad enough that we have to sync across subsystems to avoid
> build-breakages.  If documentation comes together in -next and
> subsequently Mainline that should be adequate.
>
> I doubt Linus is running DT checker(s) on each pull-request he merges,
> nor are there any stipulations for DT bindings to be bisectable
> post-merge.

Thanks Lee and Krzysztof's review. I wiil send the patch a new version to
add the adress-cell  const property.and I think we have agreed on that
the dependent patch already exist in mainline.
so these patches can applied as long as no other issues.

Best regards,
Cixi
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
