Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677E68A2E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjBCTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjBCTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:25:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3E99D58;
        Fri,  3 Feb 2023 11:25:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB92AB82BA4;
        Fri,  3 Feb 2023 19:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB02EC433EF;
        Fri,  3 Feb 2023 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675452299;
        bh=4MPBHegzmk49iNqcfU40g+kZ1YnrD76IoXK34U+qWbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/AOXMCX6uD/lVAQFvpWtVQCzWy8W31YSuBIKd0tETUWHftcBIE8whvu5zvVbivgg
         cowMQuDtmrjBS8DgiFuDqOFj82QwPk3HOCnkjaAYiKkUxdK/xnhSJlEIz6rd90/PGT
         Fp9kaeYI9V7CUTefKZrhxSsohJhaMHYQ6Z09dNEGoD1pXltPNVnbFeKGIey9bi2ppT
         wGS2YXobypUK2UOTPE1bnKQII8SppKM/JFylhPlf1B68SV3piJpJk6nXb+z0xaCMTm
         u6eHipAk1tTODyfAJCMJHhHrsAZ98hGtLdzwnri8ud/OzqrWuANrAnUFxWm07GEiHE
         n08eM41YGQZoQ==
Date:   Fri, 3 Feb 2023 11:27:18 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/qcom* to ARM/QUALCOMM
Message-ID: <20230203192718.eyuvmi7kniwulv63@ripper>
References: <20230203183115.2836316-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203183115.2836316-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:31:14AM -0800, Elliot Berman wrote:
> ARM/QUALCOMM support currently includes include/linux/*/qcom* but is
> missing a few Qualcomm headers directly in include/linux/.
> 
> This effectively adds following headers directly under ARM/QUALCOMM.
>  - include/linux/qcom-geni-se.h
>  - include/linux/qcom_scm.h
> 

Seems odd to have these lone files here...

Would you be willing to push these two files into
include/linux/firmware/qcom/ and include/linux/soc/qcom/ instead?

Regards,
Bjorn

> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2c3d471fe8f..752cddd73bf8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2724,6 +2724,7 @@ F:	drivers/spi/spi-qup.c
>  F:	drivers/tty/serial/msm_serial.c
>  F:	drivers/usb/dwc3/dwc3-qcom.c
>  F:	include/dt-bindings/*/qcom*
> +F:	include/linux/qcom*
>  F:	include/linux/*/qcom*
>  F:	include/linux/soc/qcom/
>  
> 
> base-commit: 3866989ec2c319341e2cf69ec6116269b634a271
> -- 
> 2.39.1
> 
