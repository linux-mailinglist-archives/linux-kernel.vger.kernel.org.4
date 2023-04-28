Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE16F111B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjD1Erd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbjD1Era (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65F2137;
        Thu, 27 Apr 2023 21:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F5C63F74;
        Fri, 28 Apr 2023 04:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62207C433D2;
        Fri, 28 Apr 2023 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682657249;
        bh=N3Wpd1b+D/ATOLQC3nwTkI4CmJoa3hylQhDOfEVUL3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKy1TSSOFC+vawoMefTktThOPJg1dgwCZvI/99qnn9KGDeCibLEA4R0RxGwP+K3Ac
         6H4yEzZ/k150+QoVjD6DA1+OHHTmxWjWn7fZxUdoDf2rpL34hkck+Sj7dBCFbP6Nq5
         Dao1VqyAQLs8wR9ta3POhkaIz0pee4IAQsSt5/0c=
Date:   Fri, 28 Apr 2023 06:47:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] Revert "input: gpio-keys - use
 device_pm_move_to_tail"
Message-ID: <ZEtP3uRX5Ib1W_Kd@kroah.com>
References: <20230427221625.116050-1-opendmb@gmail.com>
 <20230427221625.116050-4-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427221625.116050-4-opendmb@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 03:16:25PM -0700, Doug Berger wrote:
> This reverts commit 2569873096f7eb1acf63624e9772d82b23923bf4.

You have to give a reason why you are reverting it please...

thanks,

greg k-h
