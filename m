Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB759665359
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjAKFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAKFSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34ED13DF5;
        Tue, 10 Jan 2023 21:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AFF5CE1AB1;
        Wed, 11 Jan 2023 05:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C438C433EF;
        Wed, 11 Jan 2023 05:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413792;
        bh=vEqIX7z+ZRFDEwt/H3ykHWiUdOoXNy0BNPHjFonq+/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHbSAwxV5uia3KmlClUB+g/LGP1HTw6AOpQMzTtjGyOhwyXbvpeFFkU0hSubgq9mz
         buQhqwp/3O/r04Q7ugwLcYWdYk8s9gKryWVj/25l++z5XbVvtggf14eorcGOghSIM5
         O4uAfH5F6xXIBSA6vaYSPwaSa8PNHbqRoUeKnU1uxvccziBHzvubHwpBlusNoliuOD
         tUfjPkfq/vXN6xHIbbn2i2BpPMTgvm/YmIK76X9gOUARiJkYCue/qFnwLzGHATbnhx
         Jlas4skH2OX5/VleWXn4b9PR9OS7VcYJjOKSCC/9Q/iPApD/qB7a2JSZ/Eqaa+UzU5
         yGpTXVassCCRA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ecs.taipeikernel@gmail.com, LKML <linux-kernel@vger.kernel.org>
Cc:     robh+dt@kernel.org, hunge@google.com, mka@google.com,
        gavin.lee@ecs.com.tw, konrad.dybcio@linaro.org,
        moragues@google.com, devicetree@vger.kernel.org, agross@kernel.org,
        abner.yen@ecs.com.tw, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom: Add zombie with NVMe
Date:   Tue, 10 Jan 2023 23:09:17 -0600
Message-Id: <167341377728.2246479.7604427003596664310.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
References: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
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

On Wed, 14 Dec 2022 11:47:48 +0800, Owen Yang wrote:
> Add entries in the device tree binding for sc7280-zombie with NVMe.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie with NVMe
      commit: f6df873315f921581e430f731c430d1d6d234234

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
