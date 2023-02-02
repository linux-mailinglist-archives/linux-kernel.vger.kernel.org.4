Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676C687C33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBBL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjBBL21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:28:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5DA222D4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:28:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1118137wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6G7C6+CbotlLHhV5pB8v4PiXcl3SeDboC1BfDqfKOuk=;
        b=VxLUhaPGapq/mN890GskLmZRb5wZr1N1JPiiwQly1P4ZqxNFyhiITm0kzVOsbEeA9E
         1AwYwov2+tU4UdamIIXNsBDTaaVHqkc9empQD+2wpkcPXeTjjpjDvgpnje4oMbRtA2AK
         pf7e2KHFSjCjUx2zqa4RHVRHJe1p38l2OCKTQNREi2aoujQYC+jBAcYrtxv7FlZXkd1b
         VqiaZp58TMt2IhvhqV2csYxfnI7zM1IoYelskqC7BAuMlyOFjCzS4/7x8weds+Q58nDg
         moI7hB/fi8onNCjc38WeJDEljExv6/ATxp14bAJpRKcaPxBqDfM30/HrMkBczUpijPHj
         UI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6G7C6+CbotlLHhV5pB8v4PiXcl3SeDboC1BfDqfKOuk=;
        b=HFGOrI03ObeUA7k90JTx+klvo2+0GZll1Q3XVRsMae6WpZmHJrQ0MWGy8to3JwZhrs
         1/8QxwCui7Jn7YgOaNkAt/zflAHaKjhS3Vg9ejmO7RlxTZBm+myN5+BxzUqKk2w9+0rP
         3NAuipmFGguh3TE2ufI3HFcMByp6/g40hYG/Aisq8y4zW37gLr1uPgo1DRlFZM5lsCgJ
         oyaPiXC/iSn6m9i5fND+RRXEorZOpBuX/Bf+TJ0qPjkEfzpmyEMn/wiJCtW3/yB63wjV
         VbszglLw7hw2+yrVbF4zhyy0eNHQRA53R4xlxm30Cx5K1YAr0Jdmimxt0bSaoOeQrwgR
         tggA==
X-Gm-Message-State: AO0yUKWOYs5xEbHJvPQmRggLt/vvg1DGhKoMnBK5DPjdjALzMgxdiwy8
        UOTfh6hWd2iIbZPcODChl+buLQ==
X-Google-Smtp-Source: AK7set8g8w7bdeLSLWWG6jKSrWmqZW5B7wOaDHauzzAmPFMYlzAOK0TFE7LRWIEkCIF+Qo265e4C/w==
X-Received: by 2002:a05:600c:4447:b0:3cf:ae53:9193 with SMTP id v7-20020a05600c444700b003cfae539193mr5419631wmn.39.1675337303887;
        Thu, 02 Feb 2023 03:28:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003dc492e4430sm4576133wmc.28.2023.02.02.03.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:28:23 -0800 (PST)
Message-ID: <45ed6cd5-16b9-dab5-cdc1-9a15009fbe54@linaro.org>
Date:   Thu, 2 Feb 2023 12:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] mfd: sec: Remove PMICs without compatibles
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131183008.4451-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 19:30, David Virag wrote:
> The S5M8751 and S5M8763 PMIC chips have no corresponding compatible
> values, so since board file support was removed for this driver, there
> is no way to specify these PMICs as present in boards anymore.
> Remove leftovers of these chips since it's dead code.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

I see removal of define in patch 2, so:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

