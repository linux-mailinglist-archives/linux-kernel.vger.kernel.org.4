Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24206021D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJRDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9197ED0;
        Mon, 17 Oct 2022 20:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9430B81C5C;
        Tue, 18 Oct 2022 03:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F5DC43470;
        Tue, 18 Oct 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062399;
        bh=LP8bpf6Cb1KMx5rvVhfDL/6NfoP3tFsnt/oNldrp+bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3MLrV6VvGPvOt7jNQ1Kxq+B2C3AGOc6SiZBhsVG3cYwPTXSh7htyHgJ/tnPQEw0K
         Yc9wxZyZsIwE3LEnA4fqSUj3Iw526h/vzDd8aovZMAlmGh49EiKkRptZnHTxakaP+j
         YsYV71lvN+5cK0LcGyHs0hzAYi8c5vff2/yAmZSRMdBtSpqI+XOW9gjXiXs7tfjcUI
         b9mmf9IV3HKm46N7Wybdg2NJr9IQUsB1FINAq0x4/CfGXVt6taCnB7Zlfh/Mo++meB
         ihwoIYp7jrSeWSjVVE/8I33vYi655sKAd0n+5AagPx22OW2PX69DeEg0hrWfWCAE+u
         F1plrFNJsFmxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Date:   Mon, 17 Oct 2022 22:05:21 -0500
Message-Id: <166606235855.3553294.2604907142030947566.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220915141601.18435-1-johan+linaro@kernel.org>
References: <20220915141601.18435-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 16:16:01 +0200, Johan Hovold wrote:
> The size of the UFS PHY serdes register region is 0x1c8 and the
> corresponding 'reg' property should specifically not include the
> adjacent regions that are defined in the child node (e.g. tx and rx).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
      commit: 8703d55bd5eac642275fe91b34ac62ad0ad312b5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
