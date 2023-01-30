Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC1682010
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjA3Xwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjA3Xwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:34 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2772B28A;
        Mon, 30 Jan 2023 15:52:32 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 84D886E2;
        Mon, 30 Jan 2023 23:52:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 84D886E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675122751; bh=6cM/5l8yxa9TBrASucAMh3wX/O29p+Di+yDhLyRd/+U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aywlhFlQfze9crdMnaM2QoYgsrl4orc1gjt4b4xbYodqNrOQVHztPxR4oO7gSr+Nm
         GWs4pCX4ZjBBrpZuKdBftiK2XtONfVIx7FjVCgyTT1nu42cbcnkccLJoL6YJloSJna
         DTd0OZm9Gitx0aXi7cB0sHhUv1NxAwDofOPm0U+UDMkP9ZSwGg9obgyS/nEyA19R2u
         mnG5FPZ7PAA9lOA2i6dFQYcFFwvambsorf7gofGzibgtfbZQjVeA10MoWZBmkAW9LR
         hSj/R6zXhZ4iXK6MmJ0N/aEA4/JuQRBfaeGgs4uFCzzFlV3gEBknDb0A7p9m3IUhPN
         1xk2396uPexfA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
In-Reply-To: <021776e6-b37f-0a2e-41e0-5c09f9582c57@linuxfoundation.org>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
 <f48e8dab-2a68-88d2-7917-f8f34a39e322@leemhuis.info>
 <021776e6-b37f-0a2e-41e0-5c09f9582c57@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 16:52:30 -0700
Message-ID: <87o7qf4m2p.fsf@meer.lwn.net>
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

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 1/28/23 01:35, Thorsten Leemhuis wrote:
>> Adding another section that doesn't seem to a be a good fit feels a bit
>> like "making things worse than better".  So wouldn't this maybe be a
>> good opportunity to create a totally new top-level section for
>> application developers and system integrators, even if it's tiny for
>> now? The audience is likely big enough to justify that -- and the topics
>> are likely different enough, too (of course sometimes there will be
>> overlap, as always). Any maybe it will help to bring other stuff over
>> from admin guide that is more targeted for application developers and
>> system integrators, which will help to get more structure into the
>> admin-guide.
>> 
>
> I like the idea of creating a new top-level section for application developers
> and system integrators. I foresee this section growing and also we can look
> at other documents that are a good fit under this category and move them over.
>
> Jon, Thoughts on this.

The fit with the admin guide caught my attention as well, but I didn't
immediately have a better place to suggest.  I am somewhat resistant to
creating another top-level directory; I really want to have *fewer* of
them.  I certainly don't want to create one for a single document.  My
inclination would be to leave it where it is for now; we can always
revisit this if it turns out we have a lot of material that justifies a
new book.

Thanks,

jon
