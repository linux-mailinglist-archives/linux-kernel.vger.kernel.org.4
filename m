Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5558E74CBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGJFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGJFFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D710D7;
        Sun,  9 Jul 2023 22:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 862E860DF0;
        Mon, 10 Jul 2023 05:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC72C433D9;
        Mon, 10 Jul 2023 05:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965481;
        bh=WoxV+msGKUetnqK+qzafHrdG9aIPb2hk5RZbFvPdBrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPqTOFMRES4+UEH+7T69kArFwfa6wJtiiIMGPRtgLTwaD+nqaJerXR9qZ4GOFozfx
         exr4gYwS71Xr2ejpSQEK0IFyYsCYHY5t/qILM0KTekDVO7geyXYjfPWJDY01k+3Ok7
         omfVhXxAoTTCC3xX/KB7BTk1XVftUga/urSGL0jc3cVAbApuOd5XSPAhyYIfCdUzl/
         EgwQobYkDX7+9jtfUrmQ9bBLEMeMzNzshy+WDP59xb8BFeLoBNWmacxMuJu7wkWM1H
         /t6VgOlC6Wx7zz1CzPmxsVohWyChY/fUo02D1xyBBdeGMeIaohw/6RnDYNHcUc7576
         QGDWL//U/bPKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] soc: qcom: icc-bwmon: Set default thresholds dynamically
Date:   Sun,  9 Jul 2023 22:07:21 -0700
Message-ID: <168896565950.1376307.16697170438953063993.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org>
References: <20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org>
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


On Wed, 14 Jun 2023 15:39:59 +0200, Konrad Dybcio wrote:
> Currently we use predefined initial threshold values. This works, but
> does not really scale well with more and more SoCs gaining bwmon support,
> as the necessary kickoff values may differ between platforms due to memory
> type and/or controller setup.
> All of the data we need for that is already provided in the device tree,
> anyway.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: Set default thresholds dynamically
      commit: 0276f69f13e23b828a149d765d5712e214182ee7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
