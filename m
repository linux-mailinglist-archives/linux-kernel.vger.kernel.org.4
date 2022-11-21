Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFB631B26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKUIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiKUITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:19:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A36DFCA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:19:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so10500625pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxK12pl5lmHPrmYisbAeiLqVeVqHlMyPwaEaxEgM+Js=;
        b=KDPjIyBENY1BV1GRQ2EX2pXa8ZPNkOyppbhpmpMqCrL5BkPo7mhNaIwa0ucz0GW28r
         slEvKeHSX6/JVJS9570tdCAgjUtLwRH+w/jbUGJaJnrlkgdO/Byy0E1DifXXQ9rzCPe2
         X0RVgNvQ9qg1JP6m3qQFP2h8mR9/LlJttVmxf3kkC/TR9SQ1awOGHeuo28scnVCY6Ayp
         PhUA+2KwMmOCQtbzE5o3+OSpnaaahubaWL0V9Y6PkgB3ioBaAM2NYOLwDVwvaEzoNnHP
         1pzkB+vkXD0nJULOl+vLaRhDtqKipHITXeyn/8oS3Q8BfJLnxUXI2K23kznPZtO0isVH
         y/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxK12pl5lmHPrmYisbAeiLqVeVqHlMyPwaEaxEgM+Js=;
        b=JVhZGw9pWDaAsVMQ9/vFsCy65ZjIuY6cz9rAz0pCf3trAMwh4uhfHN2TIEg02cO5pY
         EKLHuP/3vYpxo0sQSjI+3Tl2CzVtKpWCiFw7ROI1952bJTX+cNVswzjFZmNBvrdNy/FF
         n2X+CHBajSieQL9pm9udlBmEMEbCu/7r3o9LxTLcW7x5c6buQELUyCiMA14CyscjXAYL
         cyvrFCe0d3ZKFvHdnZIrp5Lnvq1AMKSCEFjoni7v0LBDd2RNNBHNyQCBWdF/hPoiva0X
         8zqe7cowQycOEXvrAbyAbORPnDvjzcRxbhILlnMCyvTsPGs5aCu/9Gdu4yoKdBOU+TbD
         19kQ==
X-Gm-Message-State: ANoB5pnN7vHu2ZQMa2+1EdVRhGelXuo3jQu6OXTVaK6QkxwSCd8hyGAS
        H0DzkI6RSJmfVLIgXPnUoWQ=
X-Google-Smtp-Source: AA0mqf7MbnAaPrSeQwzdgRWdmu1yNxsytU6+G1KCN7WhzMY4BXjV4dS9Xv2aLgd/GkurZRrmNj360Q==
X-Received: by 2002:a63:1824:0:b0:46e:baf4:ab7a with SMTP id y36-20020a631824000000b0046ebaf4ab7amr17505699pgl.37.1669018788606;
        Mon, 21 Nov 2022 00:19:48 -0800 (PST)
Received: from [0.0.0.0] ([2a11:3:200::3028])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0018863dbf3b0sm2810499plb.45.2022.11.21.00.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:19:47 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU maintainers
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
From:   Qi Liu <liuqi6124@gmail.com>
Message-ID: <e31b0e1c-17a9-34bf-ae8a-e8f6817c8512@gmail.com>
Date:   Mon, 21 Nov 2022 16:19:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/22 2:54 PM, Shaokun Zhang wrote:
> Now Qi Liu has left HiSilicon and will no longer access to the
> necessary hardware and document, remove the mail and thanks for
> her's work.
> While add the new maintainer Jonathan Cameron, He is skilled with
> kernel and enough knowledge of the driver.
>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Qi Liu <liuqi6124@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Acked-by: Qi Liu <liuqi6124@gmail.com>


Qi

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ba29a308539..a6c2499b59af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9248,7 +9248,7 @@ F:	drivers/misc/hisi_hikey_usb.c
>   
>   HISILICON PMU DRIVER
>   M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
> -M:	Qi Liu <liuqi115@huawei.com>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>   S:	Supported
>   W:	http://www.hisilicon.com
>   F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
