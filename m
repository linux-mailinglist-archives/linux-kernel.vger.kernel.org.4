Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069A6C77CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCXGUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCXGUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:20:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433B41724;
        Thu, 23 Mar 2023 23:20:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so3667302edb.10;
        Thu, 23 Mar 2023 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679638807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCS01EGl3JC6haV+MkG2aQ+tOjHiTLDlklWP2u8H+R8=;
        b=O1Al6aJDIq2eRLxnWTqpBJZGpIxvuVvg8T/crw/gGwtAEhyUAIRUrOZzXaV2X6U6lB
         f6HWfhQNpjf+6Exqa9ILIqHlIreO1u42tM1bPO9b03hXYnRKKsJ5a6THXNq50CHszFMZ
         muPhg2dGqIGOVA9RIw8Oi3FZoPJiYacT6dhwGFog90TgmdPQAisDnRGUFP4v3UtsALlY
         W4Dyjsk9431EgfAUveqLxzXSpqcXZAb5oGXjw6IrZ8mmt1LjR90wsK89yzJ+XSNq3GVu
         8T8+s9GdQ8Ti6+gyGup9t2v5mWa9mgwvhgW2WOJSaVHeKu/Ilu0CmQEEiLqKnUQ0IlZe
         5Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679638807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCS01EGl3JC6haV+MkG2aQ+tOjHiTLDlklWP2u8H+R8=;
        b=3YkJ85As2ypxupaDgxebRBk6RlA4HaQZPkyuhEwsNoyDuHRbnGE3WKXxc9GJEmNMv1
         /1SUSFl53lAJvjZ7IKUoLMYG4tmGEZX4G42Cc+c1IYu/Nuek6ZpvwHKWDD4QM7t6N2EK
         Cq8QOSnRiNXa6KH0n8yDUToHDGNprYiyFtdDt4hCUHtd+T2VK7zBSzHKONo9qWrCvybh
         sdZVJR9Bk8KpEWsVfF3la9JUWBMR7Jjf9FnC5WFWkyufs8kJ/Sl+jKvrbCsDDKG7DMZ5
         Z2Dc/El1qBUR5V1fRX/HSoRGNAmWaxM5Y7F60UNQuUydTPSE8heUHHtShFM0/U4m+2eq
         Ce3A==
X-Gm-Message-State: AAQBX9cSLyxBzm1uJaSxh3+Yp2z4foegYR6cP0ZUbb2zHzCyVR+rLIFu
        WQNZZ9A09zO7kGAgfecvyYo=
X-Google-Smtp-Source: AKy350b8tptdELMgFi3WBc+Hri4L8u+Xc9Odfzsq+0690bX9X/tafRdiaHsj8DmyPNDYrUIJjkLdcQ==
X-Received: by 2002:a17:906:3850:b0:930:b35b:5a53 with SMTP id w16-20020a170906385000b00930b35b5a53mr1336270ejc.16.1679638806549;
        Thu, 23 Mar 2023 23:20:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00933356c681esm8189313eji.150.2023.03.23.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:20:06 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:20:02 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <eb34470f-c86e-4d80-a6a1-811d6cd452b9@kili.mountain>
References: <20230324060934.1686859-1-mx_xiang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324060934.1686859-1-mx_xiang@hust.edu.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:09:34PM +0800, Mingxuan Xiang wrote:
> According to the description of platform_get_irq()
>  * Return: non-zero IRQ number on success, 
>  			negative error number on failure.
> and the code, platform_get_irq() will return -EINVAL
> instead of IRQ0.
> 
> So platform_get_irq() no longer returns 0, there is no
> need to check whether the return value is 0.
> 
> Found by Smatch:
> drivers/usb/dwc3/host.c:60 dwc3_host_get_irq() 
> 	warn: platform_get_irq() does not return zero
> 
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
> v2->v3: remove curly braces
> v1->v2: remove redundant goto
> Only compile tested.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

