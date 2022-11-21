Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AA632E46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKUU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKUU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:58:10 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92FC6BE0;
        Mon, 21 Nov 2022 12:58:08 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F170377;
        Mon, 21 Nov 2022 20:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F170377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669064288; bh=0Y5tJr46hEduzSZqIT6mT8bVO6wGD5twAYsqE34sHA0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kd1w4jN5fSAddXUgstqgCLIDtwUZGYQ9v07Kf/lupnhNL0kG7mRU6v0wNL2mz+bHC
         sLVCpecopH00dEYM28PAiEKAi34XMBuGdZGokYkevv/yPNAxIKF1iiMRTcvZI2eLpn
         l3pmolATFkRj1T5MirW6/UdMcdyPUt7wPxBC2Jf/51rqZrcEQDWqpLn3h7SMLsJlAH
         ynQRL6hsmm2tOYVPeP1uX66CA+lmdB3Dc3oMNB/8AzlCbY9TiCXQyghqSBW13cEyFB
         rgu7OdFAmNnpUwFsxMYrSXYiPEMdkPSsy5EjMka8uFGdhd/HLUVTJmpIKNPsCvw1xb
         1XzCnqxxWdpBQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, lukas.bulwahn@gmail.com
Cc:     Dhaval.Giani@amd.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bilbao@vt.edu, ojeda@kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
In-Reply-To: <20221118170942.2588412-1-carlos.bilbao@amd.com>
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
Date:   Mon, 21 Nov 2022 13:58:07 -0700
Message-ID: <87wn7o9g9s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> This cover letter is also a call for anyone interested in adding new, more
> up to date references to kernel-docs.rst. The document has been abandoned
> for a while but its original goal is still important.

FWIW, I made an attempt to update this document a few years back and
concluded that it was pretty much hopeless.  What is there is
ancient...what do you replace it with?  There is a vast amount of
content out there that will go obsolete just as quickly.

I'm certainly not going to stand in the way of anybody who wants to
update and maintain this document, though; I'd love to be proven wrong
on its value.

> By the way, Jon, I read in kernel-docs.rst, regarding LWN.net:
>
> ":Description: The title says it all. There's a fixed kernel section
>   summarizing developers' work, bug fixes, new features and versions
>   produced during the week. Published every Thursday."
>
> but I don't think LWN.net is published every Thursday anymore. Let me know
> if you want a third patch updating this as well.

Well, we do still put out an edition every Thursday, so it's not
entirely wrong...

Thanks,

jon
