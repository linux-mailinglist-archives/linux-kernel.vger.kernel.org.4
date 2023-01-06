Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F266083F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAFUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjAFUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:24:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD388FC5;
        Fri,  6 Jan 2023 12:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B3AB81E95;
        Fri,  6 Jan 2023 20:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D3BC43396;
        Fri,  6 Jan 2023 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673036663;
        bh=0KuWCg8Jmwvu7nhxqZhepBZzEJ4BG2/U7bhs8grOa0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NE75Eh62cPiQtZwdMykDUv4azIWOcclQ2fq+17CLNRTorpOFiKnBupSfmlgBfW9Mh
         hD/Vtdc6xVvrcrJpLi2YVUr9Sw2Q78rMJKzoi2SvoZFErdEBxW9J89YdzrCJZs146+
         p5awZBVUCDRF1Kj1Kk23mIR8kXc5GjGgxT4LnJeSMUYhysbwof+xUrN0HtAMDfrp0f
         Xw4FcDi4h4ope82OBu4PTOm9LjTcsr7/CgGLBwHHM0bK+gRQRjohIB0lt820Val2Yk
         8kK6cjhVlkpOv7H6jeSC1Be/ajk9UZQ5jR/u8wA2ablXvKh+iv07k97GRh6Ysq+rj0
         becPY3Fy0FgGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_schowdhu@quicinc.com, yang.lee@linux.alibaba.com
Cc:     konrad.dybcio@linaro.org, abaci@linux.alibaba.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: qcom: dcc: Fix unsigned comparison with less than zero
Date:   Fri,  6 Jan 2023 14:24:19 -0600
Message-Id: <167303665354.1802272.14384992770455268720.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106011710.2827-1-yang.lee@linux.alibaba.com>
References: <20230106011710.2827-1-yang.lee@linux.alibaba.com>
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

On Fri, 6 Jan 2023 09:17:10 +0800, Yang Li wrote:
> The return value from the call to kstrtouint_from_user() is int.
> However, the return value is being assigned to
> an unsigned int variable 'ret', so making 'ret' an int.
> 
> Eliminate the following warning:
> ./drivers/soc/qcom/dcc.c:815:5-8: WARNING: Unsigned expression compared with zero: ret < 0
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: dcc: Fix unsigned comparison with less than zero
      commit: d4b2c7484a8edd79c90b9f8acc8a03e5e3235b89

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
