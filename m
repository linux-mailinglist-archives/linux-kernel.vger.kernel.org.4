Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4795A6DB1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDGRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjDGRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32300B45D;
        Fri,  7 Apr 2023 10:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B552365299;
        Fri,  7 Apr 2023 17:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58251C433EF;
        Fri,  7 Apr 2023 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889111;
        bh=HqAHjL1gj/bRfYJF4EdwidyWxb/Ih2XTgevFFdQxq50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFmfC2Xe4kgH/3dMDPBHAlpHBGUYwclMSz8ekz9WLeuuoWYMFJJSTFHGQgAmi/gE0
         HSOwrHiBIZbg2M9CiK/l4debh1kO/5HB68jBfiqlnqYEu6891hApYOxymJrsxoXwyM
         eXDKkwsoKvkH0+He1M3D81beMHlhcl29P5TzUDtlNTBcA2fUn+7kp7qGAgLWdjj272
         356L2U70ifTBiZsYXpuKg2ZYooYofBZjImhn7BYpPIddp5yrbOzT2/H65I1KDgBqA7
         OHUWA5+ZFooOzXqi0ZbBmj2jtl2EhITX3MPPa7UZ5HXw2cuvp6W0By5WOMXzHIa5YZ
         Zc4sm7xxY9Mmg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, marijn.suijten@somainline.org,
        Iskren Chernev <me@iskren.info>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        vladimir.zapolskiy@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.sharma@linaro.org
Subject: Re: [PATCH] clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
Date:   Fri,  7 Apr 2023 10:41:08 -0700
Message-Id: <168088927579.2561591.13634116210822560080.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404224719.909746-1-konrad.dybcio@linaro.org>
References: <20230404224719.909746-1-konrad.dybcio@linaro.org>
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

On Wed, 5 Apr 2023 00:47:19 +0200, Konrad Dybcio wrote:
> The vast majority of shared RCGs were not marked as such. Fix it.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
      commit: 996c32b745a15a637e8244a25f06b74acce98976

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
