Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E25F7943
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJGNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:51:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FFC821C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:51:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b1so2425969lfs.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrxnzkuwZDQYqR8TERT+UFYATzo6ewdwfI7spXmYrRA=;
        b=QWe8wuHg5be14uDa+SrQi/baJVMOH35gZro6o/lqjNR9gccTpRSas06iv4gTosOA8v
         mm58ll9yeAVtj/hUpG7Pzco77gVKUE8s3JTGkG4BCgv7KvsD9gbEO4E+n2uKrtSVP4Y1
         e2z9AAl5OZBQ9ZnoZTC8vBBmGtZMn63tdHqeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrxnzkuwZDQYqR8TERT+UFYATzo6ewdwfI7spXmYrRA=;
        b=uG2QGqWA1SKoRY7UeR/Mht3lrmSSIi9e04h7VABJFUMCs6vMVGZbLmkQG9cel11xL6
         qeNIr05zGwZRREFh1hDzmDQChXwgPW/dHtU6ZIi/ZJUkI02JslEfZiO+bKaioW8UJ97Y
         W/am5IAbN9hPzbBMQOB1OY24dfJwWIe/BfR8cKAdQASGpaa106fQtxRWlNoNIcviGIFp
         +LGPs02HgWs/0kpyANodPCuKma7InVe/qiER5uwRFnvdcH29uI7BhH/pv7vImYIXXoqa
         MX9ohj5Yl+ORAyf+Sjokzf9Wp+IJQ6OHACz9doqhbElhzj1QTlRjsFLv3lvd/cC6hDdv
         RuYg==
X-Gm-Message-State: ACrzQf2QPCZDOXCYdEYbMWz6d43OMG8UNtYKkAq7n8nHoToofm0SELV+
        j9MCuS7VceDwMO5TtXBD/XOOPQ==
X-Google-Smtp-Source: AMsMyM5lPdfLyTMCt4eIcvy3rowBX1fNzK2w3HCIyf+tBCFGbwYF/1vBvLeH3k5JvNOCJ23L6QxjTw==
X-Received: by 2002:a05:6512:3295:b0:4a2:71e9:b30f with SMTP id p21-20020a056512329500b004a271e9b30fmr1825434lfe.120.1665150694439;
        Fri, 07 Oct 2022 06:51:34 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b0049313f77755sm298734lfr.213.2022.10.07.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 06:51:33 -0700 (PDT)
Message-ID: <43f3df69-ee47-ed8a-3b31-927ad861ad8c@rasmusvillemoes.dk>
Date:   Fri, 7 Oct 2022 15:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/9] rtc: isl12022: cleanups and hwmon support
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 13.46, Rasmus Villemoes wrote:
> This series does a few cleanups of the isl12022 driver,
> 
> - removes use of deprecated function
> - removes some redundant code
> - switches to regmap API instead of private helpers
> 
> It also provides range_min, range_max values and finally hooks up the
> temperatur sensor to hwmon.
> 

Ping. Alexandre, anything I need to do to move this forward?

Thanks,
Rasmus
