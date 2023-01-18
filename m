Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EF672BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjARWuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjARWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E8656D9;
        Wed, 18 Jan 2023 14:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE76CB81D76;
        Wed, 18 Jan 2023 22:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEDCC433F0;
        Wed, 18 Jan 2023 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082233;
        bh=hRXECqYF6hSZOE89bOufu6TOTqiGvZGrDyJ3h9B544w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEBJphbTRaURrOhM4uokSI/FiOQ/J7P0KVUgR6LxjK3hGNQxMTMYqN1GYE4tVxA+F
         Vva/kPN47P6p+ovqWQQuxZ46rRcHsMGE3F+4gh0pJqnOFuVH9QQU6q8P1hrCVGcF0P
         kDi4enJQe8tazPRydG2Dai9EekAgr5Jcg4D8YadLmPYSJYV8fuY1huF8CtGj/Nb2M1
         eovAcopDHkbkeGdJtwJcYLAQWOcDzEXTceQGM75sbt67ukQoU0CV1oDH2/26y0MSXs
         CwKKRqI+gE12Uqf+YRPPsQpav1k5qbOH5kOjK2to0zoAJ9ckK/TVYBdBGE+w3C7Nlg
         C0Ut05MGXbQOw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     konrad.dybcio@linaro.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: sound cleanups
Date:   Wed, 18 Jan 2023 16:50:23 -0600
Message-Id: <167408222414.2952004.4882243657690570772.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230103103141.15807-1-johan+linaro@kernel.org>
References: <20230103103141.15807-1-johan+linaro@kernel.org>
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

On Tue, 3 Jan 2023 11:31:35 +0100, Johan Hovold wrote:
> This series clean up the sc8280xp sound nodes somewhat, for example, by
> making sure the nodes are disabled by default in the SoC dtsi.
> 
> Included are also two related cleanups for sm8450-hdk and sm8250.
> 
> Note that sound on the X13s is currently broken and depends on
> out-of-tree hacks to even probe:
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sc8280xp: disable sound nodes
      commit: 6ded5ed60984104a1a3560e02422941c25da686c
[2/6] arm64: dts: qcom: sc8280xp-x13s: move vamacro node
      commit: acf906140790837d235567c93207fde6ac8e1e64
[3/6] arm64: dts: qcom: sc8280xp: clean up tx-macro node
      (no commit info)
[4/6] arm64: dts: qcom: sc8280xp-x13s: move wcd938x codec node
      commit: fdc6a0b272c5f91bfb4dcd8c0d7757d8dc0abef4
[5/6] arm64: dts: qcom: sm8450-hdk: move wcd938x codec node
      commit: 306380dc93c5a305a009f7d210da0995e3babceb
[6/6] arm64: dts: qcom: sm8250: clean up wcd938x codec node
      commit: 74d6ed033d47200d18204e3935b201f385476271

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
