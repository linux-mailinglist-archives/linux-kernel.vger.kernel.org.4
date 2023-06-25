Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842D473D06C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjFYLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjFYLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:25:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6554E7D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 04:25:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d9850ef09so106500a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687692321; x=1690284321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVINm/2LH1WEB9iHiOzwEPqPW/i0PdmGJzwlQt8KATk=;
        b=DEZkzEXuaytD/9gTtjon3tQLqwTAxhHVUQIprvUqkk4FMjW4DYcx5ovDPM78fPuiyE
         eVBopACY+8JRt4x7UAxuasCvIyAVgqfWbO2aIFRPvQPEIyWobLmhB2duhOZx40SIWGDW
         pYucd4fnxK4z4VpagweyHTYMouf9Nmxr8S1lBEfRtVDsyqUz0tmdwHcez7I9zDC4kc1Z
         8f7VEn8OvkJLwTR+LuNgeCMY09/voz3+iZXGE4RH06bd6iNOYkeDWjoM+D2ERcw0HMOj
         lDmt3K7LKFWQGkKVmIVgHT69RZ5q12Omr753PwXFpVsg/tYP0fh9XVbtELj9xlE2Fwl1
         LkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692321; x=1690284321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVINm/2LH1WEB9iHiOzwEPqPW/i0PdmGJzwlQt8KATk=;
        b=hzImj94RYaJbl8UOuLHn56D2z4TYLMBSMBFgAYk53RwGo0YLZEkS0LHxqMhX6j45hn
         1k79CqJqGHrygJhuZ4bx6ytS/Rk6p0OpKz5G+Sp/wnGXBev89WrVqCL3ugwVr2Jxq/6u
         z+V5PAyiXrniB7rCvqawZpbDvLqYepo6BB1E0/xZvUkRsGDGCAM8J8pH0ObZ6pq3mjsr
         Ya8jha8FFtVyBdUPeuxGLZp1dkGDOuNQnjELd57OskLzsI5G4c7ps9HLxga5BQ236ixK
         AI9jzPI3apqAaK61Oj1jsR0i0a9RqrAmvhdSzNRbZCmz/R776rE94TqvgxyO380vNzv6
         QAJg==
X-Gm-Message-State: AC+VfDyp1bh5y3h08XUUC1DW9xUCf/R8q5/uwuiAvcj2TKdz5GWVvcVO
        Kc9P5pRkEJDCTThSQiO/bUQiZQ==
X-Google-Smtp-Source: ACHHUZ6pruJNlq2RYOm4Hp1J4J9xpDMuTNJmZA3cgmX1/SzqAlPVwWat60wZTGnfKx0/A1rypOX1VA==
X-Received: by 2002:a17:906:55d4:b0:98e:a451:fac3 with SMTP id z20-20020a17090655d400b0098ea451fac3mr626212ejp.42.1687692321165;
        Sun, 25 Jun 2023 04:25:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906561500b009888eda6b0asm2006594ejq.170.2023.06.25.04.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 04:25:20 -0700 (PDT)
Message-ID: <19082486-2f19-897c-9e40-6f36a27c3bb1@linaro.org>
Date:   Sun, 25 Jun 2023 13:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] arm64: dts: imx93: enable CM33 for 11x11 EVK
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
 <20230625105528.4057850-5-peng.fan@oss.nxp.com>
 <60efe832-b982-7ea7-abd3-5e9bfd41d064@linaro.org>
 <DU0PR04MB9417A0C5546DFCB0F34516FA8821A@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417A0C5546DFCB0F34516FA8821A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 13:23, Peng Fan wrote:
>>
>> Three entries, not one. Anyway, why mboxes depend on the board? This is
>> quite surprising.
> 
> The m33 firmware delivered by NXP use MU1 for doorbell, but others may
> use other MUs, or even not use MUs. So I put it in board dts just for
> NXP boards.

OK

Best regards,
Krzysztof

