Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28465822A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiL1Qdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiL1QdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93121AF2A;
        Wed, 28 Dec 2022 08:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6437761576;
        Wed, 28 Dec 2022 16:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB8AC433F1;
        Wed, 28 Dec 2022 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672245027;
        bh=iGjvJo5vRjcbgBQp34y2hybXCH+JoUYSL42xqvXPfvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQrCsr/RZHU8WhGxbbMw5kQXQ8pbfiGMj50E9vQrHbeAa51eX9FMvWp8Z+huZOvj+
         BTDjzbUqzkM1N3CfmhZyZmc7qVGVR9oOh1kMtYJRlb7FGgWC0Ahh3HWmV5BsYe+rGJ
         eQHI+gCElnv37QkT0RnzrZzC3kRVMAUDdwD2MlS+XwcooP7459FkXY3ud/bRlq0xCH
         S8aJR0uXHAt2zgkk+gg4Kh0JUacFDylKYH+MFBS+HEcnc6b9Tmqjs3WzuV7NPiEe//
         ooqIfFmpEB3TMqNps1WCA7kbqOpZ8KHNmHeNXIbdl7rhhVf03lIq+ph0D3NwqPPpuO
         Cs32X27bfI3BA==
Date:   Wed, 28 Dec 2022 22:00:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Carl Vanderlip <quic_carlv@quicinc.com>
Cc:     Hemant Kumar <quic_hemantk@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mhi: Update Makefile to used Kconfig flags
Message-ID: <20221228163015.GE30143@thinkpad>
References: <20221207192613.2098614-1-quic_carlv@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207192613.2098614-1-quic_carlv@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 11:26:13AM -0800, Carl Vanderlip wrote:
> Makefile was always suggesting to build subdirectories regardless of
> Kconfig. Use the Kconfig flags as intended.
> 
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
> index 46981331b38f..354204b0ef3a 100644
> --- a/drivers/bus/mhi/Makefile
> +++ b/drivers/bus/mhi/Makefile
> @@ -1,5 +1,5 @@
>  # Host MHI stack
> -obj-y += host/
> +obj-$(CONFIG_MHI_BUS) += host/
>  
>  # Endpoint MHI stack
> -obj-y += ep/
> +obj-$(CONFIG_MHI_BUS_EP) += ep/
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
