Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465D644B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLFSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLFST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640909FCB;
        Tue,  6 Dec 2022 10:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F8A6B81B2B;
        Tue,  6 Dec 2022 18:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F96C43158;
        Tue,  6 Dec 2022 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350795;
        bh=vz4R5HfdeLNtfH3g7bEOtrGumvaaG+44xj1/TQB8uy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rp5S7RlkyH3j2Vuq8MDypyrZPYTcBzm8zajehFI3PtYv3DLbSUGxN1HtUVjxtcGRf
         1vFIOgdEjsf0LP/UZj3l5zgC06+XOYWfjC/9a3rH8swrFGM+ygG1bz5xEduu9pd0oH
         3SnQ+2j5V/7BIcd0qhySsWnBWCbvkB3ftgRUmg/eifTjHvth9iG+3EM5zG8w24rJdZ
         ER8qnvXpBDqyIFKvwOffHQ9Vnu+TLIWBqLEFStAbkoJYgq91Hl33S1m1BEI1xmZV/5
         5IMj/x6qtFtzoCJsu5bm7FC39ksT+jEmkSj/wBRHLqsDMko7rZ6KEkjuJmhzpHJ9No
         Q8vTItytG3qAA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     vkoul@kernel.org, johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org,
        linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] phy: qcom-qmp-usb: drop sc8280xp reference-clock source
Date:   Tue,  6 Dec 2022 12:18:59 -0600
Message-Id: <167035076327.3155086.14325619807509249586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111093857.11360-1-johan+linaro@kernel.org>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
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

On Fri, 11 Nov 2022 10:38:54 +0100, Johan Hovold wrote:
> The source clock for the reference clock is not used by the PHY directly
> and should not have been included in the devicetree binding.
> 
> As the new SC8280XP binding has been merged for 6.2, we should get this
> fixed as soon as possible.
> 
> Johan
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc8280xp: drop reference-clock source
      commit: 9eb18ed70bd0f78099cb64f691586dbd17923805

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
