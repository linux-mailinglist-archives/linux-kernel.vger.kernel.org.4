Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C7623C80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiKJHQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiKJHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:16:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3031FB3;
        Wed,  9 Nov 2022 23:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6799561D79;
        Thu, 10 Nov 2022 07:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41228C433C1;
        Thu, 10 Nov 2022 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668064557;
        bh=zkEbitGh6NuYdSKumNuvy2niopfYizRVWE/5Z5xVl1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSgZ/lGN4y30dhemGiIjrjRTiFDJhKGw0dZ+XODNdI5UmHUgWpj9lmTKq/yfJHUCn
         po1o/W0JJghhEOaAMkra8cQWYHe1sobakzIoDp6P8ons0loJ5nPlZvc3OdB4DAQUQN
         jeo4uLSzeQi3nPGWlMkQbEmuaBYYJ8pwkoM1k97Qe4NzkSiCFxd1rjEPauY3arsJZq
         Mcvp1tU+KtBR4iAmuT4t0gqmIe3rKKJb4FpoVwK/c0uClJ0udGtgRRYi7zrgXbv2OW
         zLHAjYacQnn7n2OiEY0/Il/JSEKmgWnXIQUBuz21qcHLOmdXz9trVg/M+h8pLLJOHP
         D5kDtgtbtkIlA==
Date:   Thu, 10 Nov 2022 12:45:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: qcom-qmp-pcie: Fix high latency with 4x2 PHY
 when ASPM is enabled
Message-ID: <Y2ylKQvPhLEyRusv@matsya>
References: <20221102081835.41892-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102081835.41892-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-22, 13:48, Manivannan Sadhasivam wrote:
> The PCIe QMP 4x2 RC PHY generates high latency when ASPM is enabled. This
> seem to be fixed by clearing the QPHY_V5_20_PCS_PCIE_PRESET_P10_POST
> register of the pcs_misc register space.

Applied, thanks

-- 
~Vinod
