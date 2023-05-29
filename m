Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9682715240
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjE2XPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE2XPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:15:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDE5AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:15:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CD595C00EE;
        Mon, 29 May 2023 19:15:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 29 May 2023 19:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685402108; x=
        1685488508; bh=tDK0nx2q7ZYmH1yaR4YoJ1JDawVZeLFQPj//47nqVWE=; b=r
        V12WMFdZ3QVKfkiNt4wXc30jQCSU8YLATZkxZqvXu3FWYHjStcIfAGSYD1GGaHCR
        nJwouN7V66bED/4uWiSpn+WzAeMyo+FcEGbgWgBNmnZyCZQFyawUHxBaiA+d+p5x
        5Jbx1AwDy/qJsUUxEbbRLLfzCJiZM5kdzJXoTYt+dDXUu1Ss4n5TsnMIDpqVLkMm
        wCZXoR82k4gxIcCTRy5o/5vvpkh4hJP1i5NNMtBc17OKPHkb9/x2F5mWuzJtmWJq
        sSFOSYFE0AbG4uEjwkGh9BxqGKZcFU0DNK9BhJ+yetViGwG5qNF1m1ifQ3Ju232a
        +cE6lG7O2XgasJaPL0AfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685402108; x=1685488508; bh=tDK0nx2q7ZYmH
        1yaR4YoJ1JDawVZeLFQPj//47nqVWE=; b=rqRHZKJ3WwWD7r6hl7IyrUMWS1GOD
        1stsi2lVCk39z0eAEQHn6kOsEBVvGXUetKfzuAzyuO2oLZdCeYerPWfVCv6nw4O9
        Yg9gMwT3AkQwuEQVMGe4TAgvXxdtMvM8h8GE2EPPAcPj5Ylj7Xw7dCiSbOBnZn8d
        JyiLYpHvx9a9MOX20rmikSCa9tQot3br4HQImqA4Grup+vYhIao27hmCWRmJJSw3
        qD16BViN5NGGJQa9yH4QjORDcVnZiwMq0lwDFwLbQRl298ub5pHu8jQOduK+/5MT
        1+9Ynirqv/Te8WEyktaISNQq/1dYRssIfhGQ23AoffZPnN5ibo+/c9mSw==
X-ME-Sender: <xms:-zF1ZFEJf-LWLRZtMuKd_CvVhqz9IK5M4i-weU9aSYsecozopoWJQA>
    <xme:-zF1ZKXZF6-kf2TC_KQUkZxKJN7LpoAtZPEGQAgCt80mAQ0pLdefRww3GpX3W_92M
    -wRz_dQPbTTeRXtF3s>
X-ME-Received: <xmr:-zF1ZHJBLqyjk6erkLBMujJ0Y19w-QEtjtl0gp04wnbS61ohxUqdRIjakQ7mxTop9n5MEiSYUa4m6iL3IhnggPS00RW_b2fdo-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:_DF1ZLG1eVQ5CuiqsVJGddwJIVjTJztTVP_L_jrxzDJ5P4iRqfjmMA>
    <xmx:_DF1ZLUmf4oElynFQ2X98jn9P0Tjd_TsICj6D0wcBi4SNk_9VkOTIQ>
    <xmx:_DF1ZGO1rFoHeoe8bclJSx2Rtji2u4xClysx-6Mz2FroEHD69XGvYw>
    <xmx:_DF1ZCdmdcg0IXiOPtkhp-Q2jKzMzdH4YfWERTGu-j83YgyalFfaQg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 19:15:06 -0400 (EDT)
Date:   Tue, 30 May 2023 08:15:04 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 00/12] firewire: deliver hardware time stamp for
 asynchronous transaction
Message-ID: <20230529231504.GA20864@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 08:33:54PM +0900, Takashi Sakamoto wrote:
> Cc: kunit-dev@googlegroups.com
> 
> Hi,
> 
> This patchset is revised version of the previous one[1], I realized that
> it included wrong version number of Linux kernel. The new series
> includes changes just for it.
> 
> 
> Copied from the initial cover letter:
> 
> 1394 OHCI hardware supports hardware time stamp for asynchronous
> communication at 8,000 Hz resolution (= isochronous cycle), while
> current implementation of FireWire subsystem does not deliver the time
> stamp to both unit driver and user space application when operating the
> asynchronous communication. It is inconvenient to a kind of application
> which attempts to synchronize data from multiple sources by the (coarse)
> time stamp.
> 
> This patchset changes the subsystem so that the unit driver and the user
> space application to receive the time stamp, therefore it affects kernel
> service for asynchronous transaction, kernel API for unit driver, and UAPI
> for user space application.
> 
> [1] https://lore.kernel.org/lkml/20230525101625.888906-1-o-takashi@sakamocchi.jp/
> 
> Takashi Sakamoto (12):
>   firewire: add KUnit test to check layout of UAPI structures
>   firewire: cdev: add new version of ABI to notify time stamp at
>     request/response subaction of transaction
>   firewire: cdev: add new event to notify request subaction with time
>     stamp
>   firewire: cdev: implement new event to notify request subaction with
>     time stamp
>   firewire: core: use union for callback of transaction completion
>   firewire: core: implement variations to send request and wait for
>     response with time stamp
>   firewire: cdev: code refactoring to operate event of response
>   firewire: cdev: add new event to notify response subaction with time
>     stamp
>   firewire: cdev: implement new event to notify response subaction with
>     time stamp
>   firewire: cdev: code refactoring to dispatch event for phy packet
>   firewire: cdev: add new event to notify phy packet with time stamp
>   firewire: cdev: implement new event relevant to phy packet with time
>     stamp
> 
>  drivers/firewire/.kunitconfig       |   4 +
>  drivers/firewire/Kconfig            |  16 ++
>  drivers/firewire/Makefile           |   3 +
>  drivers/firewire/core-cdev.c        | 252 +++++++++++++++++++++-------
>  drivers/firewire/core-transaction.c |  93 +++++++---
>  drivers/firewire/core.h             |   7 +
>  drivers/firewire/ohci.c             |  17 +-
>  drivers/firewire/uapi-test.c        |  87 ++++++++++
>  include/linux/firewire.h            |  82 ++++++++-
>  include/uapi/linux/firewire-cdev.h  | 180 +++++++++++++++++---
>  10 files changed, 625 insertions(+), 116 deletions(-)
>  create mode 100644 drivers/firewire/.kunitconfig
>  create mode 100644 drivers/firewire/uapi-test.c

Applied to for-next branch.

* https://git.kernel.org/ieee1394/linux1394/c/fe971f9163b6


Thanks

Takashi Sakamoto
