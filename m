Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F715682FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjAaOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjAaOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:48:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219C4B183;
        Tue, 31 Jan 2023 06:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2C44B81CF0;
        Tue, 31 Jan 2023 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CD1C433D2;
        Tue, 31 Jan 2023 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176492;
        bh=F6JyWRgDftCpOwzvpx26cDcIZprmiXtf6DPo3FZrSI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Llnt0Kx4ZZ2Hn//lwHuBwO5l4/44WPoXGmjtphujJRxvXOmde8SB7Sqy8NuGmJOSk
         maPd4Ka6l4qZZimPvguhtrE7lFK8pzRdwmQYKaAvTFXtodcat7gXpqOUf/MAEH0QWP
         IQMyv2vXu1ia7jQlG4s4427SJzNnKMDVpObVXGghXBM24Eah/bKoqGDIFIROZywqLl
         HWMw/nnJRjTxgeHt7bTinPvaJkvbyafnPa0AM3euc1fMECOlrcaJFOFINN3Z82QIO6
         C1Tx3stJFWnhjOMrhbswExPXBC8EI0UoxTEwjg+c8eCFex8PIUyjZBEJbBAf/wQjOx
         O5NPKg4UDVWFQ==
Date:   Tue, 31 Jan 2023 15:48:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] Docs/hwmon/index: Add missing SPDX License
 Identifier
Message-ID: <20230131154807.021cfeb8@coco.lan>
In-Reply-To: <20230122213650.187710-5-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
        <20230122213650.187710-5-sj@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 22 Jan 2023 21:36:46 +0000
SeongJae Park <sj@kernel.org> escreveu:

> Add missing SPDX License Identifier for hwmon documentation index file.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  Documentation/hwmon/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c2b3c1a822dd..2186d732654f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===================
>  Hardware Monitoring
>  ===================



Thanks,
Mauro
