Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67A5EB8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiI0DYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiI0DXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C5633C;
        Mon, 26 Sep 2022 20:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10FA6156E;
        Tue, 27 Sep 2022 03:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539E9C4347C;
        Tue, 27 Sep 2022 03:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248987;
        bh=jwIr1AadyxPP096EKZl/ojVnW7WbucoDnGDfFm6rVl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kj9U86gNK9dhB4FuRpUt46aYQuyP5ty1/X3HHrtXu6JaubyYzIQEPhxQLRY450ywX
         CZmw0M9UOPlA8r/NOMa4bfSYWZMqUaI1fEoREwy87Q1JALGp5E3Gvtbtj4F7M9b8GA
         wnvfsPzjI6PFAVKYD/sSdZMXO+RHayZXQq4cP2MzTKU4tVrCtK8gprkz5/tTe0NOa4
         9MF8Ghbw9VuXUQHz+DOr4Sb3V6pD8Ya0NHzef0YUUcd8j/wpLRiQm7Y1KgS6UoIdJx
         iaRM7u8BbYJpsb5OHW71+ao74QDasU1caEIUoCqmDZvqIFtaKmpGF8RMvkwawZ9clS
         otjTYbOFHJsbw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, konrad.dybcio@somainline.org, agross@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh@kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: (subset) [PATCH v7 1/4] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Mon, 26 Sep 2022 22:22:58 -0500
Message-Id: <166424897969.1766486.9923540291851498310.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220724182329.9891-1-ansuelsmth@gmail.com>
References: <20220724182329.9891-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 20:23:26 +0200, Christian Marangi wrote:
> Add pcm reset define for ipq806x lcc.
> 
> 

Applied, thanks!

[1/4] dt-bindings: clock: add pcm reset for ipq806x lcc
      commit: d7081998cca9df11727d77bf9a34f6499a13862b
[2/4] clk: qcom: lcc-ipq806x: add reset definition
      commit: ce6bb04cad2632baa6ec27852f417b0baeaa58da
[3/4] clk: qcom: lcc-ipq806x: convert to parent data
      commit: 7458b82fa563468843a35fce946b9893d0445fd3
[4/4] clk: qcom: lcc-ipq806x: use ARRAY_SIZE for num_parents
      commit: 18f6e9cd7fa3ef6a6dcb10d3fe357afaa52bd216

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
