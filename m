Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60072EF29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjFMW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFMW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6210CC;
        Tue, 13 Jun 2023 15:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05EB63B97;
        Tue, 13 Jun 2023 22:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6108EC433C0;
        Tue, 13 Jun 2023 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695230;
        bh=brGnLs+934H/8ne5PgFLPYRlSLef8jdP9/Ha5mJTNWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LP7gRQ8F3048l17hzFYP7yo65uFsKMKyVS+w4c2ZPfDmt55M5Di/DOAB7TMXY3q3Q
         FMs4mTCCcgIKAUUsTsZ3BrtKE+4bpIMrsOR7o1yRPojKTjgzZpOwRuZX8WvhYQr00B
         dB/CIaB+VIQTpSaZvYCrtYOEFnzX5zV6+EHtoYSQXzS8us0PisOwPQw2RjWA018Byc
         0yzYiz/eLtYQLEUy6bWHiEB6r23QWBDbDl2huQHceGL6C5MbNc0T0qM6SuCCxdme/P
         St4o82SHCxfBbg0Ay1y9vsypAp3U3cr/pAEFx3XouNTucCbQaGCdlUm3prBgcbtxW0
         KeH65xtEsmc5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     bmasney@redhat.com, echanude@redhat.com, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        richardcochran@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: Specify ethernet phy OUI
Date:   Tue, 13 Jun 2023 15:30:09 -0700
Message-Id: <168669542892.1315701.6882227491843598759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608201513.882950-1-ahalaney@redhat.com>
References: <20230608201513.882950-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 15:15:13 -0500, Andrew Halaney wrote:
> With wider usage on more boards, there have been reports of the
> following:
> 
>     [  315.016174] qcom-ethqos 20000.ethernet eth0: no phy at addr -1
>     [  315.016179] qcom-ethqos 20000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> 
> which has been fairly random and isolated to specific boards.
> Early reports were written off as a hardware issue, but it has been
> prevalent enough on boards that theory seems unlikely.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sa8540p-ride: Specify ethernet phy OUI
      commit: f04325e4d4d66e63fc4e474ff54835a28b3ff29e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
