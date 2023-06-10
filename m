Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6372AD6E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFJQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFJQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:38:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC653C00
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d6aa3758so514404666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415114; x=1689007114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhc3iF+usUd5wOBnYjpPDlfxa1WSJJmnHm98HNU6RTY=;
        b=fHEs3sERTr6Xez1QnoOuzgrVvX4M9X6TQ5x4jAdXZnPOqKkXOa8HDgZn/cxR4yiMb5
         jwxQi+2NKeUNzuwg6P402naW1+a+5KDaGo6LzsZjYPbaB9a738WHZqA93pcj37eAKlnu
         i6Jip0Vi4tRZaeKlIQfyE3+wEhHoSZZ46tQlqKfAY3/VfUn6HZ9QqonvWxDlUf7dvmXr
         zl8+f1LkyrjU6BT1yVm8JlaSTScrq1p9lPg772tqcHzr5AePPKoRnNnZL+sC62WE12L5
         3CqTvRWUxNFqNWEXPL1Ez4GgpbN1+piZT5F++LQXQrMoTWkwDTMTjIlGynSZS5oJmKxP
         pDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415114; x=1689007114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhc3iF+usUd5wOBnYjpPDlfxa1WSJJmnHm98HNU6RTY=;
        b=DTxHBN8FpxxZapb6FWUczC5aYQIjOq3p8HKmQFbJ+e5xJdHaZ2DErsZO8TULtAHtu5
         VgkFNQs3zkzkR+Cwo3MdeRqoZdg+5VKSV2H75NI7q8cHZfhq7fSJMII/PKky7g2c495P
         2XGCsACA3nWDMvXXevrJS186jVu/RP2MRJgXiNFnIQHccknllFRmcxnqbzkHPCdxaGjL
         vYRfmbO1An+IDUsm+tpoX2ydrvZ3mNDa/ZKxw5pgZbOTc2gYviJHzUwHt3K+TvtrBZTP
         6bA/RHniERHz9a8uTZ46j5XiGQVNZcnuXJL3Cs5LmSI2Nb+6h1ws6QpYQecRImimfe9o
         rrsg==
X-Gm-Message-State: AC+VfDz7eSmij4K72fKyd/kpehd2IuL3n7xPnW1p37BoPIEauHNfn48x
        Bo9cVMR7qFfumUJ2ahvHUhnA0g==
X-Google-Smtp-Source: ACHHUZ5gTfEI7pySkAXDXusef/ipLbEnqL24VzPb5W+NDWa+tYVbBTmg/5fllxj+WpHy9SpuldmMhg==
X-Received: by 2002:a17:907:5c6:b0:96f:7af5:9e9e with SMTP id wg6-20020a17090705c600b0096f7af59e9emr6043603ejb.53.1686415113897;
        Sat, 10 Jun 2023 09:38:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090633cc00b00965f31ff894sm2715788eja.137.2023.06.10.09.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:38:33 -0700 (PDT)
Message-ID: <f1bb396c-5317-99f6-9a9a-4f16b49996d8@linaro.org>
Date:   Sat, 10 Jun 2023 18:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 09/18] dt-bindings: clk: g12a-aoclkc: expose all clock ids
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-9-9676afa6b22c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-9-9676afa6b22c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 12:56, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every g12a-aoclkc ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

