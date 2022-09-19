Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8F5BD848
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiISXb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiISXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:31:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4F4F1A2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:31:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so681258plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lHAxiefsOucrxQqyycSBJr0X1tuMp0PUhlLxH7tCQwA=;
        b=gpXkv92QBZm3XFIS9ab1uvvTwwPlt0chbBh9L5LW+qIy2980eyqrJeCzY1nFfeuv5v
         keqcPK3USdrT7YdmBhJsBV1zTd5xxjN/iD4bWgeTnBw2WIn3QZA8/JXCn6ovv6BnTDcI
         /sCgJNGTlQhzeJdwTcs/AzRSudJ69fJcraPsJDdh2LpStwHkF3P8kG8SHbW8Iff+Dpod
         TO1lz299nCTDYtlv/k8nYvDqhBQsHq6tehV0aOz+r2V8kIPmwNSpiQwOAOgFroLgeYGh
         kUu5qfIlmU+IDEVuHf2wzPcr055ca2ITv71BB7yoQ4ljA40p3h3jWIjaVOcysxXcBGev
         HJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lHAxiefsOucrxQqyycSBJr0X1tuMp0PUhlLxH7tCQwA=;
        b=7uofvhCpttt2G9HPKjBqJfTnCHtbKJlB3Q1/1IrVJVT0Ur6JVqcKXBUKPcW4T7MxbN
         TNqNDA0Z4T+nSeUn67MmBRKGKZzBtF2w/ncH8A1KvpweQnToEBU2ODr/vqO3gJewgqhE
         zVS79DLLnoRRR8Q3/9NzTibGNBMUOtOfbHIpnkZvHYQnwWamWlj44FaElG6ZPH/IRYX+
         4Ghs2wId4Wjr+YTTUZ8ODtYrHriH/jcIl1ZU8xXjIZyGlvJTOIsDhrMjNUZSxqHvjwE6
         W8rWD/zxf7qePN8ulePrnKP9jJstCt3i0bT8t1h+SGfp+kVmInV1EqNv55MBs3AKKYOr
         0wqA==
X-Gm-Message-State: ACrzQf0wrLq0Mmb6b9NZ7iep0HJhq55fgmd0YISMUjiJ44W5RW54GYvC
        MNcdXeVMu79QBY53Fx+TQ4vTuw==
X-Google-Smtp-Source: AMsMyM4q8KndGTGlYQXJj8gdkdFxO+PFXd0y/91jobb9+YWGqJp1WvOmfTvvOxc21+WC7iyseBkhrg==
X-Received: by 2002:a17:90a:c70b:b0:200:4366:d047 with SMTP id o11-20020a17090ac70b00b002004366d047mr685202pjt.240.1663630283103;
        Mon, 19 Sep 2022 16:31:23 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c206-20020a621cd7000000b00536431c6ae0sm20858748pfc.101.2022.09.19.16.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:31:21 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:31:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Rafa?? Mi??ecki <zajec5@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate()
 is used
Message-ID: <Yyj7wJlqJkCwObRn@lx2k>
References: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
 <22bc845c-dffc-7967-a542-f0697feec603@gmail.com>
 <7be3df2e-2250-8542-1707-121373213fe1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be3df2e-2250-8542-1707-121373213fe1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 04:39:52PM +0200, Rafa?? Mi??ecki wrote:
> On 30.07.2022 09:36, Rafa?? Mi??ecki wrote:
> > On 16.07.2022 22:50, Rafa?? Mi??ecki wrote:
> > > I added of_platform_populate() calls in mtd subsystem in the commit
> > > bcdf0315a61a2 ("mtd: call of_platform_populate() for MTD partitions"):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdf0315a61a29eb753a607d3a85a4032de72d94
> > > 
> > > I recently backported that commit in OpenWrt to kernels 5.10 and 5.15.
> > > We started receiving reports that probing Ethernet devices stopped
> > > working in kernel 5.15. I bisected it down to the kernel 5.13 change:
> > > 
> > > commit ea718c699055c8566eb64432388a04974c43b2ea (refs/bisect/bad)
> > > Author: Saravana Kannan <saravanak@google.com>
> > > Date:???? Tue Mar 2 13:11:32 2021 -0800
> > > 
> > > ???????? Revert "Revert "driver core: Set fw_devlink=on by default""
> > > 
> > > ???????? This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> > > 
> > > ???????? Since all reported issues due to fw_devlink=on should be addressed by
> > > ???????? this series, revert the revert. fw_devlink=on Take II.
> > > 
> > > ???????? Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ???????? Link: https://lore.kernel.org/r/20210302211133.2244281-4-saravanak@google.com
> > > ???????? Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > For me with above commit kernel just never calls bcm4908_enet_probe().
> > > Reverting it from the top of 5.13.19 and 5.15.50 fixes it. I believe the
> > > same issue happens with other drivers.
> > > 
> > > Critical detail is that in DT Ethernet block node references NVMEM cell
> > > of MTD partition (see below).
> > > 
> > > Could you help me dealing with this issue, please? Can you see something
> > > obvious breaking fw_devlink=on + of_platform_populate() case? Can I
> > > provide some extra information to help fixing it?
> > 
> > Any ideas about this problem / solution?
> 
> I didn't get any reponse for this bug for 6 weeks now. Is that OK if I
> send a revert patch then?

I'm pretty sure this is the same root cause as I had for PCIe with a reference
to iommu with fw_devlink.strict=1:

https://lore.kernel.org/lkml/CAOesGMgpJQjMvo6m7on+27F8REiHaVSRL6HBjiRPVDM9Jscnrg@mail.gmail.com/

There's the dependency on the nvmem-cells propery, so the driver core doesn't
call probe until it's fulfilled. Meanwhile, the platform_driver() code
unregisters the driver if it (thinks) it as called probe and there are no
devices linked to it -- since it's not a needed driver. Thus, probe will never
be called. That code is in drivers/base/platform.c:__platform_driver_probe().

I don't know what the proper fix is here, this seems like a design issue with
the fw_devlink code.


-Olof
