Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF25FF295
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJNQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:52:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5051C69CE;
        Fri, 14 Oct 2022 09:52:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h13so5424107pfr.7;
        Fri, 14 Oct 2022 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cx94pH/Te+Ooan9iwnGcSQEFKwEqsCyMjZbllG69d8o=;
        b=VGqTR76opp8m2P+fhRS9m4GiuRxLn2tE3mdIQVwSiBvw9Z/hmLnetV59TcuWYqmzgg
         PvWVm9b8iyXYOr49RIs1LS4r1zKBxgG41qxZveyQmpHm/5rgtYVBiPpcHM2scIBuz7HQ
         DmBHsl9KEwabdzWGxITdy+8MjfBSIN3fKF07xBaryzkSQzC47kukKTll+PLMlDs99oCu
         TYo5wZHrA9Jd7qFdq190iMqrfcRG0//CahSQ4TYRfxGNjtF2lD2fSh/1QOLBJVFOc/K2
         ZYC//yoNPe4E8M/llnVbMHR9uBD+g1nHUvYf5TuK4fth7B3ruQ8X+oXRLO9eiXmh3wU4
         ZaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx94pH/Te+Ooan9iwnGcSQEFKwEqsCyMjZbllG69d8o=;
        b=fWBxzUQfYLTa0B3E80ECHT43ZwIDHrt6QDMdwuSRB8LCvx2YQ8jMwGEIZzUkmzueas
         NhLWPeVw/nwi7DrANG5Dh3InPmBhUi2rm7Ja6CzvJUvRi9/fKyUGbTjS4gfzOspYyNMj
         feL0r0cz0UUHkLlVnJ3IjD/9/B11PhIeuEeAN/msBiHRaPhiC048cpXNYGh8/LeMIh7E
         slkUiZGLjJBFwkajf43fVXwoRFJn/AHQffq98jI5nqe1p+FfqjfRbHxjDUGKwecAIcsG
         DMY9L9SHcX3eS76ywVn8W1NHa2TPJUrtqkWyZtPd8qBeEcv/ZEEVdSJxQSWTSDub5N1s
         2jIg==
X-Gm-Message-State: ACrzQf2TwOvftQElVW/WuaEsWc76TaEY8UbK2xCoY/cVM7Ok2mGbAr6q
        gU1NuDR5kko/tvC63DIFacI=
X-Google-Smtp-Source: AMsMyM68AgsRaYoK3ai6hspVpOpJfxq2UWvuy2GSNI2JmEIm2hdZgspV0xFV0qQJq46eSaYLSwmVFQ==
X-Received: by 2002:a63:243:0:b0:43c:75c:d92a with SMTP id 64-20020a630243000000b0043c075cd92amr5301387pgc.497.1665766369762;
        Fri, 14 Oct 2022 09:52:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y126-20020a626484000000b0056232682a7esm1958951pfb.2.2022.10.14.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:52:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 09:52:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon: use simple i2c probe
Message-ID: <20221014165248.GA258761@roeck-us.net>
References: <20221011143309.3141267-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011143309.3141267-1-steve@sk2.org>
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

On Tue, Oct 11, 2022 at 04:33:08PM +0200, Stephen Kitt wrote:
> All these drivers have an i2c probe function which doesn't use the
> "struct i2c_device_id *id" parameter, so they can trivially be
> converted to the "probe_new" style of probe with a single argument.
> 
> This is part of an ongoing transition to single-argument i2c probe
> functions. Old-style probe functions involve a call to i2c_match_id:
> in drivers/i2c/i2c-core-base.c,
> 

Applied to hwmon-next.

Thanks,
Guenter
