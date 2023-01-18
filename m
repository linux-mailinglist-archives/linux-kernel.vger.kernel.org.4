Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89846716C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjARI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjARI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:57:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7D6794C;
        Wed, 18 Jan 2023 00:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6695B615AF;
        Wed, 18 Jan 2023 08:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95ECC433EF;
        Wed, 18 Jan 2023 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674029540;
        bh=DRMZqxm+8VKTBtBSmErc/hRT5JTMiFP+YpTdCwn9N1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzN6A5uHCY5tZnKzvjTYO1YAKZF1Cga1xxYy4/rtuckYJ7BFxnJU4KHT2bHVKuwt9
         b0p6PNoRl1Py77XOxH+mfj2K++qzQvywDyVnZTOPnPBRV4AWYx0/Bah31lkoP0cwat
         JaIpsLdUsAwC9NwhHvh39TvnWXOFeegtM1Ui6GM6ZRBvospKm7My0RqrX+CS9XgPLs
         p+r3jm4+B+F3qMZp3OA3BfIU/IGr0dsdjvNQzCkSPMd7YnCmeNfqPkBfEwr6C5l1FH
         txAdGl3gz4xDz4LwdDbTwjW3rQB7fSzeEz8K0XorNqMvdutsHhP9NMEmCItHXQneQu
         pNnzH0Z6Na1Bw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI3Yq-0000aa-TS; Wed, 18 Jan 2023 09:12:44 +0100
Date:   Wed, 18 Jan 2023 09:12:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 6/6] phy: qcom-qmp-ufs: Add SM8550 support
Message-ID: <Y8ep/OkG+MJKZ+wb@hovoldconsulting.com>
References: <20230117224148.1914627-1-abel.vesa@linaro.org>
 <20230117224148.1914627-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117224148.1914627-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:41:48AM +0200, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
