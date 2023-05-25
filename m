Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1C710AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbjEYLbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjEYLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE2B195;
        Thu, 25 May 2023 04:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E56A764501;
        Thu, 25 May 2023 11:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F37DC4339B;
        Thu, 25 May 2023 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014257;
        bh=WuDnzx0mN7mNBgU7tsgoEX4DNhtKyDb/OxubW6VyA0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GC+ljHC8H2Iux5AZ0GremU5o0Eby4zu6UKKSgNyfTjIWSXgLjXrQrHe/ZBENSdmmB
         rpjFZV7JHHSX4YXl69iH+LCnz+zJjiWyZsi4gcUrfqqj6Lsr+e8lqUfoJjoNAakTps
         ljuQitF4E2r+WIbyJeA2Nh2SzaZjOqCv74oCvYK0m4uf52VeziYlfzc6M5fNWpP2Fe
         Xap4H/8ymCI6J8X54VvkxRvbw/Ubgi+7kF8jut2nUz1Jpb8jvyX3C7v5769Y+oMh8k
         jxFYEeFD3JRntRv8w/pp92/5vkjCRxKCD/W9a+zg8JxGOp2X8wg8HZzO8C3Ou9n9sE
         o6ly+cQMgxEEA==
Date:   Thu, 25 May 2023 12:30:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     p.paillet@foss.st.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: add vref_ddr supply for STPMIC1
Message-ID: <20230525113052.GC423913@google.com>
References: <20230523074206.201962-1-p.paillet@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523074206.201962-1-p.paillet@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, p.paillet@foss.st.com wrote:

> From: Pascal Paillet <p.paillet@foss.st.com>
> 
> Add vref_ddr supply description for the STPMIC1.
> 
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
