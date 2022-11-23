Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33864636C55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiKWVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiKWVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:23:08 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6D2CCA5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:23:07 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3938dc90ab0so167654257b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80FECUBxUdFegKjeWsNqCyoU5iWi51VHxXwc7NeBlDo=;
        b=uLOkELm67Pj8ICSMSuAE32FIGw3wbJOJtLSkE3chVoNtaDuDwYgxvkJBczA1y2RJJS
         JHyZOKwrTEeqFyrRv2Rfkrpf0TFOP+PVMhx2UtQIC8hnZTwIWWMsyzxCI4GeSaKNhsMF
         lC1zWy9sHMdicAokBtDJMhL7LIu4W7e9NIYHOXdhSo64f7cHf2B2ra/IXtBsUabZNl+3
         frG+4QP8pYMimMyEcqUapGVg8JOPSZu5CAM+UgxdHBTemyjW0UVLW7dZdQVP4EnJTZ0S
         FEJH5xQfHeEGDtB6zrx1YRmk1Ob5+PxubdD/ixhqAjkonYngkQXh3aeHfoqIvjo/bd2w
         mJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80FECUBxUdFegKjeWsNqCyoU5iWi51VHxXwc7NeBlDo=;
        b=Y67MxMIW2ml0yrMTTeycNdZQ7E4saWhQnyLWiT6/TmZNsyn343b7pxND1yel5Crgxo
         ltzqAtB0CJd8ujLCOjZtofxGDhuJT/aB4WIzxX1eJ+8W5Os2VHBD7w9/3tESYMVsTQTR
         CLGkuE+xWhPYjBeYiFYB3lQO5T958K4u8Z0rm1/SGN9wQVR/oyoXqyQHnF4PcYn4vaoY
         ccUZEnG10lTMt5lknCEVJz8ptN7DMYIlCcRT2lvPfGOhaDzXfyuFnuMCeOodRrXboilJ
         IdSFy+sohvEypBDeHU2BfO8iilamedRbY3w/dHBAR7YNUX4wXWJBmG3XLgzqIdhbuSnR
         RPJg==
X-Gm-Message-State: ANoB5pnSvyHyxDFJqHDjNj2BPJ3tHZUsUzoWjDNzXowPJnBqsXgSzxZO
        RPcoYE9ssRRYIncZQuLHKgLe+4bdGNVm/WRSEyRVAQ==
X-Google-Smtp-Source: AA0mqf6MQHlEWs88gbqnsRD9Yv59kYkMampxraRXzAUqmPsucry9XnsWum+Xv66YNpMkuExEnefoQ9PgtVZoVQu19Fk=
X-Received: by 2002:a81:65c1:0:b0:376:f7e2:4b12 with SMTP id
 z184-20020a8165c1000000b00376f7e24b12mr11999618ywb.0.1669238586662; Wed, 23
 Nov 2022 13:23:06 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com> <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Nov 2022 22:22:55 +0100
Message-ID: <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
Subject: Re: Intel timed i/o driver in HTE
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 3:38 PM N, Pandith <pandith.n@intel.com> wrote:

> Since the current gpio framework is inadequate to periodic output modes.
> I thought to disentangle from gpio and develop a new hte consumer. Something like hte-libcdev.c

Maybe, if Dipen wants it.
Or maybe it needs its own subsystem.
Or maybe it should be with whatever is using these pulse trains.

Again: what is it used for? If we have no idea what it is supposed to
be used for, we cannot place it right, even less test it.

Yours,
Linus Walleij
