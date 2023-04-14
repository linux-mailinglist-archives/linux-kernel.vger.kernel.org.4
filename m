Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2F6E1AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDNDdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDNDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FA422F;
        Thu, 13 Apr 2023 20:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF4F6439F;
        Fri, 14 Apr 2023 03:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0ABC433EF;
        Fri, 14 Apr 2023 03:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681443209;
        bh=/UNOBmai2y4J8UYuZJ64apdENDUHw4H2NqyGlzhLzLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5Nw18Z5HA16x9A/MRpS8rmZ6i+22uIUZKS0EwmTqwWoVdybkLS6e3NwOS6oYXzgR
         MZORKem3CcSj4manvIf93+noYzrQdwx9zdG8dJ9AJcsjSNTPrVrlW6UHKhwEIHyoTO
         JSfuHW0OlyOzCs37zI4JaIr4kfRPIKTjwg/HGqmuf20I69QCCdGu+7kXPxWCjAqMwK
         xpRN0uYaxymGeS64hOTYCLyL2H2wzlqbAe1X2cwTtvDRXUJSJI19UBrcAlFU1tz67h
         T9lRS+64v2NJ1i088mQ1hMU9H8w/eZmZbX+iuCkY+cfoB5FqNXz6J3maEepqiMmn6L
         i9HzdSJ8D95Rw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] QCM2290 dispcc fixups
Date:   Thu, 13 Apr 2023 20:37:04 -0700
Message-Id: <168144342195.2459486.14055637721881703984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
References: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
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

On Wed, 12 Apr 2023 16:53:04 +0200, Konrad Dybcio wrote:
> I noticed some very msm-downstream-y bugs in the QCM2290 dispcc..
> Let's fix them up..
> 
> 

Applied, thanks!

[2/3] clk: qcom: dispcc-qcm2290: Remove inexistent DSI1PHY clk
      commit: 68d1151f03067533827fc50b770954ef33149533

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
