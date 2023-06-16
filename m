Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFD7331F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjFPNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjFPNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:13:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019235AB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:13:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso5226915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686921187; x=1689513187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgRqkCmLSNrRg0kzYH/gYvgx0ftRsyaeR1bjLn9ohCw=;
        b=nnmldJE1cqVEB3z6tQT1R7QHIonwbqyKADSkliHOx4r9glNa66H8oF/KUHKM54RpkQ
         6D1G1LtKnYguRmmeW+zav9/jnuN6+nChpqFPJ4v/vJy44uZXX99GefkTZK488dYGsDNe
         qLNFHeQg3D6AD6WHGKNvyrtOScCT2WhVe47QKjSZzQAQK2UsE6wXRre7c6IJonhglBzw
         1hbg9WLXhUWdrJg8hRNpbhM2XF9UEQQWpKou2RUA+rZOxaGXBbb3ezGuodFU5tFO7Xz7
         msZZwHdUEnabtImuuCpSteVRT9h73T5MG2rHh7Pa9WzS4TgTLlKvZDw2uozNMqnnwpNf
         Z7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921187; x=1689513187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgRqkCmLSNrRg0kzYH/gYvgx0ftRsyaeR1bjLn9ohCw=;
        b=f/xCxRtGNSYBeWfYzTMrf3Rt7H2vRD8VaAJQqJFVtiw6iQoeHYmKDJWuwY7bY13rwz
         MIuirZobEAC5bQbTaseVKh6bPTm8+BhjC1P2eZLfr07FR4CXQhoSlIw6kciDlZKD4BqT
         vijELGdOSG04jsroa1bXtdIiyU6peosTTCjKqA6SDsdIzSSzfcaUTOSqF84IV7Qatm3E
         W5QvqnGi3QDVaL6irrh5Wpmob+GiAPC9FDrjE5Joa1rxDgpdSx+Z1SxaQy4fWtasvZFs
         JNkm/aY1cozTGjAatqVev4LbAtSi0BUL1iB3ert4AAF6MTAq0OoniklIeQyL9mM+6Cjt
         Smvw==
X-Gm-Message-State: AC+VfDzYrhRmLDbRi/CbmHCKAu+mrG1MuFUsIcYzJa+6m7qS7f/13AKP
        kWr7l38LigZ5Lh9GK/a4jBVjbQ==
X-Google-Smtp-Source: ACHHUZ6PjvZeXabO13ItqPLMS9+xmOpBl0+X8Yf52uVDge1YdwdjlMRILf7KOevIONlKvHJnOq15VA==
X-Received: by 2002:a1c:ed08:0:b0:3f7:e3dd:8a47 with SMTP id l8-20020a1ced08000000b003f7e3dd8a47mr1584365wmh.11.1686921187163;
        Fri, 16 Jun 2023 06:13:07 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b003f60a446fe5sm2163536wmj.29.2023.06.16.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 06:13:05 -0700 (PDT)
Message-ID: <fa665e61-f36a-5f65-4837-8d7c8c6a052e@linaro.org>
Date:   Fri, 16 Jun 2023 14:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 3/6] media: starfive: Add basic driver
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
 <20230525083202.67933-4-jack.zhu@starfivetech.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525083202.67933-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/05/2023 09:31, Jack Zhu wrote:
> Add basic platform driver for StarFive Camera Subsystem.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

One thing here is the patch title and hence commit message.

"media: starfive:" doesn't really tell you this is a camera versus say a 
encoder/decoder.

I see you've used the name "camss" for your driver, which I think is a 
perfectly good and logical choice - however if you started to make 
commits along the lines of "media: camss" that would conflict with the 
qcom camss.

How about for starfive and qcom by the way, we do what Laurent did in

commit 3e8537b4c15172bfe1b285c3155ed5c37d523cd3
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Wed Dec 21 10:33:39 2022 +0100

     media: ti: omap3isp: Use media_pipeline_for_each_entity()

i.e. future StarFive commits for camera would be "media: starfive: 
camss" and similarly for Qualcomm "media: qualcomm: camss"

The point being the commit title namespace should be instructive and 
specific re: 3e8537b4c15172bfe1b285c3155ed5c37d523cd3

---
bod
