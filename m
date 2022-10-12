Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7745FC6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJLNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:54:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65311A05;
        Wed, 12 Oct 2022 06:54:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2038073pjq.3;
        Wed, 12 Oct 2022 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W9PYnqE39FVIWPtx23Tk+GKt7RrA3d27Hf1sKJ7FqQ=;
        b=UozGTu6YyIYkQQoEJ9mpP/ZP9EXBHkczxk9/ST0nwoYD5CXIifS1ksxnJ1z/XlD8Iv
         DnXdQDc3QD5BBRt/elc/g3MpiMLgBMvz47ICmyWRQUwskodG72pwSD0FvOfnFwxR4gNT
         0Nv0c1ZEd9a//beEgotrvzkxpjlIn11dOn3z2tb/KyektIxRp3AMw9k8NLnKlAlJMfAZ
         ZW00APC6mm2Rgc0I9F6MtW+FIkz4pX/PUfBY7jV2tV/BJmcb7sxvPImZbSg5MEvkpS1A
         VQqSmx00wjuq8wBY7o0koQO6OL1C+JRHOCj4nWqmVRt4CML82YQgP9dT0rzT4hrO952e
         5MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W9PYnqE39FVIWPtx23Tk+GKt7RrA3d27Hf1sKJ7FqQ=;
        b=SQhryKpLsYaX+V71pp5IBRS91fGROUxv/7os8zPiWHgrsgXKzeuG1h65Jj64zfWZF7
         7IWKDWKmgKqZuUTkekP2/70ehkVv/MtkZPZTvesxMsSC7mN+na3607EqGVL9SsRBxFjU
         FVWv6ZGoOiN5LAjzN6YaOmb9VKq9ondgpTxA1+7NNbQLWl0M6m+qyaPYjySpxdYiGfgy
         WXgjgmyQWuPfwEgaEIPPGwtrAVnHxdQxO6ihwyPHrsYHr0MUr0P4ycIs0snez01/u9Zd
         WYDeUz0NOYr5KhIzXviB+EcmGQ8eDE6CauVwSFOHg5dQBJ08MgvHkwChpVexFJp4YgAu
         3OAA==
X-Gm-Message-State: ACrzQf0IbnWsera2MGpRInyopnRNiIL6leMZLFxUL8vtXllgRpW9BRlE
        FESDsb3b3u3wTjARLSj6nYc=
X-Google-Smtp-Source: AMsMyM4GsOvqLbKi8bnipwZei9bul2eCxZ/xzZEAA7xagdE0qfFC/6Wvyu2i9hoIPRYsb/0vz6gCvA==
X-Received: by 2002:a17:90a:f2c3:b0:20b:b75f:2f9e with SMTP id gt3-20020a17090af2c300b0020bb75f2f9emr5408380pjb.43.1665582890145;
        Wed, 12 Oct 2022 06:54:50 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78bd4000000b00562f6df42f1sm8959924pfd.152.2022.10.12.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:54:49 -0700 (PDT)
Date:   Wed, 12 Oct 2022 21:54:39 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
Message-ID: <Y0bHH06cbngWk4mH@sol>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <Y0bBXSHyxpdTGxoU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bBXSHyxpdTGxoU@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:30:05PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 11, 2022 at 08:01:27AM +0800, Kent Gibson wrote:
> > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > -#include <linux/gpio.h>
> > >  #include <linux/gpio/driver.h>
> > > +#include <linux/gpio.h>
> 
> > But moving the gpio subsystem header after the gpio/driver is not
> > alphabetical ('.' precedes '/') and it read better and made more sense
> > to me the way it was.
> 
> Okay, I will move it back.
> 
> ...
> 
> > > +#include <linux/seq_file.h>
> > 
> > I wasn't aware that we use anything from seq_file.
> > What am I missing?
> 
> 
> Eventually I can answer to your question: the commit 0ae3109a8391
> ("gpiolib: cdev: add fdinfo output for line request file descriptors")
> is what you are missing.
> 
> That said, we need this patch.
> 

Ah, yes - totally forgot that one is in flight.
That makes sense then.

With the gpio headers retaining their original order:

Rewiewed-by: Kent Gibson <warthog618@gmail.com>

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
