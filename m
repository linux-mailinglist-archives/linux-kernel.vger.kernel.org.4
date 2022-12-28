Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619F6586E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiL1VGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1VGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:06:07 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9694C13E22;
        Wed, 28 Dec 2022 13:06:02 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 479043F215;
        Wed, 28 Dec 2022 22:05:58 +0100 (CET)
Date:   Wed, 28 Dec 2022 22:05:56 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: Re-enable resin on MSM8998 and
 SDM845 boards
Message-ID: <20221228210556.rj7jgt6o2jqrxhkx@SoMainline.org>
References: <20221228115243.201038-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228115243.201038-1-dsankouski@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-28 14:52:43, Dzmitry Sankouski wrote:
> resin node declaration was moved to pm8998.dtsi file (in disabled state).
> MSM8998 and SDM845 boards defining resin node did not previously have
> status="okay" and ended up disabled.
> Re-enable it by using resin node link from pm8998.dtsi with status="okay".

Thanks, that fully covers it!

- Marijn
