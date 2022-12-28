Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711F6572C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiL1EiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiL1EhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542ED2D2;
        Tue, 27 Dec 2022 20:37:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCA261238;
        Wed, 28 Dec 2022 04:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5EEC433F0;
        Wed, 28 Dec 2022 04:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202228;
        bh=ppwC4LOwWHOKDutNAnDqBaDrC7JswL9fWVDPbALelcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lU2pjDqAE8c3d7G8mZCQyMIZVlkz7gy3nh/vUNeoLtnSVwaoP1noZ4s2RHPg82cSq
         OUAdCYhdi8ELl0dPOrxI0f+o5sepXtoszEKU1SvlSWuNn04WZUtiuG4g4SbZz3iKnu
         H1IU8aSqXyvM8ys1po9dFjobX7/FBZ+b6e43HaJHFWBa5doGoe9H5C/5IINpwyGcrQ
         ijXVfTRXT8Qpmh+iR7lvoFz7I46WIgvLxLp6oZJlnfNStQ/5He1VgP1S2hM2jKbUfv
         Vzkl07PeKTRZs5BYu0v/aPEYeFfItF7uPJQTrlycOWoFhx62OnCs6NMf5L2ORKclT3
         OL+rIilvn3uqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@iskren.info, mturquette@baylibre.com, sboyd@kernel.org,
        patches@linaro.org
Subject: Re: [PATCH] clk: qcom: gcc-sm6115: Use floor_ops for SDCC1/2 core clk
Date:   Tue, 27 Dec 2022 22:36:42 -0600
Message-Id: <167220221226.833009.4380587340113538324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209123910.178609-1-konrad.dybcio@linaro.org>
References: <20221209123910.178609-1-konrad.dybcio@linaro.org>
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

On Fri, 9 Dec 2022 13:39:09 +0100, Konrad Dybcio wrote:
> Just like in case of other SoCs change SDCC1/SDCC2 ops
> to floor to avoid overclocking the controller.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm6115: Use floor_ops for SDCC1/2 core clk
      commit: 85d4e6ea082d3905f3ede470ac337fddc2d47650

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
