Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3905B7A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiIMS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiIMSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B063AA;
        Tue, 13 Sep 2022 11:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DA761550;
        Tue, 13 Sep 2022 18:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D15C433C1;
        Tue, 13 Sep 2022 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663094677;
        bh=Zytat1F3jXVHc8gfFWkMjilhBmLy2eleoKoPE6R/IZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AztK4zp9cgSvfv7Ce9QhBKx77h01V1kyhBJPJkBtQNa7KaCUdrJX71sc6lf0tDViT
         momTR18Y6t/NrSRIok9RtCgQBkkF3bOklr6au096GiF2Te18uXSQY7ItKSS4/GWBka
         bWBRb00FWh7bSvcyW7NjrVI+hk29fUz8JtwWVJPJirOMA4l5nQ7Fb246irIsZHU1Ki
         NbJTD57FXsUaUMvTtmu7Y7PmnKs5RuoBkwDQHgl9E7LdWjxzD7eIa22Azn45QH2JBI
         l+U6cdktbVWL3gNSViGY4q4oruzSbmQnYTVRf3jIkUUJW0Df7AoOCmPY0VmEbOzTnm
         ICgxPP/x3Cj/w==
Date:   Tue, 13 Sep 2022 13:44:34 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        dmitry.baryshkov@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Update Qualcomm Thermal Driver entry
Message-ID: <20220913184434.uticdyotwvvvx43z@builder.lan>
References: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
 <20220912194028.3584378-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912194028.3584378-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:10:28AM +0530, Bhupesh Sharma wrote:
> Since there are several Qualcomm Thermal drivers now available
> (for e.g. LMH, SPMI PMICs and TSENS) inside 'drivers/thermal/qcom'
> directory, so it makes sense to list all the supported dt-bindings
> YAML files here.
> 
> Also, the entry header is updated to better reflect the same.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d213a831133f..e72839f5629c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17043,12 +17043,16 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
>  F:	drivers/net/ethernet/qualcomm/rmnet/
>  F:	include/linux/if_rmnet.h
>  
> -QUALCOMM TSENS THERMAL DRIVER
> +QUALCOMM THERMAL DRIVERS (TSENS, LMH and SPMI PMIC)
>  M:	Amit Kucheria <amitk@kernel.org>
>  M:	Thara Gopinath <thara.gopinath@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
> +F:	Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> +F:	Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
> +F:	Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>  F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>  F:	drivers/thermal/qcom/
>  
> -- 
> 2.37.1
> 
