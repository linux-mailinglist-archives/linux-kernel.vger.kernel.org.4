Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22376BC17E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjCOXfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjCOXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F5A6BE3;
        Wed, 15 Mar 2023 16:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3AE6B81FA8;
        Wed, 15 Mar 2023 23:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C41C4339E;
        Wed, 15 Mar 2023 23:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923178;
        bh=J+VdprXsDkR+blMkvRslh77/YhAHDDN+vCvCjz/vvLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xyt0J9r4e5xX3KFqn3uiSSsvWIX00GokRQFtX8ZL1Jyzwh8ojXn6rinx8zrEcIpOZ
         3toEjXS8o71xa7lmgrF9/RQLSiDWOkkPSKI/iR8Gr1eZipnMAdkKDBiWzaLJss5dBA
         myq9r6icveeFgynCSEQi/s/UykZ7lW5cMsq9cwuXKN8zoM0ynHF2blrwbS0ZqLJb7l
         YDNT77TTP/UkAqcxp3BwBYx/6iLbY1jW5AP5vTPcqoqcGnK1IPApn6e+qLIiTIent4
         sFoN9SGeZJdhpOGW68f6CpNV4F/3hYtzB9HZ4BFhmIHN7ghjxzS0qhjZMWpm/w3l8b
         RpX98qog/1AkQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        Tom Rix <trix@redhat.com>, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: remove unused variables gpucc_parent_data,map_2
Date:   Wed, 15 Mar 2023 16:35:29 -0700
Message-Id: <167892332568.4030021.2522610216685451226.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315155630.1740065-1-trix@redhat.com>
References: <20230315155630.1740065-1-trix@redhat.com>
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

On Wed, 15 Mar 2023 11:56:30 -0400, Tom Rix wrote:
> gcc with W=1 reports these errors
> drivers/clk/qcom/gpucc-sm6375.c:145:37: error:
>   ‘gpucc_parent_data_2’ defined but not used [-Werror=unused-const-variable=]
>   145 | static const struct clk_parent_data gpucc_parent_data_2[] = {
>       |                                     ^~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm6375.c:139:32: error:
>   ‘gpucc_parent_map_2’ defined but not used [-Werror=unused-const-variable=]
>   139 | static const struct parent_map gpucc_parent_map_2[] = {
>       |                                ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: remove unused variables gpucc_parent_data,map_2
      commit: 54ed70b57623e18f6c18f510cbe1e741bca89f34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
