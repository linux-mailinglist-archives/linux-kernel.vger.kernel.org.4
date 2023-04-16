Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD76E390D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDPOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDPOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:05:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56B268F;
        Sun, 16 Apr 2023 07:05:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s6so322432iow.11;
        Sun, 16 Apr 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681653904; x=1684245904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30p0VyHgAhZaeHPDj7owhm6SETRtyngxJZwQkQYURP8=;
        b=KZC7hpxBc0dctYC9pNHS5dJWm21iCSyq68i06EcavxRstL4vrDTU0aGzHr8EPtenOp
         8lQAMxYWHDLqZ9bMiC8MKRjyHku8FFHoL4XmxWsIuPG4vAiC5yca6/Ls99nZ8HbLKdZU
         Rq1F0sHfKwnFofV3qpHlFuqRkvVsYVorsxAkgY1RDlt7SNUQL7/BK/B6qd02eESIP+nC
         58MkLGKoocPKb/u2TTcVgtPUwzBpyKmEtcNGgivoun5AdtHUQxj3wdAXeJHvIS4di4Aa
         T2PuFIyYgBId0iQ7Kk7zDz2OMeJfTRD/hrpWDXAzFGqXSrbCybgpH1xx/QhEWycAL1J3
         Q30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681653904; x=1684245904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30p0VyHgAhZaeHPDj7owhm6SETRtyngxJZwQkQYURP8=;
        b=MyDE/ZMtfRjFl9RUwqxL4oOT7DqAruslZDPKzH0+edA4EOu7FEm9hn2k/FGPQY7qty
         CZqqb9zzy/PMLwxmJVbi327EVI/6tk/EEnw2Qn4tlQEnp7DrgQ6ZlxxVK/AcWkhqMjWv
         WhP2+jDZS28z3r20Ml5ydbzmX4bJq3mPrfVRflZ8QsdZlaDKC/zPKkrXdyqpJwjoq/Hq
         /BbzUuVpOU4RoiQZ/5ZpYO6oONT3MQGskVrzE6jOS++F4a6hrK/EIhUmZ6D+2ivj7kQr
         i7aYGQ1hsXtgdaDjzBrgnalXubqzCgLnOiDc3qu4ZFUOhCL78XFIzVd3UlLrEcPfP/9I
         V4Tw==
X-Gm-Message-State: AAQBX9eoESI1GUdV5fh5RtxNXr2BdGe+nCU6k2cqg4B1KUfDzXOSQRMm
        P9g58LG88/ZWiigWm5CWFg9tlQjzq8U=
X-Google-Smtp-Source: AKy350bSBDEjbhark7AVl01VOcBjUDz+jChmoI0BbrGeKYScCTm8kzQ99RobafqXnJqhN6gPGjF19A==
X-Received: by 2002:a5d:8d91:0:b0:760:b5ad:ae18 with SMTP id b17-20020a5d8d91000000b00760b5adae18mr7221826ioj.0.1681653904615;
        Sun, 16 Apr 2023 07:05:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m44-20020a026a6c000000b0040b1ecc3ec4sm2548340jaf.11.2023.04.16.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:05:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:05:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/ibm-cffps) Use default debugfs
 attributes and lock function
Message-ID: <7110436b-432f-4fcc-bd90-da5645a60676@roeck-us.net>
References: <20230412161526.252294-1-eajames@linux.ibm.com>
 <20230412161526.252294-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412161526.252294-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:15:26AM -0500, Eddie James wrote:
> Switch the driver to use the default debugfs attributes instead of
> ones that provide the same data under different names. Use the lock
> functions for the debugfs and led attributes, and simplify the input
> history operation by dropping the timer and lock.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter
