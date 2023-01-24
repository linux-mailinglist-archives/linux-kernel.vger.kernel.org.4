Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5AF679432
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjAXJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjAXJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:27:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E242DCF;
        Tue, 24 Jan 2023 01:27:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz11so37407653ejc.0;
        Tue, 24 Jan 2023 01:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri9z+xYMt218fYVVMTgtEzsjvMbOGDhhgvVh2Oo1De8=;
        b=W3K8YVr1IJt2kf6zQVyQ0lGjB39bSPnyPcWb1aNfRHJ783tH83bdr066LTuIyrmqsn
         DIvSkmkZrv9W0yhKsQNDUSSbQ3+9+iizwuMhTNIUejhs0ZUwKrYmu96D1DpGbM5LiBtF
         gnQ1PhxzsRv2Kg6yKKTliJgTlQUNDYyiaSFqlNrELEL6cd6FjVTI88A6MJONnJ8Nyxu1
         i9MOX0WG9VaPY+iM8uukCbe4ceNudde0DLGP3Ok2YlgjdcBW3w+bVCFVJSo5Qd2BWidg
         Wg4cCyV1sMdO490g3XrGW0N95Rk8PqiSQ1rsd4j61wHE0kDYL5J43uptI/vWj9w97lOj
         QCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri9z+xYMt218fYVVMTgtEzsjvMbOGDhhgvVh2Oo1De8=;
        b=lLiFodZCRnYfWV9njZZBBtDX7Ugzi689hqFYD+VpKK6oFoDqUYqObwEeiN2VQAF6HR
         W49TLy15FgFazTQ5mulE6hRE8pYBTC8C6jGzf50h2w+29Tws47BP9DF4Km9Ogo/wpl6T
         bkvGeGM9o9CGan2YE8KNx94L77tAo5hKORf/zHhIB5IVfNiVMMPvXnjcVn0YzHWXxUFk
         SgxZ1JgBnxN+hycpP1nPvzD0W/Dor9I3Djj2gBVoN853RPa3NATP2wdtAkMlAnoA+M+8
         yQhbOtiH4bRsFzNwRrNAYoDwZ3CXqCN/ndTB4zJI9ixwWebBRdJKVmFN76gJTioD1M2S
         pH1g==
X-Gm-Message-State: AFqh2koTWXl5MZ0gOg/fXx07o21f80cQR96bpjYwhg0BJWWc64BpJF6G
        2DQO9ij0qOSIjhUb/5bICN5wHuW/Wa3LBg==
X-Google-Smtp-Source: AMrXdXsUj1glqQxDmzX1OGu4Y3daRhi/uusOo0IVPnQ+CKFKRQvRm9/clO/fhoqEcq77C00Yj1So7Q==
X-Received: by 2002:a17:907:c319:b0:877:609c:edc3 with SMTP id tl25-20020a170907c31900b00877609cedc3mr26701799ejc.18.1674552435983;
        Tue, 24 Jan 2023 01:27:15 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id fx18-20020a170906b75200b0084d35ffbc20sm639419ejb.68.2023.01.24.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:27:15 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id A8861BE2DE0; Tue, 24 Jan 2023 10:27:14 +0100 (CET)
Date:   Tue, 24 Jan 2023 10:27:14 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: amd_pmc module not autoloading on Thinkpad X13 Gen 2a
Message-ID: <Y8+kclibAb32JCIp@eldamar.lan>
References: <Y80NXKyaj25CtSBt@eldamar.lan>
 <MN0PR12MB6101ACCD8A5003CBB4BEF58DE2CB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y81Ja5Y/tgPXk5FA@eldamar.lan>
 <MN0PR12MB61019EC33FA0F91C0E79967BE2CB9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61019EC33FA0F91C0E79967BE2CB9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Sun, Jan 22, 2023 at 03:34:55PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> Salvatore,
> 
> I don't think we have a bug here. The reporters said it's working
> for s0ix.
> 
> It will only load by default when the system is set to Modern
> Standby/s2idle mode in BIOS. On Lenovo systems they call this
> "Windows" sleep mode for some systems.

Thanks, reporter confirmed that it's actually working (possibly just a
confusion initially on testing the scenarios):

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1029356#74

Thanks for your time looking into it,

Regards,
Salvatore
