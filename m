Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21323656D55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiL0RNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiL0RNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:13:43 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8A266B;
        Tue, 27 Dec 2022 09:13:39 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 81D631F5E2;
        Tue, 27 Dec 2022 18:13:36 +0100 (CET)
Date:   Tue, 27 Dec 2022 18:13:34 +0100
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
Subject: Re: [PATCH] arm64: dts: qcom: fix resin node duplication
Message-ID: <20221227171334.3zfesnmzbjc26sgz@SoMainline.org>
References: <20221227163810.71121-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227163810.71121-1-dsankouski@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-27 19:38:10, Dzmitry Sankouski wrote:
> resin node was moved to pm8998.dtsi file, and introduced duplication
> with other dts files, defining resin node.

This is fixing the right thing for the wrong reasons.  As mentioned in
my report these nodes did not previously have status="okay" and ended up
disabled after your patch, which is much more important than a few
duplicate properties that were left in place.

Please resend with a commit message that carries this load.  The title
could/should contain something like "Re-enable resin on MSM8998 and
SDM845 boards".  After that you can add my:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> Fixes: f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

You forgot to CC me, which would have happened automatically if you
added:

Reported-by: Marijn Suijten <marijn.suijten@somainline.org> # https://lore.kernel.org/linux-arm-msm/20221222115922.jlachctn4lxopp7a@SoMainline.org/

Aside that, thanks a lot for caring about your patches and sending this
fixup!

- Marijn
