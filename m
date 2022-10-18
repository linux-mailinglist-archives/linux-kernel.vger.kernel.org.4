Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962446021E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJRDJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJRDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E129A9FB;
        Mon, 17 Oct 2022 20:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC57861369;
        Tue, 18 Oct 2022 03:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54195C43141;
        Tue, 18 Oct 2022 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062414;
        bh=SM0KS7UEGQXFwJvZ40VUImti/wB0BT4WPB76hFirvRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhptPaU7Uhbnr9wU1Qw8ENgtcYYu9hYcvNgqlu/LsgdgEoqCictHufveTI+n1uL9J
         E64x0SQUw7V3812jYWGin7NJE+9PXt8bcQqbAcQB0mQbIrfVvnqnofnn2aozRoxAd6
         qxzrHfXj7RqyFUJfUu0eXUZ0pgki6JyILiyHD8NLPnzhUZi9DKn/fDIX/mRQliDYg2
         zYIcHh4wHdb2Koi1yeUUYQgw21HbSJA4+V0EdepWQyM+uksrSF4xJf5oJ8UCnwt2wF
         zxqmNMWyUemyVFvYwSJFqsJCLr9OU7LYXyM5EgpctCK5z7uls7eAsk0IOvD07N/K64
         1f44IB7rOo/wg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org, agross@kernel.org,
        quic_gurus@quicinc.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        robimarko@gmail.com
Subject: Re: [PATCH v2] dt-bindings: firmware: document Qualcomm SM6375 SCM
Date:   Mon, 17 Oct 2022 22:05:28 -0500
Message-Id: <166606235861.3553294.7128583878550464946.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221015115535.150037-1-konrad.dybcio@somainline.org>
References: <20221015115535.150037-1-konrad.dybcio@somainline.org>
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

On Sat, 15 Oct 2022 13:55:35 +0200, Konrad Dybcio wrote:
> Document the compatible for Qualcomm SM6375 SCM.
> 
> SCM consumes a single clock (core / RPM_SMD_CE1_CLK), though it does
> not matter whether Linux enables it, as one of the billion levels of
> firmware ensures it's on anyway. Still, mark it as used for the sake
> of correctness.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: firmware: document Qualcomm SM6375 SCM
      commit: fa2d6ed19899462758ea807e93dd972240f836f4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
