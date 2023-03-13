Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1396B714C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCMIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCMIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:41:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD3265B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:41:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h3so11740536lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678696889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGYPLzjUcOMYCS9PgF3AEJ+YYHpQz28xcB60P/4Z3Q4=;
        b=PV+hoOQKvr8krdqbX3msOaj2OhYcAhADHbCsW+STPkRgArxbvVJHgZFhope2jRQ+OA
         VToQUOSAAM8e8GqvdtBMDapua3lSJ59rANDTMXzvDh9EBt+gv7kbo/N9CfI9DvW7Aooa
         xzDaAjLrfFbE0zTyRq+t8qVRfr6Q7g1cM7Tei+5fIWOK9QrPuAn43Y2k+V0KA1n4DvSN
         Ffax6bGrU4ajTS8ZrPwadrpKEzT3udLvVhbaKtD2VGtv36GgjorcEC4PsYw4yVpLfewx
         rclntRjRt9OWE5NSDiA0VeWc+svaKmlCQh1zrOncAl/9cjK7fjiyTSzyiIDk9OL95TBW
         hqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678696889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGYPLzjUcOMYCS9PgF3AEJ+YYHpQz28xcB60P/4Z3Q4=;
        b=OyEkXZImD0udtQ2Vat+OXnd1TkQru9ki1TBNR0SIXlgeb6beR+eMQqRLi1yygP0b8G
         pIzVWeggyxmV7Tr6vAKa32tE6LmzgeL+21q4HzRMDgoI0oPehjEqRe6H89sdvwXj9JQi
         anaktvuShb1xkYySXJAUSSt7qwKF0FFb3RmpDXuhsFELtMCXWVlf7bMvP4ZicMpJ8n02
         KLFHbhBQyyEogJ1UsR9Qx3pGVks4oHWSB8LYg/8t2EK1qsLr4OyZMG/QN4zSkL48Ud0i
         PxFalObPVOAbzPW+e5MFg6MQ3FFSivQSWMpuFx5GtTjUWJdDMgtkTYF8+mW+18eI2hVC
         yjAw==
X-Gm-Message-State: AO0yUKUzFHxf3hX2PUJoM99vTOmj3bMXCNfR//g7XeTmJpm7/j+CtrXx
        tRmUZkHHf7NMPoOicHcA3hm8CLXbLt24DLF3Lfo=
X-Google-Smtp-Source: AK7set+O+49wCt5LULhHHAr8WaqE6BfQ3cmUqdhrV5fAQ6g7DhUBtHot3Whf1uunKo3lbDY9EZSvZw==
X-Received: by 2002:a2e:9902:0:b0:293:4fda:22d1 with SMTP id v2-20020a2e9902000000b002934fda22d1mr9570874lji.46.1678696888804;
        Mon, 13 Mar 2023 01:41:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y7-20020a2e7d07000000b00293d7c95df1sm919247ljc.78.2023.03.13.01.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:41:28 -0700 (PDT)
Message-ID: <3a29fd86-7ede-33b3-0d3c-15e33121f3bb@linaro.org>
Date:   Mon, 13 Mar 2023 09:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arch: arm64: qcom: sdm845-xiaomi-beryllium: add
 notification LED
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230313045539.47538-1-joelselvaraj.oss@gmail.com>
 <b5020395-f6c5-680c-c169-aa46c903613c@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b5020395-f6c5-680c-c169-aa46c903613c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.2023 07:56, Joel Selvaraj wrote:
> Hi,
> 
> The commit title should have had the prefix "arm64: dts: qcom:" instead.
> Sorry for the inconsistency. Shall I send a v2 with the commit title fixed?
Resending one commit does not seem like a lot of work, so yes please

Konrad
> 
> Regards,
> Joel
