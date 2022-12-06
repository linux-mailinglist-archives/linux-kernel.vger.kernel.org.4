Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A752F644B28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLFSUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLFSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167765FE;
        Tue,  6 Dec 2022 10:19:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EA19617F2;
        Tue,  6 Dec 2022 18:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B04AC43142;
        Tue,  6 Dec 2022 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350781;
        bh=GSlbSx9ij8l7D2Mu0NuwCYXVSjHWaBII7J+uan0+6dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtkVXguyXB7ryZoNDgPe0j9fCFkUjIm8emgC/6Hs2rBO4bGd+GC/y1pbgdJ8pROCo
         Y5XNdICPPZKvIseuAb4r3ZCe0utC9qq7LSWfQYjR3SWmdMnqT6VKQJJl99r9QwYuGV
         9q9xjxwjp4VqplI0u+JSOBuhcQFvVUYYChd66acEakx4SKzhqLNUB9DHFNn6WbgdyA
         Yp0h17maP8m9QGglEyfsc4rIpbiXzzYsiVxnWojs4l2XWPFWsiW/sJLtKrOnARLuUi
         qs5lKN0Bf4qwMrzFuTodkhktATQTKPm5Gl1Cwd4Zkg/I9GfPXpGHb9DpUccMpkC7pL
         Ai3/qDLVHIqzg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bhupesh.sharma@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, bhupesh.linux@gmail.com, agross@kernel.org
Subject: Re: [PATCH 0/2] Add SM4250 RPM power domain support
Date:   Tue,  6 Dec 2022 12:18:47 -0600
Message-Id: <167035076344.3155086.2883117402843264050.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127112204.1486337-1-bhupesh.sharma@linaro.org>
References: <20221127112204.1486337-1-bhupesh.sharma@linaro.org>
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

On Sun, 27 Nov 2022 16:52:02 +0530, Bhupesh Sharma wrote:
> Add RPM power domain support for SM4250.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: rpmpd: Add SM4250 support
      commit: 45ac44ed10e58cf9b510e6552317ed7d2602346f
[2/2] soc: qcom: rpmpd: Add SM4250 support
      commit: 5b617b1b10c1c6a4365d8f956032e95c53b8e388

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
