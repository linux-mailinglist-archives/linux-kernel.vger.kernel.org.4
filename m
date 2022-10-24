Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361C60AAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiJXNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiJXNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:41:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15A89805
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:38:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t25so5948947qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6s8WA+syYl/1soPYugl8PgRcJUKvL8znur65OKyCTY8=;
        b=O4MW5Mz8AyKyDlwQp6prA3grYcTgM+7SDh5ALqtcwq8HOqoXmYnE73w5dRu/Jcqwod
         lK8ED3cOblYtl+6O6Vnj2bd+HIKLhr5SJRZB5w/lliAoR7H/b0lI76cNRWfU8GjNwJ9F
         2jPmL6UWjTjcoHKwSfTQN01OzFd6BL19NZnUlN7a10a8v3n8e+gjgHZqDUUQObYNtKYi
         xV7cxTbLIZYYxIYD3XViMzFKJa9UvhbEiu6MKFcyeYrBoEv8kz2vpZ1NEuvTGstPrV6M
         eSU7fgy0hEmbSa1ho6YiSlY8U5EJNxOeLNms9485OnDOgHcv69wz02CBVp4qC0MFs7r+
         yh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s8WA+syYl/1soPYugl8PgRcJUKvL8znur65OKyCTY8=;
        b=tX4/22+XL82jtdHjszf/pWfWIYrfJa63cRUNZI57W7NMce2RJvwfz+vWOyZLy/vTq/
         LgteW2TfZJcLG7+gC6Ft4CvtDqfMM7ndKMO4Bhtn+bPDy02J5digE8N44EYvv10rZuSE
         vGnoQ3S30mRNkkQsLoW66K+Fkcpdp9zcJgDkdgR7oYjm7uxg5bLweWUwJ9EBwxwIF4B6
         3Fe9VOd4n7zNpSQrxwsyCoi4FWqK8ism0wVUKdeM3QBTlnV0z+XGj6wbupEKbHvaqMGj
         v1JB0sK8x2Zz1kD9e15R/SLNd/zpTNx0MZ7d6AX0uoaaXJTCEe1aLzIu66ErAsjLK5o0
         oaJQ==
X-Gm-Message-State: ACrzQf39seXZoqckSLkfrjfmh9p9Gl3PPAENLhWtWR2usLR5EsVjPHaj
        CZgOMS4ejUS2/LeHfpkRPv4Qzw==
X-Google-Smtp-Source: AMsMyM78IBElxH8BgFkoT519PImmXgVVPmXKo+cy//tqAhGj3gFdCsN0VRVhe+sZ5YMuqfvc7mXViw==
X-Received: by 2002:ae9:e8ce:0:b0:6ed:22ee:305e with SMTP id a197-20020ae9e8ce000000b006ed22ee305emr22099101qkg.255.1666614959885;
        Mon, 24 Oct 2022 05:35:59 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id cd15-20020a05622a418f00b0035bafecff78sm12693087qtb.74.2022.10.24.05.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:35:59 -0700 (PDT)
Message-ID: <a896c106-d261-c763-7410-0f2acefebd41@linaro.org>
Date:   Mon, 24 Oct 2022 08:35:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 10/21] mmc: remove s3cmci driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-10-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-10-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform is gone, so this driver can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

