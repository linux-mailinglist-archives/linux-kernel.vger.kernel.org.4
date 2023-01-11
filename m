Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE45666408
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjAKTtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAKTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490A65E0;
        Wed, 11 Jan 2023 11:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE6F61E10;
        Wed, 11 Jan 2023 19:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A679C433F0;
        Wed, 11 Jan 2023 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466552;
        bh=f+bgzjSqnyWeNsBi/gRTTNPMgKl22Q+P38m5sBH4URU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW9bIf53b5fv8vlJrVjnhYjK0dksnsKo+6cW+Ru8GgTbW8Prwwh/RTqeia0rfADC8
         viWwLKm5qZf5TjGETa0JLOCFmQvxrYzCEa9XPSE3o1pWQezItOjojchSm7G7nP31Rd
         IGQBxbVjdtOFJbDIaXMMXSK7HH4pGP6TTWw9tDVH8V29kiG/hDd6/fr1xtiDALi7Xq
         IL3qq+JeUdtn+KAqF8/spYAmyjt5CMZ8vlwPYON/tXB6uevDEysjNY1QBKLWhnaBbb
         nXoMJqKeFoe3+q7qymiCSk5ZEsYO+o4PTOiP8hxVeFrJzTTYEqSMEc4fJ0CMgb0lbL
         Um49Fo+Gg6FwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org, agross@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, echanude@redhat.com,
        devicetree@vger.kernel.org, ahalaney@redhat.com,
        konrad.dybcio@linaro.org, bmasney@redhat.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sa8540p-pmics: rename pmic labels
Date:   Wed, 11 Jan 2023 13:49:02 -0600
Message-Id: <167346654437.2315924.14963881995443596700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230111160335.7175-1-johan+linaro@kernel.org>
References: <20230111160335.7175-1-johan+linaro@kernel.org>
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

On Wed, 11 Jan 2023 17:03:33 +0100, Johan Hovold wrote:
> These patches add a missing include to the new sa8540p-pmics dtsi and
> rename the PMIC labels so that they reflect the actual name of the
> PMICs.
> 
> Johan
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sa8540p-pmics: add missing interrupt include
      commit: 32c028fccb120603368c4f2aaac44376b4a1a21e
[2/2] arm64: dts: qcom: sa8540p-pmics: rename pmic labels
      commit: aab961de74f10968ea67f42c0ca7c5cd866df3ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
