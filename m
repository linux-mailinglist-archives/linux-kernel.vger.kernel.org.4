Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B735BCC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiISNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:10:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7D248D8;
        Mon, 19 Sep 2022 06:10:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so6713063pjb.0;
        Mon, 19 Sep 2022 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=CwECRUDfj5ek1SuiILc7MXkXrhecQHuVfh9a0bFcrao=;
        b=KFethV8Zdr8meLX3IgwQFIWUoGDk5IHfcOHzYlJ3X20gm8OYwvW6ru2j/cpzDoknRq
         TtD/oS3ndl4GqZbN/eWIw9ac2vffGAvaeJEB05aDdka/61Se6IRjQX4PlsdNxxab0VRC
         txzyEGBnzN4OZOy3lwGmidqz2hGMSnDxtoljBGAL26YRmr99HCm8FW6SDkXzzkvW809t
         OHbFFTO91sWF5AwpfnSpuS/3TKYx4JONVMbKaVfQmCbj3pXC11mTENfo06xKUTfkzQDI
         RnFrfpTI7WGNOU5/so1pYB90dI6OQYtWzybkvoRXBCnQyCj8rUzyCouqBj9wx8bBL7wZ
         hXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CwECRUDfj5ek1SuiILc7MXkXrhecQHuVfh9a0bFcrao=;
        b=nMdwX2+EALMz+ixC84JtxCe4tS9dCMX85DkhegkFTcQZ4lCyYswE2LiNbaH2tO/VC8
         d3LiwBxwa2CLku8D1naJE6m40c4jPGX2cVQKqZmXj/uG1tLJ7i5V8e9i3W2FP6djT3fL
         1WOZPbNDeRZ34mCB9BsNDd4cUMqctEQ7YJ+7yqhTAjWkGHapskJ3TOuxQJoMwprIcP5Z
         haQ4AyT8PPACzpG5xgfIP0R/JcCosmmWF6a7TEDND9S18UVe4cEbfCML+Omz3Wh7pGGW
         UWrVLGVxl1d8tHjZCMS2pPObiQI1zPepL25DagpoDAusewEXESfWyYzMdsYHiHus9kUU
         6mNw==
X-Gm-Message-State: ACrzQf1C/XHtoCskGPwq1Cmo5NJ4Jrdqyg1uI0OPVrS8jqAt1w+bUPSp
        t7vPigz6aDuRVv0C/4fRObM=
X-Google-Smtp-Source: AMsMyM4wVUFKy4PABfMzfDPBeZKXNbT2BDAqMgo+PmmXaAMU9oQmGxG0hstJrH/cCZZ9V+eW6fXhxw==
X-Received: by 2002:a17:902:bd85:b0:178:8e76:c77e with SMTP id q5-20020a170902bd8500b001788e76c77emr11339646pls.38.1663593038578;
        Mon, 19 Sep 2022 06:10:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78bcb000000b0053e483de200sm20210510pfd.73.2022.09.19.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:10:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:10:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 14/21] hwmon: (mr75203) add VM pre-scaler x2 support
Message-ID: <20220919131036.GA3545566@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-15-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-15-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:42PM +0000, Eliav Farber wrote:
> Add support for mr76006 pre-scaler which provides divide-by-2 scaling
> of the input voltage, so that it can be  presented to the VM for
> measurement within its range (the VM input range is limited from -0.1V
> to 1V).
> 
> The driver reads from the device-tree all the channels that use the
> mr76006 pre-scaler and multiplies the voltage result by a factor of 2,
> to represent to the user with the actual voltage input source.
> 
> Channels that are not in the device-tree are multiplied by a factor
> of 1.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, after resolving a minor conflict against commit d59eacaac953
("hwmon/drivers/mr75203: use HZ macros") from September 2021.
In the future, please base your patch series on the latest upstream
kernel version.

Thanks,
Guenter
