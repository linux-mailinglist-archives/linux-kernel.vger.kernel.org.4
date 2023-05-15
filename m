Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA71A70225C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEODbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjEODan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297D2D55;
        Sun, 14 May 2023 20:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD436175C;
        Mon, 15 May 2023 03:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62311C433D2;
        Mon, 15 May 2023 03:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121359;
        bh=D60Dvtwd6JBzVGgPkUcmwldqY7HeCNEK1rR8BxSCcas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SceqkGC9YOo6UpPQfWeXb427B0Se6ScAuTaFmM20fUDXlx3rw8tqVgECaqTmBYc28
         eYHdRp/1uFCvD00UkaGNOaXU30a7EwlQiBQf6viCfNoJazgMqJVri9+1IeZBx6YMEI
         8HrB8M1oJFkf5La2lYfBshZq1zeAbHbUnbeegHW3X27Exg7VrJKiwVCMZhwC5dnqLP
         ja3ybFVh3P5IH/5Phy4JBBsFLCaKgDYrw2gmt8RmG/HruwUUAC81E35U+iiIDo1qKG
         YOU28kIBvC1ttYV5ky+a5O8ZpVhZ7lTn49vuojnt3Wx6Gg7g5ICuB5f6tIJsNVGj+/
         hDxikxVy0b/Yg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add the PMU node
Date:   Sun, 14 May 2023 20:32:58 -0700
Message-Id: <168412158454.1260758.7993153891695865472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414123016.176457-1-brgl@bgdev.pl>
References: <20230414123016.176457-1-brgl@bgdev.pl>
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

On Fri, 14 Apr 2023 14:30:16 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the PMU node for sa8775p platforms.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: add the PMU node
      commit: 86c96823d4b5f0403d0418b89c614682a01ce28e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
