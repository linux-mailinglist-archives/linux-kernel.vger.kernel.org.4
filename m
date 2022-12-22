Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B14465478F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLVUyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:54:38 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B81C916;
        Thu, 22 Dec 2022 12:54:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1715774;
        Thu, 22 Dec 2022 20:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1715774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1671742476; bh=BOl6ICJ8RqdJV/GOC1RaekskBBpoDf7iE7ORiDpKG5M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=opBNAa42RBXIgcq6/Wg3Wpkatc+UgO6KGWwH/W1NGxg8UlxYjdfHc3b/ECEkJOA96
         oKIbeDIfKwNEYyBR4dF88k9GtXuVx2OKnWARuS478xNZn9ArfsmOCZm6I7OErHrmLX
         vh00GCngBsJY+etnO0p3KN7UaujLje7WhZbxWrcG9BUSm7eWRaNo8oC6FXGAwTNnLY
         uJlU22BEshbtF0J/R4NhDLGq7msohT105z0dniqiB/u9vEbnpyohLtiLNhoTJUv/4B
         8gAcsLIdpoI7MJDqdjomF1XRHl3AV0VWnqN8mXAh+ZedKourXzUgsqWR8nqx9b9MBG
         cdi3W/pIl9Kpw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221222160920.GA10193@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
 <20221222160920.GA10193@lst.de>
Date:   Thu, 22 Dec 2022 13:54:35 -0700
Message-ID: <87zgbfma5w.fsf@meer.lwn.net>
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

> On Wed, Dec 21, 2022 at 06:45:32AM -0700, Jonathan Corbet wrote:
>> Sorry, the argument is that the subsystem profiles there were created
>> for the very purpose of documenting subsystem-specific patch policies
>> like those found in your document.  The hope is that, someday, people
>> will be able to go to one place to learn what special hoops any given
>> subsystem will make them jump through.
>> 
>> This isn't something I'm going to dig in my heels on, though.  But at a
>> minimum, could you add an entry to
>> Documentation/maintainer/maintainer-entry-profile.rst ?
>
> What about the following?  This moves the file to a new
> Documentation/nvme/ directory and then links it form
> Documentation/maintainer/maintainer-entry-profile.rst:

I'm not really a fan of adding more top-level directories; one of these
years I'd like to try to move things in the opposite direction.  That is
a battle for another day, though; for now let's just go with this and
get the document merged.

That said, I suspect you'll add a build warning about the new document
not being included in any toctree.  Fixing that would involve adding a
basic index.rst to the new directory and adding that to a file like
Documentation/subsystem-apis.rst.

Thanks,

jon
