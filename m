Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046316F96C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 05:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEGDz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 23:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 23:55:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739E26AA;
        Sat,  6 May 2023 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4p4n85fkGQmzI1BRcg57TZDP2/Uobir5hS/5OnYITns=; b=vjfHSwyVT2PnwZk+qnXXObIGMS
        4TsQzmjCVRLjxbwfpNlJ6zNfuwC/rxs7rn2y2ze2kG27N2gH9+kwiqg8qO2sUsvNsKWzaYGmI5QFr
        hS84DMo5PTu069JEHhggFponUKYrNjk45KZ6L9lUZ2L166dvyk4oswPI5TpCF7sxIyU+E273CZCVp
        xC3eAWKzCVDjscfUXXOImccokmPYWORgFSdVqT6P6mP+Mjjjr7AfBUUbpGv5hG5b38GQb/7DGWoLT
        FAzBXxncSgnwUEMcHTyMhsXiR1BsFIo5/chMHxorLnnBKqM9RQi8PcKDab1x4WCIFRR/Q03xfHDEa
        x5LvJ+Mg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvVV5-00F6KE-0H;
        Sun, 07 May 2023 03:55:55 +0000
Message-ID: <d7495c1c-4931-2056-90f9-56080adaf2d5@infradead.org>
Date:   Sat, 6 May 2023 20:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: confusing documentation about Development Process
Content-Language: en-US
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     open list <linux-kernel@vger.kernel.org>
References: <CADDUTFy29Cn6y56XLB-me0FneXrMED0LuHLb-7KD_NoiXZSZrg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADDUTFy29Cn6y56XLB-me0FneXrMED0LuHLb-7KD_NoiXZSZrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Costa,

On 5/4/23 22:39, Costa Shulyupin wrote:
> There are five topics named "Development Process" or "Working with the
> development community" or both.
> 
> It is clear that these topics are related to the development. Some
> content is overlapping.
> 
> Questions:
> - Is it by design or chance?

Chance. (I would probably call it evolution.)

> - What are the principal differences between the topics?

Some of these are much older than others, so I would say that
currency (being current) is the biggest difference in them.
And also the level of detail that is attempted in each of them.

> - Are there any outdated documents?

Probably. We aren't very good at removing documents from the kernel tree
unless a complete driver or subsystem or architecture or platform is
removed.

> - How should it be?

Good question and a fair one too. We (mostly Jon) are attempting to do some
documentation reorganization but it's a slow process.


If you have any specific questions about the kernel development process or you
have specific suggestions about documentation changes, please be forthcoming
with your specifics.

We know that there is a lot of cleaning up that needs to be done, but
combining documents is a fairly low priority IMO.

Oh, and you can always send patches as well.  :)


Hopefully Jon will also make some comments on your questions.


> References:
> 
> "Working with the development community":
> https://docs.kernel.org/index.html#working-with-the-development-community
> 
> - "All development-process docs" linked to "Working with the kernel
> development" community: https://docs.kernel.org/process/index.html
> 
> -  - "How the development process works":
> https://docs.kernel.org/process/2.Process.html
> 
> - "A guide to the Kernel Development Process":
> https://docs.kernel.org/process/development-process.html
> 
> Development tools and processes:
> https://docs.kernel.org/index.html#development-tools-and-processes
> 
> Thanks,
> Costa

thanks.
-- 
~Randy
