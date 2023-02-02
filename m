Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00328687E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBBNDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBBNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:03:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB464273F;
        Thu,  2 Feb 2023 05:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D45DB82661;
        Thu,  2 Feb 2023 13:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCCC433EF;
        Thu,  2 Feb 2023 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675343015;
        bh=7nZ7vEEU2cxHmgw1TBI/DSL6WgN09SclwXUQVkPAxgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvB/5NpzbUUoLHtHm/UWgpeUECI8ScoRC6lISPFfwj3n0GlUUZZeBNE9zpx7J7faU
         kGPDt0+B2bGD7IPZjwGdZGzCCzOx8zpjXQTBLCpptA/AK1SYdCi29OQNKTiBn/uWGi
         5GVgln+H6ZtqwJ/0nN4A1A4m2s3NscKpdFdBgspK3EaEcnJnPzfdKYu40q5yLGvM0H
         g6TGiRUl8Go4eL1UD1U5lNythuSfXV0FsdxmOrpYf5i5I4soFuiP5K2gT0xsIGIusj
         MXC+QuV8gCX0eTdRckMMMq9F3cmn9bOSzQ6GEs1iYn5apeLYS3KGTWhr3fuETyb79V
         QnGbvUbKG0qGw==
Date:   Thu, 2 Feb 2023 18:33:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 0/6] phy: qualcomm: Add UFS support for SM8550
Message-ID: <Y9u0oo597Y1YaSxo@matsya>
References: <20230117224148.1914627-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117224148.1914627-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-23, 00:41, Abel Vesa wrote:
> The v4 of this patchset is:
> https://lore.kernel.org/all/20230117142015.509675-1-abel.vesa@linaro.org/

Applied, thanks

-- 
~Vinod
