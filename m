Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFF665392
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjAKFUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjAKFSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043FF020;
        Tue, 10 Jan 2023 21:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B90EEB819EE;
        Wed, 11 Jan 2023 05:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5D9C433D2;
        Wed, 11 Jan 2023 05:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413803;
        bh=GKo5c58I12f/DuVwigEWWMXj2xUdU+Nl4xc7+iCa8oc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I/oDxP3C4vapwDPE0Td4F+ry9f6ftQwVLPGwXzhW35u3jk1HTYvlmtztKtCTOUAUb
         RT4UlWgTwaFUkanQKyDtSLglyUeeDkFT3jItgs5VfjNMNN/7uckWtkdHMq1k6eCzJM
         ewuDEJxsaQFM9EB+MHu0387KbsKiP06uK2BENvk9GaO9rzr20CyXvvS78WatZDHEQX
         sngwfHhrW04bfLDoSpnE6KkMY+oPYphhZhmUDbf/lR99V0OUJwZ5Fqp9/0K1DXOzaE
         TQseo464VzbCu3p1aJdc0pbokzGg2myL/DQuPwxbcVf3moLaeBC1jwkFBBJtU2sEMU
         HtQx/rdGfEQuQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: replace underscores in node names
Date:   Tue, 10 Jan 2023 23:09:28 -0600
Message-Id: <167341377728.2246479.11950593798773642688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221214110448.86268-1-krzysztof.kozlowski@linaro.org>
References: <20221214110448.86268-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 14 Dec 2022 12:04:48 +0100, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  In few places adjust the name to
> match other nodes (e.g. xxx-regulator).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: replace underscores in node names
      commit: 1364acc3f6260c51c6dd201c9b8e2fc58a6ca80d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
