Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDD6540F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiLVMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiLVMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:24:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09C183AC;
        Thu, 22 Dec 2022 04:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BECDB81D24;
        Thu, 22 Dec 2022 12:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E355C433D2;
        Thu, 22 Dec 2022 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671711847;
        bh=EGV1FLXGeAfBW/AN9blfoRhMkgPaIuOv8joBl1M51Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZX08aJhtHUVOZIbOnywFerJMOKok3BcQofENGMkyDB1geWl/cirndb2cLEVJOockF
         X+FW2Hckr4wOwZ1joG2Aty2s7PM0AzcFcyE5h5J0oVFA+JyP/YfgAbWKh/yD8wxqJQ
         nC7NzUE4Dr52c25KdZklsH6CM5HrDCLDqFS4xZHzxVjVp5aN1oOzIg9xQkZNKuL2la
         reuYUeL8brZXtTRnUrY9l4wcU8cDYptMgnVJlqwLu8G0CLOdlOaZuhynfQeHDWPPPP
         /O3WMSiAtDVUuvFHAkc4U/minTa72zXKlkxFBVjnY3GNBlnV0BiBOdPE4fi/rXqJZb
         u5qOv+MjPZwtA==
Date:   Thu, 22 Dec 2022 13:24:04 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221222122404.GB44777@lothringen>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen>
 <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
 <20221221173005.GB37362@lothringen>
 <Y6NqYydTKFEwJIqN@boqun-archlinux>
 <20221222121612.GA44777@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222121612.GA44777@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:16:12PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 12:19:47PM -0800, Boqun Feng wrote:
> > On Wed, Dec 21, 2022 at 06:30:05PM +0100, Frederic Weisbecker wrote:
> > By "same effect" you mean removing E results in the exist-clause
> > triggered? If so, then our environments disagree with each other ;-)
> 
> Nope, removing D :-)
> 
> (And yeah probably I misread your previous mail and we weren't talking
> about the same thing...)

Yeah checking that again, I got confused in the discussion between my two
tests srcu-E and srcu-D. Anyway, you were right about the control dependency :)

> 
> Thanks.
