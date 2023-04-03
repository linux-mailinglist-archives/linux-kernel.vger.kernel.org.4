Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9736D40FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjDCJom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjDCJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:44:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993CD1117A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:43:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so114738985edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emdytwm6Vo64J5QWp59UQMgTkiLCnS1+d3jrELtdiyg=;
        b=EYD2yhSSmiqu3ePf7ZuJWZvqACeLurOIT3MSjtzJ7Tn0FlzKzxvp34CSYLW3X8ewjN
         u/aQEAP6RaN5ny4/uKWoR0tAOE71l34KFBZp6tIVhsb4IwHtMxiXyPP306LcGPHnBwdj
         WyMVRwkrf1a5JKtZ2vURm3GlmgE2aMl96MWDiZLK2JtZCqQ0PueDiAzHrJjYO+HrQN7e
         G9xqedq0uhJS3hUz5BD+HLjJPeGvxZdjBoOc4SkVw2daYAVZqnYz6rsR5vyKiTeBM2ne
         YQnBqddmY80C2zNqtbRdcd0N1LjHIyV5Fcd8WZq8UzeerNzItqvLrVk6ssl6/ScMtn+x
         0dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emdytwm6Vo64J5QWp59UQMgTkiLCnS1+d3jrELtdiyg=;
        b=uh/EMaim6KkCWpcw4vfT+vqcn2yHE6yZklZeqsomv1G/Xt6gaFjU53/ZntVcCGEsUK
         iEDfRzCslyu6gWV3HVBDm9NOwT2BN1HzFWRDayOJEq4iH9E/a/+rGkIOU8Foo/RQvpYZ
         wkGcnRPBindLkL4pcKmLIRI55bD3jRZ9c6/tyBUA6AWajWLBlNjbL5OQ5KK6NL6uKcq7
         7ZBk9t0d6NfRg6uqvWnAE+SflfTg79ANh8eE9UjgexOMKjl4aUtQDINlNBHCxCEnq0kd
         7BHoLJU+AmMGFCG5WKMU7PV7GLApLitdKK5WseeBUBz7rBTaGfOvNb9tJW/hfIs4BAHH
         80IQ==
X-Gm-Message-State: AAQBX9fbli1vLYDJRlewdjsZdVRe6RrrkU/pGdW1I+UtRUR1Q+6zNTUh
        NkyVQJ5fmWqmOqg8AKZyGuylRg==
X-Google-Smtp-Source: AKy350Y0hl/RzYdB7dN+wNKEqctheVFdh+D4QlJV8y5dEO3YNu3a8xD1aDOYFuiSABD5iNu2w/XIJw==
X-Received: by 2002:a05:6402:653:b0:4fb:e9b8:ca56 with SMTP id u19-20020a056402065300b004fbe9b8ca56mr29259113edx.41.1680515013182;
        Mon, 03 Apr 2023 02:43:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id a24-20020a509b58000000b005027d356613sm3974212edj.63.2023.04.03.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:43:32 -0700 (PDT)
Message-ID: <14d7b3ab-5ac6-61dc-a538-62993edadae6@linaro.org>
Date:   Mon, 3 Apr 2023 11:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 6/7] dt-binding: clock: imx93: add NIC, A55 and ARM PLL
 CLK
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
 <20230403071309.3113513-7-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403071309.3113513-7-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 09:13, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 NIC, A55 and ARM PLL CLK.
> 

Fix subject in all your patchsets.

Best regards,
Krzysztof

