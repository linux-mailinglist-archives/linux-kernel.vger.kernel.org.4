Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCE5EFBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiI2RXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiI2RXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:23:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E421EB180
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:22:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d82so2016626pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SIbDPYXTiEpHr31cowPm5hEWT0Dsj29GpYNVG6B6LlQ=;
        b=mB8DS4FtbYahqmKbTsOUSTFLoTQRXcbJ3S67QhTIGmqSBDz/tWrFlwMcQ+cr23xX+b
         QjG8yy4p2rhzXPmzYoPpJETh+MOcZ4yLkpS+xe/4UC0kekmTGp2l0FOavxZbRoTOhb+3
         XH0z/AGyy1pyfbaQ0b8WlaXjjULk5lXJ98RdhAuDRK1jZK174zRJLrai1dB3qYm7C9bi
         mfxenLf2PEEAJXuAgS23CChpXtK7E5L++pMmei3EFlv/p6bQLa1s2fnPxLJwYph9MUyh
         Id4k8Zu0gFKur4uSD2lyGzTjCb8tFTcmzTfGvpSNt2i8W6+NVwbl2mPn83HI9mJB9uQj
         Gugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SIbDPYXTiEpHr31cowPm5hEWT0Dsj29GpYNVG6B6LlQ=;
        b=azHVt12eOCAdWRwWnFOl9aAOeEvm4Sxzi0bVI9ydKNXMfBAgqsjgRRyFRRziqUM/lY
         XNNnP9CgfZvDh49H2n8BKukgzb3GOh7dof49oCs/Ria7Zmf9aubnkGI5DJO86L/t0kAQ
         dchfYXRmxD0ue6KkcOYELmxfP9aXkUyH12CKuQlZVTEm1Qvx6vYsq5CjCiCYKem4y1RX
         AiHTK1w8P61wDi1jNjYQhk0tQ1KvfD0YJE+SF4DA1U1VLItq5+/FQOGJsGamTk6zEJz0
         O9ySUXhSavBVD6XsIYIcD/QT9+frZp35J4D+axsV8d/Jgf8Go48fNWHrIXTruYu7lgpI
         t9+A==
X-Gm-Message-State: ACrzQf0bFekad2Wh3iDlAcExKjJYnTj+59iOsjO36IcHVhUHZhsFrJHa
        weBu6YT944ZFn+VbjLo8qmp4dA==
X-Google-Smtp-Source: AMsMyM4AC3DhaeWsDiKxbTYHV9WoijHDEhKnl9Ddx2dx4JeYbpJ/IXYZuywwehHTWBeATWePCuxzFg==
X-Received: by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id h7-20020a056a001a4700b0052e6a8c5430mr4622875pfv.48.1664472123633;
        Thu, 29 Sep 2022 10:22:03 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a694d00b00205da989de3sm36917pjm.17.2022.09.29.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:22:02 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:22:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmays@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <20220929172200.GB3107608@p14s>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com>
 <20220901202517.GB626605@p14s>
 <d1cfa787-9f8e-fe8a-d816-0bd8c3a3244d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cfa787-9f8e-fe8a-d816-0bd8c3a3244d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:02:22PM -0700, Tanmay Shah wrote:
> 
> On 9/1/22 1:25 PM, Mathieu Poirier wrote:
> > On Thu, Jul 07, 2022 at 06:39:55PM -0700, Tanmay Shah wrote:
> [ ... ]
> > > --- /dev/null
> > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > @@ -0,0 +1,1055 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> 
> Hi Mathieu,
> 
> I tried to fix SPDX-License-Identifier to GPL (same as MODULE_LICENSE
> below), However checkpatch.pl reports this as following warning:
> 
> "WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/..."
> 
> I see that GPL-1.0 is under LICENSE/deprecated directory.
> 
> > > +/*
> > > + * ZynqMP R5 Remote Processor driver
> > > + *
> > > + */
> > > +
> > > +#include <dt-bindings/power/xlnx-zynqmp-power.h>
> 
> [ ... ]
> 
> > > +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> > > +
> > > +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> > > +	.probe = zynqmp_r5_remoteproc_probe,
> > > +	.driver = {
> > > +		.name = "zynqmp_r5_remoteproc",
> > > +		.of_match_table = zynqmp_r5_remoteproc_match,
> > > +	},
> > > +};
> > > +module_platform_driver(zynqmp_r5_remoteproc_driver);
> > > +
> > > +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> > > +MODULE_AUTHOR("Xilinx Inc.");
> > > +MODULE_LICENSE("GPL");
> > There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
> 
> Also, changing to MODULE_LICENSE("GPL v2") gives following warning:
> 
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure
> the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> #1115: FILE: drivers/remoteproc/xlnx_r5_remoteproc.c:1034:
> +MODULE_LICENSE("GPL v2");
> 
> So, It looks like SPDX-License-Identifier should be GPL-2.0-only and
> MODULE_LICENSE should be change to "GPL".

Commit bf7fbeeae6db is an interesting read - thanks for pointing it out.

> 
> It this ok? Any other suggestions ?

What you have looks good, in that regard there is no need to change anything
from your patch. 

> 
> Thanks,
> 
> Tanmay
> 
> > 
> > More comments tomorrow or Tuesday.
> > 
> > Thanks,
> > Mathieu
> > 
> > > -- 
> > > 2.25.1
> > > 
