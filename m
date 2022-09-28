Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0C5ED79D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiI1IXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiI1IXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:23:45 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6DA7E31C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:23:44 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CF5EB1F52C;
        Wed, 28 Sep 2022 10:23:41 +0200 (CEST)
Date:   Wed, 28 Sep 2022 10:23:40 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Message-ID: <20220928082340.mkn23ersrtzb5oth@SoMainline.org>
References: <20220926190148.283805-1-marijn.suijten@somainline.org>
 <20220926190148.283805-2-marijn.suijten@somainline.org>
 <052630d0-299e-e468-b2dd-266d371e2b0f@linaro.org>
 <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
 <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 10:14:05, Krzysztof Kozlowski wrote:
> On 28/09/2022 10:10, Marijn Suijten wrote:
> > On 2022-09-28 09:35:40, Krzysztof Kozlowski wrote:
> >> On 26/09/2022 21:01, Marijn Suijten wrote:
> >>> Document support for the pm6125, typically paired with the sm6125 SoC.
> >>>
> >>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>
> >>
> >> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> >> there's no need to repost patches *only* to add the tags. The upstream
> >> maintainer will do that for acks received on the version they apply.
> >>
> >> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> >>
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > https://lore.kernel.org/linux-arm-msm/0ec65132-7d7a-2f8d-cc16-cb76efc343d6@linaro.org/
> > 
> > Thanks, I thought of it this morning while browsing lore, but only got
> > to a screen just now so you beat me to it by ~30 minutes.
> > 
> > No need to lecture me on the rules, but I can't promise this won't
> > happen again.
> 
> 
> This is a automated message, don't get it too personal. A lot of people
> are not aware they have to do it, so I just one, same reply. I don't
> know whether you are aware of the process and just forgot to include it.
> If that's the case, just ignore the message.

That's useful, what software are you using for this?  Perhaps I can run
it as well, both to preempt myself and others.
(Side-note: I should get accustomed to `b4 shazam` to automatically pick
 this up from the list, instead of rebasing / re-applying local patches)

- Marijn
