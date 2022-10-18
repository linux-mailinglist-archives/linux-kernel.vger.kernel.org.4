Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1F602262
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiJRDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiJRDSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253A937A7;
        Mon, 17 Oct 2022 20:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5ED61407;
        Tue, 18 Oct 2022 03:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A69C43470;
        Tue, 18 Oct 2022 03:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062877;
        bh=joEAajdFBUS+uI5I7QGs4b7iH6QTCl9/sEDNk0a3OKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9jffexcY3p3sKihLezoph3yWTkKn/p/EuZXw06Z38KB/vcmXNTY/uLk8YE9TLGjr
         85hJKL5gQpYW8EvTZGj2j+JvPLVwZueojXycjA3whWVVmLa4RBj5Uq0zmoacBanouY
         6Awz4WDKkw+aqsBkUt00PtzPoSJeftkNdwqSzp+Qvtpyr8I9JJlXzyyFZ0QoAwBfe7
         K110Sztdmr1E/6ZKauq6CAceDKbNF9ny1/bNQKdoyaVBvd+VKFbBWY6zG9GvhKjqg3
         12zByV/9Uko3WCDUdAUjv5yDag5xJGPNeWSYzp06gDxyWR/e93JdzPkpv/J3D1HYge
         YU3fpq0TDWymA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh@kernel.org, quic_c_skakit@quicinc.com
Cc:     quic_tdas@quicinc.com, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add the reset reg for lpass audiocc on SC7280
Date:   Mon, 17 Oct 2022 22:14:28 -0500
Message-Id: <166606235856.3553294.15553489586953661871.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1663674495-25748-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1663674495-25748-1-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, 20 Sep 2022 17:18:15 +0530, Satya Priya wrote:
> Add the reset register offset for clock gating.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add the reset reg for lpass audiocc on SC7280
      commit: cb1d0aaa674e99957b85af570cb2730145af01df

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
