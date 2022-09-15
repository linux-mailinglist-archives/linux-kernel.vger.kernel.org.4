Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA45B9907
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIOKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiIOKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:44:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B912A81
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:44:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso21990356pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=07v4zbEzufVQlHmt2+/sJ50/ZMRE6Qz6ji3huDCoe+c=;
        b=XPSq37HbUwRk6/ZKqfzw7fC79WapQcJu3974uXF2r2vuDx32u5kKSAirqz6ZfRqDaq
         bJ3CnVfjUMk+VIYF2TMbLLkEWBi2YjaXqlU74E/qjbYEHjOSekBuS/t/MEWv12E8AnBU
         d7BLJzH3stGHBOG2IDxhP+Z5dx2qDu2+ltg5wewWxv5S+NHX7pCrDLJfRnkhQrmNmGXU
         fljn6LAubpnyyc5sfXlSbaoSU8O3fMH7i2hifO9Xf05exReevm56IKaSwJeo26JvwFW1
         5WxBZUhB4V/6Q9B5kIKuEYl5tw+709wGmurvSWT5G2jLgyLPjvugMYyb6gIeK3Qb1YA9
         vVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=07v4zbEzufVQlHmt2+/sJ50/ZMRE6Qz6ji3huDCoe+c=;
        b=Ny9x/U797Q7a+nmrYuoh993NQ0sdp1HP37fcQkeAPVZLGg7T6KedSrGU9hI9eErF5q
         HcqN36BtYatdFPcoXD09eqjl1OkTNLR3djzbem3AsZeYYSzcKubfMQHZ0WPmjYC2vs6s
         JXZ8yo1cE5l7eQkxxoKeF/xFDNfFIauMBaeXRgdVJNZSL+pPwGQyggkeWlYYkeUnx0yb
         N7soJyfYfxDUxGhDePCPxeeZeCdxVe8fg2FH1yRWPQH7fTMlY9XzZH6sVqB39PpOADXF
         1QqdsAyS4av4Bfh+EiOsnQmOlmoI9H/mEnXf/ndMQqoz2hqCygrXTIM66EQgmESOvP9L
         pR5g==
X-Gm-Message-State: ACrzQf0jLx96JDHcgJmM2r+1HzM/uAQl+dVhMTOnlEt9YbXBTlOytiMR
        p9xIrTHNatAtv/nChLgI0kjZ
X-Google-Smtp-Source: AMsMyM7VBmu9USW8hF859gkazJNpshvgjoy7xHkTmzeVjnr2Qx0mWMBDhaNX1AHTrh7RIjnGYRsg+w==
X-Received: by 2002:a17:903:41c9:b0:176:b9df:c743 with SMTP id u9-20020a17090341c900b00176b9dfc743mr3706763ple.162.1663238689598;
        Thu, 15 Sep 2022 03:44:49 -0700 (PDT)
Received: from workstation ([117.217.189.193])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001750361f430sm12525172pll.155.2022.09.15.03.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Sep 2022 03:44:48 -0700 (PDT)
Date:   Thu, 15 Sep 2022 16:14:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220915104443.GC4550@workstation>
References: <20220913101237.4337-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913101237.4337-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> not having an endpoint connected to the slot is not an error.
> So, changing the macro from dev_err to dev_info to log the event.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Since the PHY issue that could happen during boot up is rare, it looks
okay to me treating the log as INFO.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 650a7f22f9d0..25154555aa7a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> -		dev_err(pci->dev, "Phy link never came up\n");
> +		dev_info(pci->dev, "Phy link never came up\n");
>  		return -ETIMEDOUT;
>  	}
>  
> -- 
> 2.17.1
> 
