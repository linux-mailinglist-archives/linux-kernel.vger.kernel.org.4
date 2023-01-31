Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708C6838BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjAaVg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:36:54 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33AA1EFEA;
        Tue, 31 Jan 2023 13:36:53 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6847B2D3;
        Tue, 31 Jan 2023 21:36:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6847B2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675201013; bh=Y8EX7Xm7EO7rFx7DCGwhYFEcakiZsVDGA+4vdrgTolc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DKDbVL2sJZzJ7dUG7ZzefHQdeo4+za59VyE9Eq5NehFLvbVp6kR5v7bgoYGCBElfK
         ROAGEkshtKU0YyUpF9m4K4X7NAszXs5RLfbFpkdpScBXHKrKymiZ/Z7BBj0xS9v6Le
         VxZh9pofetOeJXC0ku+CHGz0yELQdcwoaNu9q4NBarwdRf4PY4p10X1RED4yrqu0s7
         uRYTNQKEwm/+nLkqmkYqXohBSC3/pVDie8FTAU2CpvRfUI91TCgEL9NO0sM17U3ESd
         M0nIICEe2zRx//Vb03QL9Frgq6Y1mFZkHHvTa5Y3hNkZSNthisY4YcoRPPou65gmIs
         1AaQyWHh9pCbw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
In-Reply-To: <20230125181840.3007341-1-carlos.bilbao@amd.com>
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
Date:   Tue, 31 Jan 2023 14:36:52 -0700
Message-ID: <878rhi2xor.fsf@meer.lwn.net>
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

> Translate the following document into Spanish:
>
> - process/magic-number.rst
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |  1 +
>  .../sp_SP/process/magic-number.rst            | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/magic-number.rst

I've gone ahead and applied this; if magic-number.rst goes, this one can
too :)

Thanks,

jon
