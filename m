Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7D678B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAWW71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjAWW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:59:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8339BA2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:59:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so9713040wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZpSsT6QI0rgCdyfZs7KnVG5ae2iXjgk88FXgcyzmRA=;
        b=u5YeiB5rqWMAFD8zMzjvfbaFygIA9yFyCGmYqetLzBTxTDxda40pEo/CEnjcItlDxi
         EAj9F/ALM4fpbpfTCjGzuGUf58H6DR1XjBJhxxFo0/sqp0g6FiEQ1VZew29eZ1WLqA5x
         M2mlXycExKOVQSDPiNJ5G2yee9aX5VGK2Mp/IcjXQ5sr8nCsI9PT9wciXDwoTuhcYbNV
         YW8nziM6jLvJBaWlWmQ5QWoprB1UJJ3E6tlIeeGhKOD0jmMDHxfSHTEaDxvzIVOZXtYz
         oPWyPC9pbYyTrTDh3QQV2Bl05htN5LSILIbm5qXrQFMpZ36JnQWG0Rc3O9pzJlKeEizd
         DUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZpSsT6QI0rgCdyfZs7KnVG5ae2iXjgk88FXgcyzmRA=;
        b=afBjHFP7tOuatw4tIHpeBsskOjTAAcVlDjssnC4MXzaj6TmCx+Y/dzJZ0z+KcZVJsb
         64yqWs9UNsr/LWdePt9O4NTcseNZ6twtds1xqRjr4XYGMf0DixR3dT044FVMSA/vEkr0
         AUrMnrl0ikh/Xmewyz/bHZWRHvExFVDyqOemBA+iwMDBkduPVWb5/uyirUgA5Zpv2bE/
         lp9s3MYIfhpdetZftQerrq8dGJ8y/d3pnj6zd2UkdcyvzSZi/T+xfCZ9SuQEeyQW9JpG
         Tq/Ai4DkHogxfdAlgwhYSxw7mGaRtkf7Hwr/NytqosOUwCHr5RzOGKR1OhlcgewGbSZS
         CxTw==
X-Gm-Message-State: AFqh2kpRuEFztbYlThDHkb+m7XZu+emH8QuayvhA3QChRrLuhnnEMG6Y
        Lb1oNLE2NHGhxo2gf2B6miVbPA==
X-Google-Smtp-Source: AMrXdXtHjG/WoKRMTL4vHHKw+QJOus1BHZT4nnfsCks4OXHZZWPMWOdEEOz5p7UVsK240vz5ky2+GA==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr26652326wmp.8.1674514730781;
        Mon, 23 Jan 2023 14:58:50 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c479700b003d9e74dd9b2sm389691wmo.9.2023.01.23.14.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 14:58:50 -0800 (PST)
Message-ID: <742ff9cd-e7be-11b8-3805-5b60aba6b2f1@linaro.org>
Date:   Mon, 23 Jan 2023 22:58:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
To:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>, djakov@kernel.org
Cc:     quic_okukatla@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "abel >> Philipp Zabel" <p.zabel@pengutronix.de>,
        abelvesa@kernel.org, abel.vesa@linaro.org
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
 <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
 <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:37, Mike Tipton wrote:
> 
> This isn't actually changing it for all providers. Only for those that 
> define the get_bw() callback. Right now that's only qcom/msm8974 and 
> imx/imx. If get_bw() isn't defined, then icc_node_add() defaults to 
> INT_MAX. So, the logical behavior in that case is unchanged. Which means 
> this isn't even changing the behavior for rpmh yet, either.

Yes that adds up.

Looking at the commit for get_bw() for the 8974, I think this change 
would be OK with the intent of this commit

commit 9caf2d956cfa254c6d89c5f4d7b3f8235d75b28f
Author: Georgi Djakov <georgi.djakov@linaro.org>
Date:   Mon Nov 9 14:45:12 2020 +0200

@Abel what effect will skipping pre->aggregation() have on i.MX ?

---
bod
