Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD61874A120
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGFPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGFPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:36:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC317AA;
        Thu,  6 Jul 2023 08:36:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so11323627b3.3;
        Thu, 06 Jul 2023 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657806; x=1691249806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD1pT2LGhjLDtjR1TYr+/gV9UU0KDGw+1r6piH1rLt4=;
        b=sRDHFcfIk5uvmBBUIU8pj2FTtO1yZffAaaLgGQiSmJ1Ka9ycBQNSQksE7Shwk7Dn4m
         OhhMBQo8hrE+MM1hhy6/ioKyIkv0kjDjCxqenBCKCwNu9gFuYRTavVw9EfjawYBNbk2x
         kg8kQcRC09au8nf/mbuwPJP8kjttWphv5yRr6LeoD+/3t39JY9dkVh39oc450Tz/XsWM
         1OuZVfYXXbdIccqfKuHNt/IUkTG8LmgnIJJmvB5gzP+Zb4efa7EyblHRiXQi5AdgWquW
         zpxEZst5r0/xTPJgZ7MsbNLqxamCrWBifWejdWepItwwiS0lnsKe+7QwoWxE3lWQIEFj
         C/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657806; x=1691249806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD1pT2LGhjLDtjR1TYr+/gV9UU0KDGw+1r6piH1rLt4=;
        b=WkDCSjf2LZVxbpkNaGXVKi+uqLQT+OnH0ZYMmM6vkT4zh09aUkpypY3AchxTtwvG+u
         3/9PTlBjLCYOFdUY/A9t5aRtS+k5OERQlPWRhVntwRFeM89ar0Iw3VublurV1JuOoP4f
         Nw8bqYdvt+QEcCzjTzJGksNFOqeaRI4NdG3mqVMp6MYtDqtDD/jSkGFlZQZ54YYSfiMB
         x44BDI9RTDBY23TK5AIZhPJdH9XPe8okM6yZ+pWMA8Cj4DZuqAUlzWy5kiZc6mp4ELfq
         iSft3oEp6xJZtIUfXRod0P5NcUAn75isxekJxVjLSajPoF4lBmaPZKjtvOpOM8Ssez8m
         jNEg==
X-Gm-Message-State: ABy/qLbnB5eFSHj40FXC8nMZ4qqA7pd/YsFKtopyO81Rg0kTz+AMIFbg
        fUlHp1S0NgA5SHf7MFQ6nUfU1JQ8pG2GJLPW70c=
X-Google-Smtp-Source: APBJJlHvkEtjlriVCUDGdbO0DZvjhc6QLEJUwDcVH9ySARGsNXDg8RwUaQouFdZRI0SujDbXeWC3+WZyWSL4w/toEgA=
X-Received: by 2002:a25:1306:0:b0:c61:488c:464 with SMTP id
 6-20020a251306000000b00c61488c0464mr1752174ybt.27.1688657805956; Thu, 06 Jul
 2023 08:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230706124339.134272-1-davidwronek@gmail.com>
 <20230706124339.134272-7-davidwronek@gmail.com> <021ad5b4-772d-f2f6-f9ec-bca06db04dd8@linaro.org>
In-Reply-To: <021ad5b4-772d-f2f6-f9ec-bca06db04dd8@linaro.org>
From:   David Wronek <davidwronek@gmail.com>
Date:   Thu, 6 Jul 2023 17:36:35 +0200
Message-ID: <CAEoe_eVAeNZVUHgpj64Redx5vg7wfzU4wjgH33TZ7ieoDifH-Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add SM7125 device tree
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Thu, Jul 6, 2023 at 5:25=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
> On 6.07.2023 14:40, David Wronek wrote:
> > The Snapdragon 720G (sm7125) is software-wise very similar to the
> > Snapdragon 7c with minor differences in clock speeds and as added here,
> > it uses the Kryo 465 instead of Kryo 468.
> >
> > Signed-off-by: David Wronek <davidwronek@gmail.com>
> > ---
> Can you please paste the output of `dmesg | grep "secondary processor"`?
>
> That would let us determine the unique identifier of the cores.
>
> Konrad
I get this output with the command:
[    0.005884] CPU1: Booted secondary processor 0x0000000100 [0x51df805e]
[    0.007191] CPU2: Booted secondary processor 0x0000000200 [0x51df805e]
[    0.008559] CPU3: Booted secondary processor 0x0000000300 [0x51df805e]
[    0.010046] CPU4: Booted secondary processor 0x0000000400 [0x51df805e]
[    0.011639] CPU5: Booted secondary processor 0x0000000500 [0x51df805e]
[    0.014424] CPU6: Booted secondary processor 0x0000000600 [0x51ff804f]
[    0.016421] CPU7: Booted secondary processor 0x0000000700 [0x51ff804f]

Sincerely,
David
> >  arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts=
/qcom/sm7125.dtsi
> > new file mode 100644
> > index 000000000000..12dd72859a43
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include "sc7180.dtsi"
> > +
> > +/* SM7125 uses Kryo 465 instead of Kryo 468 */
> > +&CPU0 { compatible =3D "qcom,kryo465"; };
> > +&CPU1 { compatible =3D "qcom,kryo465"; };
> > +&CPU2 { compatible =3D "qcom,kryo465"; };
> > +&CPU3 { compatible =3D "qcom,kryo465"; };
> > +&CPU4 { compatible =3D "qcom,kryo465"; };
> > +&CPU5 { compatible =3D "qcom,kryo465"; };
> > +&CPU6 { compatible =3D "qcom,kryo465"; };
> > +&CPU7 { compatible =3D "qcom,kryo465"; };
