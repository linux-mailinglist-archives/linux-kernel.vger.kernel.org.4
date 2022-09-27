Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA645EBDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiI0Inr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI0Ind (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E67539B;
        Tue, 27 Sep 2022 01:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0253661736;
        Tue, 27 Sep 2022 08:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11144C433D6;
        Tue, 27 Sep 2022 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664268211;
        bh=cMC0mbnCxjb8IKzSlWcakWh/99h0aVPN0peMWzbTBdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7XInvNcFk1a+0zD9fVBCEVG9kYlk7mXr09rw68F3kZvjpm5uRpNFEQxYuKaeSLir
         mIGs8cffCmPWHhII0K4CXPglklQAJlCPAIe5y8RfX6BzBc2yOLmBwfN0p260mAnmZH
         X8HcolgRgPJTG2ytlQ5WI8DnbW2ZtYEa2/LSl3/I=
Date:   Tue, 27 Sep 2022 10:43:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation
 and practices
Message-ID: <YzK3sSrHSckm7T3b@kroah.com>
References: <20220926211149.2278214-1-kristen@linux.intel.com>
 <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com>
 <YzKyqNJk72TY//42@kroah.com>
 <f0c27a5b-fee2-eb64-6855-639e7ea65d37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c27a5b-fee2-eb64-6855-639e7ea65d37@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:27:24PM +0700, Bagas Sanjaya wrote:
> On 9/27/22 15:22, Greg Kroah-Hartman wrote:
> >> When was the bootstrap period be concluded?
> > 
> > I do not understand the question, sorry.  What exactly are you asking
> > here?
> > 
> > confused,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> In the patch, the mention to bootstrap period of CoC committee is
> replaced with note about dynamic nature of CoC interpretation. I asked
> when the duration of bootstrap period was before we got into status quo.

It was a while ago, a few years perhaps?  We had forgotten to update the
document since then, sorry.

greg k-h
