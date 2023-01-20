Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C0675743
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjATOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjATOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:35:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C9F172C36;
        Fri, 20 Jan 2023 06:34:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7092C14BF;
        Fri, 20 Jan 2023 06:35:28 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6CE53F67D;
        Fri, 20 Jan 2023 06:34:45 -0800 (PST)
Date:   Fri, 20 Jan 2023 14:34:39 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        sudeep.holla@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Clarify Raw per-channel ABI
 documentation
Message-ID: <Y8qmf1cUdZYoukAX@e120937-lin>
References: <20230120122326.1932614-1-cristian.marussi@arm.com>
 <Y8qMclu5Tc3dKCS6@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qMclu5Tc3dKCS6@debian.me>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:43:30PM +0700, Bagas Sanjaya wrote:
> [Also Cc: linux-doc list]
>

Sorry for missing the Cc but get_maintainer.pl did not say anything
about this ABI docs patches.

> On Fri, Jan 20, 2023 at 12:23:26PM +0000, Cristian Marussi wrote:
> > diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
> > index 5468ec08c084..b1c505ed444c 100644
> > --- a/Documentation/ABI/testing/debugfs-scmi-raw
> > +++ b/Documentation/ABI/testing/debugfs-scmi-raw
> > @@ -80,9 +80,13 @@ Description:	SCMI Raw synchronous message injection/snooping facility; write
> >  		Each write to the entry causes one command request to be built
> >  		and sent while the replies are read back one message at time
> >  		(receiving an EOF at each message boundary).
> > +		Channel identifier <m> matches the SCMI protocol number which
> > +		has been associated with this transport channel in the DT
> > +		description, with Base protocol number 0x10 being the default
> > +		channel for this instance.
> 
> s/Base/base/
> 
Thought that being an SCMI protocol name definitions would have to be
capitalized.

> >  		Note that these per-channel entries rooted at <..>/channels
> >  		exist only if the transport is configured to have more than
> > -		one channel.
> > +		one default channel.
> >  Users:		Debugging, any userspace test suite
> >  
> >  What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_async
> > @@ -103,7 +107,11 @@ Description:	SCMI Raw asynchronous message injection/snooping facility; write
> >  		Each write to the entry causes one command request to be built
> >  		and sent while the replies are read back one message at time
> >  		(receiving an EOF at each message boundary).
> > +		Channel identifier <m> matches the SCMI protocol number which
> > +		has been associated with this transport channel in the DT
> > +		description, with Base protocol number 0x10 being the default
> > +		channel for this instance.
> 
> Same here.
> 
> >  		Note that these per-channel entries rooted at <..>/channels
> >  		exist only if the transport is configured to have more than
> > -		one channel.
> > +		one default channel.
> >  Users:		Debugging, any userspace test suite
>  
> Otherwise LGTM.
>
Thanks,
Cristian
