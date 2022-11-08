Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24E6205CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiKHB14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKHB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E028733;
        Mon,  7 Nov 2022 17:27:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77090B81711;
        Tue,  8 Nov 2022 01:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527A5C433D6;
        Tue,  8 Nov 2022 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870865;
        bh=YVL/Z4RHzbZLpJLzw4S+SsdSECoQ90X3z5A4ZYCso3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N36T1pBkQqEnmWp0xa+IsgsKycL4H8OGWCgTXKGiPQIcIOGUlgXMjhTsbx2MhQckF
         cvWh2acMkhcqXo5ex3qlBSD5mos1zZuB2SR1PgI2J3APx8PrDmGhsjKSxPP2Nzhnpf
         hnhYnaS9hH3MucvtIVML33rVnUkLc6wMhVjpRkbA1sCTN4b94O52hxR7OyglCy6iU/
         0MC2aJN4GFSBIB4sodrsT4XpFr9Mk6YWiNn3LpZV2/sl/waCpFqhGZ6wCH8vlF93GP
         NTXG6rVxpyLdyTNBnD7KsTkcaKvJdFhBdXLk5m982pd976Ap43WjX08Gj443OSXcyG
         M21MnRe7bwiTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dianders@chromium.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Villager doesn't have NVME
Date:   Mon,  7 Nov 2022 19:27:17 -0600
Message-Id: <166787084678.599230.3259461323160653012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221025164915.1.I38e2545eda2b3bd3fef6b41c98f451e32851ae70@changeid>
References: <20221025164915.1.I38e2545eda2b3bd3fef6b41c98f451e32851ae70@changeid>
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

On Tue, 25 Oct 2022 16:52:39 -0700, Douglas Anderson wrote:
> The sc7280-herobrine-villager derivative doesn't have NVME enabled so
> we shouldn't mark the PCIe nodes as "okay" since they're just for
> boards that have NVME.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Villager doesn't have NVME
      commit: bcfefc98c5781ee97f1b7a8063870830d9e42b30

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
