Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0934571048C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjEYEy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjEYEwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E010F7;
        Wed, 24 May 2023 21:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CDC64203;
        Thu, 25 May 2023 04:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE40C433D2;
        Thu, 25 May 2023 04:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990290;
        bh=PGhwQjdKJJhjNyAgBT0CpftMktWiARW9dVsE62LEbs8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j6Uc+SRGASR1X5FV9jfP0L650hHJVR1+3VlWagaR0BG0OdLgLdGq7h9yGhWaAIHi4
         6QFsnWaCjsfiOmhK9wkjOKjpKLWrpTDdsGQYKathl67MyZzap9yBdMSetwnsmH2HdY
         FqpZddoLzcUqeXuMs7+n4/vAy3d/Yl+3nvEFMCXUdJqGewYmoFy1ItJ1NwZsVcOiWf
         WsaaQlU2CE2Ur0Xcuf3dD2b+Ii3F23s7jgNgbCIINNcwMYaQyThnqR4rp51hcmy2ZK
         Mz4Hv3QQ1YCjTFgW3C8A3dXlF+C4HGKGTMajuf0eqLtLM09z199Z2vRes24bKpLJif
         sryxzEn6k/fXQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: use uint16 for Soundwire interval
Date:   Wed, 24 May 2023 21:54:09 -0700
Message-Id: <168499048184.3998961.2497779108766333625.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418095734.669858-1-krzysztof.kozlowski@linaro.org>
References: <20230418095734.669858-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 11:57:34 +0200, Krzysztof Kozlowski wrote:
> The Soundwire bindings changed during review, after the SM8550 DTS
> Soundwire nodes were merged.  Switch to uint16 for Soundwire
> qcom,ports-sinterval property, to match with current bindings.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: use uint16 for Soundwire interval
      commit: 4c8bb2d567588ccbfbf374c079f291a1402c4454

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
