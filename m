Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CF67A59F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjAXWXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAXWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:23:35 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD404523F;
        Tue, 24 Jan 2023 14:23:34 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5889699C;
        Tue, 24 Jan 2023 22:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5889699C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674599014; bh=Ft2ulHLDz1m2tzoU3sxJIQBkkOU+9wH41AFiUCgDGIw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hKETxO20ZrAtMUEfyf448vYdpkHcasrqDMK96q0uaM5gTin863wloY4ZdusWzd1Dl
         531flfsGITSdiI7BV0vNZ+IWMZKSTEslChfUjstTca4gK3GHRI3rDVqYZLFLz8JavL
         P9jV/ATIoavD1Wa2cMfbw06y+ep5S/v85HyXJqcMeUnFMxQkM8qEK2C6UgR7VWyovx
         l3+PQXeDaEuF5LKNcliAB1uoRwufhWITV06jpW03A8d3IT+1GR2plY7tiS485SlcKv
         2ZhoMl25QbpLWKmivhFFxlqYpID9gMf7LaVlyB/V2IAK0Y80SK3u5ZNrRELCjJ3BtY
         bNckbf8Wso4mw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v2] docs/sp_SP: Add process email-clients translation
In-Reply-To: <20230117144722.31195-1-carlos.bilbao@amd.com>
References: <272c6c52-767f-8b3d-ab37-4bc7d3161fff@amd.com>
 <20230117144722.31195-1-carlos.bilbao@amd.com>
Date:   Tue, 24 Jan 2023 15:23:33 -0700
Message-ID: <87ilgvfu6y.fsf@meer.lwn.net>
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
> - process/email-clients.rst
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>
> Changes since V1:
>  - Remove duplicated paragraph left in English
>
> ---
>  .../sp_SP/process/email-clients.rst           | 374 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   1 +
>  2 files changed, 375 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/email-clients.rst

Applied, thanks.

jon
