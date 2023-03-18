Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C546BFB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCRPzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:55:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517DD51C;
        Sat, 18 Mar 2023 08:55:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd5so31339968edb.7;
        Sat, 18 Mar 2023 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3UO8wzFd4aDziiIRlbrp66em8AxKDsXrNqmK59j0eU=;
        b=T1kpCmA2VnCK8TwDDuxgKqbAw4Ap11fR0DgIXgLOtdaI2KiQ4Yof1xVDuZpWdl8eRB
         EKn1tC5AlGXEGkLYVNnv2bXOHljJUl1FTPpu1xW60bnPuLB0u7m/cD2Ii3+Kymv/OKmR
         GvMfH+vVXgw8w2POChIHOIURVGwXrerXVbyBpsHjglIrHmBPcFX9BGZ4opPujmNBLX3w
         n9XGh7nNZx2KcYSvXs4ocPzKZmX3KMuQ3hXoyLDsqkeB2gRY/IbRZ+ntmW2MwQwQetZ3
         uOLXwSGQzdwP4OB0GLzZGJUN2wt/cQ8UUWSt+/3UaUaCVjkHX/popBj3OyTNzrebnj32
         xerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3UO8wzFd4aDziiIRlbrp66em8AxKDsXrNqmK59j0eU=;
        b=0yDWVMVCKxvjfZ3WzXm67DIPWvkqjGEelzRcZW0s861LmZ1ECkEgS3/glNABr5KZmI
         sbL3rWj40335JT1IbZrEfSBqnEufouHPARt/frk8ehEZ/EsS4ievMbOSy3s0LRQBvhAP
         xu7J0lqta0NLG+aFm1Ccar9f062KpD6wua8zUKUPx+gePSGfvekgU6ArhBLQ1mo8V0vn
         fYWKUggHkiY51+FP9iJf46OJbL9QRCfQ+HPcFW3KZ9n8HEyqBGsSyxjejVjpRdW+sIkz
         fs+Ht5VQPsVXOCbv67cJtr1tWmJreYFOaEo+3jKurXiSIlN46MtnDYmKjCeVFuxxucFC
         N5QQ==
X-Gm-Message-State: AO0yUKXG87ubvJi0VaP51NVznlDNBHtRvGNV9reRyhfjGMr9YxvAjQay
        KwPg7FYD574Ns/WmO1m24m3FKS1VlRA=
X-Google-Smtp-Source: AK7set8s/BKHh9Uy1ISUENON8/STQ03PR59ZEiKoxmPNVkM2ouU8+2AmaFxMMFxU04SWFW0g+zf3VA==
X-Received: by 2002:a17:906:6886:b0:924:d90a:6f97 with SMTP id n6-20020a170906688600b00924d90a6f97mr2891041ejr.13.1679154944901;
        Sat, 18 Mar 2023 08:55:44 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709063f8700b008eddbd46d7esm2308886ejj.31.2023.03.18.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:55:44 -0700 (PDT)
Date:   Sat, 18 Mar 2023 16:55:42 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <ZBXe/uHMg9WapRgX@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <ZBRYFb7iGSRsRvgT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRYFb7iGSRsRvgT@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, 

On Fri, Mar 17, 2023 at 02:07:49PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 12:48:34AM +0100, Mehdi Djait wrote:
> > KX132 accelerometer is a sensor which:
> > 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> > 	- can be connected to I2C or SPI
> > 	- has internal HW FIFO buffer
> > 	- supports various ODRs (output data rates)
> > 
> > The KX132 accelerometer is very similair to the KX022A. 
> > One key difference is number of bits to report the number of data bytes that 
> > have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.
> > 
> > A complete list of differences is listed in [1]
> > [1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1
> 
> Is it really the first version of this contribution?
> 
Yes this is my first series for the KX132 Support. 

--
Kind Regards
Mehdi Djait
