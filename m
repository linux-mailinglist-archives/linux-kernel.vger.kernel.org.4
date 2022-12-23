Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E16550BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiLWNIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLWNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:08:22 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0613FBA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:08:18 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D5DB63EF10;
        Fri, 23 Dec 2022 14:08:15 +0100 (CET)
Date:   Fri, 23 Dec 2022 14:08:13 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sm6125-seine: Provide regulators
 to SDHCI 1
Message-ID: <20221223130813.qk7thawdueugb5z4@SoMainline.org>
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
 <20221222203636.250190-4-marijn.suijten@somainline.org>
 <abd83b0c-ae33-98f7-a1e7-49f227246ebd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd83b0c-ae33-98f7-a1e7-49f227246ebd@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-23 13:00:18, Konrad Dybcio wrote:
> 
> 
> On 22.12.2022 21:36, Marijn Suijten wrote:
> > While SDHCI 1 appears to work out of the box, we cannot rely on the
> > bootloader-enabled regulators nor expect them to remain enabled (e.g.
> > when finally dropping pd_ignore_unused).
>
> Unrelated, unused-yet-enabled (as far as Linux is concerned, anyway,
> it doesn't know the state of smd rpm regulators unless you add
> regulator-boot-on) regulators get swept by "regulator cleanup".

That's exactly the point made here: at least this way Linux knows that
these regulators should remain enabled.  Even if it doesn't know about
many others and would fall flat on its face regardless when disabling
others as part of regulator cleanup.

Unless you meant something different?

- Marijn
