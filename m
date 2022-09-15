Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB265B95E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIOICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIOICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:02:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0169F6B;
        Thu, 15 Sep 2022 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663228938; x=1694764938;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ybAfiFs8eUgGnH4G//19S9jDye+SzwnhGZadHt7eQ0U=;
  b=Ueqeo7fuhWFl5/D5JTlpk2ZBnn9DhhYbs4DCAoiuFEj0rdfdEbkXXS8F
   x34DcY0Mlq7dSX+TX/m2SAu6AKvXF16se1yLQ6QxfVpYJ0PSWYpMDV6dD
   ugz4lP/efDHEqqJUZDfjD9jIeIBd3/D1ZkCyVnm9b113xWSmiifXgMrnT
   PTmoL1qozrkDHKRy4A0kfS+csceJhGsujAzN5YIGg02uGpWzU+cCGlnp6
   sY3x4QdhYg8N8IipSjEE9GPXUUBSJu08T096CwAj5QxVESVjjCet5tfCb
   hlq8Yxafm5ZWv6y1JIg2NIRghWUxr+PR0yoQT8DX4iZH/qAlitgBQDMMi
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654552800"; 
   d="scan'208";a="26194008"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Sep 2022 10:02:16 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 15 Sep 2022 10:02:16 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 15 Sep 2022 10:02:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663228936; x=1694764936;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ybAfiFs8eUgGnH4G//19S9jDye+SzwnhGZadHt7eQ0U=;
  b=cSAaWru0nDubmmWhr0zTwPPyhJFQNXWGn1Ak09iS/SKA8F6uBKpMzntp
   vIa7oGoW/lxSIMKvWrwSeNh6GXjfmubq5XTt7qw7kHHIdlIR7r4I0Cou+
   Wry+N9NQw0mLjbB3OrBZ/kBIajMOulxaCY+XuQa93rVBioUkBM2ji2sYm
   Fd91o+B7BgsRpzezFrhhhYxQGzv9KhEkk0FgVTqt+ZRIEh7cBJ/nKatlB
   jE7MFGre/SfDFYHiVEQeRz8u2Ash9DaB+hXbbmrKVkiSWRb0oJXHRExyD
   92FT5avEHCeL6qssvQxuILKRjtPIx6TAR+7L82jLPVZdI/yxXPtKDTJsq
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654552800"; 
   d="scan'208";a="26194007"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Sep 2022 10:02:16 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C9CD5280056;
        Thu, 15 Sep 2022 10:02:15 +0200 (CEST)
Message-ID: <a959cfe90356b702727413e7c14b246875eb88b6.camel@ew.tq-group.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Sep 2022 10:02:13 +0200
In-Reply-To: <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
         <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-15 at 09:43 +0200, Matthias Schiffer wrote:
> On Mon, 2022-06-27 at 10:31 +0200, Matthias Schiffer wrote:
> > On Wed, 2022-06-08 at 14:47 +0200, Matthias Schiffer wrote:
> > > This fixes the firmware update function with bootloader v8, allows to
> > > recover from interrupted updates with v7/v8, and does some code cleanup.
> > > 
> > > I believe that the code that allows to recover from a broken partition
> > > table is also necessary to make flashing a different partition table
> > > work at all, but I wasn't able to verify that, as I don't have any firmware
> > > images with different partition tables to test with. In any case, I'm
> > > pretty sure that it is working correctly now, as recovery from a mostly
> > > empty flash without partition table has been tested successfully.
> > > 
> > > I have only tested the new code with bootloader v8, and I don't have the
> > > documentation / interfacing guide for v7, so it would be great if anyone
> > > could check that I didn't break updates for v7.
> > 
> > Hi everyone,
> > 
> > any news regarding this patch series?
> > 
> > 
> > Kind regards,
> > Matthias
> 
> Ping - can we get this applied, or at least any kind of feedback?
> 
> 
> Kind regards,
> Matthias


Ping - another month has passed.

Should I resend the series? Not much has happened in the RMI4 driver,
so the patches still apply cleanly to latest linux-next.

Kind regards,
Matthias



> 
> 
> 
> > 
> > 
> > > Matthias Schiffer (9):
> > >   Input: synaptics-rmi4 - fix firmware update operations with bootloader
> > >     v8
> > >   Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
> > >     helper
> > >   Input: synaptics-rmi4 - fix command completion check for bootloader
> > >     v7/v8
> > >   Input: synaptics-rmi4 - rewrite partition table unconditionally
> > >   Input: synaptics-rmi4 - reset after writing partition table
> > >   Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
> > >     command
> > >   Input: synaptics-rmi4 - remove unneeded struct register_offset
> > >   Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
> > >   Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
> > > 
> > >  drivers/input/rmi4/rmi_f34.c   |  16 +-
> > >  drivers/input/rmi4/rmi_f34.h   |  17 --
> > >  drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
> > >  3 files changed, 81 insertions(+), 301 deletions(-)
> > > 

