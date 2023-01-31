Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705836838DA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAaVq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:46:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9C58652;
        Tue, 31 Jan 2023 13:46:25 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E0D3F31A;
        Tue, 31 Jan 2023 21:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0D3F31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675201585; bh=NAp699De6hwTXdrDETC2+efXXODw+sPFWDbGR5pRVOk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UaRONo/75H5JemdKcTotxkchApEm4lwQbxLippYI63fTf87EX8mumbH0oHltOcU0I
         a88w8k3rjawD5yXvaD3KBdFLDle16pTNKoTY8GrBTSlRDTH7N3GXGIHrfG5P70DAAT
         jR2gcDWkkqOFrI4v8PXD/1KTYzEXXdjSpkUcc4ZVGUb0FULfJROqEPGonMPkgsMkhM
         4J/EZp9Adz41oWqZeDbKJH1JBiXe9/SY+rVJLe3RoGlwSETjjgNCyOGGME6+zoSd9w
         Csn8fy41vfYnAqaaOnHPD4YkL8EnOuITkr/Yl7pjXA4CPCvaDdOoX80GC4l8i3zbW8
         o+jwwcpQydcqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
In-Reply-To: <878rhi2xor.fsf@meer.lwn.net>
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
 <878rhi2xor.fsf@meer.lwn.net>
Date:   Tue, 31 Jan 2023 14:46:23 -0700
Message-ID: <87357q2x8w.fsf@meer.lwn.net>
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

Jonathan Corbet <corbet@lwn.net> writes:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Translate the following document into Spanish:
>>
>> - process/magic-number.rst
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  .../translations/sp_SP/process/index.rst      |  1 +
>>  .../sp_SP/process/magic-number.rst            | 90 +++++++++++++++++++
>>  2 files changed, 91 insertions(+)
>>  create mode 100644 Documentation/translations/sp_SP/process/magic-number.rst
>
> I've gone ahead and applied this; if magic-number.rst goes, this one can
> too :)

...of course, the robot already pointed out this new warning:

  Documentation/translations/sp_SP/process/magic-number.rst:16: WARNING: Inline emphasis start-string without end-string.

I took the liberty of changing "void *" to "void \*" to make that go
away.

jon
