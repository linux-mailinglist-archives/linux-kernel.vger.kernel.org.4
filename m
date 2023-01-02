Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719665B825
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjABXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjABXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:23:38 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44D7663;
        Mon,  2 Jan 2023 15:23:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C2AE2E0;
        Mon,  2 Jan 2023 23:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C2AE2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672701818; bh=9rHx4HtjJrzAzodN9BUU1PBs9AgNbanjj12TLM6hyl8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OvYMSQpZNKuOAeCBOZYBff+oke9Y5MGgqpEq141WZ/d/yje/vJf7J7TcqTe3losCJ
         ZBYCaIC4Sd/9jofPxwyfk6hmiQpYnYu6LzGh1TmcdHGGo2cyQSzsvBHnlHZS113e/b
         5e8PKtH+/c84g4x9BGjjD5kpL/nDskVE0xaKlHusZCsEBrURFrregPYmwYZbQfQYUg
         +B3Hw+cXzEccrKJxyM9B2nMAfeg7xQ8LJ1G7L2z1YF0bKiMPixyraAm716F7K4xyfD
         wO5r7kCiAYGan5A0vN8r71Y8lt/u7MbrXwkRwnqThYyQeoW/bcQX/4tMUBQ9sBc+ge
         D5/Jtkswl1m3w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     bilbao@vt.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process code-of-conduct.rst translation
In-Reply-To: <20221204000109.17224-1-bilbao@vt.edu>
References: <20221204000109.17224-1-bilbao@vt.edu>
Date:   Mon, 02 Jan 2023 16:23:37 -0700
Message-ID: <87v8loh66e.fsf@meer.lwn.net>
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

Carlos Bilbao <bilbao@vt.edu> writes:

> Translate the following document into Spanish:
>
> - process/code-of-conduct.rst
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../sp_SP/process/code-of-conduct.rst         | 97 +++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |  1 +
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/code-of-conduct.rst

Applied, thanks.

jon
