Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6D6C851D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCXSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCXSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDD7DB2;
        Fri, 24 Mar 2023 11:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08268B825BC;
        Fri, 24 Mar 2023 18:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891BDC433D2;
        Fri, 24 Mar 2023 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682692;
        bh=Ej48M9ebls1K+wSIOxZxq4m6TqD3wHLtMGX0qjHoWrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddlTt0I2BOcRqGKH1iIYeIo/m8otzIVM8Nt/b+TjlYhMbZSNAcl+QEv1y9HDoCWCm
         5WPGpb5pcO8GZ+3FwJ2UV9AwdFoQVPYNq2Udd2Knd7CpPKP29fDVeUaykBDlI1dGDs
         OSkJ6BehLImkO1EempzZwjKrsrcw7SBkziessgIhCruBIEldmynmkUoC69Nvw/x0Qs
         aAQvEuDCRJbNbxlM0IH4p5LHZ1VFBJNOclz5CFi5YWI0ExvW4DHoxSQLzoFNUP0SNV
         KANnn8hatcpkQw2hQKht0tz8+FNDeI6bXRC7/OAyBFvjt/NDzoqSo+lfmUD7x282ny
         FQpGVjUHJ8j2A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/4] arm64: qcom: sm8450: bindings check cleanup
Date:   Fri, 24 Mar 2023 11:34:32 -0700
Message-Id: <167968287205.2233401.16927276389264304370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
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

On Fri, 24 Mar 2023 10:28:45 +0100, Neil Armstrong wrote:
> A few fixes to pass the DT bindings check successfully
> for sm8450 qrd & hdk DTs.
> 
> The following are still needed to pass all the checks:
> - https://lore.kernel.org/r/20230308082424.140224-3-manivannan.sadhasivam@linaro.org
> - https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v5-5-552f3b721f9e@linaro.org
> - https://lore.kernel.org/all/20230308075648.134119-1-manivannan.sadhasivam@linaro.org/
> - https://lore.kernel.org/r/20230306112129.3687744-1-dmitry.baryshkov@linaro.org
> - https://lore.kernel.org/all/20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com/
> - https://lore.kernel.org/all/20221118071849.25506-2-srinivas.kandagatla@linaro.org/
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sm8450: remove invalid power-domain-names in pcie nodes
      commit: c98a56395e7854f7975dd8539d0563e0ac7d060e
[4/4] arm64: dts: qcom: sm8450: fix pcie1 gpios properties name
      commit: e57430d2483506f046e39bf8c61159dde88aede2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
