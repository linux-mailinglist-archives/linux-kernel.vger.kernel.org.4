Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8915710451
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbjEYEvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjEYEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC84135;
        Wed, 24 May 2023 21:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5C664203;
        Thu, 25 May 2023 04:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00BCC4339B;
        Thu, 25 May 2023 04:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990264;
        bh=kMSJb6pjeX/gFzONZTUyGv/gBvFWvz4B4qXu86UNhZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwvnwWkh+oZXbfQt1Pur1fIe6pT3biMOwvNI8XC82u92Z3shZawnGUs9S7bewFtVe
         qn0SpfVgNX4C+MWBDdVOj8RD4rtdn5u87KtKyFkQRJ17QZqI602RYYXFs89sKGQtEI
         cjzNh9s3l78ilT5z/zKwPRQTTGGEsGgc49uWQFVmsLvGH+NOW2CadrvwOtUQlADOxd
         2m+K40M+37GT/KofFLxGnM7emfM92BXWOhzvxUeD4gmMsiZJLKAAIn3tQ+HZwJaIjZ
         TLHDJgS7sW1h2WBS0jqDFozOxtvFtjLvUoFMLTO40ucWWAf/NU8STuKSazGly6NmwC
         3s7VVfXMJqcUw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rmtfs: Fix error code in probe()
Date:   Wed, 24 May 2023 21:53:44 -0700
Message-Id: <168499048181.3998961.11898006309538480032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain>
References: <76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain>
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

On Fri, 21 Apr 2023 13:44:21 +0300, Dan Carpenter wrote:
> Return an error code if of_property_count_u32_elems() fails.  Don't
> return success.
> 
> 

Applied, thanks!

[1/1] soc: qcom: rmtfs: Fix error code in probe()
      commit: 7b374a2fc8665bfb8a0d93b617463cc0732f533a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
