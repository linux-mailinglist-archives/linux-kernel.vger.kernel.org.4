Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD53721FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFEHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjFEHpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:45:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627921981
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:44:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so9119105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685951046; x=1688543046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IIAm/QGH5D34mPOrZ0A7kq9U8fRJWOS1vfhra1EiAg=;
        b=Ail3x848jzNrgAm+lkmozQHROIaPSUYq7BTEXa0JxBOWs53+eReFWae8flpur1cCYw
         3BihlaAg69E8z8OP0QnU+kPciJ5yvHBaynn56p5LR7hEc/0YlhuXl5hBZxTJ0Gyh0I5v
         1u/MeMweiWdwapRep9Z/jqnvFKq/OfOF3+YwjzIUoYczQva1kPuYn5S2+buy+0wPfcmE
         NsuSqcm76SxuY/LwtdcMZbOD2fdv2MneAthAWDKkBMwso5/5VmzZLMu1FpT/DpqtalMm
         gsQBFAk1X/ByFfpr+ukZbWcfXgSxMHT3IIVbC23kSkCHLCvnciYP6hICRbmvTTRtTgg4
         zsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951046; x=1688543046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IIAm/QGH5D34mPOrZ0A7kq9U8fRJWOS1vfhra1EiAg=;
        b=UC+DPekB7+3QWUPU9uwuE0stpAwkK4CYFM93eEKuwCP8zq8OBCNti5jiKGkYSHnAjm
         +nz7AJznBnEjTlsUj7X7m/mwxTgjEv0vZFfc3hMmK7JLhtCSJLR2j1l6scwDgcMSv2iC
         IlK/b+5BUKzS7kN6ZLB1r4MDzRwsm7042rCVifWouUZsd3xcgcwQHSqsYnLblUXA0CTC
         UXXcTledhNjA9Ifem1uHZ9rVwrwov2jX4WlzHGp9z+P3OAfwOVkn4GOLEV1va5OM8Szn
         cE232bbO5yDNUd6/Qt0wBOiXZxxZ+AC41F0ps+yEyZCqreMRwfKSdiVHEBCBVtWuHhE2
         NAqg==
X-Gm-Message-State: AC+VfDx1WvbD1fomZLp5U5rieYZE5IWTNxZhIpO2IjCUPDMxOrd3LMYA
        YtYnR8M5ygxwhXQ7/cHa40LvUg==
X-Google-Smtp-Source: ACHHUZ7aR3uBe/aIXeteicbDiRnfCAHYnhLZ5OgqnDklU03uBbyhNTIpK+fRXL+oVsR9Ltbt6rwAFA==
X-Received: by 2002:a05:600c:24e:b0:3f5:fc21:5426 with SMTP id 14-20020a05600c024e00b003f5fc215426mr6610806wmj.41.1685951046262;
        Mon, 05 Jun 2023 00:44:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003f31cb7a203sm9998668wmh.14.2023.06.05.00.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:44:05 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:44:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild@lists.linux.dev,
        Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: The robot is broken (was: Re: [PATCH 1/3] USB: serial: return
 errors from break handling)
Message-ID: <dae2eacc-23f6-43d6-8238-c633090d67b2@kadam.mountain>
References: <202306031014.qzAY3uQ6-lkp@intel.com>
 <ZHyGd5BRjUaOdYyF@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHyGd5BRjUaOdYyF@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:41:27PM +0200, Johan Hovold wrote:
> On Sat, Jun 03, 2023 at 10:40:42AM +0800, kernel test robot wrote:
> > BCC: lkp@intel.com
> > CC: oe-kbuild-all@lists.linux.dev
> > In-Reply-To: <20230602124642.19076-2-johan@kernel.org>
> > References: <20230602124642.19076-2-johan@kernel.org>
> > TO: Johan Hovold <johan@kernel.org>
> > TO: Johan Hovold <johan@kernel.org>
> > CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> > CC: linux-usb@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: Corey Minyard <minyard@acm.org>
> > 
> > Hi Johan,
> > 
> > kernel test robot noticed the following build warnings:
> 
> > New smatch warnings:
> > drivers/usb/serial/io_edgeport.c:1601 edge_break() error: uninitialized symbol 'status'.
> 
> Thanks for the report. Now fixed up in v2:
> 
> 	https://lore.kernel.org/lkml/20230604123505.4661-1-johan@kernel.org
> 

I'm only seeing this now after I had already forwarded the report.  I
removed the old indenting warning because that's obviously intentional.

regards,
dan carpenter

