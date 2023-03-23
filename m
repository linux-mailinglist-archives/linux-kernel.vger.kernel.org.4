Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7F6C6522
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCWKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCWKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:32:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E21CF4D;
        Thu, 23 Mar 2023 03:29:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a11so11338483lji.6;
        Thu, 23 Mar 2023 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679567374;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPsFdDQoyAcfneJDfKox3nWALFY9ZxWExsQyFqmbKaY=;
        b=QSxJUD4vh0iWoLM3Sx9XsLseVxx3dN0FYgEfpieJVoCGfMJwily6KbeSIzeMK1xe2h
         h6vusDHnahtS0wtJmfIFAqIr3P/N0ofQ1KhDaLYecuG7JnsBOi63vUV+kn0nKsVfzhnw
         1xi6M1mygTfz/yoM3B9al4J+/zq0Q0J5UdMZrNmbKUXExYwr1DaxXCR54jnuU5SBR8xD
         CbHeH+UGMZbAn4O5I5OxZGKjtSfy94gqrsjLGm9nvh63HclxhugU+xTN4tVWwHtPq2tl
         o75okGSnwnIvDMu7Xq9RO6xMKS8QlByEWkgxryA7LE9swFt7I47homJojQOG+mjY0n4N
         NhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567374;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPsFdDQoyAcfneJDfKox3nWALFY9ZxWExsQyFqmbKaY=;
        b=J37JWdy2O2Q1IcvpWy/nSJAAVxIHBXJbXJHG2xt7l8ukO7d5lfDc2UA06/DBT0EADq
         OWFGuPNHEwNJJPvbNlWr7XE6vOKUeIaNMCYbY0XxaZYPjO7ypmd2ARD2ArslkGnx6JhT
         t7VHGckbQV8FYRpkeWF2SVKw7Oq6aQSyIFuDY4q5KOui3HyItla7oi/tR5aO03pdrhkK
         ctPlyBALR083rMoK+jl8nMJ4m3lG4uaBfrFz+KusXuwJzbHUpMKczeSNI36jkV3humly
         arxwutVGo3kOQou6PbR+sCY06cmpnDDLO8Ir8JCyBtzTTZaocD/8Mi2Bobnw0xVC4jBw
         MWIA==
X-Gm-Message-State: AO0yUKU4U6ETrNBnvPB6md7/W1JKi+zYIPFzatu7u1YoaRC+dPjElfyQ
        w0vTHnz9/RKNKmXjJCBTKmJZGQW6vF8=
X-Google-Smtp-Source: AK7set/6su682a1PUOI5b4wCtqHCKDwuZ9dNoVJipm6DinUPR8HlNUTYMqCFngMjWLJTtBK8LXomzg==
X-Received: by 2002:a2e:9d05:0:b0:298:a7bd:5c56 with SMTP id t5-20020a2e9d05000000b00298a7bd5c56mr3082849lji.53.1679567373625;
        Thu, 23 Mar 2023 03:29:33 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.74.111])
        by smtp.gmail.com with ESMTPSA id h20-20020a2eb0f4000000b0029fb199510bsm892580ljl.53.2023.03.23.03.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:29:33 -0700 (PDT)
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
Date:   Thu, 23 Mar 2023 13:29:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 12:53 PM, Mingxuan Xiang wrote:

> platform_get_irq() no longer returns 0, so there is no
> need to check whether the return value is 0.
> 
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
> v1->v2: remove redundant goto
>  drivers/usb/dwc3/host.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f6f13e7f1ba1..ca1e8294e835 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>  	irq = platform_get_irq(dwc3_pdev, 0);
>  	if (irq > 0) {
>  		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
> -		goto out;
>  	}

   Now drop {} please. :-)

>  
> -	if (!irq)
> -		irq = -EINVAL;
> -
>  out:
>  	return irq;
>  }

MBR, Sergey
