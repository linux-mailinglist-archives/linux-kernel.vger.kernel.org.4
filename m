Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27616C4E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjCVOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCVOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C58766D18;
        Wed, 22 Mar 2023 07:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C557EB81D11;
        Wed, 22 Mar 2023 14:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC3AC433A0;
        Wed, 22 Mar 2023 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496132;
        bh=jLSc5FD1EpTFBfRnXzkseAh4ytoAO858HZtAsz8lw6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZYx731+I6XY1xXOxzWLO9ikKjgqMEH6/NP2O17vGmAoLGm81ipqD5qLJfRFsAUP7
         m2XYvFvu6dO3zNrl/hIIr4Yqul+ji5ReMQ8yBJk4rced8AflMmxT35Sr1GDbt0a0Iw
         YbaUY+3vuUYBBgbdF9sSp2fVgT2tHEEyLoZblifN0GCmzBEpmOKp6/1bzB23o7y7ST
         LLcv9xNyYKWaM199LOk9K7ogYp69Lu8dUZ1F2yzqswQzPakUZ4LSrlixX3oIMjMyPz
         48ovY0Z0iiLivS/nmjxzQ0kPgYExEzfQUGWX1dXPicqln6+9v7hQskwmEd90WXwf6Z
         TkX+PHJm5K16w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        bhupesh.linux@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Move SDHC node(s)'s 'pinctrl' properties to dts
Date:   Wed, 22 Mar 2023 07:45:02 -0700
Message-Id: <167949631651.1081726.3499603994002947569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
References: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 13:10:01 +0530, Bhupesh Sharma wrote:
> Normally the 'pinctrl' properties of a SDHC controller and the
> chip detect pin settings are dependent on the type of the slots
> (for e.g uSD card slot), regulators and GPIO(s) available on the
> board(s).
> 
> So, move the same from the sm6115 dtsi file to the respective
> board file(s).
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Move SDHC node(s)'s 'pinctrl' properties to dts
      commit: 27ad7815cb70cbfdcbee4368f41033e83731479f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
