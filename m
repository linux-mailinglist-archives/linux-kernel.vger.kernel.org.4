Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA7626764
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKLGRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiKLGRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:17:34 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827B5B5BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:17:32 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d3so6730346ljl.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pb0xzePKTvk1sIDJI6C17RlkL9caXSOtGAOsYmi0A4U=;
        b=P1JK8356e8F/P7MiYDq+M8azjFuPmn4c3oEkM6Xlr62VxdYhGebooK27xnGI0Q0/C0
         aW4huooHMAgUHqwCVzlCfwVycWigqVMIeRGK8f75TnHuNO0iU8O0da6zOpq6VGgaHRLD
         S0rxsnAMKVVpUkCF/7G+vsF2WHE5eIPjucdfdYFB2YyvHU/iZVFcLEXRjzTchQjiJEKR
         DK87WNrOjDGaaLFn8rSs8dHRrGQhyET+JVY43/AKG3Gh4+m/lZ8R7ct2v8iWJZhtDU2a
         VmQi9lnZbwj2FHA/bOX3bIesjZ6F0KBi5RGq315/bEaw3l4xXoRx947UJCRJrEodv/aB
         I8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb0xzePKTvk1sIDJI6C17RlkL9caXSOtGAOsYmi0A4U=;
        b=0RdMAy3r3gu5UmLZ/JtjC/QY6114EiQJsoHUwp8hz9P8j2quiDAiv2+aF9CH1isY/L
         a/Uql08+vxs/uWjWxOqbtOsQdakHGgHpiq0agdaN2NfWi1UPaWNy4TDzbGnyxmUQnAht
         iZXhqmkDPg6UYIQ2lNaomeat6xw9vTaJVpZTgUA4sw3SC+65CU4Z+EUfnX7f9uUAoxmU
         FEC0fLm45p8J2G8d59kDC3bRvDfTYkw9oi4nYXTbOU4vs0PgM8gi7MhnI1i311mXrtTH
         GmR6S3P+vpiD8YBLbknrkoRmrsa1F7z7isPffEvslra4JXGLtRdu1BVetUPfRJ/04Rgo
         NTJQ==
X-Gm-Message-State: ANoB5pnLZOeTbpeMdAQ87Etqk/IRPjdtVnyr1lZU3L9972VbMNZ9sF1A
        qrIL6hdjipS+zh52PeXRsWqTYd34092A9hTz
X-Google-Smtp-Source: AA0mqf5J3YdRUe9n4OzmClvX4Xdm3vOmLCnK3EXmHB6pS6yT+quSrtsn/e9A0DVJG4BR6ODbVqmE0w==
X-Received: by 2002:a2e:9d85:0:b0:277:100c:db42 with SMTP id c5-20020a2e9d85000000b00277100cdb42mr1442858ljj.417.1668233850616;
        Fri, 11 Nov 2022 22:17:30 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u11-20020a2eb80b000000b0026dc7b59d8esm759476ljo.22.2022.11.11.22.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:17:30 -0800 (PST)
Message-ID: <c685cfc8-adec-31e6-c45a-f0e63d85cfcf@linaro.org>
Date:   Sat, 12 Nov 2022 09:17:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix runtime suspend
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111084255.8963-1-johan+linaro@kernel.org>
 <20221111084255.8963-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111084255.8963-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:42, Johan Hovold wrote:
> Drop the confused runtime-suspend type check which effectively broke
> runtime PM if the DP child node happens to be parsed before the USB
> child node during probe (e.g. due to order of child nodes in the
> devicetree).
> 
> Instead use the new driver data USB PHY pointer to access the USB
> configuration and resources.
> 
> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")

I belive the Fixes tag is incorrect. One can not easily backport this 
patch on top of the original ac0d239936bd. I'd suggest to point the 
Fixes tags to the addition of phy-qcom-qmp-combo.c

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

