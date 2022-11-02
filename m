Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E83615E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKBIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:55:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2A24969
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:55:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p141so14465924iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcE47X74p4ZLI+MbkADionKujrI2BX7HQN2GnbMJo5M=;
        b=p+Ol3h8/vz/XfFARtEJbA6eZnO6+Y5xsaobJk0lFGDbdAGtMWkliUSfmubQIUHD6DQ
         eG9EDgYg4HrqgaKcSlicxDaZ9uLE0YIRBS2NSPrf1dPWWYKHSMmaloSyT9/d8hee9VHG
         1bYHvHdWWGxjoWVFfB+26yOV0eckW0fI/J5gqq+XzEWMNgaXcJ2SxRDgXYZMjet1WEC/
         /K8WqUyF0siVy6R2mMr/tOF27vks4Ow2sO38PxItQzdGbkDM9U7AMT/BTjf8s+kzl3Bl
         ulTpM4ReJ+HUrXwAuzXdpfDdHR1jmOHurslDK0L278MHhUy1Atf6nJ6Qk0M+ZtadJaP0
         stdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcE47X74p4ZLI+MbkADionKujrI2BX7HQN2GnbMJo5M=;
        b=wJpXN8gnw3evoTlvRPYWYftvFY6ht8PT2Ra1qQ4e/B/lE/phyRD8EwtB29TUo+Tcyb
         lqy6kq7Yb44f8WQvus77l5jBE/b0qk5g0/CSC1yK0Kp7sUsXmpxlmF+txtRafLoPYlCu
         BQ4YdzIrPom05dVsQnlrzIUT92yaCCNoox9ttBo2WYPzQudpOAXofxNBDN41VnIkllBb
         mjQsndPp7IPWIhda5arEkRbPI+2u53QNB4QCP4cjDv+gcCXoZbHvro3sojWoePP2pTZ7
         42SS1GUPnbNOQYRzKQ02sUVWUY9pdcoLL8Jc23ZhIplVuLa6Kj+8624fL+DL8/JAYJSO
         F96A==
X-Gm-Message-State: ACrzQf1/i8Rrt/yS6lAemAQJl1MDcwwg7rJShPJ3sZ6c4Ze19ERgATBv
        0Ad07k41ND6U9r7z++fyovMNHgmOt684b+AbtGqIUA==
X-Google-Smtp-Source: AMsMyM7ej56+xne29skg2szA+CTcxkTmPIeEtUAGt3HFdcFDHgGJ9SFe5tdP7dtH/s687K83x1fl7Gioc4yEVqB7fis=
X-Received: by 2002:a05:6602:2f02:b0:6a4:5b5d:9dbb with SMTP id
 q2-20020a0566022f0200b006a45b5d9dbbmr15221603iow.32.1667379301818; Wed, 02
 Nov 2022 01:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com>
 <Y1vvPBw4xB7m23wY@e120937-lin> <CAKfTPtAfuqtCee7f4bREsLqb5KJcLWw1Y=-0Y+2t+3XfX_YctQ@mail.gmail.com>
 <Y1wKHoxcWTz6VXyh@e120937-lin>
In-Reply-To: <Y1wKHoxcWTz6VXyh@e120937-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Nov 2022 09:54:50 +0100
Message-ID: <CAKfTPtAcEiqBDr5BXBS8Q9HzBWg544YR0eZkkaF3u_9EowZJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 at 18:58, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Fri, Oct 28, 2022 at 06:18:52PM +0200, Vincent Guittot wrote:
> > On Fri, 28 Oct 2022 at 17:04, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > On Fri, Oct 28, 2022 at 04:40:02PM +0200, Vincent Guittot wrote:
> > > > On Wed, 19 Oct 2022 at 22:46, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > >
> > > Hi Vincent,
> > >
> > > > > This series aims to introduce a new SCMI unified userspace interface meant
> > > > > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > > > > from the perspective of the OSPM agent (non-secure world only ...)
> > > > >
> >
> > [ snip]
> >
> > > > Hi Cristian,
> > > >
> > > > I have tested your series with an optee message transport layer and
> > > > been able to send raw messages to the scmi server PTA
> > > >
> > > > FWIW
> > > >
> > > > Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > >
> > >
> > > Thanks a lot for your test and feedback !
> > >
> > > ... but I was going to reply to this saying that I spotted another issue
> > > with the current SCMI Raw implementation (NOT related to optee/smc) so
> > > that I'll post a V5 next week :P
> > >
> > > Anyway, the issue is much related to the debugfs root used by SCMI Raw,
> > > i.e.:
> > >
> > >         /sys/kernel/debug/scmi_raw/
> > >
> > > ..this works fine unless you run it on a system sporting multiple DT-defined
> > > server instances ...that is not officially supported but....ehm...a little
> > > bird told these system with multiple servers do exists :D
> >
> > ;-)
> >
> > >
> > > In such a case the SCMI core stack is probed multiuple times and so it
> > > will try to register multiple debugfs Raw roots: there is no chanche to
> > > root the SCMI Raw entries at the same point clearly ... and then anyway
> > > there is the issue of recognizing which server is rooted where ... with
> > > the additional pain that a server CANNOT be recognized by querying...cause
> > > there is only one by teh spec with agentID ZERO ... in theory :D...
> > >
> > > So my tentaive solution for V5 would be:
> > >
> > > - change the Raw root debugfs as:
> > >
> > >         /sys/kernel/debug/scmi_raw/0/... (first server defined)
> > >
> > >         /sys/kernel/debug/scmi_raw/1/... (possible additional server(s)..)
> > >
> > > - expose the DT scmi-server root-node name of the server somewhere under
> > >   that debugfs root like:
> > >
> > >         ..../scmi_raw/0/transport_name -> 'scmi-mbx'
> > >
> > >         ..../scmi_raw/1/transport_name -> 'scmi-virtio'
> >
> > I was about to say that you would display the server name but that
> > means that you have send a request to the server which probably
> > defeats the purpose of the raw mode
> >
> > >
> > >   so that if you know HOW you have configured your own system in the DT
> > >   (maybe multiple servers with different kind of transports ?), you can
> > >   easily select programmatically which one is which, and so decide
> > >   which Raw debugfs fs to use...
> > >
> > > ... I plan to leave the SCMI ACS suite use by default the first system
> > > rooted at /sys/kernel/debug/scmi_raw/0/...maybe adding a commandline
> > > option to choose an alternative path for SCMI Raw.
> > >
> > > Does all of this sound reasonable ?
> >
> > Yes, adding an index looks good to me.
>
> Ok, I'll rework accordingly.
>
> >
> > As we are there, should we consider adding a per channel entry in the
> > tree when there are several channels shared with the same server ?
> >
>
> So, I was thinking about this and, even though, it seems not strictly
> needed for Compliance testing (as discussed offline) I do think that
> could be a sensible option to have as an additional mean to stress the
> server transport implementation (as you wish).

Thanks

>
> Having said that, this week, I was reasoning about an alternative
> interface to do this, i.e. to avoid to add even more debugfs entries
> for this chosen-channel config or possibly in the future to ask for
> transport polling mode (if supported by the underlying transport)
>
> My idea (not thought fully through as of now eh..) would be as follows:
>
> since the current Raw implementation enforces a minimum size of 4 bytes
> for the injected message (more on this later down below in NOTE), I was
> thinking about using less-than-4-bytes-sized messages to sort of
> pre-configure the Raw stack.
>
> IOW, instead of having a number of new additional entries like
>
>         ../message_ch10
>         ../message_ch13
>         ../message_poll
>
> we could design a sort of API (in the API :D) that defines how
> 3-bytes message payload are to be interpreted, so that in normal usage
> everything will go on as it is now, while if a 3-bytes message is
> injected by a specially crafted testcase, it would be used to configure
> the behaviour stack for the subsequent set of Raw transactions
> (i.e. for the currently opened fd...) like:
>
> - open message fd
>
> - send a configure message:
>
>         | proto_chan_#  |     flags (polling..)  |
>         ------------------------------------------
>         0               7                       21
>
> - send/receive your test messages
>
> - repeat or close (then the config will vanish...)
>
> This would mean adding some sort entry under scmi_raw to expose the
> configured available channels on the system though.
>
> [maybe the flags above could also include an async flag and avoid
>  also to add the message_async entries...]
>
> I discarded the idea to run the above config process via IOCTLs since
> it seemed to me even more frowned upon to use IOCTLs on a debugfs entry
> :P...but I maybe wrong ah...
>
> All of this is still to be explored anyway, any thoughts ? or evident
> drawbacks ? (beside having to clearly define an API for these message
> config machinery)

TBH, I'm not a fan of adding a protocol on top of the SCMI one. This
interface aims to test the SCMI servers and their channels so we
should focus on this and make it simple to use. IMHO, adding some
special bytes before the real scmi message is prone to create
complexity and error in the use of this debug interface.

>
> Anyway, whatever direction we'll choose (additional entries vs 3-bytes
> config msg), I would prefer to add this per-channel (or polling)
> capabilities with separate series to post on top of this in teh next
> cycle.

Ok

>
> ..too many words even this time :P

Thanks
Vincent

>
> Thanks,
> Cristian
>
>
> P.S: NOTE min_injected_msg_size:
> --------------------------------
> Thinking about all of the above, at first, I was a bit dubious if
> instead I should not allow, in Raw mode, the injection of shorter than
> 4 bytes messages (i.e. shorter than a SCMI header) for the purpose of
> fuzzing: then I realized that even though I should allow the injection
> of smaller messages, the underlying transports, as they are defined, both
> sides (platform and agent) will anyway carry out a 4bytes transaction,
> it's just that all the other non-provided bytes will be zeroed in the
> memory layout; this is just how the transports itself (shmem or msg
> based) are designed to work both sides. (and again would be transport
> layer testing more than SCMI spec verification..)
>
> So at the end I thought this kind of less-than-4-bytes transmissions
> gave no benefit and I came up with the above trick to use such tiny
> message for configuration.
>
