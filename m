Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E16E34D2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 05:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDPDux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 23:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDPDuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 23:50:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338D213A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:50:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d15so5169580pll.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681617050; x=1684209050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EV7rnGqgJooE9h+THqYmlRcBxwugQCSpvoxAvYNE/A=;
        b=QaOHvAewGQw2YCpt8SdVomtjueUEB4Rf9npQkKcK1CwjYD5Tl+Nm8qVhTe3PVWbutt
         BASIhdjxVHTKQwBxQEqWLZirgs8ezoU1p0PnMPzcWoKjVWngE9SwCvdVUO3C/rHJJPHw
         VJKrPTBNYGieAYQdvUsBqJNE9Q4ADFiHwqthEfvrkixBAciL4BOIbOnmRHh3JS7ntuPQ
         vXkpBp4SLgKdMJNmYf6xjFmI0cLtozC/6lFcsPoblypTNN//GshPVErdwzpDpAjiYGmX
         HjfqfHLMCylQ60BLI8qPG+VFRTcl3BicUVpyoAvajkg0GbxtnBUOzHB56DeoD82n7ZZ7
         PMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681617050; x=1684209050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EV7rnGqgJooE9h+THqYmlRcBxwugQCSpvoxAvYNE/A=;
        b=Y2c+gUIY/ZFsdzGvLbLYWteGtLHAq0Vi9MlmmFyrOZTiZdZNUT8s04cqAgRZYdE6Gh
         EcnBQpkehcPxyR0qhNiREMYt3JgyLLX9E6H2rd1FsvYl1a+BRAy/5ekpDPR4v+5qO6uI
         bkxdAPhFAJioNsYvaSILy9p2rDCTi+9163BJ3/IghqfwxD8bsRb81vBfSuLrPaBcRCQ4
         laqOtoSotDF7ZGkVCUE0yLyiZj1bRMNegRRtTzLqY8y26dpU+lSvQB244yNtWnLLfdkX
         lXzu/ly6wZ/nqZ1Ol/8tqmBr4k3NTPCVSbQDlGasclF7SjeNDdn/0wHaerQgnY3F/udQ
         CCQQ==
X-Gm-Message-State: AAQBX9cvDxdtRUHiGT1mBZ5t7gnGI3bAEXF8KUj1m1BVOt4JMhUgc5i4
        mvK/MGOGJYwOyYA71xRStYY=
X-Google-Smtp-Source: AKy350ZE81+STyKF0GnwRNnbKMaXqxVv54pCFm7VyRJzQ96AFcqUKVg5XTm1jFGnDqNJSJsz+DIW9A==
X-Received: by 2002:a17:903:1d1:b0:1a6:c12d:9027 with SMTP id e17-20020a17090301d100b001a6c12d9027mr2481121plh.56.1681617050357;
        Sat, 15 Apr 2023 20:50:50 -0700 (PDT)
Received: from sumitra.com ([59.95.146.80])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c24100b001a0667822c8sm5308585plg.94.2023.04.15.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:50:49 -0700 (PDT)
Date:   Sat, 15 Apr 2023 20:50:46 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix alignment to match open
 parenthesis
Message-ID: <20230416035046.GA267177@sumitra.com>
References: <20230408165151.GA261885@sumitra.com>
 <2023041516-lushness-neurology-a728@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041516-lushness-neurology-a728@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 05:54:24PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 08, 2023 at 09:51:51AM -0700, Sumitra Sharma wrote:
> > Fix alignment to match opening parenthesis as suggested by Linux kernel
> > coding-style. This issue is reported by checkpatch.
> > 
> > CHECK: Alignment should match open parenthesis
> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> You have sent a lot of different patches for the same driver, with the
> same subject line, but yet doing different things.  I am totally
> confused as to what is, and is not, the latest versions, so I am
> dropping all of these from my review queue.
> 
> Please resend them all, as a numbered patch series, so that we have a
> clue as to what to review here.
>

Okay. Thank you.

Regards

Sumitra

> thanks,
> 
> greg k-h
