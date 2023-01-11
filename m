Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF29D665ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjAKPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjAKPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:09:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F1C53
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01F5AB81C17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32782C433EF;
        Wed, 11 Jan 2023 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673449795;
        bh=Ks8HSEjvIu1cAM6ETL3oj12pqeJide7riwjR3VRZYGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdoCGPq+Zt3Dsk57Rap/pOAezLK1AkQ3FGGQCXIoeFhLJrDDmXYd9kv9UcJZP0MFE
         iQRx1H6UnDNrkikQcsfD8/8x9NX7TplGITCgCBBI6B2TxNE5XC/9ebC+HhbEdnu7GI
         e9rl9+unGWifs+cshKTj+FPt3ME43OrssYgy9LIU=
Date:   Wed, 11 Jan 2023 16:09:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: change to_subsys_private() to use
 container_of_const()
Message-ID: <Y77RQDgAXxXuPZb6@kroah.com>
References: <20230111093327.3955063-1-gregkh@linuxfoundation.org>
 <CAJZ5v0jDb9gbXNc8oeW4poPh_MQydOqjyfgWmDehfTeG_5F8uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jDb9gbXNc8oeW4poPh_MQydOqjyfgWmDehfTeG_5F8uA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:50:49AM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 11, 2023 at 10:33 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The macro to_subsys_private() needs to switch to using
> > container_of_const() as it turned out to being incorrectly casting a
> > const pointer to a non-const one.  Make this change and fix up the one
> > offending user to be correctly handling a const pointer properly.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for the review!
