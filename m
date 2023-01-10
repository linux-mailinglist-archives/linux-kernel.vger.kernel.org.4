Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF421664BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjAJSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbjAJSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39D55650;
        Tue, 10 Jan 2023 10:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88916B818EF;
        Tue, 10 Jan 2023 18:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85808C433D2;
        Tue, 10 Jan 2023 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376411;
        bh=hTOsPuQr3iieh+3n39jznnktBGUjr5/PePpj0wySIXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFPqX3w5GrfJY22xevdFdabJyMfu7Xnn0HD9bTH642oAe3/Wt/I9IsP8alXRZavve
         ZJ7p/a+sGd5vYBK0c+ymQMnNksEc1RGQYztfzj9RVZk7PeZ9l14orB9iRzZYHhigz+
         pg+gLUmcByEbI4W2f1d6INHfdjyxrnrStUSEHVirVHswim1RE67VFxQqka3eE+GBnG
         h7fGNPUAKQl/aJqK8I+emAKcpZItHWRYvHM2og1Kmxzr/sszegaVJGHBzhG/7NvtNF
         GTy8avSfCzJAs1N/bywUKfgQGgyGinUP5GkeP8M8Wtx0FsguetWotzLmJxN8/dqJki
         r/HcG7aPEm9+Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add I2C Master Hub nodes
Date:   Tue, 10 Jan 2023 12:46:48 -0600
Message-Id: <167337640562.2173176.7741779152484906124.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115-topic-sm8550-upstream-dts-gpi-qup-v1-0-86a60cf3e57d@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-gpi-qup-v1-0-86a60cf3e57d@linaro.org>
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

On Wed, 16 Nov 2022 11:45:50 +0100, Neil Armstrong wrote:
> Add the I2C Master Hub wrapper and I2C serial engines nodes.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add I2C Master Hub nodes
      commit: 377972ac743f54506e675c695a287e1821a47e70

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
