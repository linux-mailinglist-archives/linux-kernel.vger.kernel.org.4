Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E968FEB8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBIE1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBIE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:27:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F87DBFB;
        Wed,  8 Feb 2023 20:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7068961882;
        Thu,  9 Feb 2023 04:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6D7C433EF;
        Thu,  9 Feb 2023 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916476;
        bh=yjDmqbE2RLz6ygR+nXeIUmWjI3trDsUJGU0PH5pMrcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKRftciidwm6SP9Y1n/k+O/IPDbVK0fkEinA6i4dbiHIgMmfDvy2ASxxRyBQGFCb1
         ZLjIE9o/5Uv8MpADGU8L7wROaCQE4Bv0azoeQSxCutTpoInuEBV3C6W3oDHSeoGkSP
         yoKn/tJHchrmKQJBu7zmBg0F4vbNjQYclwyXzvUtE473aVBiNdzp5hpHibpHHfxw9F
         4gT+rak9cRfQRbl6ttOfn8UQAPhCbBYi69S3gulgkCU6uhvvBGXacYbDj2tsoaHPio
         hpjUtXqXy4VEOH6GArvkIop5+4czfeAEoevrBPOFX1MMj8fk22IO3Tp+XI+GQiMqHP
         n0VApjBzBVWZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Fix the aoss_qmp node name
Date:   Wed,  8 Feb 2023 20:22:34 -0800
Message-Id: <167591660368.1230100.18128145744883212125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127131441.1157679-1-abel.vesa@linaro.org>
References: <20230127131441.1157679-1-abel.vesa@linaro.org>
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

On Fri, 27 Jan 2023 15:14:41 +0200, Abel Vesa wrote:
> The proper name for it is power-management. Currently, with the node
> name being power-controller, the bindings check fails due to the
> property #power-domain-cells missing.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: Fix the aoss_qmp node name
      commit: 3a63e478b3c01b7c0eddba1121200b089bf1df12

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
