Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBC68FEA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBIEZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBIEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:25:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11A11EA8;
        Wed,  8 Feb 2023 20:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7D6618A2;
        Thu,  9 Feb 2023 04:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487B7C433EF;
        Thu,  9 Feb 2023 04:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916516;
        bh=mz1Vku2oOsZLgEUaFSb/PCLdh32eln2k7ZFz6oJsz7Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fgo6+T0zbhrUepxKsPG06pw31X4+zo5urOYGW7CZCGH/aJsk4Y14ejz4MjEFwVrc4
         P/eJBZS5znpHqKxA0WtGjvejHsqkRGi8AZ814/G6lT7IU3tvFviu/fcmIAm4iKBcuc
         qYCE8V8dlRlrsQQjNKynbefXROf60nX5eRJNlusXyHNiYttHniPveOTPeDcETuusjd
         a34NRP/xw4HDyGYvYuTPbaxDqUBe9cewu/kM9sDNASEAcglcBRITtx1j78CZjWi35R
         ST8U4myfJNCX86TdZ/NzctvAj47nzP5R8yna9wngLhNNMbo/7SrWF0AOPypvDA5OT5
         uLV39n6mV6wDg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-mtp: correct vdd-l5-l16-supply
Date:   Wed,  8 Feb 2023 20:23:12 -0800
Message-Id: <167591660368.1230100.10521172451668003499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
References: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 13:18:43 +0100, Krzysztof Kozlowski wrote:
> Fix typo in vdd-l5-l16 supply of qcom,pm8550-rpmh-regulators.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550-mtp: correct vdd-l5-l16-supply
      commit: c5658e52ba014cf4ab14a113c530d447a3c2c1d0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
