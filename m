Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700835C04AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiIUQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiIUQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:50:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47B613E3D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:46:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so4036196pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qkaWQq/e8jMNSc3CfM1XzkMkXBpJAMD7KP0TF5sVgvo=;
        b=Kg/vmSISBltO9JSThpgIOntZuYMQg6jwvL42P3ElY0YzsYBHf6VpGH3Ey6jdLBU5Dj
         /vhxw5JtXE0eOGS0NNtPhIeJTAeCaUFp6C+ZIGqvGZTSU+dBc6nQHRDGvgKD8xNZmYMz
         UDGQjb/KQ+QZOcc/lv1XzxMFteghwrKAJGPwiqHyAbwERHpHe9dlSig6koAnfouQReiB
         J2KtlZjd8yeK34XsQ54n0rSchKidSCQrJa7bmB6DR92SkNDMPn6M7G8dqk6wTLpy7iTc
         qdcK4fs/b7Ul52Yrv3I229DBbHZNQsfeksEoFwqdJ2j5qfPV2bUhdHAaeo+lgB3dwM3M
         /Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qkaWQq/e8jMNSc3CfM1XzkMkXBpJAMD7KP0TF5sVgvo=;
        b=qKpScUVQKt1r8YL+Sd7F3+1xfY2ivlPQnWtv0g08JwnRxN5rgjIecnih10oAZ8mUne
         B7bkY1CwG6r/W6TmGxeTp25YHcSqIn3YCI3+TsMlD/LWtUqQ3f5HYc2DmiZSeN/TSG4/
         1SK0/1wSekyjM4FVZ9ONF64Wf6d8/8PUnEjWzL7Vptt/72zLdEXI4ewOd5lNCVo3Uv1h
         UHwf8cSxJrK5lR7URIdIRKS1ViY97HvIMcY50nbEtdytJaQrWJ8mzw1Fgd+qj7KypRy4
         dGcOJ6Dx6A/HTdDg8ZwoRVwXhRqEkg0hLzkBA0XJOx1mYZ1XottDd+XdnoH53euTKJmm
         4HQg==
X-Gm-Message-State: ACrzQf2xC9nM+XDqgCTVqhoeG+L/DS0bbpd8FYhn76p2gqljZASlKwNK
        VedU+dlBg7nk7YHTxgCTNuy70w==
X-Google-Smtp-Source: AMsMyM520JcZa8QuhYyGM8rmRgLlx/UzkQXp9ryFxU5lO5mllWpZFfL3rtuH4+ms04r29p/Pau+oWg==
X-Received: by 2002:a17:90b:3903:b0:202:affa:1c9f with SMTP id ob3-20020a17090b390300b00202affa1c9fmr10689948pjb.27.1663778787032;
        Wed, 21 Sep 2022 09:46:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v127-20020a622f85000000b0053818255880sm2368380pfv.193.2022.09.21.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:46:25 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:46:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] arm64: defconfig: Add Coresight as module
Message-ID: <20220921164622.GA1124503@p14s>
References: <20220921140535.152627-1-james.clark@arm.com>
 <20220921140535.152627-2-james.clark@arm.com>
 <YystQ3pw3uBpi0CT@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YystQ3pw3uBpi0CT@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:26:59PM +0100, Mark Brown wrote:
> On Wed, Sep 21, 2022 at 03:05:35PM +0100, James Clark wrote:
> 
> > +CONFIG_CORESIGHT_CTI=m
> > +CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
>

I agree - integration registers should not be enabled by default.

> Do we want this turned on by default?  According to the
> description it's a bit dangerous and it's exposed via sysfs
> rather than debugfs.


