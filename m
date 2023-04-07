Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6636DB1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDGRim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDGRid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF2B45E;
        Fri,  7 Apr 2023 10:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 990A4652B1;
        Fri,  7 Apr 2023 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB73C4339E;
        Fri,  7 Apr 2023 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889112;
        bh=C+CTkyDzUyGXXgBG+BbaCjjthUJ0gPkzKjAOImPDXB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rX75Cd7omYeT4Hu7UgW9m4dzPnm+k6M9M+qHekYzt2RzUxbe/7Wklsj6khTWffAAM
         qaFGYZ631LzoNl2FUdoTUY4JmDM5LCizWDmXRfCV7dx66DIMqhTKRd8SpbecaxL0Rb
         gnL6adaybfBrlzR5IsbB3NEjNL6VpwxsyLiwnmyuPzmyxIlWllE/o91X/zoim9iVvN
         jQEE76DqOuB1ZRzFkpOSH4SjcjYeSeBMbcctH2OJdl7fBV69rDplc/51k0ZmQmuG01
         mxIp7kbVxa4A1Wi75jPXyjHqscOHTQa2z+jLpOcImCxSFo/2kI9VG+aaViO9+6uFzu
         uwkQNLL9kpCjA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, marijn.suijten@somainline.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gpucc-sm6375: Configure CX_GDSC disable wait value
Date:   Fri,  7 Apr 2023 10:41:09 -0700
Message-Id: <168088927579.2561591.3779420398674639585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329140135.2178957-1-konrad.dybcio@linaro.org>
References: <20230329140135.2178957-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 16:01:35 +0200, Konrad Dybcio wrote:
> Configure the disable wait value on the CX GDSC to ensure we don't get
> any undefined behavior. This was omitted when first adding the driver.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gpucc-sm6375: Configure CX_GDSC disable wait value
      commit: 93f21d925f787eb4a91e7ade77a544df30be0605

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
