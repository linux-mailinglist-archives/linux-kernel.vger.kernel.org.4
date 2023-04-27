Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C06F0097
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbjD0GAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0GAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:00:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE563585;
        Wed, 26 Apr 2023 23:00:17 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:00:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682575215; bh=7/SgwyqfcCoVi3b2qScazJ/eHD+6clxjAKvHj8rhJuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO0bIyoEGNrkdh28YRhz4OA1aZ4Rqeh/eNvEDvwtKO/OTYS1T+HcBAxtx42tSAdhp
         9LGUluUnDIOx0bvuNm9t/Inqi+rdeSAdvbL8p1PIttpfF2fEVgEFB4fVtme3hS5T1x
         EexgjaHwqA8PYuQcO359GV45itRRuUMgJK/xRVVU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
Message-ID: <43b18d93-442a-4735-9a5e-3c88a3912f8f@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
 <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
 <0a57896e-3f61-7761-f03d-e47f0c21be7e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a57896e-3f61-7761-f03d-e47f0c21be7e@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-26 18:26:11-0600, Jens Axboe wrote:
> On 4/26/23 5:12?PM, Thomas Wei?schuh wrote:
> > Hi Martin, Christoph, Jens,
> > 
> > On 2023-03-20 07:56:58-0400, Martin K. Petersen wrote:
> >>> The embedded member integrity_kobj member of struct gendisk violates
> >>> the assumption of the driver core that only one struct kobject should
> >>> be embedded into another object and then manages its lifetime.
> >>>
> >>> As the integrity_kobj is only used to hold a few sysfs attributes it
> >>> can be replaced by direct device_attributes and removed.
> >>
> >> Looks good to me and passed a quick test on a couple of systems. Thanks
> >> for cleaning this up!
> >>
> >> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > 
> > Am I getting some part of the process for block/ wrong?
> 
> Sorry, I missed this series. I'll queue it up for 6.4.

Thanks!

> > It seems my patches for the block subsystem are having a hard time
> > getting merged.
> > 
> > * https://lore.kernel.org/all/20221110052438.2188-1-linux@weissschuh.net/
> 
> This one is missing nbd review. It's unfortunately not uncommon to need
> to re-ping on something like this, if you don't get a timely review.
> This is not specific to this patch, just in general. Things get missed.

Will do.

> > * this series
> > * https://lore.kernel.org/all/20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net/
> 
> This one is just a week old, and coming into the merge window. Generally
> takes longer at that time, as it's late for that merge window, and folks
> are busy with getting things ready. If nothing happens on this one, I'd
> suggest resending past -rc1 when folks are more ready to review and
> queue things up for the next release.

Indeed, it is only listed for completeness sake.

I assumed that because all three series were like this, that I maybe
missed some PATCH prefix for your filter, managed to end up in your
killfile or mails from my privately managed mailservers don't get
through.

This is why I also wrote to Martin and Christoph, fearing that you don't
see my mails.

Thanks for the clarification,
Thomas
