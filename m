Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC7703281
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbjEOQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbjEOQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:14:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1926A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:14:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so22907670a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684167252; x=1686759252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lzf2gQIO3En4Gs0Mh5AfyCqX7dywHK4HYcVjkIaq3so=;
        b=TSqr+ffAlzvuGvpEA4CTOd58GeZUwZVJ/nBj4cDGwx46gij8iCrQNtfdpK+uXhpxjA
         t43n6oe6Fi0K5dJOotXKN/2BDqLfB9atzvVsJX+IkL8DnUXPvNTdYACXXPRkCgMw+0fi
         D1wqp8uKwWYne/KCREG71B+LRPeU6OK0CHEpmKOa+VTX1fQzAuZJKrlA0N4cBfYVjKvc
         1HH2hcBOq2AWATPJtUUvMifEGfJuA85oRAj1tQ9K7U74h56NVFX1lz61yS7mLkLGElZo
         Ifjikb/39YgSjjRirKbjZqrFMy5jndjixiAA8SH4Nh7W2kE1jl9hftH18nUb4pySF6+C
         N1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167252; x=1686759252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzf2gQIO3En4Gs0Mh5AfyCqX7dywHK4HYcVjkIaq3so=;
        b=SFWViATu7A9VgndvhtNtcLSyvErD/nt3j5wHYqWzvMG9lsEz2/hs8A6BmsfJ5jGoN+
         FaB46c5lRvvphXgzgG4folPDStGamD5S1TPI19eCMOjWTliA8jVi4VgQNkcS/j31W4Ur
         8YAsnStvutSfJHi318zxeHZf5PktYkS7+/zadP6g25+Dbiz6f/dBvgOBZDnbu//E92Zq
         tNTH36KBU6AzaT0SIC641onFvuOO+YbpXuAmjiqnUMFhsPBimpzLq1PV9CIx/DgX7uaL
         ivpNJiy2+zaDRcg/EGyvofmOCRVhvGn5RYNX5dgi5mkcODqu4x+onBY8dPQ6V3WtRT6/
         guVA==
X-Gm-Message-State: AC+VfDz6fdG80dwSHhDfjl04sYex8wxE6BKHuGh7IyF55upgtb6kvrkL
        CraEMcPVNfem4HctshJPjbP8DQ==
X-Google-Smtp-Source: ACHHUZ7yO73Qb93V66px0wxMXJT8l+wrPngwT+FKgR+3uDKmcWjxlK63+UxcCrAq5PIPtziJvH+3cA==
X-Received: by 2002:a17:907:368b:b0:95f:2065:83c0 with SMTP id bi11-20020a170907368b00b0095f206583c0mr33674583ejc.62.1684167252532;
        Mon, 15 May 2023 09:14:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id ib8-20020a1709072c6800b0094f67ea6598sm9747712ejc.193.2023.05.15.09.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:14:12 -0700 (PDT)
Message-ID: <53d76eb1-f474-fd1c-f1c7-9997c0d6cd3e@linaro.org>
Date:   Mon, 15 May 2023 18:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: Add crypto clock and reset
 definitions
Content-Language: en-US
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
 <20230515150722.12196-2-quic_anusha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515150722.12196-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 17:07, Anusha Rao wrote:
> Add crypto clock and reset ID definitions for ipq9574.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

