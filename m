Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7768FE82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBIEXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBIEXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4010C3;
        Wed,  8 Feb 2023 20:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 778E661838;
        Thu,  9 Feb 2023 04:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F178BC433D2;
        Thu,  9 Feb 2023 04:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916478;
        bh=W/Ri1m5q1BeTBKDLmtqRWJxqxGoU4qD2z5PvMZelzjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLRGSmnSs0W/nc8ZGKdrQFsYOSPpEVvKcOT4HgljPrBuN/2+p+Z3UolrOxYccgPQp
         FpausfD39lWQprT+wTqHj3qxWsQoKvx27/MoeUcYt8rkjzBWku2JR9M9S9Asgkrs7p
         SHyhg/9kbKfV4/N8TDNwoQD3VXWJBe3s8xpiFUi1YGHK5tWwzrkVw6diiNYVxHVVkb
         1dr6AYOJomavv1Fo0V1k0bolyODRDj7ctUob6BpXJEyKl/AzLUiABRLUPvDW5fddbX
         t7BcQNZIg6l1VcjeA0BxuiEVVEz8e7+WFOP6orlJm5a0UDrBApGv5IOPCecN/essnC
         nrfX+4+MX9VFg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        phone-devel <phone-devel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-xiaomi-beryllium: Add reserved memory region
Date:   Wed,  8 Feb 2023 20:22:36 -0800
Message-Id: <167591660367.1230100.18277478564789130052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127063355.1775246-1-amit.pundir@linaro.org>
References: <20230127063355.1775246-1-amit.pundir@linaro.org>
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

On Fri, 27 Jan 2023 12:03:55 +0530, Amit Pundir wrote:
> Put cont splash memory region under the reserved-memory as
> confirmed by the downstream code for both Tianma and EBBG variants.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-xiaomi-beryllium: Add reserved memory region
      commit: 1b8f9b9109790acf9c9647a721bad9ad345f0b29

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
