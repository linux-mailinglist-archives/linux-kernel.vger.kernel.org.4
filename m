Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD6644B45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLFSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLFSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE67B7F2;
        Tue,  6 Dec 2022 10:19:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C48ECB81AD7;
        Tue,  6 Dec 2022 18:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6BBC433D7;
        Tue,  6 Dec 2022 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350791;
        bh=NypZyXvmluKqB8oSwyhJlhKhn5A7RyhaC8StvY6/oOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X33MdJNWImOeIn69bgps0KvP9q/7xWvawCDrgnE6pHYkeiF/Y1BXJW9bjp418RPct
         7dFvV1Xw0UYamY5h7tIFUue71Gnw2YxTzzb7gXZyke2fuG5ruC/FiZQ/avFHUicITQ
         257gSGz8K+cETqfWSZsuzkrD7Y8SdCfz0rOrlKo3k/n71um/x4ewb3+Jb6jfDe/7xd
         DIA0f08cG/eiLlVJBoSC9bikOOyzkCdL8rd2ajyufVS6g5Bv52rKtCvl+CAs7kQm3F
         M7MU7xXd91muiitvdea5J+/D+4wWu+esiLlwOAAUzrP+GThaBuaYu9z9Ml1mEbPIHq
         QiqL5lX7jIYPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        quic_ppareek@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation
Date:   Tue,  6 Dec 2022 12:18:55 -0600
Message-Id: <167035076336.3155086.2959589608822706937.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116102054.4673-1-johan+linaro@kernel.org>
References: <20221116102054.4673-1-johan+linaro@kernel.org>
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

On Wed, 16 Nov 2022 11:20:52 +0100, Johan Hovold wrote:
> When reviewing a new devicetree for sa8540p-ride I noticed that the
> indentation for the 'regulator-allowed-modes' properties was off and
> realised that this had been copied from the recent patches adding the
> missing modes properties.
> 
> Let's clean up the binding example and current devicetree sources to
> avoid this pattern being reproduced further.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation
      commit: 25f08f02f47d0f83f39308359bad06719ad9a55c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
