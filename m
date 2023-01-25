Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7267B349
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjAYN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAYN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:27:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FC10AB1;
        Wed, 25 Jan 2023 05:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC90BCE1ECE;
        Wed, 25 Jan 2023 13:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF983C433D2;
        Wed, 25 Jan 2023 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674653223;
        bh=+yhXbFOH/NA0IXvnqojhd9YmW3lok9/Vt6OXKcPpStc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WKPvIohrjz+xcwLbMwJeN6Q9fLX6YwQR0FsgYJXS72hSr5pI6DvwCWyfNhyEaUjQ6
         7/32n5C4KYee1Ax7omY+/+Tc0Mgz8YOeNPeZ2JGJRJXPm0csSQOXELNuMS8Ub8fWX8
         peb8MNA1oApqTpsrdfyr3WV/weo8iV/DU0ZU3CgemQ/0zXZhusxCb5hXHS/WbDyzuo
         +Wx2h4jr4hryl1znQOTm/5ZfbxGTTl6xBPvYCfM2UI9mc2XjVxDTNSxQOywxPHxq0D
         dxtbAhTlg7fpBda4jG88/RfK+Wmc0eSW2wgmuN8Vp0KKsRMQYx/cnq2pkG9jUTUqqR
         0ZOuJdiNAJEpg==
Date:   Wed, 25 Jan 2023 14:27:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Philippe Valembois <lephilousophe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: evision: Add preliminary support for EVision
 keyboards
In-Reply-To: <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2301251425190.1734@cbobk.fhfr.pm>
References: <20221224121814.11709-1-lephilousophe@gmail.com> <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, Benjamin Tissoires wrote:

> > From: Philippe Valembois <lephilousophe@users.noreply.github.com>
> 
> Jiri, I have a doubt. Do we accept emails from users.noreply.github.com?

From quick search in github documentation, this seems to be a blackhole 
email address, right?

If so, I'd much prefer to have a real e-mail address there, in order to 
make sure the author / signoff holders can be reached in the future if 
there are any concerns regarding the patch.

The e-mail address disclosure concern is moot as soon as the emaill with 
the patch hits LKML anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs

