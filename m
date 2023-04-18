Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BA6E6C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjDRSqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjDRSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA12FC164;
        Tue, 18 Apr 2023 11:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5971C6381E;
        Tue, 18 Apr 2023 18:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC4C433A0;
        Tue, 18 Apr 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681843604;
        bh=pKJj9g3tBEkFJP6eRoZIhrGdL6/PVt203b7XHIVgCB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MA532bzdkC8gnUE8qJC+Z9XJx4r60U4jXHWdnFCAP1lqtSvNm63zBg9I7tps0GmeO
         LZhywIGCGgapvYxPTRWSgInBfrtV1qOOUBoxfUZzd43xfjpfRniaqx7y3xdQroY2Pb
         YG7PK7BrpCd844yVBrwErw45bhlpqdwYPo4joG9p2uOq46lHNRF3U8u/Oi/KtS5eRq
         o17pjw1qlLb7yIiMx3swcZFILGOI9UNAtMuhNTvLyHmKiesKs+wx04aay0+N2wu3iX
         8lN5XQzvH3nnHwnn7BQh3GCjaZ2Vc2Nri+6GT7Gn4OMvjt5P4gbWVpX9opCgjGGdSG
         ElO46apzLuPCA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-54ee0b73e08so473020817b3.0;
        Tue, 18 Apr 2023 11:46:44 -0700 (PDT)
X-Gm-Message-State: AAQBX9eb21SGv2ZRaPt+j/7XyGxfRhLwhdP1S2hLRmbN/KA2WOl7J2Ox
        Do85azT3ow9sWRA8Cbb6FDPS4ETJvE35tgxkjQ==
X-Google-Smtp-Source: AKy350YZVJSdk9pRa2UGMByWO/Ybo+AAHEAwh2PwITon48BeO0ZkbmsZmJF6/RAw5tyZru+XXDUnu779QuByl8GQZhE=
X-Received: by 2002:a81:bc05:0:b0:54f:b27f:286a with SMTP id
 a5-20020a81bc05000000b0054fb27f286amr476178ywi.5.1681843603770; Tue, 18 Apr
 2023 11:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org> <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org> <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
 <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org> <20230418184246.GA2103246-robh@kernel.org>
In-Reply-To: <20230418184246.GA2103246-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Apr 2023 13:46:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKVa+XHkoDbDLaD+haC2J7QDJ_oLr9RAT=7Pvwa-rWHLg@mail.gmail.com>
Message-ID: <CAL_JsqKVa+XHkoDbDLaD+haC2J7QDJ_oLr9RAT=7Pvwa-rWHLg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 1:42=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Apr 13, 2023 at 10:41:23AM +0200, Krzysztof Kozlowski wrote:
> > On 13/04/2023 04:34, Changhuang Liang wrote:
> > >>>>> +  lane_maps:
> > >>>>
> > >>>> Why did this appear? Underscores are not allowed. It looks like yo=
u
> > >>>> re-implement some standard property.
> > >>>>
> > >>>
> > >>> Will change to lane-maps.
> > >>> Yes, according to Vinod advice, lane mapping table use device tree
> > >>> to parse makes sense.
> > >>
> > >> Hm, I have a feeling that I saw such property, so you should dig int=
o
> > >> existing and in-flight bindings.
> > >>
> > >> Best regards,
> > >> Krzysztof
> > >>
> > >
> > > A standard property? Like "clocks" or "resets"?
> >
> > Like lane-polarities now submitted to one MIPI.
> >
>
> data-lanes perhaps?

Except that is for the controller's endpoint rather than the phy.
Presumably if the controller knows the mapping, then it can tell the
phy if it needs the information. IOW, don't just copy 'data-lanes' to
the phy. Follow the normal patterns.

Rob
