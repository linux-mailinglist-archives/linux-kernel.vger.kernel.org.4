Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08C5B7800
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiIMRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiIMRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE25DEBF;
        Tue, 13 Sep 2022 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 570B3B80EFE;
        Tue, 13 Sep 2022 15:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD8EC433D7;
        Tue, 13 Sep 2022 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081488;
        bh=K+qAUyBDaxC6YKW3AVQ5CpGrRVjYD9gOV8IHaBzkstA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxoQPXOH6IgaIYsQhFUZdjqdj9ViQOWdiYFlVKBDTaUIXqm9yWfvO+4cGKtA2dkpb
         S678r77fjvWIVmJ8xR8S/4MUYWzK616Q4si/wk62isEcXtTlS7A9b0QTKPhCb3JQ1N
         baIFYThPDySeeXKLhrOf7jY/uTyUxdw8K5gDu3KzWNlE+8aFWcNdvGJspLK+SXhXLH
         1cqqfTzsshB91Y7XGJWTU97lfUw2LgW2hpbDgUKeCLHFwQQSmaq/+Z9slcQZWOH2dw
         5961Yu+YnQexzpdER7N1fK5mdWnaCxAMPIgGJPw9YxCpC2+vzZFNRKxuc4I/aCUIKB
         xecpj4/Xbx38A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, bhupesh.linux@gmail.com,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: Remove unused properties from eth node
Date:   Tue, 13 Sep 2022 10:04:40 -0500
Message-Id: <166308148202.625876.1117056219578043604.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220907204153.2039776-1-bhupesh.sharma@linaro.org>
References: <20220907204153.2039776-1-bhupesh.sharma@linaro.org>
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

On Thu, 8 Sep 2022 02:11:53 +0530, Bhupesh Sharma wrote:
> The 'snps,ptp-ref-clk-rate' and 'snps,ptp-req-clk-rate' properties
> are not supported by the stmmac driver currently, so remove
> them from the sa8155p-adp ethernet node as well.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8155p-adp: Remove unused properties from eth node
      commit: 00d92171ee142200000a984dd1e3cfe599252ec3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
