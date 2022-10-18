Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974B3602270
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJRDUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiJRDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:19:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D4B7EC;
        Mon, 17 Oct 2022 20:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F6CB81C67;
        Tue, 18 Oct 2022 03:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867A6C43470;
        Tue, 18 Oct 2022 03:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062881;
        bh=OGvmkL8Ax2VasWA91y6YkYOpsGQ6wLZRdg5ApzUi+TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nn/Rzgjiky8WpCgHKJLlY95jCqtoChTeB0vPsL1XGDXTVOhcP6eqxvrGQB/MALk1e
         7GAS7y5OAS4EP094PxEUHf986O7w2Owulw3MytDsmy/0uV8hkPIEnFLPs/ZIw6K8Q1
         BzCujZ7cDCq3SJrSdqdzUZh0Aal7D8qvp9bWsEp/n9y+jvLiJs8+jO9iK0GFssUrbD
         ksqVzcadMX8/Q1dcRcw/cVPLyg6X0QeVYww1HRd+n3UDscofW+982T6anbzMOGCl4y
         e21ANL3UKqaAT08IXPeA3832tfDTEF5Xnqr/PW0xiDgtB2GhY+bNbDU5zz4de7xrxJ
         dhnB44pPckAEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, quic_kriskura@quicinc.com,
        robh+dt@kernel.org, agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280
Date:   Mon, 17 Oct 2022 22:14:31 -0500
Message-Id: <166606235841.3553294.16113585888708911297.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1664462290-29869-1-git-send-email-quic_kriskura@quicinc.com>
References: <1664462290-29869-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 20:08:10 +0530, Krishna Kurapati wrote:
> Add SNPS HS Phy tuning parameters for herobrine variant of
> SC7280 devices.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280
      commit: 9c2eb59712cc21a183772e9837dec2305b14a423

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
