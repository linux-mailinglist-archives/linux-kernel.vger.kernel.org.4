Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974368EE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjBHL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBHL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:57:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CED54902E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FBE2B81D6C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A553C433A0;
        Wed,  8 Feb 2023 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675857439;
        bh=BVw1vZicbo8JZjKsL73PiviDBYA38VzaxFGG0j4KLWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2W8MSLCjoLJOPmibeArKXJrIqneucO+kWp3WegNMESPXveLxYaERp82Q07D0+VFHM
         blMM10Ll5rVzjV0LTTtAFoXP+xh7AH4O6pVoYjythvGvZ5iIR6UuV/RW9Yf4kztIPf
         q1I8JhzllhsgRogDaXFKSICa7v94y1IItczVKG74=
Date:   Wed, 8 Feb 2023 12:57:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Visweswara Tanuku <quic_vtanuku@quicinc.com>
Cc:     konrad.dybcio@linaro.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, quic_vnivarth@quicinc.com,
        nicolas.dechesne@linaro.org, srinivas.kandagatla@linaro.org,
        vinod.koul@linaro.org, quic_eberman@quicinc.com,
        quic_satyap@quicinc.com
Subject: Re: [RESEND] soc: qcom-geni-se: Update Tx and Rx fifo depth based on
 QUP HW version
Message-ID: <Y+OOHWBzL+GINcLW@kroah.com>
References: <20230206122215.22090-1-quic_vtanuku@quicinc.com>
 <Y+D04FIti7yejya+@kroah.com>
 <ca31f247-0297-7582-c16f-a85453872ca4@quicinc.com>
 <Y+FCQg4c4XBYk+G6@kroah.com>
 <0afc0752-1a4e-be3a-e9bd-0f56243d5e41@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afc0752-1a4e-be3a-e9bd-0f56243d5e41@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:54:13PM +0530, Visweswara Tanuku wrote:
> 
> On 2/6/2023 11:39 PM, Greg KH wrote:
> > A:http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> > 
> > A: No.
> > Q: Should I include quotations after my reply?
> 
> Apologies will take care.
> 
> > http://daringfireball.net/2007/07/on_top
> > 
> > On Mon, Feb 06, 2023 at 07:36:49PM +0530, Visweswara Tanuku wrote:
> > > Added RESEND for resubmission of first version which is not modified in any
> > > way from the previous submission.
> > 
> > Then why was it resent?  What will cause this to be accepted when the
> > previous submission was not?
> > 
> > confused,
> > 
> > greg k-h
> 
> https://lkml.org/lkml/2022/11/21/549
> 
> I had posted the same patch in November last year but did not receive any
> response in spite of periodic reminders.
> 
> Suspecting that the patch did not reach all the required recipients
> re-posted the same and hence RESEND.

When you resend, you need to say _why_ it was resent.  "adding more
people" is a valid reason, don't make us guess.

Remember, some of us get hundreds of patches a day/week to review, we
have no saved context.

thanks,

greg k-h
