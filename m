Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFF6B549A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCJWjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCJWjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:39:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194912C435
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:39:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f11so6383377wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678487964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PuvKOvfLUjyVO4mPIX/XjsIPQ+ajMnbP2SJqNrL1cI=;
        b=oXFqjObqygxkHRfqqAMKRIVwozsa0l3DRG6a6G7slqeC+CHe384vkDLPFFrgbGeydG
         kOyWZjR1179dMQJLO+/tAshkv3m/fLIQ9GVzY+IpruvMWcjLnEFkfdIjGzLuE3mCpzMl
         pPcnQljNsdvoaKgdB+l6cu1hkxG9Itfx6XfTpL8ZJAzK+z6tsEy4BMFChg/kwBhWE2PD
         VXznHjVeZosZojk7dMs3t3JzdXmlhdhS3gtM8Uht7t5EjvAM2UYmD2GidzVMbs6gI2A6
         h86Y9mL27HXXz9sUl3QlbAPk4Gq8EuD74Mu7I5Ox+Z05pfIyMha48spVo9zCnOxh5f0B
         dosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PuvKOvfLUjyVO4mPIX/XjsIPQ+ajMnbP2SJqNrL1cI=;
        b=5sKy/yuwj8o3iqy7PKwccNmxZkkM+pUAXYObiPOK8y04m0e/lDJYERHuzaJ817XRa4
         aOpOAhvfmuwNixdYeRuvk/NXClf1Gy8XSUBOp2FpEriu/k/36VB3UUuJhaLezcFHIRAt
         1q+BAuBh2R8rk4U7eTYA4V+6+83uKfaIi/oLs5FdhL4BjKfVHPs5CTzL8dJKSo/zJAOf
         oB6V0ZxhDnsAGXmGs6nRi7g4J3spKU9uu9TLJGRJMCGPbHFQj9q58SxX4UJn8HdqYVDD
         +efHS91OOECP+Q6h9IeId1NPi3E66j4o62JxGgxRccp+lltl1OFtVEZMHcfeKOprsldi
         GbTA==
X-Gm-Message-State: AO0yUKXuhGw0KiZGEq1NSVEs+OfW1h/AfU0J7PSETaRPsSDbfbXT7c1f
        kRd/Zb/zZlrg+SyL5iUN0tnMGCmzkCrqUu2J
X-Google-Smtp-Source: AK7set/7u/SY1mUQXvz+1eJcT8g0IyPHytdodVx6/Y9NnoSmRa1Uw6b/LVVnXac95BUA3XmVBqxmqQ==
X-Received: by 2002:a5d:474b:0:b0:2c5:a38f:ca3a with SMTP id o11-20020a5d474b000000b002c5a38fca3amr2557906wrs.10.1678487963664;
        Fri, 10 Mar 2023 14:39:23 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bcd10000000b003dfe5190376sm1095707wmj.35.2023.03.10.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:39:23 -0800 (PST)
Date:   Sat, 11 Mar 2023 03:39:20 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>, julia.lawall@inria.fr,
        drv@mailo.com
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <ZAuxmGmVQMSwig44@khadija-virtual-machine>
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
 <eb7475da-7548-4820-a2b6-ff0f6cf4be71@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7475da-7548-4820-a2b6-ff0f6cf4be71@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey! 
Sorry, I am unable to understand this enough. Since it is mentioned that
the patch raises another checkpatch warning, should I stop working on
this patch and look for some other files? Kindly let me know.

As for now, I have submitted another revision of this patch.
Thank you.
