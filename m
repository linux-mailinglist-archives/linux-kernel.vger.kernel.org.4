Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C475EA9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiIZPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiIZPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76F73919;
        Mon, 26 Sep 2022 06:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D7A60DCC;
        Mon, 26 Sep 2022 13:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C30C433D7;
        Mon, 26 Sep 2022 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664200352;
        bh=muvgMToPpctJMbwWwZJxgkDnIo++ePMK9lMYLqFPlIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B0H2ubdHhiW9W/vLpPLRdDlwUDU6k5KRIpztcMHD3wKLGQZwVIbs38DigKdXy7JR0
         LI+1shqyKhd5UfJXulwW9prr0+8D1GIF2MuwFcNU41xK43tIFYoZR7DFXoH9QYAVo9
         k3l86M+jqD7Xj+Anwv1jfY9fWgutBdV9V7LoDlr+62kSIXK5WwyE/NZXuwCQFRszqR
         dhtXUfNRmxldj987FWjo0FHNRMang2vWMy3B9vstYQVfAb67RAIARA4cGY1IEh0NDv
         PbFRrzung6f7IitgWz9b5vypgAapq0OWgrsjMoksfvqbhN+1mMC4XZDi8RLGU0Qs3/
         CwqyzQFiX9t1g==
Message-ID: <704b3687-d102-711a-0686-833ddc95b77f@kernel.org>
Date:   Mon, 26 Sep 2022 15:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] usb: dwc3: st: Fix node's child name
Content-Language: en-US
To:     patrice.chotard@foss.st.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jerome Audu <jerome.audu@st.com>
References: <20220926124359.304770-1-patrice.chotard@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220926124359.304770-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 14:43, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Update node's child name from "dwc3" to "usb", this fixes
> the following issue:
> 
> [3.773852] usb-st-dwc3 8f94000.dwc3: failed to find dwc3 core node
> 
> Fixes: 3120910a099b ("ARM: dts: stih407-family: Harmonize DWC USB3 DT nodes name")
> 
> Reported-by: Jerome Audu <jerome.audu@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 166b5bde45cb..6c14a79279f9 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	/* Manage SoftReset */
>  	reset_control_deassert(dwc3_data->rstc_rst);
>  
> -	child = of_get_child_by_name(node, "dwc3");
> +	child = of_get_child_by_name(node, "usb");

While this is a ok, the proper fix is not to rely on any other device
nodes or document it in the bindings.

Best regards,
Krzysztof

