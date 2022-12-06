Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF00D644B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLFSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiLFSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE94AE4D;
        Tue,  6 Dec 2022 10:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A24C617F2;
        Tue,  6 Dec 2022 18:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272A5C43148;
        Tue,  6 Dec 2022 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350782;
        bh=HK4f3sTSRb+Qbyh2DgntGQfbwAWYOBh4uBn/smwxrps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5ahkbWSzZwLzbfdjcjBtmWv9WFcC7/1Amqa7eQjQ00qkpqQXwpK2BIQ9kE6Opebf
         Hdz6Gbe4a0FSqwjrAR0yuBh7qOunYlNL6lcpHHi648oUAriXmktSD1ezUQyNv1ZTHr
         5fR6wvnvyU3VLNaH1YMkRNiPXEWjJ/8P3ZwLoIa3n18drOaM3QGVJRf5XvqkCqPI+i
         Ah0LZ8J7krFVJuQg5wHM7CQ9BS8DZJTivSaBZjSFo6DgHJMEsHIopUDfJp+4rjzmmD
         2YbVIVUfGpOc7kXTpXPUOkeRr7ys40dtIQyLCkwq+lZG0IwrbXrjXdPzbzuJ1vvHqZ
         oyN4BmuvWQnhw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bhupesh.sharma@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, agross@kernel.org, a39.skl@gmail.com
Subject: Re: [PATCH 0/4] Add SoC ID support for a few more Qualcomm SoCs
Date:   Tue,  6 Dec 2022 12:18:48 -0600
Message-Id: <167035076353.3155086.7865345819947544762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
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

On Thu, 1 Dec 2022 19:46:15 +0530, Bhupesh Sharma wrote:
> This patchset adds SoC IDs for Qualcomm SM8150, SA8155,
> SM6115 / SM4250 (and variants) SoCs to the socinfo driver and dt-bindings.
> 
> Bhupesh Sharma (4):
>   dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150 and SA8155
>   soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to the soc_id table
>   dt-bindings: arm: qcom,ids: Add SoC IDs for SM6115 / SM4250 and
>     variants
>   soc: qcom: socinfo: Add SM6115 / SM4250 SoC IDs to the soc_id table
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150 and SA8155
      commit: 87f67727e057bc54816097d3b8e38a4a0c58e0bb
[2/4] soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to the soc_id table
      commit: 911eed825cd7573c8fa9fa3f348a5a657fa180a4
[3/4] dt-bindings: arm: qcom,ids: Add SoC IDs for SM6115 / SM4250 and variants
      commit: 67d1af1c50a4a0ae48f535126cdfca915ffed29b
[4/4] soc: qcom: socinfo: Add SM6115 / SM4250 SoC IDs to the soc_id table
      commit: f33ca7ec5e5e3a53d5636a4eab270bacac751f6e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
