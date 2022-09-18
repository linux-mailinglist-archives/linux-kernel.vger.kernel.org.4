Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38375BBE8D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIRO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIRO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:59:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1416640B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:59:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so59226523ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wghU3mvgI9A299vgW/vb1F2JNbCLJJLboYCMtsmtiHo=;
        b=NS40DWp84BpkS+F4VFw1TgVC9rSCVjAo2xNR7CuoBz7u4+bXQErZLfVwbQm66jYySL
         mifjjzOaoXNSioviJDP5aDJH8e2mKxGkyTWPhVG0ZyDXxxrbWM+ZtLdu0BchQQ4+QX3l
         8f4LkpYTjhZxBN4LDVbINIeeoJAPMWv/thGjQPc3Gn1NmXlF5TB1AixU5EiuCxc5Ej6r
         OoY+PLSe0erMM7Slal0CiASMO1y6mAN03oK6QZS83+mzQJBdA6j2w+9I+0xi0KypLwNr
         9Yfv+EYbK80IwGF3zBOmKJA7/PvwV1ByavsCVa/dZyM0eVlepCoZoh8K+juW1gYQVx2C
         H/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wghU3mvgI9A299vgW/vb1F2JNbCLJJLboYCMtsmtiHo=;
        b=XNq5EdLALJbQb1kN8LUWehliAvTy9X14kxmIkSXd3j8+sg/Le0IPurDncSC8hAdKyL
         lg9r9tk7mCJUnsrk1V3jlYzLRiiDsbjvG2Te6QOHhufW7LhS+xLfNuqyZvs66gMyATmh
         T9750WfXxbUjX1Fy/Sqd27UUASGp7Fw70Er3PotrNWJzdwvAv7oSmyHe8Leh++DGY2BW
         iiQM+q+P1J1liQ2Cdflxn69N05/ZVyVqy6PgedlOI7MXYHVmOLPdAEuXLAOoyrCChq9M
         5vtyqblzHX0cvVK4MT8Dbfx83dm2597nsUYdVEhLjblei2LnVo9s3MeQ+Hic7l80nUHn
         bOrw==
X-Gm-Message-State: ACrzQf1OpR8e3XWlSIsyDi/TQm35o3oQLty8SxDWboA84OLlSsBm/yxp
        N1PYXGVbcV8Q0OQXkPPwY4w=
X-Google-Smtp-Source: AMsMyM5IusEaWMtQcAHZrMW326zxUzmmApsDfzrx4Lgh510Dr5Jqj8Dviq3l1XTDKdVqwryoRjGg6Q==
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id u1-20020a1709064ac100b007803448ff06mr10026107ejt.403.1663513193507;
        Sun, 18 Sep 2022 07:59:53 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id h15-20020a056402094f00b0044e7862ab3fsm18091851edz.7.2022.09.18.07.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:59:53 -0700 (PDT)
Message-ID: <2239be8b-8dd1-0e82-7e1e-49b94b89b052@gmail.com>
Date:   Sun, 18 Sep 2022 16:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: fix CamelCase variables
Content-Language: en-US
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220918113041.3805576-1-vvidic@valentin-vidic.from.hr>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220918113041.3805576-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 13:30, Valentin Vidic wrote:
> Fix checkpatch warnings for variables: LinkCtrlReg, DeviceID,
> RevisionID, IrqLine.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 26 ++++++++++-----------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> index 1d992d5c4e17..7a9a24935da9 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> @@ -16,11 +16,11 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
>   	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
>   
>   	u8 tmp;
> -	u16 LinkCtrlReg;
> +	u16 link_ctrl_reg;
>   
> -	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &LinkCtrlReg);
> +	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &link_ctrl_reg);
>   
> -	RT_TRACE(COMP_INIT, "Link Control Register =%x\n", LinkCtrlReg);
> +	RT_TRACE(COMP_INIT, "Link Control Register =%x\n", link_ctrl_reg);
>   
>   	pci_read_config_byte(pdev, 0x98, &tmp);
>   	tmp |= BIT4;
> @@ -33,28 +33,28 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
>   bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
>   {
>   	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
> -	u16 DeviceID;
> -	u8  RevisionID;
> -	u16 IrqLine;
> +	u16 device_id;
> +	u8  revision_id;
> +	u16 irq_line;
>   
> -	DeviceID = pdev->device;
> -	RevisionID = pdev->revision;
> -	pci_read_config_word(pdev, 0x3C, &IrqLine);
> +	device_id = pdev->device;
> +	revision_id = pdev->revision;
> +	pci_read_config_word(pdev, 0x3C, &irq_line);
>   
>   	priv->card_8192 = priv->ops->nic_type;
>   
> -	if (DeviceID == 0x8192) {
> -		switch (RevisionID) {
> +	if (device_id == 0x8192) {
> +		switch (revision_id) {
>   		case HAL_HW_PCI_REVISION_ID_8192PCIE:
>   			dev_info(&pdev->dev,
>   				 "Adapter(8192 PCI-E) is found - DeviceID=%x\n",
> -				 DeviceID);
> +				 device_id);
>   			priv->card_8192 = NIC_8192E;
>   			break;
>   		case HAL_HW_PCI_REVISION_ID_8192SE:
>   			dev_info(&pdev->dev,
>   				 "Adapter(8192SE) is found - DeviceID=%x\n",
> -				 DeviceID);
> +				 device_id);
>   			priv->card_8192 = NIC_8192SE;
>   			break;
>   		default:

The only thing I do not like so much is that the comment with CamelCase 
"DeviceID" is not changed.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

