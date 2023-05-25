Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A198A71048D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjEYEya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbjEYEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9FF1A1;
        Wed, 24 May 2023 21:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B4776429E;
        Thu, 25 May 2023 04:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D648C4339B;
        Thu, 25 May 2023 04:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990291;
        bh=YC371qVlrksCDD+aSBuocFDBr6NM9zqoMCy2lRmJK2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKs7jREWwZtLScVfHlGkhXvzIk10BAbq4e0U6RGNDfw3pgiujl9+G6ivS81qK6s4J
         G2tKisnK3pnhC36f4xeSHC00M0iclRpMNh1na18t8D9H0WlmsKeWDJSF1CEoOGIR7r
         JHFteRCRAH+uah0l6TSX6yYg+FubV0CvJWVpQPk0MInb63PNUA7e2V56mc0qoX016h
         +CNv7MmEpBB1VWEMBqwFyzUkree6dHyJFFlEDsX9n8QtNmGMxNDQ0PxOdDlwAfws+o
         vXPXr795p1haPgtMcCo+996zbfAlAkX1pykUqag6rSfJ/gOnfsCdUSSg1OXrQc/BRE
         3iUNyXE4f35hg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: fix broken NAND controller properties override
Date:   Wed, 24 May 2023 21:54:10 -0700
Message-Id: <168499048184.3998961.18184377820386635736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420072811.36947-1-krzysztof.kozlowski@linaro.org>
References: <20230420072811.36947-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 20 Apr 2023 09:28:11 +0200, Krzysztof Kozlowski wrote:
> After renaming NAND controller node name from "qpic-nand" to
> "nand-controller", the board DTS/DTSI also have to be updated:
> 
>   Warning (unit_address_vs_reg): /soc/qpic-nand@79b0000: node has a unit name, but no reg or ranges property
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: ipq4019: fix broken NAND controller properties override
      commit: fd1db0249b0971642770aa4c987771b7c592557f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
