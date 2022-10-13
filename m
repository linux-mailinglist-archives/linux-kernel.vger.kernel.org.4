Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23BD5FDB28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJMNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiJMNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:41:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930175AC48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c23so1049012qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfmEgQuQVh7sTBmqJ0VUPOWywieYxc2ZYWNI1q6xxkM=;
        b=m7VC4poWRxJmtaAHaMM31ThEfzElZ6O9xDTexyesxF9+tAuMlB9okvMdWIQIbpZRab
         lfyXIBDjGQ7PEMRwGd8V+ORRJRIdpxfrkJF2rGEUmGSVNzqVEVnE49Q76NktnfSB2od1
         cs080AfipvWFO3fPZIEDii/reoH7m0zVr2xUSiF4wGG6TZ5EDkHXgUZpfFctSHHtWGul
         0bJWyUWuaBOfOTWZ6NA4IQfMQ6VY0evvj74Y3FVtck+5iyXNHxqDOV17upBHCFj/XQlL
         Fig5CCf49g0Lgeu2pqIjr/HQkc73LkKuQO1pOJ2a7BN5Ndi/TyZn8+MdhSqZbupHPKn7
         fhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfmEgQuQVh7sTBmqJ0VUPOWywieYxc2ZYWNI1q6xxkM=;
        b=zdnuy4yQkgOcx4kvliwepj3WRYRzuYW/bmtdBfFKOqb6yp//jvNOFIHk7G5w8I7kJK
         WOv6gghXRtH8sbTgSSMrGZN4kFr47mxdvW5d9OtUjMJgV+ftF7Uggkvmh7Wu0Urdp/9o
         JQ3f2SC9HcJw7Upjcw9a8UUTRVE+Rpzhqm8a01jUNALjpotmsj1mLvyqErdOk1ZRwQfk
         3epNHJ/fIB7vbVryK8E5kemmGB4h6r4D9N63YfWVUSf/iOovXZgG/VYfBtOG0nYUQ6GO
         prYGNIwdtaTNbHl9eV5MZryEIAmHlxSNk1ahXW5q9Ug0opv+Yvs8ffg1rzTL1w2QiV3i
         4UpQ==
X-Gm-Message-State: ACrzQf2v5QlRdheBgg+OyVxSWFxBPRjoomlYELjUpVOr8d/yrhxYwTn9
        Rj0TN7bX+QNqzEYmA6AM1polrg==
X-Google-Smtp-Source: AMsMyM6Yeebymip42Gn94hyjo2aEpwIcg+DQ9YQgBwfVTw3CqEJJ95fFwLXiRpj2B1Xm48vHnDeqww==
X-Received: by 2002:ac8:5e11:0:b0:39c:b869:491f with SMTP id h17-20020ac85e11000000b0039cb869491fmr9642738qtx.315.1665668475630;
        Thu, 13 Oct 2022 06:41:15 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a2a1300b006cddf59a600sm18876143qkp.34.2022.10.13.06.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:41:14 -0700 (PDT)
Message-ID: <861dd64f-0443-db69-ef81-900973f2fa11@linaro.org>
Date:   Thu, 13 Oct 2022 09:39:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] dt-bindings: qcom,pdc: Add missing compatibles
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221013091208.356739-1-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013091208.356739-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 05:12, Luca Weiss wrote:
> Document the compatibles that are already in use in the upstream Linux
> kernel to resolve dtbs_check warnings.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

