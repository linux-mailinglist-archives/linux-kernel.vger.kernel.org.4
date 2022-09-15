Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621C65B9C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIONjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIONjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:39:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6712A9F;
        Thu, 15 Sep 2022 06:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9C33B82054;
        Thu, 15 Sep 2022 13:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18B0C433C1;
        Thu, 15 Sep 2022 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663249185;
        bh=EnFkkERMLTpjtQ/t2B9lWfX7du1ItkBYOZh8dr/GFKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NY7iVb7Ut5hSSPuz+7lWrUwDsbFrpB/e1y4EII6GH3M/gG188ldhGty/zkAjGJAed
         GTLt95JXYdws18O3ky3bEYUuiJlihHAkQ3RqrEAD4roIaSpSbUXXhb4PuLE8yuVjbO
         0cKd0tH2u/wHhIAstRBLsVmBsoCBkLge/vKauvDw4n/AksVMn6ibIyAotxFjgDFrCu
         EhxmUtrlgRxqTq4Wr0y0IAzmHRK93fTxkx3srIE4DpX6dnpk6/7E3IE/Wi2sZfk2O7
         UNV0s9dpprajNQX9UNDbdULpYUBBwCLWp6jYhoTRu4xjdgGfo3q9V2nShCw8SC5eYu
         HJQ8WOQjQ5+Nw==
Date:   Thu, 15 Sep 2022 14:39:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: bmp280: fix datasheet links
Message-ID: <20220915143944.79348ecb@jic23-huawei>
In-Reply-To: <20220912222645.377874-1-ang.iglesiasg@gmail.com>
References: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
        <20220912222645.377874-1-ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 13 Sep 2022 00:26:44 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Updated links for BMP280 and BME280 datasheets on Bosch website.
> Datasheet of BMP180 is no longer available on the manufacturer's website,
> changed the link to a copy hosted by a third party.
> 
> Changelog in v2:
> * Added a notice about the situation with bmp180 datasheet and list
>   missing changes from newer versions.
Change log needs to be below the ---

We don't want that level of detail in the git logs.

I tidied that up whilst applying. 

Also, it's not a good idea to have new versions as replies
to older ones.  Leads to very deep nesting in email threads
and generally makes things less readable.  Just post
a fresh series each time.

Applied to the togreg branch of iio.git and pushed out as testing 
for 0-day to see if it can find anything (rather unlikely on this
patch!)

Jonathan



> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe7aa81e7cc9..01cd32003ca8 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -9,9 +9,15 @@
>   * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
>   *
>   * Datasheet:
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> + * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
> + *
> + * Notice:
> + * The link to the bmp180 datasheet points to an outdated version missing these changes:
> + * - Changed document referral from ANP015 to BST-MPS-AN004-00 on page 26
> + * - Updated equation for B3 param on section 3.5 to ((((long)AC1 * 4 + X3) << oss) + 2) / 4
> + * - Updated RoHS directive to 2011/65/EU effective 8 June 2011 on page 26
>   */
>  
>  #define pr_fmt(fmt) "bmp280: " fmt
> 
> base-commit: 2f61ff8272967c9bdcba810aa978170814b08f7c

