Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98670AB33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjETV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 17:57:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610D10A;
        Sat, 20 May 2023 14:57:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4eed764a10cso5069953e87.0;
        Sat, 20 May 2023 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684619842; x=1687211842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPNUD7cNkzmAphyvq3rw3p2VYxxzFLzr1hHOl/6y8X4=;
        b=Dg3Guhu+KNFu3cQ7FBwwGWE+98As2DqyGLoBuWybWO8MP+Mr6BTn+xFSrTIQ4If9aq
         2HFfnoV6fllmcjpDQ/6QZx/l7Yj8Okn3a+tHXyV0xlqSQ3GC34+wtjawOUBMz2XrpoTn
         qMeu1sFuQo/NUOQf3BbDZBfOKB8tZXD308F2aUQbh8+kDqi+APPyN2NhFPfMIgygpULe
         fl0CR3YHgeB8jo3QIvBJ49JUlMws3utm9n3S1Pu8VJ4mXxHevrA5+eeaUUdoAxn0cCcU
         p7+p/Y/5WYJXptdYEmHGCjs5iZsiiOO2hy9L7Geubr505kjzSL1UTu1AxmkD6+slMmb7
         p0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684619842; x=1687211842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPNUD7cNkzmAphyvq3rw3p2VYxxzFLzr1hHOl/6y8X4=;
        b=J7pEtsCKXCMOTH9QT44m/Xsc/DwF5wZPtI5vflU2V+t9FBaJ4/DL/qsHMXtJ2rB+10
         MchRu82ynkhMjN7zmnAzWuh0BLAATcIMqGdsDlTfsl7awfTH4Q8M/KAI3HQ4S7YMDosO
         HxSccxHDEK8RGqQovsAmr/TYTkUbScYRMucXCFr4l93kONYwrQoHszyG8nlYXRJxxVi2
         E4mraP8EYTuzXt1cgVMGvFyYdDpHLM+TrwtuZQ+qUia6Xdm0AupVmUHwohnfwn+0T4lQ
         XkE3org5dhupI5HWhoVZ5b1MBv3bHUrNDObcxWg8ba7Cq+XA97shlXmOxhmEvAP5Q3S3
         Aaiw==
X-Gm-Message-State: AC+VfDztl8XhHJa11fqvTQaM/8vWakESK46CGoUeH8IjihXS0t9UiZbE
        CJPYm5K80oJ/reeU4K+kDUY=
X-Google-Smtp-Source: ACHHUZ4qzQ91T8MQRk1i5zKY2ftck77yGfDPC6y1iTwsHcgFi2sSTussEM5S0RxTCBsIf8yZMz55Xg==
X-Received: by 2002:a2e:a164:0:b0:2af:25cf:92ae with SMTP id u4-20020a2ea164000000b002af25cf92aemr2434227ljl.22.1684619842384;
        Sat, 20 May 2023 14:57:22 -0700 (PDT)
Received: from [192.168.0.108] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.googlemail.com with ESMTPSA id w5-20020a2ea3c5000000b002ad9df0586bsm454172lje.132.2023.05.20.14.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 14:57:21 -0700 (PDT)
Message-ID: <8431c46b-bd0f-3f09-593c-591a403c7c3b@gmail.com>
Date:   Sun, 21 May 2023 00:57:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Mark RPMCC XO_A critical
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.5.2023 15.57, Konrad Dybcio wrote:
> The Arm part is supposed to hold an permanent, active-only vote on the XO
> resource to prevent the RPM algorithms from deciding that its main clock
> source should be cut off.
> 
> Guarantee this by marking XO_A critical.
> 
> These patches are extracted from a broader series at Stephen's request:
> 
> https://lore.kernel.org/linux-arm-msm/3040c836-4db8-7e7b-3ed4-6d71f0496cc5@linaro.org/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (3):
>       clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
>       clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
>       clk: qcom: smd-rpm: Make BI_TCXO_AO critical
> 
>  drivers/clk/qcom/clk-smd-rpm.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> ---
> base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
> change-id: 20230501-topic-rpmcc_xo_a-2caec8c8dad5
> 
> Best regards,

This series fixes booting samsung,matisse-wifi with 6.4 rc1 and rc2.

For the series:

Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>

