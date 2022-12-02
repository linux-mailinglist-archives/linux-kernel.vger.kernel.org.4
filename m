Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A142640F93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiLBU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiLBU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8449E98BF;
        Fri,  2 Dec 2022 12:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6305F623E4;
        Fri,  2 Dec 2022 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1412AC43141;
        Fri,  2 Dec 2022 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014735;
        bh=gZFQmYMl3O1AnlKbfpIpV3NDpXuaHZU8zBfh4OaBZ90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vay7YPL7lQ/qocPg/vkWTHYjt38S+4pcgtTVCcKMYAAe1IHbGD3H1ruYmILWIx2M8
         FY0iXB31FYCkkiebHyzJ2oq9KRt9yZuiAh+DmY+HeR67OHGELOb27T4BOCovHN9B+f
         n9H6VNkGYosRFb5V7FN0tqYVP3p/z3ocXDq/ImmhUoYfEpdKpk/jrakqTyjoHXEKoJ
         8eRSrfHxYUgvALUaS1pBZemfXwQC1WE+MPMHQT0E/EK1+xnV0IcgOdaWiyBdzcQTlC
         SYbdhTUpR3R2rT7CzEgiC9qOqtyc/GRBbKEcoOnrCU6o5fALlUBaTnbRP0DeKLWfIq
         iPAHgfxjC7JWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        agross@kernel.org, sricharan@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-krait: fix wrong div2 functions
Date:   Fri,  2 Dec 2022 14:58:41 -0600
Message-Id: <167001472422.2721945.5450579392925679034.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108215625.30186-1-ansuelsmth@gmail.com>
References: <20221108215625.30186-1-ansuelsmth@gmail.com>
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

On Tue, 8 Nov 2022 22:56:25 +0100, Christian Marangi wrote:
> Currently div2 value is applied to the wrong bits. This is caused by a
> bug in the code where the shift is done only for lpl, for anything
> else the mask is not shifted to the correct bits.
> 
> Fix this by correctly shift if lpl is not supported.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: clk-krait: fix wrong div2 functions
      commit: d676d3a3717cf726d3affedbe5ba98fc4ccad7b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
