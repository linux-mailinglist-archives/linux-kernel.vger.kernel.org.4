Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00D46B50C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCJTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:16:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043212D439
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:15:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p16so4121612wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678475757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqbNsTNOU67IwaiaWCAxfvEEEDh++1uXymdMW0foEhs=;
        b=cT0jJhdjcwmJq6UzC819mX2/Azk1UEB9t9n/W+tWJ6SWmbiKqZGGOWzwKRB9BFqRUu
         vJWovyAg9K6qJc2QTNYn3Oem00xTTae8WAWyHdq1NqQt7jiy54Ng/qiLFS8Dq8kUt2pG
         u6KGguRcep7kPEP9m7LOK2Gct3L63SrsJqbFXNJZYQr3YoFDaPyrZInal37N/dXH+zOR
         YorOH89iDSSJdvJZNEF2DCiybdhVPBKz1bFABBpyvemOi2hwgFYudsYqp1Atp9+egtwG
         +t+03XDV2W8kO7qWrrbQDIvvmZ5oOlEolrO/DbSLGPTc2ZFSkRX2HIWuG/8RhtbTq/LC
         SQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqbNsTNOU67IwaiaWCAxfvEEEDh++1uXymdMW0foEhs=;
        b=IlG5sRCNOhk/j4lA4NiP33czpiPcKPKpV3q8s3l6N8fTrtHq7YGYTlr7a8pre3Lu96
         pdizYBnOUZYB380Ay90zYNcB0P3cA8hKRDiUtxJifAYLJhDC7Jihc2r1BxHa+ORe55ti
         Ts0XM0S1xCvJ0prYFmiNmwwfkNpWPfqdCCUAD20ClpUBgfpZhtLhx+7xI9MxqyMp861G
         H6c7W84ydyaYVraYY/MfSsQs41d897l3f/5LyuBieteqC89rM257yXKcW1ZVr8zVrPpQ
         sr7aVp/Zoa9MuKY+TIKupLE7i7NgRTUtNsaJa9SH4i8cdc8VHGYzE/wsEN1IgqsrGoKC
         /+WA==
X-Gm-Message-State: AO0yUKWaKnQ1ryRe+7kgwOXdtuUK0Vf5aRdOFsq9R3UxXjsUWLIAHshp
        I0kwVCHB07OVzUP1XuXgAwPquawx3q9BDDPF
X-Google-Smtp-Source: AK7set+ubJCHM2ZlWoVvoojB2vEcbbw7e5ifnSEHfK8SB1s3rdsPs3+lH0WoZPup6grrhJM5pia7bw==
X-Received: by 2002:a05:600c:3b11:b0:3eb:f73a:cf89 with SMTP id m17-20020a05600c3b1100b003ebf73acf89mr3677472wms.8.1678475757388;
        Fri, 10 Mar 2023 11:15:57 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003eb20d4d4a8sm655548wmq.44.2023.03.10.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:15:56 -0800 (PST)
Date:   Sat, 11 Mar 2023 00:15:54 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <ZAuB6hJ3pOWxnWuS@khadija-virtual-machine>
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
 <ZAt4irZnVJW4zQNb@ubun2204.myguest.virtualbox.org>
 <ZAt9e8Xnd4wAnjPn@khadija-virtual-machine>
 <ZAt+wJIhq780Ms4T@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAt+wJIhq780Ms4T@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak!
If I join the if condition to one line, the line length becomes 97
columns. Would that be okay?
