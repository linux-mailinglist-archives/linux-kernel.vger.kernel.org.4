Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A27151DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjE2Wdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjE2Wdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:33:45 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37525AB;
        Mon, 29 May 2023 15:33:43 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DCCD5202FB;
        Tue, 30 May 2023 00:33:40 +0200 (CEST)
Date:   Tue, 30 May 2023 00:33:39 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH RFC 08/10] drm/panel/samsung-sofef03: Add panel driver
 for Sony Xperia 5 II
Message-ID: <gytain3f3sjvz6q2rm7fv7jqn3til7leqxdvqx4zhlefylilbh@gpsdwmxtev3s>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-8-541c341d6bee@somainline.org>
 <4679c741-7877-ce79-4086-08ec4ee9e6bf@linaro.org>
 <cf5dea0f-5999-6ac4-4f04-9b397ca94fdb@linaro.org>
 <g2f7oeoo5dljqpl7mwguoh5c766obe7vfltc2vlhx4c2na5ymm@pr2p6l5vewq5>
 <80372e51-e72f-e70e-c205-8bd79ad57515@linaro.org>
 <3839853f-eca7-5ff2-db90-51c014baff06@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3839853f-eca7-5ff2-db90-51c014baff06@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-30 01:22:54, Dmitry Baryshkov wrote:
> On 30/05/2023 00:29, Konrad Dybcio wrote:
> > 
> > 
> > On 29.05.2023 23:21, Marijn Suijten wrote:
> >> On 2023-05-22 11:08:12, Neil Armstrong wrote:
> >>> On 22/05/2023 03:23, Dmitry Baryshkov wrote:
> >>>> On 22/05/2023 00:23, Marijn Suijten wrote:
> >>>>> The SOFEF03-M Display-IC paired with an unknown panel in the Sony Xperia
> >>>>> 5 II always uses Display Stream Compression 1.1 and features a 60hz and
> >>>>> 120hz refresh-rate mode.
> >>>>>
> >>>>> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>>>
> >>>> Konrad's S-o-b is also required then
> >>
> >> I am unsure what to include here, since Konrad originally "authored" the
> >> commit but I believe it was nothing more than a completely broken and
> >> unusable driver spit out by "The mdss panel generator".  This needed
> >> enough rewriting that I don't feel like giving it much credit ;)
> > Might have been. I won't be mad if you drop this!
> 
> I'd say, either add S-o-B, or drop C-D-B. The Co-developed-by should 
> always come with the Signed-of-by, otherwise one can not be sure that 
> the co-developer didn't copy-paste some super-proprietary stolen code.

That is effectively what the downstream command sequences are, with
their meaning removed :P

I'll drop it then, that makes most sense I think.

- Marijn
