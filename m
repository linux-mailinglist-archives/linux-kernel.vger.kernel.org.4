Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B23C665366
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjAKFTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjAKFSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321E13DD9;
        Tue, 10 Jan 2023 21:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D630561A32;
        Wed, 11 Jan 2023 05:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2EEC433F2;
        Wed, 11 Jan 2023 05:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413791;
        bh=nZRo1GOzAcIl6SE5xTrRrHd8fgcSr5LSqxOz3zp0ve0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUOdd4DcCYZW1EBnrlXN6w4gcjtI3sFsO2sWSQc9Z+2tuRHnN+njLeY2h7iG1PNNH
         gysetDwQTOdKG8R+7OiUNsYAdJ6w7xO8ltAxYAFbQ0c9PjcSJhHsL/Bh6DH+aBHiLP
         VFYzkzLOeGyCHPwF1nYAhPNlu6buIJfaJK4K0PR/++filnFNSUrQYO0ejjOGt9tLk7
         UFCF3B1r3qAE/ra21Bf8Wt2DY7gCyBbTFeXV1ozq+1qqk5Rj2tQqC2pW29LhYebNtw
         kgaEIX4E0NM7+OHM4QMR+OLt3bPvU2GECs+XkJUK3dyJrES7Z80pMyMOa+ZY92nAkm
         R5Nrc3VrvIXqg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, echanude@redhat.com, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ahalaney@redhat.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: enable sa8540p-ride rtc
Date:   Tue, 10 Jan 2023 23:09:16 -0600
Message-Id: <167341377730.2246479.15159085114851446298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221219191000.2570545-1-echanude@redhat.com>
References: <20221219191000.2570545-1-echanude@redhat.com>
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

On Mon, 19 Dec 2022 14:09:57 -0500, Eric Chanudet wrote:
> Enable sa8540p-ride rtc on pmic@0.
> 
> sa8540p base boards share the same pmics description, currently in
> pm8450a.dtsi. Rename the file to make this explicit and use it in both
> sa8540p-ride.dts and sa8295p-adp.dts.
> Add the missing offset where appropriate for the alarm register bank in
> other qcom,pm8941-rtc description.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: rename pm8450a dtsi to sa8540p-pmics
      commit: 2e1cec6e1b5b525ce1022da0ff6cd2b47532da9a
[2/4] arm64: dts: qcom: sa8450p-pmics: add rtc node
      commit: 650fed7806b7298a274a5f9f604d9ae3e0000687
[3/4] arm64: dts: qcom: sa8295p-adp: use sa8540p-pmics
      commit: e1deaa8437c4b6ce5a28e98e66d89de99378e72d
[4/4] arm64: dts: qcom: pm8941-rtc add alarm register
      commit: ceb01bb895716c18c3dc711af978c19e327444e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
