Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D7C68FEAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBIE0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBIE0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:26:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE84492;
        Wed,  8 Feb 2023 20:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A246183C;
        Thu,  9 Feb 2023 04:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED6BC4339C;
        Thu,  9 Feb 2023 04:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916534;
        bh=UeoYhZBmKp1BB7kZalyf0dAO1kBJgBZfKiubXJ0+xxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYLJsQVyeJZbsfsTf3lPUrSaSIxWG4oKAGQS8NmvTUJ/grtbnuhvSPKW9eWUx2Ljd
         4rzNcc+5BeRR8tCvozwm5+urVtM2ghqvnK08iq+pSP3axDMmkPasHwgMoejnzUFmD9
         6gw8KpDWPnnUcCu2gzxZz2gCi9ja/52IWrroEw9j6TZ9PdmZ3+We1y4YH9RsuxzoXX
         PYWnnYU8dqHXM5npTVwUXHO6AyjWbRetNePTqb3mjiCjGqnR5bij2+fThH378Q5wqc
         Jtpy6xHvQwIbiug9wT1NE2D+6aWjR9C1Pd59zREGjLIq+C3UIxG1WTtDB0xo1Si8iL
         fcqrlqbCURECg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_kathirav@quicinc.com, konrad.dybcio@linaro.org,
        agross@kernel.org, srinivas.kandagatla@linaro.org,
        devicetree@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Wed,  8 Feb 2023 20:23:28 -0800
Message-Id: <167591660366.1230100.16348288841996494337.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123101631.475712-1-robimarko@gmail.com>
References: <20230123101631.475712-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 11:16:30 +0100, Robert Marko wrote:
> Document IPQ8074 compatible for QFPROM, its compatible with the generic
> QFPROM fallback.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: ipq8074: add QFPROM node
      commit: a1ab382704f59c917a497b44e7552c4f2eb4faf7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
