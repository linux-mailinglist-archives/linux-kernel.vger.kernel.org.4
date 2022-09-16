Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A55BB0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIPP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIPP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:59:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB12B4430;
        Fri, 16 Sep 2022 08:59:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r18so50411920eja.11;
        Fri, 16 Sep 2022 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0eOqMrsEPlo8wf0Kb/kFeTkXHYSCkhl/zlKEpzl3GUU=;
        b=gmfWSQs3LmqC3lPZz6lRjnb/2ggeGEEHLUBxU1OLJpLVLP4A7WoN54WvtK4PvmRago
         DJ9oDYAR4M8yLdwcNKjJEqQrw2KjX20ioimVvQ+pgFXJsBbEYSKFYcD1ILYkCEV453tS
         Jfaoy30nBTJHahfepA+1qFu9skK6DuZMvkYFOgrXUAmvuznVk1HPyPUVudHJNgg4w5Et
         KKyGAz2tHFco7JBCiAn2U1suRoxbPiErP4StNYJdTevGeqKHu606Uj/UithsHYQkYqLA
         kw+V+dTqrFrMDlXCZZ63vPwUH5+R8XvRfjoVwMeH5wmpQvpWeNardHMOtp444A5WTeee
         rnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0eOqMrsEPlo8wf0Kb/kFeTkXHYSCkhl/zlKEpzl3GUU=;
        b=JkQRYSw/PTIy/Bd6zX23yGhTAjAAdtPfmGoncjIOhMXK/SfB6ATnbyTbz1tBQRVb5B
         ZZnQ/hAu0WAsUuDkToFgEQNL6lUrQBmgNwdUDEi1iKKLQ2NAZ+RWtXm0cd7mnEpR4XCd
         cxlLs08kqPciYSaOAXyfimwQC9pqR1iqImrEmSDYrpy5ooNAEdYzX9Agi56xNtTUVsPk
         k72TYEcK+BrcaFG+bOkmVNGRgB2zcuoD4dGyeJuuEkQ5UXZmsMVUSPHtV21dQPqPeMIh
         MDoCGZITgeBRUmTMrtkYnL7XJ8rfb1XJTP84z1sFXIZB7JzS8DSatdo8RwwyMxrvlXoe
         SU5A==
X-Gm-Message-State: ACrzQf3aty7EchuUTgvHORbDoPNMevHP87vFaPc5wehhvW2k1sv8JFuZ
        dQNw2KnPHptClZGvZWPIiaA=
X-Google-Smtp-Source: AMsMyM7d7ML3/4FI57O/qGJTqdztH/7vmNeZp6oIqHbhq3K1SwPiHviL8jifBmzWTeiZcHwH/46FZQ==
X-Received: by 2002:a17:906:7945:b0:73b:e605:f31 with SMTP id l5-20020a170906794500b0073be6050f31mr4090685ejo.129.1663343959977;
        Fri, 16 Sep 2022 08:59:19 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id u3-20020a05640207c300b00451e3160451sm9437675edy.89.2022.09.16.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:59:18 -0700 (PDT)
Date:   Fri, 16 Sep 2022 15:54:31 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Add sata version of the quartz64-a board
Message-ID: <YyScN7ezdngpRxq/@lab.hqhome163.com>
References: <YyRxx4zovhMMeQYV@lab.hqhome163.com>
 <2385186.jE0xQCEvom@phil>
 <2145659.NgBsaNRSFp@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2145659.NgBsaNRSFp@phil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review.
While I wait for the dt-maintainers direction, I will fix the patch following your advice.
Shortly, I'll post the new version.

Alessandro


On Fri, Sep 16, 2022 at 03:18:28PM +0200, Heiko Stuebner wrote:
> Hi again,
> 
> Am Freitag, 16. September 2022, 15:12:10 CEST schrieb Heiko Stuebner:
> > > +&sata1 {
> > > +	status = "okay";
> > > +};
> > 
> > I guess you may want to disable the now unused usb controller?
> 
> ignore that ... I just realized that is was kept disabled by patch1
> 
> 
> Heiko
> 
> 
