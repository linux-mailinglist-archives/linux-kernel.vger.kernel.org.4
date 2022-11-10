Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB80623C63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiKJHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiKJHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:08:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2A18E3B;
        Wed,  9 Nov 2022 23:08:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7EB61D9E;
        Thu, 10 Nov 2022 07:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18549C433D6;
        Thu, 10 Nov 2022 07:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668064115;
        bh=bC3mntiO+4TdnNlSsGW2KWLyVk6VhIwgdCAIZqUmDhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkeaIVavbPyf8nxRsqLXbkYtyY1sHTYZUw2uUmEl+c4xiyNGhmoZsfjeqOQmsj0Gk
         gKT8DrXBwsxLOkyD76kp8s3Av8WO7yfvoF/9RFMids8FrYUKtcb3jUt9PaK7mvMYl7
         uL9r8M8ewXk00smk1QobnnHUoHEs3IUKLRBIixhugdnzasL1qktbslb1wUfCDzrhju
         +8RFeUogxbLRL8VyzGGwhHo/fmUtiotKATFKFgcNS0T/t8wfbr25hWYPkxg6jHhDov
         XGtEUVymgpuweMyfSy7wZZ8Mp+0ScjhvOpMslAxy/JUkmcJgBkBeglwumFHDQNmcAu
         5y+U3VmoHWACQ==
Date:   Thu, 10 Nov 2022 12:38:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq6018: improve pcie phy pcs reg
 table
Message-ID: <Y2yjb5nLgYUhey/P@matsya>
References: <20221103212125.17156-1-ansuelsmth@gmail.com>
 <20221103212125.17156-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103212125.17156-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-22, 22:21, Christian Marangi wrote:
> This is not a fix on its own but more a cleanup. Phy qmp pcie driver
> currently have a workaround to handle pcs_misc not declared and add
> 0x400 offset to the pcs reg if pcs_misc is not declared.
> 
> Correctly declare pcs_misc reg and reduce PCS size to the common value
> of 0x1f0 as done for every other qmp based pcie phy device.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
