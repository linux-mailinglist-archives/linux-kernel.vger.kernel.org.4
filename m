Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960CD6F53D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjECI6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:57:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10242700
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:57:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so3023647f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683104275; x=1685696275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnRb7dDXP217oGo1HF2W6EYow19JwD0ZBlHKF/B0F1s=;
        b=nKz9j4av6PvO4+KQsmLJhqBm9WWlR9U2fpFqJBZjLhWr8IKluihScR4lvkQ3kIGfhn
         PQF9Q/gZTh0XeEwdphja6hPZaHh+V4RhppJWnmOV6AV9xwE5JurkKluq5ZjQtQfxZzG2
         CIOhqbug02+l0xvqhAO/ZK7wMIhe1d0dngaavzg4LCEKs2VEjH7rQqOpmIQ9NC3S/KL0
         TMUZLzVi1DK8ayaQE1F9Nk3PNQmojFW+E42S6d/TcaTX/IcyIJ4gn0bj1f2ClE8mc3Jw
         e6dPPjEq7iioZZLel6UjJxFAYGMgndT0LnRsggaGrQ93zmj/pIoQweqHMYk0ueXuykJ+
         qTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104275; x=1685696275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnRb7dDXP217oGo1HF2W6EYow19JwD0ZBlHKF/B0F1s=;
        b=AOdHAV1qNt3rqpP3DdHXYy7YkRvB5SATUuxwRJz9aG16KY8kkH7G6dLa+OCmzF6nVo
         YqiKrCstbm0pWAV8cxZCVvKPYbIZpUILEGjQsIQdC639tYq85h+5hLmcglZDYvKQ/Mbt
         TX+5RG0SMxkvT42390C++KvSQCc8KFp0RB3jPVM8yTMOWH4wvfLY0Q9931FzX1xQOl6M
         SpSDc/20aWovGHaJaGCT94zJUOYS9rPCvm3h/b2WF4xKxu2xJ+TjvaKN2ll9PorzCFAp
         UGcWowVD/xviTQKT8ZXc4eOC5PPvj/bdcQlSXQIAOgnqf1nGoqw3TReAtoWKSJkaLjU2
         8LcQ==
X-Gm-Message-State: AC+VfDwxykRMfD3TATpUfwGSev356qxoGM04mOk8jhKiVjC2PDU9ioQ2
        Ipsts+iGPmAr7bEU7QNrQiJuZA==
X-Google-Smtp-Source: ACHHUZ7rdLlv/3s8yG4JbblbnG+sbMkxQNNVv3adxxdOWjyGlPNDx1ClTj/QjF7GE76Jbpq26AhpKQ==
X-Received: by 2002:a5d:4d44:0:b0:2fe:e435:4a17 with SMTP id a4-20020a5d4d44000000b002fee4354a17mr14436000wru.65.1683104275055;
        Wed, 03 May 2023 01:57:55 -0700 (PDT)
Received: from [197.55.55.58] ([93.107.151.186])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c214f00b003f18141a016sm1224227wml.18.2023.05.03.01.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:57:54 -0700 (PDT)
Message-ID: <36f2a720-976f-7c88-1bfb-6c226ec286d8@linaro.org>
Date:   Wed, 3 May 2023 09:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] media: camss: Link CAMSS power domain on MSM8996
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503072543.4837-1-y.oudjana@protonmail.com>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230503072543.4837-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 08:25, Yassine Oudjana wrote:
> CAMSS on MSM8996 has been broken since commit
> 46cc03175498 (media: camss: Split power domain management, 2022-07-04).

Don't forget to run your patches through checkpatch --strict

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'Commit 46cc03175498 ("media: camss: Split 
power domain management")'


