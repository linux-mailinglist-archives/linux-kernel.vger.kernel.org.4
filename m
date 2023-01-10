Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36DD664B82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjAJSpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjAJSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:45:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808196115;
        Tue, 10 Jan 2023 10:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A842BB81910;
        Tue, 10 Jan 2023 18:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F6C43392;
        Tue, 10 Jan 2023 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376009;
        bh=opAs2nnw3kFxRUm6VtuaK25Z5MzUf0Em/Ibb0JfZJPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3+H8k2g8XhivjDcqWOfChx5Sh4Q1euaJGvAuZo2y9TZsFusrXB2eXAWzu3tPtK2c
         zILNIVuKQLwDaMZCEi0Gop7H43ss0iGnayzzLQMjxz3M2KT2LrKDjNpPeGA/HbVyBY
         AhoMRaboQn+4Iu+/YZJokx04ryg4egwgViRbgY/cabq8H9sids3mCRlydS0i1zztBM
         tXLW6zGNtGz4nbbQS9erwPE3iupX118G8tevv+1KPY5i+lJ0O2+jT0+Zz9BtkWU1Q9
         aRstEmg7QOTTHwns2nlGcYmnzKQ4UzKl/i4gvU72PqqPKzTie7NGAX5zi3e62ek5l6
         7rL7N57rNVB/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, agross@kernel.org,
        neil.armstrong@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] clk: qcom: Add DISPCC driver for SM8550
Date:   Tue, 10 Jan 2023 12:40:05 -0600
Message-Id: <167337600119.2164548.8599951480799708349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v3-0-8a03d348c572@linaro.org>
References: <20230103-topic-sm8550-upstream-dispcc-v3-0-8a03d348c572@linaro.org>
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

On Mon, 09 Jan 2023 16:47:21 +0100, Neil Armstrong wrote:
> Add the Display Clock Controller controller based on
> downstream and upstream SM8450 driver.
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: document SM8550 DISPCC clock controller
      commit: 0960ec915a7531e3a760cf97d523ce2fa90b1412
[2/3] clk: qcom: clk-alpha-pll: define alias of LUCID OLE reset ops to EVO reset ops
      commit: 494162c739775426c8a9ab9cd2056386e9bf6b4c
[3/3] clk: qcom: add SM8550 DISPCC driver
      commit: 90114ca114760315507b218ee1a3b23609d9d2b8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
