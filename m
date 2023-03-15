Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44126BC136
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjCOXdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCOXct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D029DE1D;
        Wed, 15 Mar 2023 16:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0A12B81F9A;
        Wed, 15 Mar 2023 23:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE92C43445;
        Wed, 15 Mar 2023 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923148;
        bh=5sXlnF580LR2yb10v5fHCaFZO/SydoVhE46jgi/Nrwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sj896pUc556F0HbhHFyaA196d2ztrs1P5bWWtXPwlLfsrU6RHdcaWWWgb8/kozxKg
         aZNx6ytFM96Kgpg++Z5xjbHFaKuP8XlkC1vPXM+U31y68SicyNCtuSH8Ja9NWMw+0o
         ifkT5aUEt8pSEMLvXC0IOsBzVfa+rVMLtojSd0dTNTRcY0Ukwm8OZeRv4425DIPUNd
         pzeOA1C1BUKhaQ5owjIOZy05SeCuk/H4UiqbvsOzmXqwEW6nvcUY73jcN3aqiqH2Qq
         Pd7E/vM7IKszJDuDuKnkoiDq+wOVSwNo2G5HRRm/+CapVee58E07J0ncPFaaofMMep
         /7smWoUZeBkxQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add some PMICs
Date:   Wed, 15 Mar 2023 16:34:58 -0700
Message-Id: <167892332565.4030021.5856869187160249154.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230213215500.2131511-1-konrad.dybcio@linaro.org>
References: <20230213215500.2131511-1-konrad.dybcio@linaro.org>
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

On Mon, 13 Feb 2023 22:55:00 +0100, Konrad Dybcio wrote:
> Add some missing PMICs based on the _SUBTYPE defines in
> include/soc/qcom/qcom-spmi-pmic.h
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add some PMICs
      commit: 112d96fd29272726b2a4bc59d027f76fe1e78af3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
