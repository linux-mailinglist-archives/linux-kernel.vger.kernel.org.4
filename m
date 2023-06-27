Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182EF73FAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF0LDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjF0LCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53243BF;
        Tue, 27 Jun 2023 04:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8196114C;
        Tue, 27 Jun 2023 11:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A81C433C0;
        Tue, 27 Jun 2023 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687863773;
        bh=Pd55JstkEZiJmiP0d9Dz2XXtqWnXAl44ODneLK+mydI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd1NVngtdIuZ2MO7Dj6iOSX+zjE0MmtjBbJY2OMBO9hUvjue1hJOys599USo41/gO
         62qAAx9cw6i61Cmez0mlenEGrlb/gKZe3UdTlPhqLO/HU0zCCXYo6/26D5qo0Wua45
         1c1/2d3R5ZOJMwXYeDyr5nur69OsRUoV+3zrjaYw=
Date:   Tue, 27 Jun 2023 13:02:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@linaro.org>
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
Message-ID: <2023062711-unwitting-unwomanly-aa55@gregkh>
References: <20230627104033.3345659-1-abel.vesa@linaro.org>
 <2023062741-passion-scarcity-2390@gregkh>
 <ZJq/zgFC+O2MoiEw@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJq/zgFC+O2MoiEw@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:54:06PM +0300, Abel Vesa wrote:
> On 23-06-27 12:46:28, Greg Kroah-Hartman wrote:
> > Also, why is this a RFC series?  What is left to do with it to get it
> > into a state which you feel comfortable having us review it "for real"?
> 
> There is a bit of back story here. This HW control support is something
> that Qualcomm platforms support for some of the PDs. Sent this as RFC
> as I thought it might open up a discussion of such a generic need at
> first. But now that I think of it, it might've been a non-RFC patch as
> well.

You need to provide that information, otherwise what are we supposed to
do with this patch series?  What would you do if you got it in your
inbox?

thanks,

greg k-h
