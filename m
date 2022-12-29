Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC0658DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiL2OKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2OJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:09:59 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A1463DE;
        Thu, 29 Dec 2022 06:09:58 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-14fb7fdb977so15140318fac.12;
        Thu, 29 Dec 2022 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCyGeaN1lQiboSJM1g5OOJQeMMM9+eazmmK/45JBdi4=;
        b=Lil8NtO8O/cGJiBgn0DCQcMQkeFB4C/uNJKOd06YZd5IunkBhYDJKPOgyfULbBVGyU
         psTxILkK3rN2xSnwQgWq12s/Hh8pf5jc+WfsFXzlVYZfILS/z172MY73x1VatwlxJs5g
         CUQf0R1L/zV0+CDO6wWEEG6g/wF7Hwh8tr6USA/MGoVxi0JD0nCxMHmDC6APXa7MIQRX
         fS6CPLxFmTrofuuc0DqYgzsQWjkcppOBrJVaYrI0oGVUNV8WiMLP9oAIIsavbhYYC3mT
         rz8kCpwH4AkNa4Cv3bISlJUn67Ie0V5p+3nFuW3EvhmzbBmb4FdRIFFcteJWXp2okgmY
         YV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCyGeaN1lQiboSJM1g5OOJQeMMM9+eazmmK/45JBdi4=;
        b=AMNR/PHKM7bS4X3QLE6wPDMozRS4NQS/v5O27YUrit1lCsD3Y8urV6vgWzITpqfWIL
         K8VwhFs81jYGgW/avR2HW+z3awSNAgz7jIBlFUJr+X+MCJ2JPhB49JwXNcoN0lmXnkDD
         wOkTpTqJplfxvFUchBfXh0Dw3yWaRc6MdTUAYSiuE0QVh0m7WlEjCPzvVLnjlY89JHgR
         3scexiuWjoaGpr2lKpiFU68e8YPSEeqaYDs89JvveHwgWMyKsYU7I8UbKMMLP4D6nWWb
         YBr4Iab57xAomeBV2TWL7WVDEoxatcA14DeSxMAj+Xk+1uyCV3NVjperm/ILAufGHawC
         5Meg==
X-Gm-Message-State: AFqh2koSKQwsgwoHYCpYsDc3doAF2rcBCHlRkFosN6tZUWm7QOWMF8Mo
        CAsSDjVPaCq8Ynhtl5KYQFI=
X-Google-Smtp-Source: AMrXdXt7K8YJ9es+AXGBPvMg+Ixqjsd1Idk4PDlhyHGTNwp8zs59WJpy7PFRtFowHljKsvW5UzLo3w==
X-Received: by 2002:a05:6870:ee08:b0:14f:fad3:5a7f with SMTP id ga8-20020a056870ee0800b0014ffad35a7fmr5946341oab.38.1672322998011;
        Thu, 29 Dec 2022 06:09:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d39-20020a056870962700b0013b911d5960sm8640432oaq.49.2022.12.29.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:09:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:09:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Update the entry for MPQ7932 PMIC
 driver
Message-ID: <20221229140956.GA18659@roeck-us.net>
References: <20221207173716.123223-1-saravanan@linumiz.com>
 <20221207173716.123223-5-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207173716.123223-5-saravanan@linumiz.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 06:37:16PM +0100, Saravanan Sekar wrote:
> Update the MAINTAINERS file to include the path for the MPQ7932
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1daadaa4d48b..469ff520c479 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13932,6 +13932,7 @@ M:	Saravanan Sekar <sravanhome@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
> +F:	drivers/hwmon/pmbus/mpq7932.c
>  F:	drivers/iio/adc/mp2629_adc.c
>  F:	drivers/mfd/mp2629.c
>  F:	drivers/power/supply/mp2629_charger.c
