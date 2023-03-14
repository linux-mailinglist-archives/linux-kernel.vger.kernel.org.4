Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97E6B9168
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCNLSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCNLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:17:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED89F04A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:17:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so60471404edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678792621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyMYTE8eRVWxXGxDN3qi6ovP5SN8DKhbGCFcirh8c68=;
        b=gYVni5rS+U0D3XPXroPjMejaXjUCgJYQue+8nXmM0hbi6lhCI1VcxmbnKS+hiuTamt
         RC2WeKXamlUyZ8HLt6b+G0enmZvwqk34qKNb2OswI1SlizapZY242VV4VpdgRK2zAfGm
         Wr2hX1BB0yOy6KvMaF0CtOVuzxY4Pxpyn6Yi/IXic4Pfs27QQ29/aw/aXjdOlXJsS6XF
         JR2T3I/DsYGTkVk5dy6Owqkm9qjkNtBoeJboMe3C6LDW2Q+//sYbFPpyxOlJ012bCxzT
         86j+GjQy7rhOi7RAshikVzvFiXBYiXWy/rP0RFyb3t8vqfU+XR3xdCR0X3D0bfnDKuTu
         +Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyMYTE8eRVWxXGxDN3qi6ovP5SN8DKhbGCFcirh8c68=;
        b=6Ej8nhRLn6r/vRNpEMj2yL6Rvozq3Tf74wlJukMEDGR1s0leGqdYmNzSClJXx/H8xv
         O3AGVPKWmDk/nYGxJ51Po3UEVdPbFoE9kPsUvzq7Q9YqzceAb5wWJaiDUEBY9fcZxGLO
         rO+EtuGS7JIRLBG4ELakf5qiXXDNF9oe7avP0+nOtcxMHp4Yx4GBdyUbw0nhaMKnt9G0
         EoKOK+RkqCEt9aZVpDhJVrhQ9aaVIHRaYlVcZrGbwSvBopCwm0fpfiCd5NkfX4txKtqS
         VELGJSXSvi14r90ueiEIcrErVvYsjKyy1Z8UEmb8Rk3MziTzP2PyIYAn+IhwvwNmR2eV
         L96g==
X-Gm-Message-State: AO0yUKULFedCAR8YdpX1R61tjP5hX4ZTNuFZ71MR5znnlJCFgVSUbj8L
        G+T+ts17pjVlUrO8hGNorcaydA==
X-Google-Smtp-Source: AK7set/G4w6NSTJvqWAmj5mHdKpnG7SBlJNvbb8K+gxbWYCEVR2R0MuarC2DZo6U0jwmmUYaFYUcug==
X-Received: by 2002:a17:907:b9d4:b0:8b1:7eb4:6bea with SMTP id xa20-20020a170907b9d400b008b17eb46beamr2029236ejc.38.1678792620771;
        Tue, 14 Mar 2023 04:17:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id r9-20020a50c009000000b004c13fe8fabfsm855903edb.84.2023.03.14.04.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:16:56 -0700 (PDT)
Message-ID: <d9f5a8da-575e-40b7-4871-b73374421245@linaro.org>
Date:   Tue, 14 Mar 2023 12:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] PCI: rockchip-dwc: Add rk3588 compatible line
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
References: <20230313153953.422375-1-lucas.tanure@collabora.com>
 <20230313153953.422375-3-lucas.tanure@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313153953.422375-3-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 16:39, Lucas Tanure wrote:
> RK3588 can use the same PCIe driver as rk3568
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c1e7653e508e..435b717e5bc6 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -354,6 +354,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id rockchip_pcie_of_match[] = {
>  	{ .compatible = "rockchip,rk3568-pcie", },
> +	{ .compatible = "rockchip,rk3588-pcie", },

Why do you need new entry then?

Best regards,
Krzysztof

