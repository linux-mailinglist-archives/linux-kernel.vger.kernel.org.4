Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6613674058
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjASRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjASRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:51:42 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6793CE;
        Thu, 19 Jan 2023 09:51:37 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id n8so2369459oih.0;
        Thu, 19 Jan 2023 09:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88CEYayVz9P+ewRhEaNDKsu17wnm0wIpWAPH9sbb1IA=;
        b=EEnKd0O6AIC2cl4W7Xht0Ia5DcY00mMYZ88d5zfHtf/K5dlK2QHlMiS0GT6/aKhXve
         JktxSD+UPZlrfreqBodlCse2AHqRKyL+WdLj/w20VoAX+1kuZ9Bpu/OgVGpQhlzWbunB
         Uc7myhQVGcxPXMtcHmN2ULO3pnHmhK1uw++TucduEYSWookBYGkpMKteK6t7Z26Lj5Ae
         9uCp1cPMfA08SRm7eeX3mLARonRv0QqwEhFIcKCEI/IvGNf7dAGyA/XUz4/p8s6RevAL
         CxRGgpegXBmUR3vwCFjmBfBA2FdrQFpRd2wgAwNFfWhzFxy5E1xLDi8b2ZhEdj52fDOp
         /YrQ==
X-Gm-Message-State: AFqh2krUO71vl0X4OmWnWL5t0aGIvLETHzvwLEwk2HEWsrj9oBC14ipt
        IyKy0mwaVmW7nymsH6YFgA==
X-Google-Smtp-Source: AMrXdXtXwGBPksu+/jJLSzW2KkFBYnEBDrD8ZPFZET2oHNBgRWSgf6Q/22TJC6L0+eIw9JAIJ04kvA==
X-Received: by 2002:a05:6808:200e:b0:360:de9c:98cd with SMTP id q14-20020a056808200e00b00360de9c98cdmr6659825oiw.49.1674150696295;
        Thu, 19 Jan 2023 09:51:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c6-20020aca1c06000000b0035763a9a36csm2159422oic.44.2023.01.19.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:51:35 -0800 (PST)
Received: (nullmailer pid 2099339 invoked by uid 1000);
        Thu, 19 Jan 2023 17:51:35 -0000
Date:   Thu, 19 Jan 2023 11:51:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee@kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <20230119175135.GA2085792-robh@kernel.org>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:32:26AM -0500, Jesse Taube wrote:
> Some devices may want to use this driver without having a specific
> compatible string. Add a generic compatible string to allow this.

What devices need this?

Is that no specific compatible string at all or just in the kernel? 
Because the former definitely goes against DT requirements. The latter 
enables the former without a schema.

> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index f4c8fc3ee463..0bda0dd9276e 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  };
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{ .compatible = "simple-mfd-i2c-generic" },

Simple and generic? There is no such device. Anywhere.

This is also not documented which is how I found it (make 
dt_compatible_check). But this should be reverted or dropped rather than 
documented IMO.

Rob
