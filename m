Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672AA6BC144
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjCOXdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjCOXdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4B4DBCD;
        Wed, 15 Mar 2023 16:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5D461EB4;
        Wed, 15 Mar 2023 23:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746F3C4339E;
        Wed, 15 Mar 2023 23:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923155;
        bh=dJcB4Jfq1RndmSlmxonuTV5MJ5pFS6c8/NXxiK+FAXY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ec6brwlVcwi2rhKCLWQ7TroNSsIdJmFuZxsrbt1jqXjE2n+0/Qk7I5hW/K0c3uYMY
         bi1/fSc9ce7elCDuh8zsKmYhiJ0WhDPXz8EbU+QYXGh5QVUJBg8vbKI6ueqfjibiwZ
         JP4en83D5RkdnoudXcqhD000duOfB/vrKfXqxM+1E/MsIru9d1z+YoZ5UCYvgb1TEz
         tat60ngz+H2+uP0Y45pGbp1oo4+ZLk0MDQ5SSJhzUCd8CXOg8eV94YdryK6ZEZ8E9y
         7EBZez1Bgj4uNDF08W3LOuN+QMRXjWZrPL4ZCzmAyOmjYC26ZdqKOG6+b1+gx0yauX
         hgOSFiyiObKGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
Date:   Wed, 15 Mar 2023 16:35:06 -0700
Message-Id: <167892332561.4030021.10477640058062310133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308123129.232642-1-krzysztof.kozlowski@linaro.org>
References: <20230308123129.232642-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Mar 2023 13:31:29 +0100, Krzysztof Kozlowski wrote:
> The WSA2 assigned-clocks were copied from WSA, but the WSA2 uses its
> own.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
      commit: 6df6fab9320bc9ebdf50136a01e7bf0ee5984c62

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
