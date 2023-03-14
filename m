Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1A6B9E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCNSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:21:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C995E2A;
        Tue, 14 Mar 2023 11:21:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF54944A;
        Tue, 14 Mar 2023 18:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF54944A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678818078; bh=PMcKPQGre2B2gIl2+R6vogcNUKCYa7zH3FQuapRObUs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HF0BY4mpmcvSKC/Z0pw65s9prNYPwYnX+160bpFrhNj8ZObEM8XC2WEPcmRV9gmIs
         0pgjvavWLw1HI4RoIKXtKvvSd5yZ94xF9zwNCXTebltFIlMtaxh3R7mlK0CUGVpd+C
         z0U2wNVRxmAUlOC9KO+MrEi/vccOxOlnmkt7x/8nHX2gmdbnP7EG++Ih0SiRkVYzbx
         yBh3s9vjwmyhyPGRCY+Mi8JPv35WbCyOGZkxOrQplZIymPGkP1/j01KZQfEzgaBS5x
         d/+K4WBvM2wnqjkiihk7ZqGly97W/IPZEab72qfikSXltamKQuTyTrJrtNJYWP+Io9
         3iFZP6qxhBAFg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, sergio.collado@gmail.com,
        linux-doc@vger.kernel.org, akiyks@gmail.com,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v3] docs/sp_SP: Add translation of process/deprecated
In-Reply-To: <20230310163651.2500175-1-carlos.bilbao@amd.com>
References: <20230307134502.625671-1-carlos.bilbao@amd.com>
 <20230310163651.2500175-1-carlos.bilbao@amd.com>
Date:   Tue, 14 Mar 2023 12:21:17 -0600
Message-ID: <87mt4fry76.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Translate Documentation/process/deprecated.rst into Spanish.
>
> Co-developed-by: Sergio Gonzalez <sergio.collado@gmail.com>
> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>
> ---
> Changes since v2:
>  - Change SoB chain, remove From: tag
>
> Changes since v1:
>  - Change commit message to avoid confusion
>  - Add From: tag
>
> ---
>  .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   1 +
>  2 files changed, 382 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst

Applied, thanks.

jon
