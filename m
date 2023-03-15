Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92666BB57A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjCOODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjCOODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:03:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1E23C62;
        Wed, 15 Mar 2023 07:03:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1317993wmo.0;
        Wed, 15 Mar 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678889009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIk3ogv3pUdC7KwTvWg8R7IPOwtwSacY2eCQ4DVoSyw=;
        b=DhcNMjg36eUyCZu6ESsusG9qEqjaDiku8RyxJ9JQ5O4rOyvTH8Jii5N6Hw75QSECp3
         YPKlKhvmRV9mQ8RmIxvEPO9PXLb5c9gH/lXlQkOeFd00PXXPoKra/wqebmzCt/MniQr0
         RRr3XZjIN6ulRMO98Po1CAdXZKJq51jQJLeJcLCQ/OPWe+mH/j7aCAyLeoNnK2qZfAYr
         moZzn/fIP9zx1i51U/LAjhNu+L9ho6c34uRIT9mfUILwxCBZW060XcpNxgmJr8SrJHND
         iqzunKvoqnkQ04Eu0/VApr3FNVHxVyIMVpD1aC1K2zd6k8BF0P5d0sY3fHMH+nsiG39l
         6SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIk3ogv3pUdC7KwTvWg8R7IPOwtwSacY2eCQ4DVoSyw=;
        b=eJPT/RclC1d6B15/4SBVtheEQTpDfkm0dcqkC+1yNiFCztuHJBhp+KSNRid5lI4wH8
         b08paWUMo23MGwtjIZSR5Kb83fxselSMz44vCJOA44M8yMtuDMv7FtnaNj6yjMjMjQBr
         zz7FRKA3pir0XN3MCyem+RcERkgqLKlC4At6k4xB8luw2sUydncIv78RARc2PlBXifU9
         PLJw4fuFVUj4O8k/tCGtQj6sccoM0Ik6KKGe0oA/BKI39tLD9p03gCdmviKSq2U/DMBt
         HeuhnWnJdThvI0/3GrjtX8ABZROfYFaRSR0lqxQ+Z+uwQPNknuJohN7jORslGYPBdFk2
         hRSQ==
X-Gm-Message-State: AO0yUKVPdi5KhNq6cT6Yd9d4GwbC09/zDtUNGQZ0PQNAUSbKNkgg3vnL
        MeP/ynaxIs0DCn/oH1O0xrtXt6U1rct2VQ==
X-Google-Smtp-Source: AK7set+96i3xc8VHHtOjLteM5z+uwSmEOg6a1WnipirrplHwA+cni/zDDYAcWHcmCNkqwSOh+2nBpA==
X-Received: by 2002:a05:600c:540c:b0:3eb:25ff:3446 with SMTP id he12-20020a05600c540c00b003eb25ff3446mr18054106wmb.4.1678889009322;
        Wed, 15 Mar 2023 07:03:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm2211614wmb.15.2023.03.15.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:03:25 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:03:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux Kernel <outreachy@lists.linux.dev>
Subject: Re: Outreachy
Message-ID: <8a30c3d1-a1a4-468c-a9f4-d15e0f418ef6@kili.mountain>
References: <ec13bbba-88ec-64b0-58ae-eee8617990b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec13bbba-88ec-64b0-58ae-eee8617990b8@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 03:17:28PM +0200, Menna Mahmoud wrote:
> Hi Mentors,
> 
> 
> I am Menna, Outreachy applicant and I work on my clean-up patches.
> 
> Is it Okay to work on this error reported by checkpatch script?
> 
> 
> drivers/staging/iio/frequency/ad9832.c
> --------------------------------------
> ERROR: Use 4 digit octal (0777) not decimal permissions
> #256: FILE: drivers/staging/iio/frequency/ad9832.c:256:
> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);

What???  Is it complaining about the 0200?  That is octal.  Why is
checkpatch complaining about this?  Am I wrong?  Maybe I am misreading.

I could investigate, but I am leaving that task to you.  It may be that
checkpatch has a problem and you can fix that instead.

regards,
dan carpenter

