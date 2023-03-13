Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068056B6FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMG5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCMG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:57:00 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE24D62C;
        Sun, 12 Mar 2023 23:56:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h7so6491532ila.5;
        Sun, 12 Mar 2023 23:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678690610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o++4el5QvXQ4SLwy0XsqLCTBNTxf4vLRzZ5SJb+4Stk=;
        b=MSgB5EJNVhX1iaowYZUFH2a007vIPQxoHTjCVgwkHJcvcBVcT7Nx7/eLCGxoDMHS6v
         RTUmZcH45ycfTUjRrc25PXUKCKsNW1be4XUlkfWL0cBIDJpIpPuT21NYW4vkmM1ZbuYt
         ORfHSoKFwFl5/3e+RD/X90wZ1AKHBZlpTtMsZsXKbQdVCOaKJN+j7Tto75cxHVl5Gseb
         PHSSLIJ++PiSiMzHgbJGQ5uY9lO9rhuExC51VQdWzoi++9WqEWLxiUtLBVSEwj6sT08X
         m5LRLfNbrTn6iUWud3IUMUudh7bg6tzPstwo9SdJ9ORmxJUiYyNt7CGRyrww0GA0uO+Y
         096Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678690610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o++4el5QvXQ4SLwy0XsqLCTBNTxf4vLRzZ5SJb+4Stk=;
        b=gEZbAaIuWzYbMy650w1rV3g/IEbBA61Xk1We7N8smQqlayUx6w6xC9VkGZ0TLzWxss
         d4kQ513Ysj/oNS6MVaDkspaD3IMhpNrspiNKELwhFecYa72T6RvwzGjeeirjByvCKYqU
         6x/LU0oCzSDwXEInPFW8ORHHkEIGaBDsXS+zmbN2OBmBbghJBOn9OcAwn3sMMGJwYqHd
         SAu3ed789RTNqbt/VyhWte8KCsC81jkJc2EU40ssE7pJAH0aHrFMngnjBb+a35MwocWf
         6qLMr4z8RaRptziWRkRt8VEixvPac11ze3dl/+0sQpBeereJEkwI4Tu5NThZWNWh4IJu
         UBIw==
X-Gm-Message-State: AO0yUKVGC7fIyTR/xJWcwbDtGLBQf6wI0eHgkbX/X1XgphBHi7XUVm/8
        g631+0kv/OQTzilbYfZqFng=
X-Google-Smtp-Source: AK7set9Tuv1mZdwM2KMX+goIskUvG/0EAd92d2cG5R7wTTcOxSoT7jvbIeRniOsFX7VtqufBaPaJjQ==
X-Received: by 2002:a92:cccb:0:b0:316:67be:1b99 with SMTP id u11-20020a92cccb000000b0031667be1b99mr7366395ilq.0.1678690610030;
        Sun, 12 Mar 2023 23:56:50 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a02c6c7000000b00375783003fcsm2206467jan.136.2023.03.12.23.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:56:49 -0700 (PDT)
Message-ID: <b5020395-f6c5-680c-c169-aa46c903613c@gmail.com>
Date:   Mon, 13 Mar 2023 01:56:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] arch: arm64: qcom: sdm845-xiaomi-beryllium: add
 notification LED
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230313045539.47538-1-joelselvaraj.oss@gmail.com>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <20230313045539.47538-1-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The commit title should have had the prefix "arm64: dts: qcom:" instead.
Sorry for the inconsistency. Shall I send a v2 with the commit title fixed?

Regards,
Joel
