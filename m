Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F916AD625
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCGERa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCGERM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E258C17;
        Mon,  6 Mar 2023 20:17:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A86EB80BA0;
        Tue,  7 Mar 2023 04:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF4DC433AA;
        Tue,  7 Mar 2023 04:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162628;
        bh=nTXBdHMvCQ9Is/WqC3E5j8y4/TTXEJbrZ84W30pmuUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUWoKFMyhnGP/w80V03/9PjCCahpE7rAepLlbcUVvYy4iXrArf/bEpN7OSOL1qOTY
         HOmdLq7kOAg7eWbo0VmIKEdke6OiIU7rCMRPLiOr4CbGmha6h5WPcClbCMEF/ufNtY
         v7aKVxqkJxIeEZE31ENMyLUBwfJTSvxNyWka1at91P13MF/O2TS9EyXb/ani1Nn2UX
         5hwTsEv+lro0o28A3LmVCNKwnVVMyP+nEr8/3924nQfV+9toiE7q8IgJjAp8RNKxBX
         a9GqZFXK4ZHZll0BjDB3bOH6k0/o11l9DoPPqWeyqususqH08SKrKib57LFWwgcZiK
         dUayeJSh8lDaQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path
Date:   Mon,  6 Mar 2023 20:20:32 -0800
Message-Id: <167816282864.1458033.2117440381677662004.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221123633.25145-1-lujianhua000@gmail.com>
References: <20230221123633.25145-1-lujianhua000@gmail.com>
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

On Tue, 21 Feb 2023 20:36:33 +0800, Jianhua Lu wrote:
> Missing vendor name for venus firmware path. Add it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path
      commit: 052750a4444577e6067bdf73dd5ff92876f59ef6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
