Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B366B239C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCIMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCIMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:01:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57272DDB27;
        Thu,  9 Mar 2023 04:01:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f18so1961751lfa.3;
        Thu, 09 Mar 2023 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678363278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tve5bNapQ7T+NjlxZdJFJ3Bc6H97qUyB+SM+FU5DWVQ=;
        b=FkrcOqO/kd7xRILlJt7gJ7NSnBuntrKA2dOVWBjLPm2dBnK08E+kNQ0tKzJSq/cMeJ
         SUZ1sP5mO9tH5KnXp8tWMVOcKZAyXgI+5z23F6ZVA6bVW2o1rvm9sQBB899VM/IdV4vl
         eN/KpTgZPBjrQ8yQgXo6XDhftAxw/mvimnAXE/vCc6vwGOoiFDGm48mWAk8nL/cnoCKg
         E7EO79JIW1F7vOUKSHcmW/1UpRnKX5Pj+c3SKLYGrG2adpTAl8M2jMY4rDZl0odF6xbE
         ETANbntU+IpbC1BN8U4yT0LDQsBzO+JUTeotGTBxkMfAh7KtbE8wMcEDMVDst923HET3
         QYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tve5bNapQ7T+NjlxZdJFJ3Bc6H97qUyB+SM+FU5DWVQ=;
        b=OFoZvsA+0oPd1NlmtqWOiDJPQ6YEnPtPBAXaiMwq2U06UEgFDKHu7RCtCMxErzduEM
         PQj5MgeznIeOUP1Yv5qGBMTDdurLgsG9yhdeyxRKdW5B+WX6APEgwiXCVr2MOCBkmFJl
         lUF9527xWGUWhkwSyThZfLoknrNR1oMAnbo21hDxAl69Z6H+DTxm2itYJMYCn33fIrws
         ADbqK4kd8STduvVKlkxoQ0h1FGMEyJQzEoKiSVPQik28m4l+SNatkNX2iT4JffxqWfXf
         LSgeMTsDM1puCaPgZTTTrUghK6bKI50DKL4m5DBUSc00t+xE0vAoXtQTAr5qClLfMUFM
         eaPw==
X-Gm-Message-State: AO0yUKW6IOMv/8KkJtUKsLbsEK6J1nobTnrkLmacUInIuMQz3lfwXZaM
        wYX16Pbve1wKCf+82yKPm3Q=
X-Google-Smtp-Source: AK7set8nOD0+LqZdtetn68p5GlyqtuV++nZo9ciY9AUQ+HN5vjNrkAFShtUUA5gctanxxG7F1gNjwA==
X-Received: by 2002:a05:6512:25b:b0:4dd:ab39:86e0 with SMTP id b27-20020a056512025b00b004ddab3986e0mr6766687lfo.27.1678363278424;
        Thu, 09 Mar 2023 04:01:18 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512390300b00498f77cfa63sm2606748lfu.280.2023.03.09.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:01:17 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:01:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, ntb@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ntb: idt: drop redundant
 pci_enable_pcie_error_reporting()
Message-ID: <20230309120115.fbcjqtbm7fxvlojg@mobilestation>
References: <20230307203021.881866-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307203021.881866-1-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Tue, Mar 07, 2023 at 02:30:21PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.

Thanks for the patch.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

BTW seeing the pci_aer_init() method fully clears the AER status don't
you think the pci_aer_clear_nonfatal_status() function invocation
should be dropped as well?

Note the patchset doing that was already submitted a while ago:
https://lore.kernel.org/linux-pci/20220928105946.12469-1-chenzhuo.1@bytedance.com
* particular patch:
https://lore.kernel.org/linux-pci/20220928105946.12469-4-chenzhuo.1@bytedance.com

-Serge(y)

> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..7192ff59dd91 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2651,20 +2651,18 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	}
>  
>  	/*
> -	 * Enable the device advanced error reporting. It's not critical to
> +	 * The PCI core enables device error reporting. It's not critical to
>  	 * have AER disabled in the kernel.
> +	 *
> +	 * Cleanup nonfatal error status before getting to init.
>  	 */
> -	ret = pci_enable_pcie_error_reporting(pdev);
> -	if (ret != 0)
> -		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
> +	pci_aer_clear_nonfatal_status(pdev);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Failed to enable PCIe device\n");
> -		goto err_disable_aer;
> +		return ret;
>  	}
>  
>  	/*
> @@ -2692,8 +2690,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  
>  err_clear_master:
>  	pci_clear_master(pdev);
> -err_disable_aer:
> -	(void)pci_disable_pcie_error_reporting(pdev);
>  
>  	return ret;
>  }
> @@ -2714,9 +2710,6 @@ static void idt_deinit_pci(struct idt_ntb_dev *ndev)
>  	/* Clear the bus master disabling the Request TLPs translation */
>  	pci_clear_master(pdev);
>  
> -	/* Disable the AER capability */
> -	(void)pci_disable_pcie_error_reporting(pdev);
> -
>  	dev_dbg(&pdev->dev, "NT-function PCIe interface cleared");
>  }
>  
> -- 
> 2.25.1
> 
