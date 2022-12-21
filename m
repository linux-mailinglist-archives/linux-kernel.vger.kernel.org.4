Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38226531F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiLUNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLUNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:45:35 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11C1276F;
        Wed, 21 Dec 2022 05:45:34 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 93009377;
        Wed, 21 Dec 2022 13:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93009377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1671630333; bh=beJP4Kkr6h/TSuOC2Qdh8B/D19ZPOqfTigW9Np05uSM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M/yTZSKLUuE/4gSu73sQpKftAaDPNioV00WJlWxHkM984l79P3miE6ozHL2971BcL
         sCpK6Vnme6hcPU4TElZkLAV9opZwnlH0NMxxkmoAPRnA+Tb4xdnNCFUsdFOKottDjK
         YWx9B3VyiZvBTsSnRWzOU7N0e1EZuUodYTJMg9WLS1fK1dJ6e2mxIFbOAUIHXkGIGq
         W+79MiRh991nxm7gL3piE2D7YszQcFSIYf0M6YA3Wr0/3jhDZZO8pORUvtZV5SDLXl
         pvOiSYSc14RBoTXd7e5dsj5CG+SeYa87mjkkdDwqnqNNPcKmYznwf5kvHWZaQ0WB6x
         s59EuAWyoFFZw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221221083450.GA23903@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de>
Date:   Wed, 21 Dec 2022 06:45:32 -0700
Message-ID: <87mt7g27lv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Dec 15, 2022 at 02:26:22PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
>> > The document looks fine, but I do wonder if it wouldn't be better placed
>> > with the other maintainer entries in Documentation/maintainer?
>> 
>> Hmm, nothing in there looks very similar to me, while process
>> seems to have real policy documents.  But we can live with either
>> place.
>
> Any strong arguments for moving it Documentation/maintainer?
>
> I'd like to merge this with the fixups from Randy through the nvme
> tree ASAP, and need to decide on the location.

Sorry, the argument is that the subsystem profiles there were created
for the very purpose of documenting subsystem-specific patch policies
like those found in your document.  The hope is that, someday, people
will be able to go to one place to learn what special hoops any given
subsystem will make them jump through.

This isn't something I'm going to dig in my heels on, though.  But at a
minimum, could you add an entry to
Documentation/maintainer/maintainer-entry-profile.rst ?

Thanks,

jon
