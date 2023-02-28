Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0661C6A53BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB1HfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1HfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:35:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B291A485;
        Mon, 27 Feb 2023 23:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3406FB80DA7;
        Tue, 28 Feb 2023 07:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FE2C433D2;
        Tue, 28 Feb 2023 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677569716;
        bh=W+ZxgZBXE6luli+R8QIBBe9xfKHjyYEjF5uz85v7fKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bdd3/iFC2XAdcrA229RZoy5Q9BebyyKGi2itSp5oCidHwB0yFpwzPxFgc7XQ3Yjrg
         5BUk0bardnowPVrUEI4Jy8qX9xpH5eCjVQ3R3BTqQbutbo+HCa36N+6nsjKHlZw495
         0+xifVn++ziOUyc2ZMoFX1LHCbrmz3Z9auK7hQn4=
Date:   Tue, 28 Feb 2023 08:35:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     torvalds@linux-foundation.org, tytso@mit.edu,
        Kumaravel.Thiagarajan@microchip.com,
        andriy.shevchenko@linux.intel.com, jslaby@suse.cz,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/2ussWYcd+63Vev@kroah.com>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu>
 <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
 <Y/sBGesMZSd188OQ@kroah.com>
 <PH7PR11MB59586BD780F9427EEFEC3F499BAF9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59586BD780F9427EEFEC3F499BAF9@PH7PR11MB5958.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:54:53PM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Sunday, February 26, 2023 12:20 PM
> > To: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > I agree, sorry for the delay, I'll fix this up before -final for this release.
> 
> Hi Greg,
> Shall I fix this for SERIAL_8250_PCI1XXXX and submit new patch?

Please do!
