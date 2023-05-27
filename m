Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421BF713141
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjE0BEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjE0BEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB680E41;
        Fri, 26 May 2023 18:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A74C654C7;
        Sat, 27 May 2023 01:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6491BC433D2;
        Sat, 27 May 2023 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149436;
        bh=gq3MiEJn7cc8dK6KuHIuQGHegznMjK7aZMTVzjupvQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XI4JjjP/tScJ4LxdTf9Uv+BBCKsaCbufv0zAeFQ6mOCGo5yqOzahgKNA3TSqEJet2
         Yy8Ub2QPLixf1O8fwF9m4cwXCVQOGikBDN3iNtvfivDZ6H3GM0u4kMw/oyYyBJQZ5f
         jlGifU6lW/AvTatWAWVu7IdXoVmEkrF7lYLfja01dpIZOAWZAQ9Y5WLT1mAHbjHGH1
         WTKWnLIcMymJAbXxXsb0BXyuOSuvyThKGOnzrsfPCotBzv7VAIbWYrmB8qPWK5W8gW
         a/dLvIpdi5MgKsfw/tBsniEw+cixn7WZZ2QcwT8vwe7ZD8Du409sKANNdGRQriCYB1
         pzLwl6StsLaOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-clk@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: [PATCH V2] clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO clock
Date:   Fri, 26 May 2023 18:07:31 -0700
Message-Id: <168514964950.348612.3003761382932080629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417105607.4091-1-quic_kathirav@quicinc.com>
References: <20230417105607.4091-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 16:26:07 +0530, Kathiravan T wrote:
> The order of DT_SLEEP_CLK and DT_XO are swapped and it is incorrect.
> Due to which the clocks for which the parent should be XO is having parent
> as SLEEP_CLK and vice versa. So fix the same by re-ordering the entries.
> 
> 

Applied, thanks!

[1/1] clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO clock
      commit: 7510e80f4ac707efc7e964120525ef759a02f171

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
