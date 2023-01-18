Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCE672BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjARWvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjARWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA063E26;
        Wed, 18 Jan 2023 14:50:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFB8AB81D76;
        Wed, 18 Jan 2023 22:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537CC433F0;
        Wed, 18 Jan 2023 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082237;
        bh=2blp33AOuNZgDL48gG5lYTR7R74zR8GX5DBx5UyySA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL8tabuAZqwcjzroj/lcYe+3MwW6T/FjQjJ+xtyJwkHQsT1/3dqP462K8aCaP4pQx
         jihZTCOo8labZCEyd/UNHjWynlGYWOeFP5x7KryMVzT+cPz1nkFVtXPABPvyYa7BcV
         txzvzYPVxhv4EnS++80wr5FgibhyLcD1PUKYP+YpvJYQ7OxBQWJbRY8INRlsGQExrS
         g6blVMtr8h0jCqRbyJRCeUi6bQ+zjVX17n5uSplBdju0Ez8ezUJESynGDWGNcFvgQa
         kFXVgsnCNcPruBQp3t/jg0nnKRccjtKNlrYfKOGgoW0o7t2iMl7hmYr4suwEaVB1dr
         7Ikw0zEJbIdwg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, quic_bjorande@quicinc.com,
        agross@kernel.org
Cc:     ahalaney@redhat.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Define CMA region for CRD and X13s
Date:   Wed, 18 Jan 2023 16:50:28 -0600
Message-Id: <167408222416.2952004.7134382340412664997.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
References: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
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

On Tue, 17 Jan 2023 10:46:30 -0800, Bjorn Andersson wrote:
> While booting the CRD, a series of CMA allocation errors can be seen in
> the kernel log:
> 
>   cma: cma_alloc: reserved: alloc failed, req-size: 128 pages, ret: -12
> 
> Growing the CMA region and querying /proc/meminfo indicates that a newly
> booted system (currently) uses 64MB CMA.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Define CMA region for CRD and X13s
      commit: 5f84c7c35d49e6d92b720db19d421951f1ff8599

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
