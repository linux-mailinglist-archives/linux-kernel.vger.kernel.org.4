Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8E6016DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJQTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJQTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:02:50 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29D733CA;
        Mon, 17 Oct 2022 12:02:49 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-134072c15c1so14367168fac.2;
        Mon, 17 Oct 2022 12:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfuFTCnT41Vf+yqme8MYS5/WX6SrCU7lrQN9QbMWIls=;
        b=MkqeHj5QCt7tEWSFxbnrTlLKLTmU3P2z+mf2gLBVYwicqrZwG9PK3K3Eg97p6IK2NF
         BmAiA8iwvuKcnBwMGxmHsPbftLSfz0ivgyAsL+UFkISwMfGH6NOZnG7h25EkgIH1lhtN
         7HjHjCsIPgCRvnWNMDdt2Lk9aO5s6jqr7/Bm7LvVNV6C5P7ut5QcQE495h1TvTtn//lv
         gDxHWNmjfKtFTl6A0qbWU8lAR0mVrDpENoAz8m5ItPVSqasVtQlCOKBM5Frjb86ua3JS
         xukDPODn2Gs1xiD0+qqU3DJhQ3D6G2J7ya4JO38ogvqGEjiwnfV1n5TLG6u/UT1kxNAN
         ebRA==
X-Gm-Message-State: ACrzQf2NXpgUsK9R5jloHfCpvmYWW9ZhTRpTHikKhWPTb+g8VylXGckh
        BeymTTe0OY3xAwhNTBDbdSFXjgzhPA==
X-Google-Smtp-Source: AMsMyM6TiiRCJTJ7FzW9bmZbAhlcf3b8Miwh+vNx6cQ9k0vDAhf98IuGy/E94LDfTJcqf99R7R6jfA==
X-Received: by 2002:a05:6870:e0c9:b0:132:2090:20f7 with SMTP id a9-20020a056870e0c900b00132209020f7mr6312682oab.277.1666033368584;
        Mon, 17 Oct 2022 12:02:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m8-20020a9d73c8000000b00655c6b2655esm5038320otk.68.2022.10.17.12.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:02:47 -0700 (PDT)
Received: (nullmailer pid 2285363 invoked by uid 1000);
        Mon, 17 Oct 2022 19:02:47 -0000
Date:   Mon, 17 Oct 2022 14:02:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Message-ID: <20221017190247.GA2284064-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-4-639fe67a04be@linaro.org>
 <20221017143951.GA1434507-robh@kernel.org>
 <9b5df679-3561-b51b-7127-bf8bdc8cb65f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5df679-3561-b51b-7127-bf8bdc8cb65f@linaro.org>
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

On Mon, Oct 17, 2022 at 04:47:44PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 17/10/2022 16:39, Rob Herring wrote:
> > On Mon, Oct 17, 2022 at 12:23:08PM +0200, Neil Armstrong wrote:
> > > Convert the non-SMD Regulators bindings to dt-schema, the old text based
> > > bindings will be deleted later since the RPM bindings are not yet converted.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++++++++++++
> > >   1 file changed, 127 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
> > > new file mode 100644
> > > index 000000000000..e18bb8b87c43
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
> > > @@ -0,0 +1,127 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: QCOM IPC RPM REGULATOR
> > 
> > Fix your capslock.
> 
> It's literally taken from Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml:
> 
> title: QCOM SMD RPM REGULATOR

Plenty of bad examples to follow.

Rob
