Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9263F5E95DF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiIYU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:28:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379D2AC52
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:28:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m3so6523052eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JmEF3VgAAVi7+Y0Pygy9FB9gwwriHYaTSr06fWVaI4U=;
        b=bceifiwsv8+fZQAElyZEagn9YVXo4HwAkTnSEn819W3+sGGtqHDCL56F7izJ55uxce
         jfK3Fa6WPswh0xsRDyGJtnrtmArwrzbvGLaF2vEbERlxWKfMF8VVSXfzHp+VSBk3wnqT
         edzyrDy82QlJlrUDatTzDaPz5h8jJyGauiEAGdOgyZyUw4BCONCGw+5NwWWsJlpsscKc
         oR3gu9mZ2P7OPoF+je6Rhfthk/3HI9+0jJ1FMQqXOtHD9zb94QqqIkMEhZOx0MB8xvSI
         n5LKFZKgHg3eVEXy/agcwx019Np+O0+fzpadXdJSrw+TB56Rym2B7w+YRYi+PSr9e9U9
         AJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JmEF3VgAAVi7+Y0Pygy9FB9gwwriHYaTSr06fWVaI4U=;
        b=KDKnXihva/+Ppyi7SvG0E6OKOCs742/CwpMysVURbxLk34i9voqmX1K4VjXa21AeX/
         AcSrhm59UW6NGwLenBN74aXoxAHDu7TyQOAon/C4sjzmdGQREL2weh1NKyJwQ75ODKV+
         yGa+AOUMnqyX3A1F1ni6CuuXHAaBHccZATfLmjqd1okkudwkwYXiTO0SiOYiScsZfh+X
         juwct9reOrAIhZJwtgaW+E3Nh/EngZfzstqI15dPEXumqoCSiHvAJyiEvVADrPGytr3t
         5luxNYm7VpuX7mJasZVn8MHxxrdH71i7aaKBuQZPCrCrGbmdPOGm+i2gKVuvW9vnK6h+
         feAQ==
X-Gm-Message-State: ACrzQf3DOymy7hV924j+mmfMXyRxWXgm/aZ2MZb5lucIyxkazHLFbuov
        Q87ur8mIqy4TQ9IL9l9BpoYVTxNm0mg=
X-Google-Smtp-Source: AMsMyM6rtfy7z/6lCTkdGP7UvSbT7xcpDG20JYu+B98QVQEN3IRfeNIv91caaB1bANdfarmgm4834w==
X-Received: by 2002:a05:6402:42d4:b0:443:4b8:8cba with SMTP id i20-20020a05640242d400b0044304b88cbamr19076510edc.3.1664137717571;
        Sun, 25 Sep 2022 13:28:37 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709060c1200b00780f24b797dsm7348011ejf.108.2022.09.25.13.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 13:28:37 -0700 (PDT)
Message-ID: <47fc8e27-e71f-99cb-e765-26cd3d8c26c5@gmail.com>
Date:   Sun, 25 Sep 2022 22:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: rtl8192e: fix CamelCase variables
Content-Language: en-US
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220925123810.2492865-1-vvidic@valentin-vidic.from.hr>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220925123810.2492865-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 14:38, Valentin Vidic wrote:
> Fix checkpatch warnings for variables: LinkCtrlReg, DeviceID,
> RevisionID, IrqLine.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
> v2: rebase on staging-testing branch
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 24 ++++++++++-----------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> index 886bf4ba2adf..81e1bb856c60 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> @@ -16,9 +16,9 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
>   	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
>   
>   	u8 tmp;
> -	u16 LinkCtrlReg;
> +	u16 link_ctrl_reg;
>   
> -	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &LinkCtrlReg);
> +	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &link_ctrl_reg);
>   
>   	pci_read_config_byte(pdev, 0x98, &tmp);
>   	tmp |= BIT4;
> @@ -31,28 +31,28 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
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

I do not like that the dev_info messages with DeviceID are not changed 
as well. But that is a formal thing.

But the patch is working:
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>




