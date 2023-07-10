Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89174CBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGJFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjGJFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7FE5C;
        Sun,  9 Jul 2023 22:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864D060E73;
        Mon, 10 Jul 2023 05:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36844C433C8;
        Mon, 10 Jul 2023 05:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965475;
        bh=TWRzV+mGs6YFi2TtnVBTR2XSEgmw2zF5J3Z2qfNcMFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+vNuNMZ6Eq2VjPHYytZpex+M5CtvmFQ7T4wKgaFfjiZtDCDCcJUPrXSsqzttkeU1
         zWn+k77xgZ1prKq4EAufHshAUXHNlwowjwN7eod0TuezCmOFUpBPD1tYYqZ5+GxfJt
         zpUPhDGrjYEtCnDRXspknWwkVLHvqv4twb7rMsjMEWmpknyrDsqJWsA3e62aDV4H4t
         Vk8mPFng261PljiOg5vJvDGyCKasm7v5qRO1VAVdrnSgyXDFwEly4U1apODpCTB/6Y
         hyNtYvZDb/3yN+7glv8LlgtAEs8VUE5IYRu25vvdygj74bmobEPiKgxwJB0CDEtrR1
         RPcDlOrO18tGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Provide XO to RPMCC
Date:   Sun,  9 Jul 2023 22:07:15 -0700
Message-ID: <168896565983.1376307.10081166281011300716.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627-topic-98_rpmcc-v1-1-4024e43ad0fc@linaro.org>
References: <20230627-topic-98_rpmcc-v1-1-4024e43ad0fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 19:28:52 +0200, Konrad Dybcio wrote:
> The RPMCC node should be fed a reference to the XO fixed clock.
> Do so.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: Provide XO to RPMCC
      commit: ddf66e4b16744b96db4bd1ddee9d19b5a834f94f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
