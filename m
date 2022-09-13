Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5315B7628
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiIMQKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiIMQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:09:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778199C8CB;
        Tue, 13 Sep 2022 08:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D036B80F4B;
        Tue, 13 Sep 2022 15:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED12C433D6;
        Tue, 13 Sep 2022 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081490;
        bh=oidwpiM6VeKYhxSJMhyuPrJ9auyt56OT608jbptONVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJLvppkh/+b9U0QnmBapkwzHpHj/O/V1ZrmCVttsrO3r/o+EaUXMgWk4AQho+iW65
         1dwzM1UMFoE73uEGplcWbA/YUHAH9bEHpx79ZYQJEl7Bb5O4KXRFZGApFS4PF01Mqp
         emhhIQQkGKznP8a7o5JHD1J10FeQZ6IbYmtMqJ28UzNNwm0ZgXHKlJduQs+aa2U33e
         seJ0BBVuOjlcAsMVpiHe+b8wFdsdbrdFVpK+Mxo11Mynzlc8GlKnXvUd3k2aZsiBS6
         XoDVNODrLoHlPS9+YjGBNPRft03Pp+PRjhEIpRqCRTqsCNOfGBs4WzRRZ8gR59EVi9
         Il6/O13vMF0Mg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     quic_srivasam@quicinc.com, judyhsiao@google.com,
        cychiang@google.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        swboyd@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Fix Dmic no sound on villager-r1
Date:   Tue, 13 Sep 2022 10:04:42 -0500
Message-Id: <166308148206.625876.8801069802083923195.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826065621.2255795-1-judyhsiao@chromium.org>
References: <20220826065621.2255795-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 06:56:21 +0000, Judy Hsiao wrote:
> Fix the DMIC no sound issue of villager-r1 by using "PP1800_L2C" as the
> DMIC power source to match the hardware schematic.
> 
> This patch:
>    1. set vdd-micb-supply to PP1800_L2C as the MIC Bias voltage regulator.
>    2. In audio-routing, set VA DMIC01~VA DMIC03 to use the vdd-micb-supply
>       setting.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Fix Dmic no sound on villager-r1
      commit: 61a301ca83736afeeeb307b931c59f107067da3c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
