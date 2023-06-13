Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701C72F0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbjFMXsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjFMXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D262D4D;
        Tue, 13 Jun 2023 16:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C484B63C86;
        Tue, 13 Jun 2023 23:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455D5C433CC;
        Tue, 13 Jun 2023 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699946;
        bh=yVQ4OBiRpUPCMwJRvlKeoOYf9HO6CWCfuRhtfs7iVb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYbyHl04FCzWReAQRS5XYTyhR0reylOBCKMspA9P3SaJUVX6sTRMvrqqflaFqC+oI
         1Yssjk5w+uKcMeoqUkZgDMFgoqf971yHbD1kYrs2ux8yodamfeOWzN7Twxho+7yass
         IDqHDHj+Whzwx+sUQs0L14RGug8/pqV/zejcXkftGyL9Dn2JY0g1E4vT4BJDhsSGpG
         WG6QdB1mxMoLwsd4CfgpVamHoKM0OF984rB0T3tql/aZ6k1jPnnmaKN/8G8m3AFhYm
         pNGUcv4s0GiD3RMSHFIRooarYSpdWIFgb93C//gMgk9Oqi4tM4VsX96aF3K5shf1tN
         fFqJQY1J8W8oA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm2290: Add CPU idle states
Date:   Tue, 13 Jun 2023 16:48:49 -0700
Message-Id: <168670013501.1400697.13968552127398469455.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606-topic-qcm2290_idlestates-v2-1-580a5a2d28c9@linaro.org>
References: <20230606-topic-qcm2290_idlestates-v2-1-580a5a2d28c9@linaro.org>
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

On Wed, 07 Jun 2023 01:04:19 +0200, Konrad Dybcio wrote:
> Add the (scarce) idle states for the individual CPUs, as well as the
> whole cluster. This enables deeper-than-WFI cpuidle
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm2290: Add CPU idle states
      commit: 4acf7eceed31c56cf4baf11d43ee91255685f89a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
