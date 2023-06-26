Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381873E6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFZRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFZRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:54:29 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895E186;
        Mon, 26 Jun 2023 10:54:26 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3CB883E7AF;
        Mon, 26 Jun 2023 19:54:23 +0200 (CEST)
Date:   Mon, 26 Jun 2023 19:54:21 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Message-ID: <w3bbdq72thnerbyglb4dyshzg4vu5go2wpsciprk27vah6w2ms@yc4eqclct24a>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
 <6bbf239f-d530-2f1e-ff52-361f7c9cc951@linaro.org>
 <75d64lixeawfoqbrctm4thzh73cxkvnlmnh5xgbpf277pmh3gz@zthnqvvuxmeq>
 <a6f3906a-98a7-de7a-3e26-4b8c45fe93f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f3906a-98a7-de7a-3e26-4b8c45fe93f7@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 18:16:58, Krzysztof Kozlowski wrote:
> On 25/06/2023 21:52, Marijn Suijten wrote:
> > On 2023-06-24 11:12:52, Krzysztof Kozlowski wrote:
> >> On 24/06/2023 02:41, Marijn Suijten wrote:
> >>> SM6125 is identical to SM6375 except that while downstream also defines
> >>> a throttle clock, its presence results in timeouts whereas SM6375
> >>> requires it to not observe any timeouts.
> >>
> >> Then it should not be allowed, so you need either "else:" block or
> >> another "if: properties: compatible:" to disallow it. Because in current
> >> patch it would be allowed.
> > 
> > That means this binding is wrong/incomplete for all other SoCs then.
> > clock(-name)s has 6 items, and sets `minItems: 6`.  Only for sm6375-dpu

Of course meant to say that clock(-name)s has **7** items, not 6.

> > does it set `minItems: 7`, but an else case is missing.
> 
> Ask the author why it is done like this.

Konrad, can you clarify why other 

> > Shall I send a Fixes: ed41005f5b7c ("dt-bindings: display/msm:
> > sc7180-dpu: Describe SM6350 and SM6375") for that, and should maxItems:
> > 6 be the default under clock(-name)s or in an else:?
> 
> There is no bug to fix. Or at least it is not yet known. Whether other
> devices should be constrained as well - sure, sounds reasonable, but I
> did not check the code exactly.

I don't know either, but we need this information to decide whether to
use `maxItems: 6`:

1. Directly on the property;
2. In an `else:` case on the current `if: sm6375-dpu` (should have the
   same effect as 1., afaik);
3. In a second `if:` case that lists all SoCS explicitly.

Since we don't have this information, I think option 3. is the right way
to go, setting `maxItems: 6` for qcom,sm6125-dpu.

However, it is not yet understood why downstream is able to use the
throttle clock without repercussions.

> We talk here about this patch.

We used this patch to discover that other SoCs are similarly
unconstrained.  But if you don't want me to look into it, by all means!
Saves me a lot of time.  So I will go with option 3.

- Marijn
