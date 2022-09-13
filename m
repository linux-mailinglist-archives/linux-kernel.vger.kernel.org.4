Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC665B7962
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIMSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiIMSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FC85F8B;
        Tue, 13 Sep 2022 10:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3CD6153C;
        Tue, 13 Sep 2022 17:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B3C43142;
        Tue, 13 Sep 2022 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663090838;
        bh=B7oGOaWd2RGDT26f5fnBk21I7+zmp5Eg+smfvCn/Y+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7PFeIqCElucLRJP2yjLvSQZq+11WQ/MPIkLHcX+smGJKAA6pPTBTWtL+TI4z6Iur
         pKes4LpNCe26TZjdBQhatpG7nT0moigtvbcYXSC7++xL1LKtye0jCEVTCamqEE78tB
         mTntBQXmfxe2fFzUgrwGe052UYIWSTqwe5COO1E2PLwTlyQeG1v6UcwVglu31AEy4U
         rul6BRxaK/Ve8wF1CEUqU497e40XmYfSgQfArQnw3Y7Fz3XOlSJjiv4xhYvkezHszu
         uphSnz7eqvXmSsfxJoguaCShWiYpqTso4VB635th+52Y7euZZYuKUaX9Txk60r99Y1
         MUcecbAm8fL4w==
Date:   Tue, 13 Sep 2022 23:10:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, dan.carpenter@oracle.com, grygorii.strashko@ti.com,
        rogerq@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Add support for QSGMII mode
Message-ID: <YyDAkSwaiOdNgUV4@matsya>
References: <20220912085650.83263-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912085650.83263-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-22, 14:26, Siddharth Vadapalli wrote:
> Add compatible for J7200 CPSW5G.
> 
> Add support for QSGMII mode in phy-gmii-sel driver for CPSW5G in J7200.

Applied, thanks

-- 
~Vinod
