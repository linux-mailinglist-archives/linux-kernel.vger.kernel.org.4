Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9419F6C7BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCXJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjCXJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:42:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3823D99;
        Fri, 24 Mar 2023 02:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15B32B822B4;
        Fri, 24 Mar 2023 09:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1A1C433D2;
        Fri, 24 Mar 2023 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679650934;
        bh=RXLbJP66l+NVDx7tBnaGVTOAavKemdss5NDCGeWcfZ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jm0Xn+E3CwlJEpReaFwKvz9hTsksuJUCgPK0qLE3cS8cKrAnmZVB/+ITNIK5HWako
         4YqmR6Lk9yqksRYGaZBFj/KBo4U43/sd9GAnrjh8n1zKBh0Z+grBxq+myMHpP0uHJ2
         2DKMSMP9c885ArAyE7nHseasv0i8MxEScCkIGWiMw1GOnraTv1eK8HWEQwwiQGdEoq
         puGVUeMI+Yt6UZ635ZC50KeNNZac1BSZLdvSAUrZt3BomTouok1x+EhSXjjFERR6B0
         jxp6cfCGmvc2PPVTjccfldPc8/eAZba4qpAqcVx1BR5Gj0jqrKRJCDF58nLzptr31r
         Cf9wiuI9tVywA==
Message-ID: <172e88fc-0052-d16a-ed68-5c29ddc54bd0@kernel.org>
Date:   Fri, 24 Mar 2023 10:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] devicetree: input: cypress,tt21000: add wakeup-source
 entry to documentation
Content-Language: en-US
To:     Maximilian Weigand <mweigand@mweigand.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alistair Francis <alistair@alistair23.me>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
 <20230323135205.1160879-6-mweigand@mweigand.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230323135205.1160879-6-mweigand@mweigand.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 14:52, Maximilian Weigand wrote:
> The touchscreen can be used to wake up systems from sleep and therefore
> the wakeup-source entry should be included in the documentation.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>

Best regards,
Krzysztof

