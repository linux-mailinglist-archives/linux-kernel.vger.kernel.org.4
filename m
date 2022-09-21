Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A05C00E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIUPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIUPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:15:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D6844D8;
        Wed, 21 Sep 2022 08:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A162CB83049;
        Wed, 21 Sep 2022 15:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A554BC433C1;
        Wed, 21 Sep 2022 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663773325;
        bh=ZgGtY+gxyrSFBWWVVjjmrO/psm/X9jtqA6gftQjRxkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHRIjCQ9f/O/stpRENKKXsc6lbeicjaDTezcqLw3qL5f4eKB9pB7s5z4j5i9Ojf4x
         Sv6+kwyfgC27X0m38q7Py4e09VSQGTBRbPTo84BA88nVgsnXJVFTKjTXLAabhbBTR4
         xUD00K+t1T2XGMaeyY8UXjqwhSa7tWOrJoWzlx5aRmVnn1+j+I3qARqTnN0fZZyROX
         lFlszNrDxKpX8+HvvP6F2rI/GvWM6ubtmf+zXckjMt0Yo/3gXX8TbQOQyBpR3rdCPN
         DFcJWYrGWpxkosSAjzzRJ1gIvmDVUXIq8ctKDm8ghuCXoNyW0s1+K4IC4iGgq0oWGV
         36FL9PwBYkPgg==
Date:   Wed, 21 Sep 2022 20:45:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <YysqiefYFYC13Ykm@matsya>
References: <20220914165212.3705892-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914165212.3705892-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 22:22, Vinod Koul wrote:
> Hello,
> 
> The is version 5 of support for PMIC v7. I have added a new property
> qcom,bus-id for supporting v7 and then add driver changes for v7

Steve,

Can you please get this in for v6.1 ?

> 
> Changes since v4:
>  - Fix David name and email
>  - remove trailing line in binding
> 
> Changes since v3:
>  - rebase on spmi/next
> 
> David Collins (1):
>   spmi: pmic-arb: Add support for PMIC v7
> 
> Vinod Koul (1):
>   dt-bindings: spmi: Add qcom,bus-id
> 
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
>  drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
>  2 files changed, 231 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 18c42f8d23426d3f4048df89523aa47203c3493a
> -- 
> 2.37.3

-- 
~Vinod
