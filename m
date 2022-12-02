Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190DB6401CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiLBINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiLBIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:12:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFC2A706;
        Fri,  2 Dec 2022 00:12:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CA8AB820F2;
        Fri,  2 Dec 2022 08:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EDDC433C1;
        Fri,  2 Dec 2022 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669968759;
        bh=1YHxaPfn8M9jQ9cv60wp0gSTaug3FBn0xd2YrhV7jFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYP2iZk3IazuD58r2b1YB2eThdPH7+E9tkUrp/bYL0LJjHSzr1Ps36EnuLz3TJD6E
         u/nUeLeLwU/Xv80EOMVitVb+DqTHy+Uy3N5VnTo3bqyjboGu30AVYs32RUrPHvl5n2
         FAZdPwGxQ1HXe1YbnuZfQHz03GVkBrl3svnKj8DBLWe4MKcmD+leML0aut6jRBH4H6
         TEjvr3crz9a9nk8/QMhHojo71lr2Rf7hqMJ0+otoOWdrggLrTAdSsgOS1i9ps4y2o2
         MptM2J6MVAYb8llwVPvQjAd0rJORjVOhBQxdTNRkq/reLkfjWGzuz5/XbXd32eR+h7
         G08dYXXQdowxA==
Date:   Fri, 2 Dec 2022 08:12:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH v1] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <Y4mzc7DieBNrYBpy@google.com>
References: <20221201041004.1220467-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201041004.1220467-1-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022, Jesse Taube wrote:

> Some devices may want to use this driver without having a specific
> compatible string. Add a generic compatible string to allow this.

I actually really like this idea.

Perhaps kontron,sl28cpld could also be converted too.

Please reverse the nomenclature though:

  simple-mfd-i2c-generic

> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index f4c8fc3ee463..cf2829f703e2 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  };
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{ .compatible = "generic-simple-mfd-i2c" },
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>  	{}

-- 
Lee Jones [李琼斯]
