Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1E72305C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjFETvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjFETvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:51:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E3F4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:50:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-777a6eb3662so70151339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994615; x=1688586615;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qj96eUvKoVyqvxWWyYz9moBteO2fmVIfECBk0Ox5VEY=;
        b=STMZSD33gHDf4yEp0r7w8/lwSlDwikNrU3rWn7F4DQK+qezNqagQKOfmeC0cSP+d1f
         XTDRXMtbVlfqbEJJVADjfeLRW4kfHqXdgxev+t/5pVnBp4ewBpqbOAnSLMOW06VOnGY8
         4QZalMhijYf20W1fkL+ySZscrfVyw3EXUdtOnSLC+E4Hbwci8yIXZpsqo67GOKL51SoV
         4VDY2AK2B6KdhajPrJd4DtJhioPz+w7LAcpKzg0FbK1RAfEayv5BG0QtzNfg41d/WdKR
         ZU6GPL1DW9+Zh7rLiiDEkRCDwWk+GqEPaa41OwMBV9jV5b5GDq9dVpTL60TTK4VsqPqU
         bpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994615; x=1688586615;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj96eUvKoVyqvxWWyYz9moBteO2fmVIfECBk0Ox5VEY=;
        b=S/Hrrq7lNqxOtmFM4iwODI1ppedeJNGYEL9arIRpGyR3UZ4BxR078emHCVxf3GXUTl
         Pa0NrNwoPhidWcMFYNPeBqwwVMrCLBU1mtbg5Gt5y76li/dD+dr4LGdCfPBS3s7oVEW5
         2SinIl7hlHprEqTcZnDZHxVasJfRiLoSoPDiU/xR5RymVqZ25ZXsRJp/W0FVpUzr0CQ3
         xQk6MlMdSc07rwvJAG4Jg/Wsin9jDfDEc7geS7/vZcZGcvAe0BZfWKs4qB7rBbCwQUrd
         B6jZBHcpNowdW2KdyiW4g3PLJeOd/h+St991N6rUzuG7YW0WMXnWFMVSqrGZr6KSr4Ug
         C7Aw==
X-Gm-Message-State: AC+VfDxO0MTx0UJABAZfv8VyTPMulwra2Q1dqJ5z9f7zuFPlcio2cbIk
        yLXRxpNYT10B/It/Y6Hfp/8nHg==
X-Google-Smtp-Source: ACHHUZ5wXvukrPBxMAZHWmjSdAni226Po6Q9DzB2+3Wm9ByxYquZ5Eoi9STvpAUMe2f/JT5UtMcAyw==
X-Received: by 2002:a6b:7a0c:0:b0:777:b713:22ba with SMTP id h12-20020a6b7a0c000000b00777b71322bamr156583iom.11.1685994615620;
        Mon, 05 Jun 2023 12:50:15 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a26-20020a02ac1a000000b0041675393f68sm2338753jao.6.2023.06.05.12.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:50:15 -0700 (PDT)
Message-ID: <bdb9867c-99b1-f205-9f86-14710a562047@linaro.org>
Date:   Mon, 5 Jun 2023 14:50:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 19/24] virt: gunyah: Add IO handlers
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-20-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-20-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Add framework for VM functions to handle stage-2 write faults from Gunyah
> guest virtual machines. IO handlers have a range of addresses which they
> apply to. Optionally, they may apply to only when the value written
> matches the IO handler's value.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/virt/gunyah/vm_mgr.c  | 104 ++++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h  |   4 ++
>   include/linux/gunyah_vm_mgr.h |  25 ++++++++
>   3 files changed, 133 insertions(+)

. . .

