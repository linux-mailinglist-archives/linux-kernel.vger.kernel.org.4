Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61327699096
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBPJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:58:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A59061BB;
        Thu, 16 Feb 2023 01:58:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84AA81042;
        Thu, 16 Feb 2023 01:59:04 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86AD93F703;
        Thu, 16 Feb 2023 01:58:20 -0800 (PST)
Date:   Thu, 16 Feb 2023 09:58:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] mailbox: Allow direct registration to a channel
Message-ID: <20230216095816.rzhxa2qdexy3ulrz@bogus>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
 <20230215101732.pbpom3ub3yh75n4w@bogus>
 <d35633ea-4049-6f51-3a3a-2a258a4af037@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35633ea-4049-6f51-3a3a-2a258a4af037@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 08:58:10AM -0800, Elliot Berman wrote:
> 
> 
> On 2/15/2023 2:17 AM, Sudeep Holla wrote:
> > On Mon, Feb 13, 2023 at 03:25:34PM -0800, Elliot Berman wrote:
> > > Two mailbox controllers have channel/client binding mechanisms that are
> > > controller-specific and not using the devicetree binding mechanisms. Mailbox
> > > channel/client is conceptually done in two steps: selecting the channel
> > > and binding the selected to channel to a client. Channel selection is sometimes
> > > controller specific (pcc and omap are examples). The channel/client binding
> > > code is all the same.
> > > 
> > > This small series de-duplicates and refactors the channel/client binding
> > > into a common framework function: "mbox_bind_client" which all of the
> > > channel selection mechanisms can use.
> > > 
> > > I found this duplicate code while working on the support for Gunyah hypervisor
> > > message queues [1]. I've only been able to compile-test omap-maiblox and pcc,
> > > however it is a straightforward conversion here.
> > > 
> > > [1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/
> > > 
> > > Elliot Berman (3):
> > >    mailbox: Allow direct registration to a channel
> > 
> > I am unable to find the above patch either in my inbox or in lore[1].
> > Can you please repost the same ? I would like to test/review w.r.t PCC
> > driver.
> > 
> 
> Hi Sudeep,
> 
> Not sure why the patch didn't end up your inbox; lore seems to have linked
> it correctly and indicates you were in To:. If I missed something, let me
> know and I'll make sure you're properly included if future versions needed.
> 
> https://lore.kernel.org/all/20230213232537.2040976-4-quic_eberman@quicinc.com/

No, I do have patch 2/3 and 3/3 in my inbox along with the cover letter.
Patch 1/3 is missing in both my inbox and lore. Can you send me the lore
link for patch 1/3 if you are able to find it ? Or just repost the series
if you can't.

-- 
Regards,
Sudeep
