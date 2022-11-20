Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7477B631567
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKTROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:14:48 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D2236;
        Sun, 20 Nov 2022 09:14:48 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso6102587otb.2;
        Sun, 20 Nov 2022 09:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+rkX70e7RE0S7j3/g/2Phldb7Wlk6Lkj7kfdf/nfow=;
        b=b3KmmpqRcxaSufYzxUqr3TIfPcNgr8j0RDuHfwXIpNLiAVtVE1geb+OAWmOrUMxDWO
         p9s9VByqdhbWNTzDps+plo/4UVV+7DUSx/EOJatbhAEEmc5hkbT/ARMigeN+9KnTWZpW
         Of9pC9A6Q79z9yS7EBkT+ITylLPNsVqxEGl4HeFjpZHE7kNdcuM8wJOHHyfgFoNbQZmZ
         TDgLripS0FCvZR5ivXavURNdop1K5Snwf0Af1GbKTWPcIcC6C2IveLE3zHeNxLx4ngA+
         flW3YnSoo23vrfnqatTu9/hq8hSZqUFWjona6EbkwMMVA4jlnx+38ncRqWL2Vw0PyeYD
         Xu0w==
X-Gm-Message-State: ANoB5pn5AYwfsyIpkqPIlPdlsic1f7luonMgroOaiDBdgZVIkAiAKKVf
        5AOhJDxdEcidnLxO2gcvr3jlpAZbwg==
X-Google-Smtp-Source: AA0mqf7cjZEsUZlQYmDs59qSWPEUEPIiBl5AQyT5kP2xNrQSaUWhyCc6yJkzO+Zli3vdjNuwfy/2bw==
X-Received: by 2002:a9d:5c81:0:b0:661:c48b:12db with SMTP id a1-20020a9d5c81000000b00661c48b12dbmr7767190oti.105.1668964487486;
        Sun, 20 Nov 2022 09:14:47 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id b43-20020a056870392b00b0011d02a3fa63sm1392288oap.14.2022.11.20.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:14:47 -0800 (PST)
Received: (nullmailer pid 3214059 invoked by uid 1000);
        Sun, 20 Nov 2022 17:14:48 -0000
Date:   Sun, 20 Nov 2022 11:14:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/3] hwmon: (max6639) Change from pdata to dt
 configuration
Message-ID: <20221120171448.GA3204528-robh@kernel.org>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-4-Naresh.Solanki@9elements.com>
 <20221117074510.qqtjc6h3bnh5rccx@pengutronix.de>
 <81cd642f-c5fb-77ec-a634-5655d5b6088c@9elements.com>
 <20221117091324.h7etwyzckzvpoa4p@pengutronix.de>
 <20221120151946.GA1791682@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221120151946.GA1791682@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 07:19:46AM -0800, Guenter Roeck wrote:
> On Thu, Nov 17, 2022 at 10:13:24AM +0100, Uwe Kleine-König wrote:
> > On Thu, Nov 17, 2022 at 02:10:45PM +0530, Naresh Solanki wrote:
> > > 
> > > 
> > > On 17-11-2022 01:15 pm, Uwe Kleine-König wrote:
> > > > Hello,
> > > > 
> > > > On Wed, Nov 16, 2022 at 10:36:15PM +0100, Naresh Solanki wrote:
> > > > > max6639_platform_data is not used by any in-kernel driver and does not
> > > > > address the MAX6639 fans separately.
> > > > > Move to device tree configuration with explicit properties to configure
> > > > > each fan.
> > > > > 
> > > > > Non-DT platform can still use this module with its default
> > > > > configuration.
> > > > > 
> > > > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > 
> > > > What changed here since v5? Please either add a changelog below the
> > > > tripple-dash for a new revision, or make sure that all relevant people
> > > > get the cover letter.
> > > > 
> > > > It seems you didn't address my comments for v5 :-\
> > > Not sure what I missed but did following changes:
> > > Removed unused header max6639.h
> > > Used dev_err_probe instead,
> > > Removed of_pwm_n_cells,
> > > if condition for freq_table
> > > removed pwm_get_state & instead use pwm->state
> > > division/multiplication optimizations,
> > > indentation of freq_table,
> > 
> > In the cover letter you just wrote:
> > 
> > | Changes in V6:
> > | - Remove unused header file
> > | - minor cleanup
> > 
> > which is too short in my eyes. If you wrote instead:
> > 
> > 	Address review feedback by Uwe Kleine-König in patch #3, patches #1 and
> > 	#2 unchanged.
> > 
> > This would be much more helpful as people that were already happy with
> > v5 wouldn't need to look at the first two patches and I would know that
> > you addressed my feedback and would have looked in more detail.
> > 
> > What I miss is the most critical part of my feedback, i.e.:
> > | My overall impression is that this patch mixes too much things. IMHO it
> > | should be split in (at least)
> > | 
> > |  - Add dt support
> > |  - Drop platform support
> > |  - Add PWM provider support
> > |  - Make use of the PWM API
> > |
> > | maybe also add the 2nd PWM in a separate step.
> 
> Those will definitely need to be separate patches. I am far from convinced
> that all fan controllers in the hwmon subsystem should implement pwm
> providers just to match devicetree requirements. That adds zero value in
> 99% of all use cases. Actually, I don't know of any use cases where it
> would add value or even make sense.

There's no requirement that using a binding means using corresponding 
Linux subsystem. Convenient usually, but not required.

Rob
