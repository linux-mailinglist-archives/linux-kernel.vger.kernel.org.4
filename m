Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD36B3A65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCJJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCJJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:27:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB167617A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:25:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so4398514wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d04M76ABv9OzEZj8YysWWEAPcORPfP75jP6XlG4gbJ0=;
        b=CR0IYjUTqCTanblIpmDaPhqx2DuEqmeYsW6tGNHLFjLe1Sda/h/WbKtLNZCgdAhSNM
         cMH6zz3NEyxUfAvi1KTPsTf4oO52OYj/6pJsOoSosqd+l2w6diiarlucRPQBrTzBQE7R
         DxHy+B4XsLFq58GDyTRUjbeYkDnwzH6lTopbg90BNSZrQ2vbC6u1/EkeZZ0OIaBm6oxq
         USLrYSxGCtV/rN+44qAInTrAJUr36XSkcNq8X+gaCi+os/0QLU2XhUxBDDRgBe9IGdw2
         YcAV9G2p8PagBgUAsZGinp548RUEmc60aoYkyup/5UXziy6hKv2DLJ3cmiJLNCs01HjP
         h15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d04M76ABv9OzEZj8YysWWEAPcORPfP75jP6XlG4gbJ0=;
        b=ls7k354IRa54okd6T3QnefPWGR5UG1UYv0G8J5txbzPUPo3tXmY/XkP3u4WtiVN1j5
         LeqCHP3OV0O2EC8nFFng0LRchxHix189MjnfPo73JU2MGlGi0hs9GPMJ7lPw6Wo3ACts
         hleyDlEinRihfPrhXbSmnn7jsmiiIhcFv1M5pN0AJ7Ibk8yy3Ph+mB5MNqO+GcOKqmh0
         z85wd+sbs8UcN3h7qg9mRBI0FR9Bi0a/WsWww9ZLX3haPTifoxJ10nOe5Tb63wuF1tDh
         6o8Ye0H6EYlWUeVOXfpqf4XApijrQpm1Jr+a3/l47USoHo0oeR83bDR/gttk9LbTu5fn
         G2IQ==
X-Gm-Message-State: AO0yUKUKACDWqS6xE/gYInzRpx1kFoZdGNK/StcZWOQiv365o1I96VwU
        +8t4Sk97aSw7JlIDy0A3d7MgYA==
X-Google-Smtp-Source: AK7set8Oah0vua0JkPc6VPqYUdh16gWo8Wktcn45jRNHsedDl72mZsYB5cjsWBu30eKo6bplbaEWgA==
X-Received: by 2002:a5d:4a47:0:b0:2c7:cdf:e296 with SMTP id v7-20020a5d4a47000000b002c70cdfe296mr16434653wrs.66.1678440329086;
        Fri, 10 Mar 2023 01:25:29 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j10-20020a5d564a000000b002c71dd1109fsm1614861wrw.47.2023.03.10.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:25:28 -0800 (PST)
Message-ID: <944a5935-689a-2847-dc79-fadba0959a14@linaro.org>
Date:   Fri, 10 Mar 2023 09:25:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de
References: <20230222172245.6313-1-zajec5@gmail.com>
 <20230222172245.6313-3-zajec5@gmail.com>
 <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
 <20230309113211.6321ce3d@xps-13>
 <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
 <20230309122324.4b012a58@xps-13>
 <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
 <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 11:52, Rafał Miłecki wrote:
> 
> Rafał (me):
> NVMEM cells should be registered as they are in the raw format. No size
> adjustments should happen while registering them. If NVMEM cell requires
> some read post-processing then its size should be adjusted *while*
> reading.
> 
> 
> Michael:
> .read_post_process() should be realloc the buffer
> 
> 
> Miquel:
> While registering NVMEM cell its size should be already adjusted to
> match what .read_post_process() is about to return.
This is the behavior that I would expect,  this is one time thing and 
cell sizes should be fixed before adding them.


--srini
