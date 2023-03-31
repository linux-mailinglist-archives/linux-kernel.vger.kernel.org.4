Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBF6D2444
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjCaPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjCaPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F02063A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0514B83081
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E1C4339C;
        Fri, 31 Mar 2023 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680277474;
        bh=YB72uFE1fdkW6+uOgpZzxMBlcxb4C+4qQ9J1ORXVSwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBwSeEcMvenMTjvIJ/+s3lgn7aTLz4gtWNCTRnTdE+q1XrpHdy9LRpClKQUczkhv0
         X1BdiwLh53xrtQHT5XjSzoF16qSkFSsmCENSbHUZ44ZNxMrObAlA9UCUC/NfL/Z9XQ
         COEkLvv2SAAbsdggHz2H0jEjYeuGWWq9XNXQ6CBY=
Date:   Fri, 31 Mar 2023 17:44:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] driver core: core: move to use class_to_subsys()
Message-ID: <ZCb_37N5OTOEXtT4@kroah.com>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
 <CAJZ5v0iczxyGP_11hS19D-zQnFgvdbDAhTbNC+ueNwNo9qi2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iczxyGP_11hS19D-zQnFgvdbDAhTbNC+ueNwNo9qi2fA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:26:34PM +0200, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > There are a number of places in core.c that need access to the private
> > subsystem structure of struct class, so move them to use
> > class_to_subsys() instead of accessing it directly.
> >
> > This requires exporting class_to_subsys() out of class.c, but keeping it
> > local to the driver core.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for the quick review!
