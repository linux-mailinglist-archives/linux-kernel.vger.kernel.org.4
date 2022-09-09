Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A85B34F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIIKQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIIKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:16:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9312B2BE;
        Fri,  9 Sep 2022 03:16:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a9so578760ilh.1;
        Fri, 09 Sep 2022 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Q8z7Zr48bJWSSWTTcUPuG0wa86xruExRF49z6BXyq4k=;
        b=XeIyNie8rozFXvTXWLZRpsQiL9x57MO8ZSi2o08wWnyrrLQomtP392m9LW+0XBDmgY
         SG4IRxpJNQtDPp0hznw4PLp72RRhk9dormEUfoDFU+ZAyNuYoTwvTjN9N5FUKkqDOQY1
         YP0VSlRE5sIS91i+gVUaMJvmU8PAoop9n/ovdFEurSAm0AhBSnRHlqgdaa7HNkNxnXLA
         DHJYqKx8pNdtG07oVv9MwapwhjdpLGVSVXQ5u/qVVkJGU1/jVJI4Tie5dlFj1Kp5qMyi
         25bWjImvz1bMrGRwfmcvH25dnUHg2ex0gaVn4O14SbobrgYQu5ssEzNNoLuwOpx2tTUh
         WfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q8z7Zr48bJWSSWTTcUPuG0wa86xruExRF49z6BXyq4k=;
        b=YH6jE+2YjYuajZmkXKATB/MUnyGM1DxE/MATFrsb94M+t6SIx2pcbn2z55IQk6HW5Z
         mZM9nyOpnV7GxCyUJvkXBkKnD/e2ZbpU+2ymrYH1u03vOKmAV0bqjfDmfiAwojS1Wxrs
         jgphFWo2uufLxcSNJJlbrpjm2tHyKcuQkzJ9KkzY4RXyA7X5AZl9KM7PyXz6xo59I0vs
         /6ndcTku9VCfUKe6J9kVHRQ28DH4bmjW49XE/8nnUffYXCuwVTP7GUMHuIta9QLQsr2W
         lsf40YrD5lftZ0hVsnI7fLcjfhCbtBYR+ylEFDpuZOhWJqirrQcsGMdzyLH2ptpSzihn
         KHwA==
X-Gm-Message-State: ACgBeo3sG/pkB0KO5+QtlYq3cI6iQ4HyG4z/8BqD0bRumdu1T9Bv75BX
        TXt3boqrWhfHcxae+eQiRioHkdBwfGZujwcv2zs=
X-Google-Smtp-Source: AA6agR40iMfte830HQDjzHKsxh6lQf3hqItkapLHO0DZzzpCfbd3RvMUNGEIyKPxiXCQiEpyt32978gf8vBO0+1qIIo=
X-Received: by 2002:a05:6e02:1789:b0:2ec:ab4f:4b0f with SMTP id
 y9-20020a056e02178900b002ecab4f4b0fmr4096396ilu.34.1662718596631; Fri, 09 Sep
 2022 03:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073456.239668-1-gengcixi@gmail.com> <20220909073456.239668-2-gengcixi@gmail.com>
 <Yxr0+LJWWsF53dr2@google.com> <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
 <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org>
In-Reply-To: <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 9 Sep 2022 18:16:00 +0800
Message-ID: <CAF12kFt95PYcK249Zm8r+jZtEm3vGTd3AXn2DB_CG0Xf=3xeFQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
9=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 17:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/09/2022 11:50, Cixi Geng wrote:
> > Lee Jones <lee@kernel.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 16:10=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, 09 Sep 2022, Cixi Geng wrote:
> >>
> >>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>
> >>> Add bindings for Unisoc system global register which provide register=
 map
> >>> for clocks.
> >>>
> >>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++=
++
> >>>  1 file changed, 68 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512=
-glbreg.yaml
> >>
> >> I'll take this when the clk driver changes are merged.
> > this patch is depends on the clk dt-bingdings, which is already merged =
[1]
>
> which is merged to different tree, so this one here cannot go via MFD
> tree without cross-tree merges.
Hi Krzysztof:
I test on the latest kernel 506357871c18e06565840d71c2ef9f818e19f460
(torvalds/master) version:6.0.0.rc4
what you mean is I must warting your branch upgrade the cross-tree?
>
> Anyway please respond to my comment.
it in different reply-letter, about the question "Hmm, why these are not co=
nst?"
do your mean I should write as follow? what the different,
because I found both the two ways of writing are exist
  "#address-cells":
    const: 1

  "#size-cells":
    const: 1

>
> > so the patch can be applied without wating the clk driver
> > and the clk driver need merge this first
> >
> > commitID =EF=BC=886a3a6c7ae0ef235faebf66bac56384dbd5f944dc=EF=BC=89
> > [1]. https://lore.kernel.org/all/20220711202740.198F4C34115@smtp.kernel=
.org/
>
>
>
> Best regards,
> Krzysztof
