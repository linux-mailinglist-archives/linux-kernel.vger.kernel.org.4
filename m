Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B261E958
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiKGDO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiKGDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15251209A;
        Sun,  6 Nov 2022 19:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F5C60E9A;
        Mon,  7 Nov 2022 03:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD87DC433D6;
        Mon,  7 Nov 2022 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790792;
        bh=5lPhuVO2WN3Opr2bN7Yy8gt5CFqVQHz0FlwMLGYszw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcOCLWtzc8MG8+qiYefjV6dTN90+oxQPpiLYHuJGkd5+DLm3+M9/C2+X5T+clnjSN
         lKxfItp0w2ZN3kXXYIrqCI/MYCMpQHY7/WlR0UuP3A1BvWXGZsjcLZ3Vv/ui4gIdOj
         xLfj+pAqNaEptNi8VH4rbkkBMMijDZVmM9xozwH6XoGQanoXX4z6hwWGEVTnh6oWda
         EaGSlUK3qDna3DgO8gkko4y5sYuaMmalgfcMrmi/cGmeN3JOdOzXVLI1jBBhXfv1JS
         I1EuNNE62jEfVtSJHpu/ZvfmPzh3dGwhhBsjg/9QRsDxjTUSTOX9ywtb0uRk3EIpRA
         nNxeBI1N0UF9w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     martin.botka1@gmail.com, martin.botka@somainline.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, marijn.suijten@somainline.org,
        paul.bouchara@somainline.org, linux-arm-msm@vger.kernel.org,
        jamipkettunen@somainline.org,
        angelogioacchino.delregno@somainline.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/1] clk: qcom: gcc-sm6125: Remove gpll7 from sdcc2_apps
Date:   Sun,  6 Nov 2022 21:12:29 -0600
Message-Id: <166779074256.500303.357473237614927854.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221001185431.493440-1-martin.botka@somainline.org>
References: <20221001185431.493440-1-martin.botka@somainline.org>
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

On Sat, 1 Oct 2022 20:54:31 +0200, Martin Botka wrote:
> This removes gpll7 clock source from sdcc2_apps as it caused issues on the
> device during testing
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm6125: Remove gpll7 from sdcc2_apps
      commit: 6db4d77f5701699aa6eb4e9718d69a7a55f0aa65

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
