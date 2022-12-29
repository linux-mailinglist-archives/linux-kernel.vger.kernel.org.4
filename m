Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55903658FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiL2RYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiL2RXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97EB15723;
        Thu, 29 Dec 2022 09:23:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 94081CE16B8;
        Thu, 29 Dec 2022 17:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07376C433EF;
        Thu, 29 Dec 2022 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334627;
        bh=82/A8lS/C3Z4zYTGQHkGXPLPsBVBa4QeexI8Gxpp29k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGXwa/k5lZaZFRBqVBXBHg2r0sCyEPDg++foehn3bWMLl9jxyuE544a91wAYPcww5
         vR71Gpc/+GxPpMkm+nW1duYVMikF0KJYekeLiRrWvvblyybkapiu1cZSh2NpZb1quL
         riiDEc26dw+DVTgGcoZ7NgMvsLVC1dno701Anh6GPNsrzsZKb9iHgIJeCgYNrdoKUW
         DpAozy+2xGjZx5+lcJejl5AXjxOqRhsE2vz+HxQg1Z5mI267EwLWEBVZ4U4Gftk1ap
         YdZubXGbjSz/6SvBhki4l9HQPssglAWF5hFjVWs6Vqrkui5bXA2+LkFPrNV13MsvXx
         bsL3bJDw9uS6w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Date:   Thu, 29 Dec 2022 11:23:26 -0600
Message-Id: <167233461728.1099840.11811611017721603406.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221229102712.983306-1-konrad.dybcio@linaro.org>
References: <20221229102712.983306-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 11:27:12 +0100, Konrad Dybcio wrote:
> With enough pins set properly, the hardware buttons now also work
> like a charm.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
      commit: dcc7cd5c46ca5e7bb8e4910ed8259597439c7246

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
