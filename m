Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC725E5414
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIUT65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:58:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E1A3D27;
        Wed, 21 Sep 2022 12:58:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 18837536;
        Wed, 21 Sep 2022 19:58:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 18837536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663790334; bh=lf9Ox5RC0j5yk4zNZL0BJ1t4oik3bdS9NrjeDjQK6zI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M7ZPuK5fB/12pAmQEupqIwyTVMyCWBuD1b9CazOAqLBl4HzlMlq5Pos6M4jxuMRM8
         Lw643V5BlGC+9cu+YrIJRHyy9AjVfku0OlT1ELrPiNGAHXGikMv77aCDY3NTxeD2PG
         cHpnAF2JJpZPnDnbkVQXPL1cZgm/fSLMiWLO7J8HdsKF2VbHh8bXC4wCB/HG+zmSvZ
         mpO0ZFk2ZveXK03lgGrfP310wUUjI7ex5TgwhRAzkaDwWxuvqXsfxOJRubwCGr4YrF
         jdRzNCocREDf7sc7lCoFeuNqe7VGcbyi2UIq8IfQzXsBPGYalS3zJKinr+zvh+uf2S
         7VZfLg+0PCO5Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rong Tao <rtoax@foxmail.com>, krzysztof.kozlowski@linaro.org
Cc:     erik@kryo.se, jkosina@suse.cz, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@leemhuis.info, lkp@intel.com, ojeda@kernel.org,
        rdunlap@infradead.org, rongtao@cestc.cn, rtoax@foxmail.com,
        tglx@linutronix.de, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: process/submitting-patches:
 misspelling "mesages"
In-Reply-To: <tencent_924BF0B25425E2D5673409D1CF604F682505@qq.com>
References: <2e4c52b5-85e8-6951-8248-961c2cdb13e7@linaro.org>
 <tencent_924BF0B25425E2D5673409D1CF604F682505@qq.com>
Date:   Wed, 21 Sep 2022 13:58:53 -0600
Message-ID: <8735ckwlc2.fsf@meer.lwn.net>
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

Rong Tao <rtoax@foxmail.com> writes:

> Fix spelling mistakes, "mesages" should be spelled "messages".
>
> Signed-off-by: Rong Tao <rtoax@foxmail.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/submitting-patches.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b..7dc94555417d 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -715,8 +715,8 @@ references.
>  
>  .. _backtraces:
>  
> -Backtraces in commit mesages
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Backtraces in commit messages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
Applied, thanks.

jon
