Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A626B1084
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCHR5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCHR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:57:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7BBC4E98
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97F13B81D31
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF07CC433D2;
        Wed,  8 Mar 2023 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678298258;
        bh=nbhrYcVtF+y4wFWLoB+6j5eVmmdOWyWav5kWdnULwVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiebBYflgfpJSBgfXwrz9Q2msHS/Zls/Z1GXyyZJf5XLP7sh8DTyvPvp+0YqFJHNg
         +6VJbWi52jESnREmQTI0rVl2RJCagU66yn0bbTPtwuSS1GmRUnA+uygJojZp1lAHq4
         +pBc/huWsdm6C1X1JkuVwXa8AJ+M5tRaFj+2VX5Q=
Date:   Wed, 8 Mar 2023 18:57:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] container_of: add type safety
Message-ID: <ZAjMj01l4A/eR0JX@kroah.com>
References: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:35:03PM -0500, Michael S. Tsirkin wrote:
> Using a wrong member in container_of will result in an error.
> No so for container_of_const - it is just a cast so will
> happily give you a wrong pointer.
> 
> Use logic from container_of to add safety.

Also your subject line is wrong :(

