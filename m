Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D658641650
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 12:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLCLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 06:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLCLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 06:17:00 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF673F51;
        Sat,  3 Dec 2022 03:16:59 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC7C9723;
        Sat,  3 Dec 2022 11:16:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC7C9723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670066218; bh=kk7h3jcdGRSAY42RkxDPLTCAc0PdknwtKLmsLOObe4w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CPPYmL3PiRwrJ7rA+514mMKT7jPaBN0gWkQZie2uBryWiW7vn4QJgW/PZ3wWbhcuw
         q7ue4miG2T4Tqp3+45Hk+TPyXp1oPPIoHLp0bNV3SSv2J5LNgmggyaUMukFAnk+jmD
         1mB/VaucRNNfYTbE2T1r04LvZ9yb//XJY3XQCkDRtWtWo4NKY5Rs2miZ7EynI0omxN
         76eHgfTTgqXGs/xEFkAdFSCGwV2p7w+HlU/RX0eIB9V4sB6sO1SS6LYzY9HAVQ4w3q
         qIk2z2cs402wB2IwpMBSjJUqS7einFBW9Qtuf4m+k7H3U/+3HZLrCbZ5I6X7geeq0q
         js9OCgzeL1iWQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v2] docs/sp_SP: Add memory-barriers.txt Spanish translation
In-Reply-To: <20221128152323.4080455-1-carlos.bilbao@amd.com>
References: <6b1d95ed-3000-3baf-81ae-7794c9515e3b@amd.com>
 <20221128152323.4080455-1-carlos.bilbao@amd.com>
Date:   Sat, 03 Dec 2022 04:16:53 -0700
Message-ID: <878rjoohy2.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Translate the following documents into Spanish:
>
> - memory-barriers.txt
>
> using the wrapper documents system.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/translations/sp_SP/index.rst    |    1 +
>  .../translations/sp_SP/memory-barriers.txt    | 3134 +++++++++++++++++
>  .../sp_SP/wrappers/memory-barriers.rst        |   19 +
>  3 files changed, 3154 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/memory-barriers.txt
>  create mode 100644 Documentation/translations/sp_SP/wrappers/memory-barriers.rst

I've applied this, thanks.

For future reference, it would make life just a little easier if you'd
put patches inline rather than as attachments.

Thanks,

jon
