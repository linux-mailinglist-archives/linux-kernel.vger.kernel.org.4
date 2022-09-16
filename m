Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14F5BB43F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIPWEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:04:36 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0DE8E;
        Fri, 16 Sep 2022 15:04:26 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 52E7C1F8BA;
        Sat, 17 Sep 2022 00:04:23 +0200 (CEST)
Date:   Sat, 17 Sep 2022 00:04:19 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, agross@kernel.org,
        angelogioacchino.delregno@somainline.org, rnayak@codeaurora.org,
        jamipkettunen@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        martin.botka@somainline.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: power: rpmpd: Add SM6375 power
 domains
Message-ID: <20220916220419.nk66b2ub634l6wsf@SoMainline.org>
References: <20220716193201.455728-1-konrad.dybcio@somainline.org>
 <166321302060.788007.3857501388494145309.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166321302060.788007.3857501388494145309.b4-ty@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-14 22:36:54, Bjorn Andersson wrote:
> On Sat, 16 Jul 2022 21:32:00 +0200, Konrad Dybcio wrote:
> > Add the bindings for SM6375 RPMPDs.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: power: rpmpd: Add SM6375 power domains
>       commit: 2d48e6ea3080ef7b2424dabfb500e29b030129d6

It looks like my request [1] to move these rpmpd definitions from the
rpm*H*pd section of this file down to sit with the rest of the rpmpd
definitions hasn't made its way through?

> [2/2] soc: qcom: rpmpd: Add SM6375 support
>       commit: df646a17f103c6f18ab85c5e3773763d18dc528b

[1]: https://lore.kernel.org/linux-arm-msm/20220721095946.wy3wbeib4ycwghzl@SoMainline.org/

- Marijn
