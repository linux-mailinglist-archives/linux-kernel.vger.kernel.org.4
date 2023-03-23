Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AD6C6EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCWR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjCWR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:26:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D34B777;
        Thu, 23 Mar 2023 10:26:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DB07378;
        Thu, 23 Mar 2023 17:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5DB07378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679592402; bh=MBuRS26mgv6HpsYzuzNMBYMg9+1oJPHXW00uMeFRd3M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NM/ZkxP2Csjnth8cI1gftpl8cvVvA0aSpJ9hspjYmKD75/FqUs0yno0GMoR843bM9
         n77dqi4HfOewvPUzEtuBjZ96I8ZpIGzoaEFMakTpbAEnuscMyWocgcY6x7Jlo2DdJf
         9bO7OjMSYXqkx2IzorWrtBD8NWVU4M86sLqe2t6WKDIMJ24Qa2rqNBEUctuUe+AgOy
         SanktsE5ibv+h71c7HXbgl399kD0FvKHnv9Sb0plP+0RaXB3UQzRey8iDB/r6rmkQR
         cNCSg49BcAs/DhYBulWhxz6NR/IHtRcztjaDOje8GQAFrniHOOjcdwGeSxjP9Jddes
         G9Vbmw4lcH/7Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Documentation: maintainer-tip: Rectify link to
 "Describe your changes" section of submitting-patches.rst
In-Reply-To: <874jqd9jol.ffs@tglx>
References: <20230320124327.174881-1-bagasdotme@gmail.com>
 <874jqd9jol.ffs@tglx>
Date:   Thu, 23 Mar 2023 11:26:41 -0600
Message-ID: <87fs9vcram.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Mar 20 2023 at 19:43, Bagas Sanjaya wrote:
>> The general changelog rules for the tip tree refers to "Describe your
>> changes" section of submitting patches guide. However, the internal link
>> reference targets to non-existent "submittingpatches" label, which
>> brings reader to the top of the linked doc.
>>
>> Correct the target. No changes to submitting-patches.rst since the
>> required label is already there.
>>
>> Fixes: 31c9d7c8297558 ("Documentation/process: Add tip tree handbook")
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> In cass Jonathan is picking this up:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

I've applied it, thanks.

jon
