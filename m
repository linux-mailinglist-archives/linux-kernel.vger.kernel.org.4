Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E29632E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKUVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:13:25 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775D2870A;
        Mon, 21 Nov 2022 13:13:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 06B90377;
        Mon, 21 Nov 2022 21:13:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06B90377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669065204; bh=Iol520HD+IvmDQhHhMYX8VqVgTTrliIv7/NunxcRzSw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P0qbGBW72V5dL5o7xsu+tijozHEwBAY8hkEtmpiyJs46wLi2Vh6DZza8ZIZb43xaD
         DpX4Khb2shfPeUcuG2zo6GKFGDGlfhNEXnD1PKVinKyjdxhYmsZzfGqra4aaWQahVv
         Ywh4JrROcpoWzL5GDWQuTRJctd74Ks13+Q1yoyQe48oLRxrPYOix8n4Ha1M3WF99ey
         DM8NpJ3Exau1jiZngC0ImHCslOTl37bbIeGXFJLZd1YYmB8N826cIZeK/7Ad+EEJCT
         zsFzAgKHthNCeynfrP6yvn8He6v/7InIXVz6Q9owSjAXu7Nh/G5pgDxsrOC7yjkCQi
         34+sSgDX0OOKg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process coding-style translation
In-Reply-To: <20221115184737.712625-1-carlos.bilbao@amd.com>
References: <20221115184737.712625-1-carlos.bilbao@amd.com>
Date:   Mon, 21 Nov 2022 14:13:23 -0700
Message-ID: <87bkp09fkc.fsf@meer.lwn.net>
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

> Translate Documentation/process/coding-style.rst into Spanish.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/coding-style.rst       | 1315 +++++++++++++++++
>  Documentation/translations/sp_SP/index.rst    |    1 +
>  2 files changed, 1316 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/coding-style.rst

So I'm kind of slow, I'll admit...but I have finally noticed that you're
not preserving the directory structure used for Documentation/ as a
whole.  Is there a reason for that?  We've been (slowly) working to
organize our docs in a reader-friendly way, it seems unfortunate to lose
that for the translations...?

Thanks,

jon
