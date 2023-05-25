Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F3710445
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjEYEvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEYEu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5083;
        Wed, 24 May 2023 21:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798F4641E8;
        Thu, 25 May 2023 04:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422C3C4339E;
        Thu, 25 May 2023 04:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990257;
        bh=l8tcrDWF0cp2L8xHKZs4rk4OtL4USOEBMMnO7LVpJgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oG8PymZV4+vdJRpt6fFg0UFRw6ysGihTBv8jIcrLk/1ciz2qT2PdIiIEpaRaI+ZIf
         H7HqeIuabHomU4Ud7mhTZXfqhGRs9VWJFlA7PzMNQKmC73oAMz+qBooO37p6yo1Csv
         6EMVGS5M9FpOFpRwhfcBpTCdXDa5EwMczg/DkRwxaqsFvNU7xoeAj1jXacPaakLp54
         3EaOf4+oE9fUHPJ+z8s6S1h3zXvTy/W9XAaAD4XmhX9l9/j5Wuy/O1E0K0zCbF2tsV
         g57Iaop0D1TfKr6eQvQvSA29fekoo+ISba8M45vdr001JE4dX6nl38SLzT2G/SykbY
         WuXUkG8eHZLGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v4 v0/4] sa8155p-adp devicetree ethernet cleanup
Date:   Wed, 24 May 2023 21:53:37 -0700
Message-Id: <168499048179.3998961.11840915445015146788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501212446.2570364-1-ahalaney@redhat.com>
References: <20230501212446.2570364-1-ahalaney@redhat.com>
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

On Mon, 1 May 2023 16:24:42 -0500, Andrew Halaney wrote:
> This series cleans up some devicetree conventions in sa8155p-adp based
> on feedback from other platforms.
> 
> The hope is that by getting it right here, future contributors won't
> repeat the same mistakes as I did!
> 
> v3: https://lore.kernel.org/linux-arm-msm/20230421205512.339850-1-ahalaney@redhat.com/
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sa8155p-adp: Make compatible the first property
      commit: eee7369de0c3cca7aacab3874663d460fb7a5b06
[2/4] arm64: dts: qcom: Make -cells decimal
      commit: 674631c35f8670017d3bbd51a5b52f8b953f6816
[3/4] arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy information
      commit: 0ff4f6a380214fcf85a5b5ad64ff481d9bd1dfc6
[4/4] arm64: dts: qcom: sa8155p-adp: Move mtl nodes into ethernet node
      commit: 93fe463652504bba298a68b56334729cdf92c0c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
