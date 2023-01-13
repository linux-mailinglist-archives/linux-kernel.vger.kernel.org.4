Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82433669E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjAMQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAMQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:47:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7F7814C;
        Fri, 13 Jan 2023 08:44:58 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C8E5D733;
        Fri, 13 Jan 2023 16:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C8E5D733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673628297; bh=I6rm7KzONNVJMxFe3CSWGLez9rLB0K0wtheNbQk0RTg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Px3iMEjwOXNwv9qHZSYHlwRKgWqhzDzT5j2jDTpRSLSBMfqK4zyBckYDO096GZi+r
         c/n3HW579SEbB3r0lSH/Rb9To2supz/hrcIQyuamkZW0/s4oYKgDtk9Na7nShk14Gc
         7pe5fbuPPIp+r1fNymFziv16celjWc3bfFmIybD9cvj5ctadLNBmReAofhitcmRCSl
         rJ2iIJNdfYkZ/PYXXizk5tKnjuBlvl/FwYUSHl8BJl4zxxSmbuuCqaFkEiV91ISqfs
         TbLf5pHzu84K149myIQ6z9H4AzmenGo4Q+Ch7RgVLXf/8ce/ELw/NcbcX2fqJfIkjO
         yEXJc792fdgpw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bilbao@vt.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process
 kernel-enforcement-statement.rst translation
In-Reply-To: <20230103165608.134190-1-carlos.bilbao@amd.com>
References: <20230103165608.134190-1-carlos.bilbao@amd.com>
Date:   Fri, 13 Jan 2023 09:44:57 -0700
Message-ID: <87tu0uqt86.fsf@meer.lwn.net>
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

> Translate the following document into Spanish:
>
> - process/kernel-enforcement-statement.rst
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../process/kernel-enforcement-statement.rst  | 174 ++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst

Applied, thanks.

jon
