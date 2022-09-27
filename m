Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386825EB8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiI0DZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiI0DX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D621C102;
        Mon, 26 Sep 2022 20:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45A7B81910;
        Tue, 27 Sep 2022 03:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95AAC433C1;
        Tue, 27 Sep 2022 03:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248990;
        bh=19/9uNWInCFs/3J0s0YjTK/DMo8Sz7zXI9f66mQgI6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+qMzAL0AiokDrLzQo8UkShub526g98cuOFm/n1dxKTfrsv1mxlJVfodMQ3zwf/Gu
         3buxi8F/BzjQivg6XcX/+4wnqAkZrq38gwU8KbMDZ5hIHSgAtlIfVex1SJZzz17WOe
         hvrXHpFuOcDe0Tg0o5DrSGBKf8jw4bcQLZHvWjdfdZHonJO2ZAn0XSn5zQeaCR3YVl
         lRBAZc6VPhddKGIiX3yDtogh4rfc24ihl8J7L7ZjiB34W6oXqG6rqgAWyVxPu1DAPK
         uVwR5vvb70xCfyF3kBx1jwMeNzeeuEZQ5E9QD0u8XMGDEMI+SQooJ/i/xVrTEPEBh7
         6iPtDbx4vLB0w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        iskren.chernev@gmail.com
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, a_skl39@protonmail.com,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH 0/3] Merge non-standard qcom clk PLL offsets
Date:   Mon, 26 Sep 2022 22:23:01 -0500
Message-Id: <166424897977.1766486.8297085520259468743.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830075620.974009-1-iskren.chernev@gmail.com>
References: <20220830075620.974009-1-iskren.chernev@gmail.com>
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

On Tue, 30 Aug 2022 10:56:17 +0300, Iskren Chernev wrote:
> Both the qcm2290 and sm6115 gcc drivers need a non-standard Alpha PLL register
> map for DEFAULT and BRAMMO types.
> 
> The initial gcc-sm6115 was lacking the DEFAULT override, so fix that first,
> then merge the two overrides by using newly created DEFAULT_EVO and BRAMMO_EVO
> types.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: gcc-sm6115: Override default Alpha PLL regs
      commit: 068a0605ef5a6b430e7278c169bfcd25b680b28f
[2/3] clk: qcom: gcc-sm6115: Move alpha pll bramo overrides
      commit: 65f1fa35aa70b9e5abfd184ce3078c9aa93a1cb4
[3/3] clk: qcom: Merge alt alpha plls for qcm2260, sm6115
      commit: 9e48f0519bae644d91c85d0a99ea5887688e4bd5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
