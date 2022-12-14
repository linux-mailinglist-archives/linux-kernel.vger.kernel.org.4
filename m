Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD864D166
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLNUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiLNUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:40:01 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0232C676
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:39:05 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4EDC43F77A;
        Wed, 14 Dec 2022 21:39:03 +0100 (CET)
Date:   Wed, 14 Dec 2022 21:39:02 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Message-ID: <20221214203902.jilmsvf3bhg2kwqf@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org>
 <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org>
 <5740737.DvuYhMxLoT@g550jk>
 <20221209203851.sy37qqzczoaruuyb@SoMainline.org>
 <4846bb5f-79a9-e199-6a1c-5021e975e7ee@linaro.org>
 <20221210163121.woacrjuicb3vuzcn@SoMainline.org>
 <cd23d45c-f0a0-d81f-5230-a7de2bb90c07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd23d45c-f0a0-d81f-5230-a7de2bb90c07@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-11 21:11:51, Krzysztof Kozlowski wrote:
> On 10/12/2022 17:31, Marijn Suijten wrote:
> > [..]
> > If we were able to have rules for labels, would I then be allowed to
> > "correct" this?
> 
> If we had rules, yes. But we do not have. That's like - I will rename
> all variables because of some non-existing rules... There is no rule, no
> coding style (except what I wrote)...
> 
> >  The inconsistency between DTs is /super/ annoying (and
> > it looks wrong to have a singular _gpio named thing contain /multiple
> > gpios/), 
> 
> What do you mean - looks wrong? It's just a label which does not matter,
> so how it can be wrong?
> 
> > but just because we can't express this in dt-bindings (or so I
> > think) we shouldn't change it?
> 
> No, it just does not matter, so there is no benefit to change it, in my
> opinion, if label is readable and follows generic convention
> (underscores). Of course someone might treat its readability different
> and maybe for someone the missing "s" at the end is important.

That must be me.

> I am just
> saying that, unlike the node names, the label has little impact/effect.
> 
> However just be clear - this change also does not harm, so I am
> perfectly fine with it.

Okay, I'd prefer to have it :)

- Marijn
