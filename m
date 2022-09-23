Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26EB5E8241
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiIWTCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:02:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E3121E5F;
        Fri, 23 Sep 2022 12:02:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so1081228pgb.4;
        Fri, 23 Sep 2022 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2k6HWGdDwy1kgtlm0Nt4fQqupyR8236/Bu1w1by3LAs=;
        b=dVrRFyyuNGoSyIKd5EN9JP6JaufLfb+hAWGRoCqCrISYhk/gq4U6bTsDPFueKEWbWm
         5/9cBqBNcYnemStf4MKPcyT8w9p5TkmRAWcEOnlxVdi8k8nTZN49hz6UFhwDOGSPxxE1
         05bmzTSnk/eNwKsZbT7cgfp7uLMdV4/dSUTvjPzVUhLc2+yEbLeTKETOxa+Lxu8MaMK4
         Byex7s1zT5Bv/YB1iaOa7jciZGkUyMureB3YF2NOpaD3LbRfDCjfkgTLTJjpV5VOx6xf
         SLt+55+SsZExgY89hl8nOzOTy4Dgmn9VgDAHRgrCT92B7Dff4WKbLXLNvWTymAmBRaF/
         wsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2k6HWGdDwy1kgtlm0Nt4fQqupyR8236/Bu1w1by3LAs=;
        b=0PB4a5Vr8u+oR2FH2HDK2nQ7YrgUkaicaABSQE2De7n/2dnFgu+KyziQ6HNJzK3AmW
         tJsCr+GNsfNriDww9g520TfbdsoGiQVYdGbEW2hEBIsZbsiNXH2eoRyIe1iWEMcSpnj8
         lZjik/u1eSAKvr413JF6ijwZHgR9wGWVG7HcVyAgdVcG+56/9b0Jv+GjTky/3xXicpaS
         vvM6utBB4rJPugdtM+6kVqvBPbY37s3pcVACya3SrHxryP0qkqpYuGOz2wt+3PTxFP+r
         cWIv/EL7caaZUQEvrkHpDURL7FW1dIHRjAxjUe8wB6vC/2LuYD5VpEphxSaK8swn5DKO
         oyoQ==
X-Gm-Message-State: ACrzQf1XQ/XMmMFFBM09Ial7w7Gy3xE6oiyCYt2uEi1+tocYo+G8zXVQ
        RSqPv9NOMlhS/l2Dk+5MU4I=
X-Google-Smtp-Source: AMsMyM6r1vIyoygUuNBLpDm42819FRt1OzlwGdTpj9n71z/BhQxDlC0COTYkXQ/fDNbF56Hsfzp8/g==
X-Received: by 2002:a05:6a00:1a94:b0:548:8ce8:db93 with SMTP id e20-20020a056a001a9400b005488ce8db93mr10686430pfv.13.1663959723347;
        Fri, 23 Sep 2022 12:02:03 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b00172d0c7edf4sm6380657plh.106.2022.09.23.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:02:02 -0700 (PDT)
Date:   Fri, 23 Sep 2022 12:01:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Input: matrix_keypad - add missed header inclusion
Message-ID: <Yy4Cp/BPH/75oFb1@google.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:46:31PM +0300, Andy Shevchenko wrote:
> The gpiod_count() API is defined in gpio/consumer.h. Include it.
> 
> Fixes: f8f7f47d576f ("Input: matrix_keypad - replace of_gpio_named_count() by gpiod_count()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you.

-- 
Dmitry
