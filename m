Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62077104EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjEYE5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbjEYEzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73319AE;
        Wed, 24 May 2023 21:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4024D642D4;
        Thu, 25 May 2023 04:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05489C433EF;
        Thu, 25 May 2023 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990317;
        bh=rIPZFZpqIyb9U/9HI1HqKJ9j46kFAYPkBG128IeLSDs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QDJCRUnhJM6wGUtlpxLPMPwggVCAokWCGx/HAIO4JOVqvGtpTGjE3xQu+sYJg4sKj
         xqyO1Te4tCjPYkTanxui4GevUrkew8by9OfhjFwmQcsbwMxN8S1TJWE1KfHyk7qHrX
         vnhBg6KFdI5eSJyijKwenIIj5bCcWaJk5QE75N4OncONToZzESo1H1VGZn3RP5o6VB
         fsgaf/UtfULrgXtUMyAoA5jG8TxciUPMwXDC+AWEZroqNXCllnMU9s1aIBPaupjcna
         wZnBa1g3DBRCsTM3U+9F1U7+MZtZO5ohjXocDQJjf3NxcMQsHy1FUuZp+B31SMdLuy
         gJniHQadSPUnQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, konrad.dybcio@linaro.org, sboyd@kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: ipq5332: Use floor ops for SDCC clocks
Date:   Wed, 24 May 2023 21:54:35 -0700
Message-Id: <168499048178.3998961.12783025021801928480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508163145.9678-1-quic_kathirav@quicinc.com>
References: <20230508163145.9678-1-quic_kathirav@quicinc.com>
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

On Mon, 8 May 2023 22:01:45 +0530, Kathiravan T wrote:
> SDCC clocks must be rounded down to avoid overclocking the controller.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc: ipq5332: Use floor ops for SDCC clocks
      commit: a30e62bf6bf4d3230fa9164c7e174e32b9be7ba5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
