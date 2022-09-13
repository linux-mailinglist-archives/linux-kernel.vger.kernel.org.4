Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A085B7D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIMWnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C317A8C;
        Tue, 13 Sep 2022 15:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC8EC6160B;
        Tue, 13 Sep 2022 22:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DAEC433C1;
        Tue, 13 Sep 2022 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109023;
        bh=HMs7SygX+dZ+FJdrUSMKbxGpb+XAtjm7bvaVNyusMpA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m2HiEt1NnMSeXdLoqwo3rgiLAZ/IJiTj2exJZFvQaHBmJQ3C/FEWoD/CflbpLaFfD
         o2CR3vQIZ1N1w7M3F9VCtVIJ2ur9fyOmgnao+aLf7iz8aaPuKHf5L6r94NSMgPknS1
         Enj6Mmd4E9dvshkvjLYMLz84G925VVQakZIKuim+1Tds1V8764VyjgKuQ6hq6weOgs
         2AxlzAIknAnbHJL5iCR3JLEu6yChM3Bg2xBaxiUNa3vzope0CbGZMjSHkXylmyfzR7
         PagqnyJhRM0nN4AIf7bIWCMZS8M3si9WQxrxH6c6uemTWBSS/1dh5wYTrMBHE4lUDy
         B50t50s6iiZIQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ohad@wizery.com, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, baolin.wang@linux.alibaba.com,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: (subset) [PATCH v3 00/15] ARM/hwlock: qcom: switch TCSR mutex to MMIO
Date:   Tue, 13 Sep 2022 17:43:41 -0500
Message-Id: <166310901623.665247.12740915451161443545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 11:20:20 +0200, Krzysztof Kozlowski wrote:
> Switch older Qualcomm SoCs to use MMIO-based method instead of syscon.
> 
> Not tested on hardware. Please kindly provide tests.
> 
> Changes since v2
> ================
> 1. Rebase on current MFD changes.
> 2. Add Rb tag.
> 3. Split MFD patch to separate patchset:
> https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/T/#u
> 
> [...]

Applied, thanks!

[01/15] dt-bindings: hwlock: qcom-hwspinlock: add support for MMIO on older SoCs
        commit: 6ca53a75c425cb1cb0929ce07f58d9e41094500c
[02/15] dt-bindings: hwlock: qcom-hwspinlock: correct example indentation
        commit: 276a4f1a5fb118bfd6980d42732d530e43f2916a
[03/15] hwspinlock: qcom: correct MMIO max register for newer SoCs
        commit: 90cb380f9ceb811059340d06ff5fd0c0e93ecbe1
[04/15] hwspinlock: qcom: add support for MMIO on older SoCs
        commit: 5d4753f741d824e04e7ba46f46ec016be120f383

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
