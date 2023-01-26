Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945F067D3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjAZSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjAZSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:20:30 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B855EF9C;
        Thu, 26 Jan 2023 10:20:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 748B22D3;
        Thu, 26 Jan 2023 18:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 748B22D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674757229; bh=9h5c/Wc/TnQKi8hrEAkk6qxaNidEx19xoyRt26ZvJQQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TqTY6znsRo+VoXIJG+5iKdD/+S4ir0PYxv+9iwcakv92fm3PV34aPIRNPKNMDD7An
         KTjC5siMllNZ45tAMThh9FaYw80MRY8DmneyMvQJXXS/RKKEh5LsX/74mZsIgxdOq2
         YCHAGEH4nKawqTLz1Sgm5m9vayCq/JMV0EthRD2eqakYhsQg3VQNFT5qvCzszdegMn
         CGBBnXQ8CtSxDXcGQlS8kX7/iNH5Hhz3+G5TGbL1x/G1QZOF3TtnkaQmZezQUFO/U4
         jb7FxC5UiykidLXKSDGB2C+LddH9qhzeBD9/1dKneJutaTXxlSWdGwPHGqRPH9hv8/
         s9arfc5auaRkw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: leds: fix the following docu build warning
In-Reply-To: <20230125154426.12464-1-skhan@linuxfoundation.org>
References: <20230125154426.12464-1-skhan@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 11:20:28 -0700
Message-ID: <87mt659mz7.fsf@meer.lwn.net>
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

Shuah Khan <skhan@linuxfoundation.org> writes:

> Add leds-qcom-lpg to Documentation/leds/index.rst to fix the following
> doc build warning.
>
> Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/leds/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> index e5d63b940045..b9ca081fac71 100644
> --- a/Documentation/leds/index.rst
> +++ b/Documentation/leds/index.rst
> @@ -26,3 +26,4 @@ LEDs
>     leds-lp55xx
>     leds-mlxcpld
>     leds-sc27xx
> +   leds-qcom-lpg
> -- 

I've been meaning to fix this annoying warning for a long time, but
never got around to it.  Applied, thanks!

jon
