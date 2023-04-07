Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC56DB744
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDGXhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDGXhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AA8C66B;
        Fri,  7 Apr 2023 16:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5C265569;
        Fri,  7 Apr 2023 23:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F83EC433D2;
        Fri,  7 Apr 2023 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680910639;
        bh=CnGXvD8rCX992q5WEVr+sstDQgDU+kc91sEVP9dsAa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5XlKoHcfVfMl9Z2fYOXGrfKzlYdaTSkjQR35SHNx3u0J3acfkOqy9iPA1qwvz1C5
         8f7YiWfK4O+/vzMOzFY879ZPUsDsrhUMb2pOvCT4rFSAgRNlRgkgY0eH7dq3AhksnX
         WvE0EX5mJvO17UJx+vHLvNNaSo04Io7JxBai5VulE0J6pIVqohCetGEUpxbo2ERUnX
         f0VH61MpWBv1WUZ5USHgiuSZvtTbUZPqPlVEdooojU5LGOLQamdY0zlGFaUrxA8Hwi
         T4jfPOaB5jkKpQ9w5UHZrXcHMYxWAGCgNFD4wvEk2eMgykVDtFsyFL+y/vZoU7sc6U
         v5f5JYrwJXunw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Tab P11 features
Date:   Fri,  7 Apr 2023 16:40:04 -0700
Message-Id: <168091080212.2759405.12118976491725806960.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
References: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
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

On Fri, 07 Apr 2023 21:54:40 +0200, Konrad Dybcio wrote:
> v1 -> v2:
> - Add ftrace-size and drop no-map under pstore [1/4]
> - Add qcom,ath10k-calibration-variant [4/4]
> - Pick up rbs
> 
> v1: https://lore.kernel.org/r/20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm6115-j606f: Add ramoops node
      commit: 8b0ac59c2da69aaf8e65c6bd648a06b755975302
[2/4] arm64: dts: qcom: sm6115: Add RMTFS
      commit: ecc61a207d0fad45ba991e0ce0273382b20bb226
[3/4] arm64: dts: qcom: sm6115p-j606f: Enable remoteprocs
      commit: 7584284537c2a82227ed2ea359b2c53f28e6abbf
[4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
      commit: 137e5c267232c89b2284ea44229545d4820bcb26

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
