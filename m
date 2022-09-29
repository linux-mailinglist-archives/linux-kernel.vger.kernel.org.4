Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1295F014E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiI2XVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiI2XVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:21:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC51332D7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:21:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dv25so5740669ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Lm6VXmur+/4daoRRpAM76RIHFiAfUBxz6IdDWHuOY4=;
        b=opHQOs3rn9EzBtb48ioD7yF3uif3JGhopAZuZ0xk3StZfZoWRuXDIFEccK1DuKuycm
         CIj+XSdBVrmYkE/vF5GZIQjvVJS9zjADbj0bSCaBow/jJl4AG1RcnZ0YaO5nq6y2zTPu
         WjJAJPc6YiyAp9SAtma5yabZkfBxCoVt3BLnR5HSULHrpYa8qoK3fB9M4rF8gPFECRe8
         7jWmcgu7VZipwYA5GHytA3kKji4AklimVGYrbMvD3kqurfh0lwEq8xI2NaWv+I6go+Xq
         cxMpv8H6bD5u4mRCQMgmxG8wZx4U/mYlfrsLojDKokJL4/Djrx0ckT6iB184vZdoxcSB
         kIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Lm6VXmur+/4daoRRpAM76RIHFiAfUBxz6IdDWHuOY4=;
        b=b7CkPPyA3U/U+Jf0x3P8RhvzT8664BOskOFR7TBKgGYDl8r/UEDaoWIu8tRygdIsVO
         EnfXP633R6FLoEsD2oDmhoo5PIVs3wWUWAwAUcbgai7vDoJRX102ah/sU1LhoJmWGbCP
         gSdd29rPEyKuyrd0zhk0jL0RhhRy9RFASnd4w++m+7sZ5NlBtLHlWhqxWdYg3uNimhNz
         mMENTA0fx9sQ8sz4vwT1w5XKm5EmZK7kS9CBTDofjdt6FXuNRypeiP4KXtTSgOwezXUh
         m4AkW3qcqIDyxYUfggqS5cPLo+RJSEgMqow9JRVrZkRandbRjeVTHVJ+c0dg6wwsr5PM
         g/lg==
X-Gm-Message-State: ACrzQf3GKfje1IqJwvusEztgMPVzy6TLG/PfiEdqJ8mAUxZ7Hc7WREfs
        X1Fvs089XiGQfgX5hIFbsoqD7x4gCAHXzFBu6sujAw==
X-Google-Smtp-Source: AMsMyM7ou8R3GEJ4wdix9XuO7815aqFuta7V8VxGDSDUNoMGXaeSv+fUTi446omoon3NurqNc7oupYDZ18/IS4jZtmY=
X-Received: by 2002:a17:907:e93:b0:782:da6:8c47 with SMTP id
 ho19-20020a1709070e9300b007820da68c47mr4501522ejc.741.1664493668489; Thu, 29
 Sep 2022 16:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220708013955.2340449-1-tanmay.shah@amd.com> <20220708013955.2340449-7-tanmay.shah@amd.com>
 <20220901202517.GB626605@p14s> <d1cfa787-9f8e-fe8a-d816-0bd8c3a3244d@amd.com>
 <20220929172200.GB3107608@p14s> <fa91ce5a-8c7e-850a-eede-1f6a61a3d651@amd.com>
In-Reply-To: <fa91ce5a-8c7e-850a-eede-1f6a61a3d651@amd.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 29 Sep 2022 17:20:56 -0600
Message-ID: <CANLsYkzG6REdGepd8pxH7bLWVLSEW_RJDaSmLqAMnGKPR_We4w@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc driver
To:     Tanmay Shah <tanmays@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 13:28, Tanmay Shah <tanmays@amd.com> wrote:
>
> Thanks Mathieu.
>
> Also, I see that last few revisions I have changed driver a lot based on
> comments, but documentation in driver is not in sync.
>
> I know we agreed initially, that I will address changes _only_ commented
> in previous revision. However, in next revision I would like
>
> to fix documentation all over the driver along with your comments. I
> hope it's fine and I wanted to give you heads up so we stay on same page.

I'm fine with that.  Thanks for the heads up.

>
> Thanks,
>
> Tanmay
>
> On 9/29/22 10:22 AM, Mathieu Poirier wrote:
> > On Mon, Sep 26, 2022 at 03:02:22PM -0700, Tanmay Shah wrote:
> >> On 9/1/22 1:25 PM, Mathieu Poirier wrote:
> >>> On Thu, Jul 07, 2022 at 06:39:55PM -0700, Tanmay Shah wrote:
> >> [ ... ]
> >>>> --- /dev/null
> >>>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >>>> @@ -0,0 +1,1055 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >> Hi Mathieu,
> >>
> >> I tried to fix SPDX-License-Identifier to GPL (same as MODULE_LICENSE
> >> below), However checkpatch.pl reports this as following warning:
> >>
> >> "WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/..."
> >>
> >> I see that GPL-1.0 is under LICENSE/deprecated directory.
> >>
> >>>> +/*
> >>>> + * ZynqMP R5 Remote Processor driver
> >>>> + *
> >>>> + */
> >>>> +
> >>>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
> >> [ ... ]
> >>
> >>>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> >>>> +
> >>>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> >>>> +  .probe = zynqmp_r5_remoteproc_probe,
> >>>> +  .driver = {
> >>>> +          .name = "zynqmp_r5_remoteproc",
> >>>> +          .of_match_table = zynqmp_r5_remoteproc_match,
> >>>> +  },
> >>>> +};
> >>>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> >>>> +
> >>>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> >>>> +MODULE_AUTHOR("Xilinx Inc.");
> >>>> +MODULE_LICENSE("GPL");
> >>> There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
> >> Also, changing to MODULE_LICENSE("GPL v2") gives following warning:
> >>
> >> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure
> >> the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> >> #1115: FILE: drivers/remoteproc/xlnx_r5_remoteproc.c:1034:
> >> +MODULE_LICENSE("GPL v2");
> >>
> >> So, It looks like SPDX-License-Identifier should be GPL-2.0-only and
> >> MODULE_LICENSE should be change to "GPL".
> > Commit bf7fbeeae6db is an interesting read - thanks for pointing it out.
> >
> >> It this ok? Any other suggestions ?
> > What you have looks good, in that regard there is no need to change anything
> > from your patch.
> >
> >> Thanks,
> >>
> >> Tanmay
> >>
> >>> More comments tomorrow or Tuesday.
> >>>
> >>> Thanks,
> >>> Mathieu
> >>>
> >>>> --
> >>>> 2.25.1
> >>>>
