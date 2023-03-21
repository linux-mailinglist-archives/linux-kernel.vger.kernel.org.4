Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A36C345D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCUOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCUOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:35:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4947435;
        Tue, 21 Mar 2023 07:35:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q6so7005143iot.2;
        Tue, 21 Mar 2023 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLIEUjpPIkk5ZzeFs91fzheQ2P/C6YZLsjoyxu0zBSY=;
        b=YmaItWKwyThfHmmzmWbFEwaB6lWSDyG9F3mZkDIntHl7tNMjJp5VZQLtBR11IIoi8U
         3U/Nl2zoVHdXFK9Me1m4Co/z/LBl8yzcGVdbZ9ZIQw4LQVDnVVTc7vVJlkqUkcUouXMw
         Vy8uednSlQJjcLxBhylmkzq+jEiyvY57lOz0mqK7O3jwzJTInmLFaMhnzC/AgaQfiX9R
         RvXDM/PsFZ+KrVqmjpZggst5V6OzRyRfYr+D0mZXIxy6Y3aJRFzSuFNPWxANq1359InO
         TeB7PkaKFBknkgFtvJoN4RLTqlcwPu1TqgW+CWQ9S+exXicIwPSBkcFEO2iT5m7ggwnF
         K85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLIEUjpPIkk5ZzeFs91fzheQ2P/C6YZLsjoyxu0zBSY=;
        b=LwdFNiaymJv4FlHcvxWJKWVbi1ecCMLjWNpEaLpUMC67cgMzL0X1mfKGDf3M+FeJ/g
         7g2X2VsCANE5QWbCEY9eZU76t8CarsvMMWUvVqRCuqhs9VHCtOLz+vf88b8924wqu6Cu
         iqd1cQ3Wj+JE4BcU41ge2DA0pHy6MxIlUvOtr9Q4ooj/sJjhEVwnoQXlqXV2wUqR2zLR
         3sgvaCqm2QUXPRy165RHWVbub9cccJkCDWKGxYgLw7mf8ZfzTxKUcYzXhxQn84wkKogI
         kwFXjxtSJBF2vgG4dMBaETcfEiX7aaVCimtfj2XYc290xO9SPxUjxYCaZmJaOhBGesvk
         9PGA==
X-Gm-Message-State: AO0yUKWbsPynlK+QUpjK/kEecSLDHsePx1ORe4fKZ81liqDejGWCyHrV
        vU/6HEUugGV1Hx8uqoApA7k=
X-Google-Smtp-Source: AK7set80j+wwwROdSByOE4y0Ml39evb+VWSLcs/srYh+mgkN0R2RD0cTX9+qLbvZ7EwqN3uGWL9t4A==
X-Received: by 2002:a5e:8e09:0:b0:758:6d1e:2978 with SMTP id a9-20020a5e8e09000000b007586d1e2978mr841923ion.10.1679409335658;
        Tue, 21 Mar 2023 07:35:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b0074c7db1470dsm3604347iom.20.2023.03.21.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:35:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Mar 2023 07:35:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "Winiarska, Iwona" <iwona.winiarska@intel.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "fercerpav@gmail.com" <fercerpav@gmail.com>
Subject: Re: [PATCH] hwmon: (peci/cputemp) Fix miscalculated DTS for SKX
Message-ID: <b23c180b-667e-4689-a7da-2f8b8902c8cc@roeck-us.net>
References: <20230321090410.866766-1-iwona.winiarska@intel.com>
 <f2fe16cf-3838-df89-958f-c39d1bae81a1@molgen.mpg.de>
 <df6ab72faf9f1484f7f850ad7386f76b60e5bf02.camel@intel.com>
 <ZBmsXYV6jkLiFmJz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBmsXYV6jkLiFmJz@smile.fi.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:08:45PM +0200, andriy.shevchenko@linux.intel.com wrote:
> On Tue, Mar 21, 2023 at 10:29:22AM +0000, Winiarska, Iwona wrote:
> > On Tue, 2023-03-21 at 10:41 +0100, Paul Menzel wrote:
> > > Am 21.03.23 um 10:04 schrieb Iwona Winiarska:
> 
> ...
> 
> > > This is not aligned. Why not only use one space before the equal sign?
> > 
> > Yeah - same alignment problem is present in cpu_hsx and cpu_icx though, so I
> > just followed along for skx to not stand out visually.
> > So while I agree that alignment is broken here, I think it might be better to
> > separate out the potential cleanup from the fix.
> 
> I agree with Iwona. If community wants a cleanup, it can be created in
> a separate patch. For the fixes it's better to reduce the unrelated churn.
> 

I don't want a cleanup. The original author chose the alignment,
I accepted it because I give submitters some slack when it comes to
formatting as long as checkpatch doesn't complain, and I do not want
to get into lets-change-alignment wars.

Thanks,
Guenter
