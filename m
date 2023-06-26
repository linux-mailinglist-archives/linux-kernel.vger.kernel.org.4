Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5579473E0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFZNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:47:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464DE7A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:47:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f973035d60so4037340e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787237; x=1690379237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyiLaDvatRqjfpVf3KAhKDlTNB9yV+3Ms6KKxl9c+5M=;
        b=GCUBO9yYfKCBpCEJz2Y8P14Z+/QED+NYxvNLso8WNXbdHGmn0x5/DP2nfs9lgc2pJv
         aMlwQwmSpOQxrdY0XeuuxLxNkDmTml5/BMcdxNyPc/lzZq62Ep1Nj/chy69PjZ6LClkE
         MtsBmo2T2Jo2xELFsCxVIX/0/ZItfO0/l3pmHDVbmzNCXAOV53OX03sEyflu0etAPamM
         /yyClh76i76BaEXw9iJEylrI/0aBb0XO/Yub0ujy81myHfncE7MychvYkcY3G1cZXypA
         v/uVjXJdVkz7aH5/vW9jFxNVh0Bjx53RDDMHmz5k8HQkIZL/uJSSsXfM/IoNiB7z5jfn
         nuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787237; x=1690379237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyiLaDvatRqjfpVf3KAhKDlTNB9yV+3Ms6KKxl9c+5M=;
        b=ICydaYC9l7dhjLNXp7DGvO9FYECxwUKAA/Z/cvMKmS69OY2PTYccF63c3zectiXotJ
         Hdg8kpuZiJBfY3/N5dCwcrvfFHjibBh5DyLMpObQLJ9j9hpLacGM4hXNLHxxjfOagsgY
         q1C0nj0rYVrF0eMruW7HheeJm0TwntkGPvWuwezE4PQN254iS+8n3JvzhhL/7vzd2vyb
         Ov2uCnoOuNAe3eTGc/hd2TxDSOOt/5E7+YatBGL2z6fqjqK+FWF7HVoEtchOLDXxq6bq
         DmHaRXC2SKG47QvHlZEtSuYeFlM+TeVWTeMxzYkGv0hzaZIWmMDl8l/JsmEt4QEW6tum
         HpEQ==
X-Gm-Message-State: AC+VfDzfDs/KaTG1LdodKwuYWRtCw5BSdEopSg6ELLjYW1pTBOL8JPxz
        Nv08cacXMyztdSyH69rC3mQ=
X-Google-Smtp-Source: ACHHUZ6mnpV//fE1sOpuVv+z0wCyK7r45RM+trFDQ1e4Qr2yfWoHeG4Rb9svP5rCqsl34V8O7EK6pA==
X-Received: by 2002:a05:6512:60e:b0:4f8:6f9e:326a with SMTP id b14-20020a056512060e00b004f86f9e326amr13592138lfe.31.1687787237161;
        Mon, 26 Jun 2023 06:47:17 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id g18-20020aa7d1d2000000b0051bf49e258bsm2842028edp.22.2023.06.26.06.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:47:16 -0700 (PDT)
Message-ID: <e305e548-4f8c-d57d-fc0f-9263cb4481c1@gmail.com>
Date:   Mon, 26 Jun 2023 16:47:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 05/13] regulator: introduce properties for
 monitoring workarounds
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-5-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230419-dynamic-vmon-v4-5-4d3734e62ada@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 23:02, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> These are useful when the state of the regulator might change during
> runtime, but the monitors state (in hardware) are not implicitly changed
> with the change of the regulator state or mode (in hardware). Also, when
> the monitors should be disabled while ramping after a set_value() or
> when the regulator can enter a certain mode in which the monitoring does
> not result in a valid state.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

