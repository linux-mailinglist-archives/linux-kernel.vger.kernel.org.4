Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFD7104B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbjEYEzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbjEYEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EF1A8;
        Wed, 24 May 2023 21:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6FF642A0;
        Thu, 25 May 2023 04:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83382C433A0;
        Thu, 25 May 2023 04:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990305;
        bh=F/9qCi/aWpXCcfQtpOkMwB8Avnr91ZUf5XsK08GzRfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0hBuQMlLwjJz8mgTzaZlDTldWkuwvSMP9WFvEyH1mQl01JhHR7u/hi8LkI6v6Bca
         qm5lfMZsvUM+je1W5DM9KTHWYNPh8L2nyOCTLcWOdgjgQhEA/5Nuk/DH7GuOSn9Q8u
         s71bhW8D5qaVUP2BGfXPgZc9PM0v1Dk7AhuUgX4UqpxBigtEy99/8ozanSohfWAAGa
         OEaJG+6cJ8SOFCgaGJm21KAaXjMcDWRBl0r93t+tXqsp+a8dZv97RnlhyZgxVZzNjv
         wrEioEuBvR+Aye/qXkd3QNZxdyL80bAVbdjWt3BNt926HenQDfj+6gk+anJ1gNb0ml
         0TROj99kxSy4A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: smd-rpm: conditionally enable scaling before doing handover
Date:   Wed, 24 May 2023 21:54:24 -0700
Message-Id: <168499048185.3998961.3233222343826029268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
References: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 May 2023 22:10:32 +0200, Luca Weiss wrote:
> On older platforms like msm8226, msm8974 and msm8916 the driver in the
> downstream kernel enables scaling first before doing the handover of the
> clocks.
> 
> While this normally doesn't seem to cause noticeable problems, on
> apq8026-asus-sparrow this causes the device to immediately reboot,
> perhaps due to older rpm firmware that becomes unhappy.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: smd-rpm: conditionally enable scaling before doing handover
      commit: e9a2db5caf9f219d9cf570cb0965710344c85519

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
