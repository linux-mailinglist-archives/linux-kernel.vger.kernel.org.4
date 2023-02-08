Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990968F1DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjBHPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjBHPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:19:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA14ABD4;
        Wed,  8 Feb 2023 07:19:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j1so12817227pjd.0;
        Wed, 08 Feb 2023 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAQNOEz10pxYOiqzmdo+aFdBHrodKxaja7D61VZvZKE=;
        b=oqqNObI/+zH/weckd22QIJi/PdQzGXPqbnwY4J9NNpBNndsiw16oTiWxgpwIdTYWqd
         Ag/szpXZVx9hMihQ/QMqMdTU1Tu+0o8s6va66pQiqFDy3Y1XOCcvXHSsIuj77HfhnKMR
         mTy1+IQdRMdorJSmG2kmbPHhhUU30VPDBDEjxWdpenk5vgFkpA2VrsnklAzByPenOSvq
         2RDwIjR4Skx7EmtrmEbW7eR1hLq41tuAGdvkgqwqi3FhY7Vhen311EE0mR8xvsdYpHjv
         /0mt7GffAJVmoktocxQ1MXhXBinUtNpokjEBnyGrEgutXCC+FgKSgKDG2HJyj593LOox
         PbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAQNOEz10pxYOiqzmdo+aFdBHrodKxaja7D61VZvZKE=;
        b=4UNGlk2EDV3UBu7yFlPijf54+TsiFhAbonjyWPyqtmLr9aON6cVebguWMvJkDcGuhZ
         1GIAq6uQ/Ls4FdqtF0pzkeJczMbPD7wOSqcZpo8/jxpX7Rf87uZwIe9+GyRywaJFlE8d
         9NoksgJzOLNRQFDfz1DPCaMwCnYgjQgpHP5teIVmfyvlmJ2rLw4scUvLeviXwQhoC/sc
         3EDdk30WqavMi2QeMcEi8YceNBSdbE0B78AanwCoj3ABGCLYaGSTuuz0eIYuerlN2sap
         rOLFbCCJV7ooQ8g9k52FzwzvnblVVohHgYWSnsVswybOsgxWafUKE5ZcLSG+c0KeM6EP
         NvcQ==
X-Gm-Message-State: AO0yUKXFOU92Tbd7/PnktsYGgFrnkhv0Of2hdJjIFcgRUvSAFzlO+C0y
        wKfZ+1EXxKPb1KPB+eAEeA0gis4VMOxjGg==
X-Google-Smtp-Source: AK7set9V9PKCVFfuxJLJob6eUGmN7YBPAEC6D+gaORlW+/r0IjinF8MZNXvfykcPKXrdgnmXcaU5OA==
X-Received: by 2002:a05:6a20:6901:b0:b8:8a94:5bf with SMTP id q1-20020a056a20690100b000b88a9405bfmr8472613pzj.21.1675869584507;
        Wed, 08 Feb 2023 07:19:44 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm3317995plb.132.2023.02.08.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:19:44 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Thu, 9 Feb 2023 00:19:39 +0900
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208151939.meya6c5gayspvmtr@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
 <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
 <20230208150306.ve2pnt3pvlmf5wbu@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208150306.ve2pnt3pvlmf5wbu@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:03:06PM +0000, Sudeep Holla wrote:
> On Wed, Feb 08, 2023 at 11:43:27PM +0900, Kazuki wrote:
> > On Wed, Feb 08, 2023 at 02:16:58PM +0000, Sudeep Holla wrote:
> 
> [...]
> 
> > > I was about ask you earlier as why can't you implement just system
> > > suspend in PSCI where the last cpu just calls WFI if you are interested
> > > in system sleep state. Or you can implement CPU_SUSPEND with an additional
> > > retention state which enters PSCI implementation just to make sure there is
> > > an active cpuidle driver and the s2idle state machinery works as expected.
> >
> > The machine I have (Macbook with Apple M1) doesn't have PSCI.
> 
> Well, if we are allowing to boot on such a system, then we must allow
> adding a platform specific idle driver. It may be useful once we info
> to add deeper than WFI states.
Hmmm, I thought for arm64, non-PSCI idle drivers were prohibited? Or am
I mistaken here?
> 
> > I guess we should ensure that systems without a cpuidle driver
> > will not suspend maybe around here then.
> >
> 
> Are we ? I thought were making changes to enable it. Or are you saying
> we allow to enter into such a state and render the system unusable, if
> so we need to fix it.
Both as I mentioned in my first email. Apologies if it turned out to
be confusing.

Thanks,
Kazuki
