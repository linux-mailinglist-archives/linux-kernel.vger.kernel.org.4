Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359CC6EA324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjDUFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDUFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:33:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18061B3;
        Thu, 20 Apr 2023 22:32:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f4c8eso42133666b.0;
        Thu, 20 Apr 2023 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682055174; x=1684647174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFW7Gg1SgGBbBJt5owgBHTN5D7RxDmj2irhm6z31MIQ=;
        b=VxiYdLrE1afaqY5HkATYYMkJb8GawuWMByr4Cnuu4TCSxIO9qF4emDfIiTguKIRkD3
         7QBWafFYwaVQseFDu2qMwMedVO4LFCSbENEVcUdyfTniSaC5eq6N1wxvsGlZajUzkl1H
         e7ljqj5zbwu858s53seRVTSKP2l5FFGynKhpJ/eAQu1eJs3CMwY0nqNiIwjDXB6SqdJ1
         QBNTeeh9ogt9JVHMkEMfTlQ6N53PkAHY+cUlhG95De4FKk8ZogU6+QdTMGOQj762UiYH
         1xIGvodhYAeTSIV+493oDYJbdhvWx7nYTRTD50c04793W47IUhpTTvRcfPXbEghJIict
         RMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682055174; x=1684647174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFW7Gg1SgGBbBJt5owgBHTN5D7RxDmj2irhm6z31MIQ=;
        b=MXhF7F1WKbVpWkyHxFGgjeQ66Mn1FefXxsbdNzxiswBMWYGkJTB2R375yntnlqfx4c
         Fd9FzMK4CQ0Z4ifbGf/oNOaioe4EKf6fw4mkGstURexRHjD4JaQg2QBA0oRUhqYpXyQT
         9Q6NyHygoVibApK84RBtJo1RITJQWlRI9OYZphdjdHyEg/cOFtvkjL/GjuvW205A+vwC
         W+GakXVoJfdx1brj7OA5BHhxwwdKqVJ4KevkPs9tF4MtKZG51x6rkhkuXlf61i/9ml4r
         b2LtXdeTV6/cK3YX/aYb5QTWIKvdg2edunCgOSfJLfxquRVNaiqpB4Yee89zpZJ8IYKO
         ctWA==
X-Gm-Message-State: AAQBX9dIH8o/H71cC6FhLqZ7AoqGQefuT9z1rCZxRFQ+3r2GQFTjvkfn
        eqGuebvH39TBCpuh6dxlnWk=
X-Google-Smtp-Source: AKy350Z/TfHG2ZHB6XiI5P2UxmdymQ0V+AbYUHsq26ml8FoULXU8BIx3YGBKeVyQ+boAr4AqINfHOw==
X-Received: by 2002:a17:906:35d1:b0:94f:4ec3:f0f5 with SMTP id p17-20020a17090635d100b0094f4ec3f0f5mr3504174ejb.4.1682055173642;
        Thu, 20 Apr 2023 22:32:53 -0700 (PDT)
Received: from [192.168.0.101] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906174d00b0094e477eb441sm1573171eje.110.2023.04.20.22.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 22:32:53 -0700 (PDT)
Message-ID: <d5140404-6b11-6755-a086-7e473d093494@gmail.com>
Date:   Fri, 21 Apr 2023 07:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] staging: rtl8712: Adjustments for process_link_qual()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nam Cao <namcaov@gmail.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 12:54, Markus Elfring wrote:
> Date: Thu, 20 Apr 2023 12:05:12 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (4):
>    Delete null pointer checks
>    Delete two variables
>    Reduce scope for the variable “sqd”
>    Simplify the usage of an expression
> 
>   drivers/staging/rtl8712/rtl8712_recv.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> --
> 2.40.0
> 
> 

Hi, you get the following checkpatch warning. Is this wanted?

WARNING: From:/Signed-off-by: email address mismatch: 'From: Markus 
Elfring <Markus.Elfring@web.de>' != 'Signed-off-by: Markus Elfring 
<elfring@users.sourceforge.net>'


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120
