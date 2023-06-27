Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC673FB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjF0Lse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjF0Ls0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:48:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F71BE9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:48:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so5827782e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687866502; x=1690458502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqtZzMODsbge3FzH7PvLUrnH/SiLk9B9uttmIxMRB9A=;
        b=h8yr8dvOrJ0iH5h7MIU7WDJH3arIKIdGOmrnsLpZMg2N6kIkWB5bXWRQEFVlIVHYhl
         vERaRnYF3SezsIw2nNT2qHPe/3gryu+PKF2+tgATGrNvZtdhpEahyfNGB2FwvY4bpzKQ
         2A7PCXdoYZLeABDjxg/I0N2LBJW8BfBF9dYbBm8DLlWkgo4pXILEoeHrYAaD1Ra7kDZt
         pCW22/XG4Q+53wxduia/TNszRjihMEzJzeXKXrKvrlLfNJ/y7jvgnPKHH86z/6pSdf/R
         tkpSFw3eYJWYJZPxFCMbJN5U/P33dz3bpHAs5ewVvFWyCUv8lE6ndtwLCDaj/k6Wh8+B
         Cvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866502; x=1690458502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqtZzMODsbge3FzH7PvLUrnH/SiLk9B9uttmIxMRB9A=;
        b=SY7GQwxGfkmyO8i+eL9TLZJeW/mSgVaZdO6q78W1Ts+Xhnn75w/4wje3w+BVpV8pQI
         y4i/HvMAHA4tCPqi5mWy2FyRjaK5R7w+IuDDXwEYT+UytiddlRZ8Aa+W1TpTUnbc4EUv
         gc1w2grZdScZDwZgAOS06n3Cy4RPzBme5L7XaB1lB1QL3KHnmYft7nivI42n4gnQ0y0R
         xvAmJMzS6283i+5fjOQbOrTqMieVbNl2cp5jDt9j15mnnXP2fH6uglhCGBP3MJkzPnvj
         cHik2ALDft8o3EJkEncKz3ZdiQDETRRtFhpWHTGW+wbn8g4Q6WzlNKc79EZkNE/AIquO
         mkVQ==
X-Gm-Message-State: AC+VfDxsvhHkbZ/6bAN60BkzjQ8oDCvtfqlBt9v0bIePBN6Ao9q6L3aO
        kFHRsl3Ep0w0Nm8Pgij4b+IOfA==
X-Google-Smtp-Source: ACHHUZ5jX/9fIQBU4Yh+tw4SLl9c7pvuSEWOqS1dGPgDoJHSSLoURkOcwnvfv30ESG0kb0+EZH+a2w==
X-Received: by 2002:a05:6512:455:b0:4fb:8939:d962 with SMTP id y21-20020a056512045500b004fb8939d962mr543348lfk.19.1687866501847;
        Tue, 27 Jun 2023 04:48:21 -0700 (PDT)
Received: from linaro.org ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003f8d6647661sm13413655wmi.15.2023.06.27.04.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:48:21 -0700 (PDT)
Date:   Tue, 27 Jun 2023 14:48:19 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] PM: domains: Allow devices attached to genpd to
 be managed by HW
Message-ID: <ZJrMg7EXzfVP0oBz@linaro.org>
References: <20230627104033.3345659-1-abel.vesa@linaro.org>
 <2023062741-passion-scarcity-2390@gregkh>
 <ZJq/zgFC+O2MoiEw@linaro.org>
 <2023062711-unwitting-unwomanly-aa55@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062711-unwitting-unwomanly-aa55@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-27 13:02:50, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 01:54:06PM +0300, Abel Vesa wrote:
> > On 23-06-27 12:46:28, Greg Kroah-Hartman wrote:
> > > Also, why is this a RFC series?  What is left to do with it to get it
> > > into a state which you feel comfortable having us review it "for real"?
> > 
> > There is a bit of back story here. This HW control support is something
> > that Qualcomm platforms support for some of the PDs. Sent this as RFC
> > as I thought it might open up a discussion of such a generic need at
> > first. But now that I think of it, it might've been a non-RFC patch as
> > well.
> 
> You need to provide that information, otherwise what are we supposed to
> do with this patch series?  What would you do if you got it in your
> inbox?

Will do in the next version.

Thanks.

> 
> thanks,
> 
> greg k-h
