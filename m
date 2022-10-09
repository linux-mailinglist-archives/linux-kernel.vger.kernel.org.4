Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17565F8D21
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJISYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJISYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:24:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8453CCA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 562FCCE0F76
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F374C433C1;
        Sun,  9 Oct 2022 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339873;
        bh=AbykiathWdaLgkhoGWqjoEm9luQULmv33A1fYXksF5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujmvs0D9gu8klPDeVArNHQMa0XbteYoxB0yb83XZQ5gcEUlwYzx7YlJwbz22zWdGL
         2VrPTu0kMkEUHPl8QZMoqJTCsxVY7QMDEE9ctb8tCY7VPsQJENKXyDGjiBVuaYFWRD
         BUJq3pIZHh2cr4G440u0cMvniHS5Ly3ZOvb30evo=
Date:   Sun, 9 Oct 2022 20:25:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] device property: add
 {device,fwnode}_property_match_string_nocase()
Message-ID: <Y0MSDNPw+8vj6uMB@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
 <20221009162155.1318-3-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009162155.1318-3-soha@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:21:54AM +0800, Soha Jin wrote:
> device_property_match_string_nocase and fwnode_property_match_string_nocase
> are used to do case-insensitive match with match_string_nocase.

Again, why?  What platform is broken that needs this?

thanks,

greg k-h
