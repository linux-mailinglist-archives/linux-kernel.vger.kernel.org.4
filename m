Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE1673DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjASPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjASPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:41:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14C82999;
        Thu, 19 Jan 2023 07:41:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB67A61C99;
        Thu, 19 Jan 2023 15:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9880C433D2;
        Thu, 19 Jan 2023 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674142861;
        bh=kcg9B/jMLpN2IxpZNMi5++G/x9aD5/3+tJIqR3+NnQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeAgtS+HaZm1Gqx8OEv7DQMiyCl4hLC2VUulYyQ4eFcUx+X3a31HBaIqn4M9kggs/
         3k3tN9+SOVrRFJpoiYqW92bro8LGkbXV+59w3xLOuPZcZkVzc/qJmTaX5G6ckyPFq0
         u9OJHq3C/rn1wCdLnR1p5u3uikFp/kSdyHW1mk54=
Date:   Thu, 19 Jan 2023 16:40:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 1/4] device property: Get rid of
 __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Message-ID: <Y8lkhedIFY8UOPf+@kroah.com>
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gewC7z5XY+r8=2bkOAO2y8q7VVbrazj0z+4xGRR2Bkew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gewC7z5XY+r8=2bkOAO2y8q7VVbrazj0z+4xGRR2Bkew@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 07:55:44PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 22, 2022 at 2:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
> > Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
> > to the data layout. It's more understandable when the data structure
> > is placed explicitly. That said, get rid of those macros by replacing
> > them with the existing helper and explicit data structure layout.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> The series in which this patch is included does not apply cleanly for me.
> 
> I guess it depends on the earlier material already in Greg's tree, so
> I'm leaving it to Greg.

Andy, did I miss this?

confused,

greg k-h
