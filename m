Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3B6BC0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjCOXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCOXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDDF2310D;
        Wed, 15 Mar 2023 16:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18C561EAA;
        Wed, 15 Mar 2023 23:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6723DC4339E;
        Wed, 15 Mar 2023 23:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923131;
        bh=rK+SlPbDPjVZ39qCrZeKlgUu260uW3VoonEiODgtr5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PS/fszWzWqpXYPI0/ygRoU48kDgHEIvBEY15hqlUlqGDN++bL9gMrqNFCjZxwO2f0
         1ynh6Eh75pTeJHYBODZU5lZsAEa+iNMq91kkvOl89hEkXOQjtWxNlOCVo/NwqSSL6T
         JnCbLaIFrj9eN1NrhROCL6ucLX3ftRAeUB0t7c7OWF71tXQLFhLCF8EyjxGDUJTOSb
         0LN9YydLxvWykhd3Hw9iDpIEum/HfrcHKrCx1mGPxUVeoxDqCGWhWiFU4qjrG0vwfh
         a6x/JvOk9Msf5BpV+FG+5BhhjcZ1jTOjIUFImBeNdPZHhYG7DfokUThw2D8vCDFoPX
         NAoT0IdBf3EKg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH 0/2] QRB4210 socinfo
Date:   Wed, 15 Mar 2023 16:34:40 -0700
Message-Id: <167892332567.4030021.15516080475490437610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315160151.2166861-1-bhupesh.sharma@linaro.org>
References: <20230315160151.2166861-1-bhupesh.sharma@linaro.org>
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

On Wed, 15 Mar 2023 21:31:49 +0530, Bhupesh Sharma wrote:
> Add missing IDs for QRB4210.
> 
> Bhupesh Sharma (2):
>   dt-bindings: arm: qcom,ids: Add IDs for QRB4210
>   soc: qcom: socinfo: Add IDs for QRB4210
> 
> drivers/soc/qcom/socinfo.c         | 1 +
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for QRB4210
      commit: ee6ae544ddfabe60245d4eaee41a7330acd46d94
[2/2] soc: qcom: socinfo: Add IDs for QRB4210
      commit: a11bc4a5b371e05e89c0fba5756efe5788a4d1ab

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
