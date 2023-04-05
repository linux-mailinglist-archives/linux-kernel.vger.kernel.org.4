Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203D6D730E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjDEEG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbjDEEGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E44C31;
        Tue,  4 Apr 2023 21:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC3FE63B03;
        Wed,  5 Apr 2023 04:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6803EC433A1;
        Wed,  5 Apr 2023 04:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667586;
        bh=YbAEqcbrw0PcrgPzQcDRvLvymbTdjscXETPc/+FzPxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJP3U70ShgACWlgmeTVfI7LLEf12ibrci/W1Gw6u4mEFNd8XD6sr7Dx5ajLQ2IlCJ
         wzwCagW61gWH6Qkcrpn34Ce+ohKydOWpijbkDjzlLksIWBeuo5qBHy9056jCRzMrIG
         x8nVplfAsZnPUg9iNS1vBVlcmhWUKBL6AR48rAtZYq2IO2/04VPprX6XwEulMChLA1
         irp0LzJD4qB933OAp0PotLxsl2B37zZfkn7FJM0JQr4d4faT1Eda2khvD68ZvmHotd
         GqzyCTQlr3ASi/efCM7KlnbhkXa2ad2vkZp8pVD64J7UtaShwPqr8c4vXwDwA7HPyf
         8R8BHCdB456Jw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Use actual GPIO names on MSM8998 Yoshino
Date:   Tue,  4 Apr 2023 21:08:57 -0700
Message-Id: <168066774413.443656.12133849636165959049.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
References: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 14:28:33 +0100, Konrad Dybcio wrote:
> SONY gives us an in-depth look into the actual GPIO wiring-up. Add and
> use that information in our device trees!
> 
> v1 -> v2:
> - Split the introduction of gpio-line-names and node/label renaming
> 
> v1: https://lore.kernel.org/lkml/20230102190157.970053-1-konrad.dybcio@linaro.org/T/
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO names
      commit: 900007f26aa82e28ac4f494cd0121a75673d39ff
[2/2] arm64: dts: qcom: msm8998-yoshino: Use actual pin names for pin nodes
      commit: a9eaa4798473fd3cfe39210c64e403d6cbc31984

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
