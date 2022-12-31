Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11A265A530
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiLaOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:52:15 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A02F6B;
        Sat, 31 Dec 2022 06:52:14 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1433ef3b61fso27644451fac.10;
        Sat, 31 Dec 2022 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0+WY80iRNDRnBXULmWsIfhdxD6/IuyE4kKVn64bZwI=;
        b=AO+uJi5Hmp6EvZfQOpRmI8uZGusZ5/Dq5ZSow+WUVpzzGIyI86x8vvTIAjXVFR4j3+
         cMP9PqNf5mopJieq3i581RBK6ZnnI6c/OKKLKAFjxQuvbm81ASAIF/8sqc5WhCd+WcYD
         IH7E7KGOhK0gtJY41qnbMY0xJFlmUpI0gaa71OasAuzSCyolqrP4JTqg4sZvYzrxy/lm
         2wh0ihm8SQ1VUKdT1noDl/9yb/qLpFwKUfiaxN6dGxzJ4nuWxk7kg0Ob7NZA7YIEhP0N
         MwvZpVrK9vojVVTKvme07bxNHheWqH+GcLYEwK+qVIUV9WhiKoaka+TW+UA1sVpgcgrk
         TTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0+WY80iRNDRnBXULmWsIfhdxD6/IuyE4kKVn64bZwI=;
        b=jfvNpCmcO7YqUqoaydrcTKv0JJGRqpwD5+ObaGDSPnjNNn3zY3r079h76U+QJix8pN
         rUHKxP2zPB/Jb7xyGZIhT+8o18iU19gzp5MQa7oN6fxUR5LMCi8HwO0fSNveUoUCthhM
         i7eqYok1MjaYsz4yVzI8X/H793yqy+SPYrksqUpMZfL2ocM0YskBKJ9abu28eFwSJRZ1
         FPB9vGgFrE2+0eXVrI8KjceMRpPdFjeiE+vYWIm+engSKVO93fZJnyJbAiIX4V1oRMIc
         RY5Dicyhx3iyVe8eSHF0DsL/IS4wJ7I+jRq92SeDJ/q6dmPdSArqxeARRc29uPbq5Wbu
         Jszw==
X-Gm-Message-State: AFqh2koyRA9H0wIZWxfIrvC/5xBPgv55AeQ17ovBHEy9wzWWu05U5Oeq
        onC56aD1/TQ6h7Oy4/N/ZxnJhpS8SVw=
X-Google-Smtp-Source: AMrXdXuMLhzij7G+M/SPNFxDi03oNaeY/vu44Eci1RsUHllyC29l9Bn4hqDxz2+wy7hoh8GEj/YNKw==
X-Received: by 2002:a05:6870:3d95:b0:14f:7756:1cbd with SMTP id lm21-20020a0568703d9500b0014f77561cbdmr15415000oab.26.1672498334004;
        Sat, 31 Dec 2022 06:52:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n38-20020a05687055a600b0013b9ee734dcsm10933245oao.35.2022.12.31.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 06:52:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 06:52:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (ftsteutates) Convert to
 devm_hwmon_device_register_with_info()
Message-ID: <20221231145211.GA2280076@roeck-us.net>
References: <20221224041855.83981-1-W_Armin@gmx.de>
 <20221224041855.83981-3-W_Armin@gmx.de>
 <20221224151835.GA569106@roeck-us.net>
 <b0bfb455-f702-7ac8-230f-01c8e4aa2be3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0bfb455-f702-7ac8-230f-01c8e4aa2be3@gmx.de>
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

On Sat, Dec 31, 2022 at 12:40:40PM +0100, Armin Wolf wrote:
> Am 24.12.22 um 16:18 schrieb Guenter Roeck:
> 
> > On Sat, Dec 24, 2022 at 05:18:54AM +0100, Armin Wolf wrote:
> > > Convert driver to use devm_hwmon_device_register_with_info()
> > > to reduce module size by 40%. The non-standard fan_source
> > > attribute is replaced with the standard pwmX_auto_channels_temp
> > > attribute and its special behaviour being documented.
> > > Also export fan present status as fanX_fault.
> > There are multiple changes in this patch which are not related
> > to the actual conversion. Please split into separate patches for
> > each functional change.
> > 
> > While I agree with the fan_source -> pwmX_auto_channels_temp
> > change, it needs to be done separately after the conversion,
> > because it is an ABI change which we may have to undo if someone
> > complains.
> > 
> > "export fan present status as fanX_fault" also needs to be a
> > separate patch.
> > 
> > In this context, normally alarms are supposed to auto-clear
> > after reading an attribute, if the condition no longer exists.
> > Is it really necessary to explicitly clear the condition, or
> > would it be possible to auto-clear it after reading the attribute ?
> > 
> > Thanks,
> > Guenter
> 
> According to the datasheet, the alarm flags are "sticky" and need to
> be reset explicitly. Unfortunately, the BMC does not immediately reassign
> those flags in case of the alarm condition being present, but does this at
> the next "poll cycle". In order to emulate auto-clearable alarms, the driver
> would have to constantly poll the BMC, which would still glitch since we do
> not know the duration of a "poll cycle".

Many chips have that problem. The solution is to either accept it
(which many drivers do) or to work around it by cashing reported alarms
and only clearing the alarm bit form the cache after a poll cycle.
The lm90 driver is probably the most sophisticated of those.
There is no need to do anything special, much less anything that prevents
standard applications such as "sensors" from working.

Guenter
