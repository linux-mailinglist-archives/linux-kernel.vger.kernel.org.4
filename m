Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9872AD65
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFJQiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:38:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719ACC4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so4928347a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415091; x=1689007091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hp33yA5HcmdHo6uDlO7P+JfSf1kHY2kxoEjyxwdelr4=;
        b=qpWBaIqFetal+BReZfUxUTyc6Jao3DQNWqNlxdw8JnRTnxNxho/XZvNQz6kE83BBO0
         9AESFhLOtsmkcdaO7cEDKhjp9Euc9dxTmfFl+TDXNt28M4cbF48nxbDmz1V1HRp+KoDZ
         HhU+EAzkqemptHxjze8XJi1TttEK+Gbrn2iRET14U+/o7BYIr/7ycjj4VhaPc63q52ZE
         NDxzsSxac9XDEoVRh9Rrbd4b+b32RV2vVlFsI0z0+nzoP8+w+cHXQ2vUdz/jK7MO6xmH
         2aP2X/06q+4APRPW1I4Ghzrjd9gMWPAwT/t410ZJIMRoflwn8M6B8+OQ4auePe3ImtRH
         +MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415091; x=1689007091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp33yA5HcmdHo6uDlO7P+JfSf1kHY2kxoEjyxwdelr4=;
        b=fHbdbfyUMvNIw5pmRt3KDWSvuHc9VcRMDwaGa6GtF0qraKXtPoV8LPtW1pDKncIA3W
         ghqZrkrvDVTH2eero6CVGexPc0QvWV4k8nnIO88X+jPFs2Ca7d0HeJ+FOv/zCK0Ia+mj
         iuZChCh1sQpPiB1YmBsGhjnecGuX3WJV7DrqxzL7TLPOnUusz/06plZN9CokbqIezGa4
         SQLGMhXp6nYdThdXvv/8V+1LBbVDt8YiSuJJ34O5NswdUnBfcLQJ3KX9pp9n033YUei5
         A025pLD2a3k4i0tGzoRWB7vDJiCFktKPeJnUfzvV5RpOVODPTavjKecdhiFzxX04UAdK
         6O/A==
X-Gm-Message-State: AC+VfDzs8OEWiG7lEeT5V6AbLLtOTWcVvHeIW2EOVt1wstPh4uxGa1iW
        NmOAf1/U7KpxmqcMAp3SUsSM/w==
X-Google-Smtp-Source: ACHHUZ5WhgtdYTW5eL6c7P8syI3GQHp0HZckc2U6paAq8Szm4VAUQjVE2jDkIGK6LbHNiZyOsXRPdw==
X-Received: by 2002:a05:6402:690:b0:505:4f7:8a50 with SMTP id f16-20020a056402069000b0050504f78a50mr1600989edy.5.1686415090961;
        Sat, 10 Jun 2023 09:38:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7dd09000000b005163054e330sm2968446edv.87.2023.06.10.09.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:38:10 -0700 (PDT)
Message-ID: <b18908cd-fe52-8f2d-2882-503460909936@linaro.org>
Date:   Sat, 10 Jun 2023 18:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/18] dt-bindings: clk: gxbb-clkc: expose all clock ids
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
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-6-9676afa6b22c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-6-9676afa6b22c@linaro.org>
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
> It was decided to move every gxbb-clkc ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 
> [1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> [2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

