Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741FE5EF38E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiI2KdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2KdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:33:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2313AF1C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:33:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so2943693wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0jUTfFIgKk/2yeo2BJNDMeJhuO1PB3sjcqaadJwgKho=;
        b=hpmTeMR/CKDwh+ce3mVXd4Qf37umw+QQYOURtg0a6TuyYWWRJi63eCiK/8AK8dJW8t
         q6cB+YFZt3sUUEZA+A4Za2mA/sbs7P6T1rmO1ptBJKKQD9+pYP346ar2uaxUWLLB+FiB
         nWHy+Np06JX6m8ScNAWQcGHkN4dJBj+CxS/NBnYHUkNHwx3SSmpC4+yTNF5c/eugY3w4
         KEQFosCOrVNbcT8v6vN7u6bmjN9sZLTeOETE8G3Tz34xlrHYewOoBVKgfG0r6/4VB607
         gu6yVC58JsNdd5EFwKhTHN2hcvVP/QvpdXTZKZYsFVRz+hxu6JytgY1LNTehQrUwxBf5
         fM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0jUTfFIgKk/2yeo2BJNDMeJhuO1PB3sjcqaadJwgKho=;
        b=hJLgMTmt0qRD6NSip5spOa8+7fnfOfElrA0u4VUm8SZHrsUjmr9s8/GPC0cF1QeAUN
         hArtp2tt7drfhKFxAdSLCU/2PT3lGhtIooD2GjqRy1l3xS/pXmNYg8uILapyDjDCakkY
         gE27vOKqZd3MES5Amha6hcjkJx0K1FUeiNbYelVVZzvR4OPzeAC4M42biHyiHIwO3/7H
         xZPSfGu5drtdRNz3CKQ1cjraIrCBDGRJPLWedkEOJa8BdcLVKYJbcp3dvFUSeSOM0hOJ
         DmaBuM1RrGb5kwqsFSNSB9JPkBEKn35NeaVjaQa/UNKhpH1zsSBMamgdJBcyLMjEOiXM
         xC/A==
X-Gm-Message-State: ACrzQf2QRnXbgD0yzEYqzGjTwJgm/VezhkN6BhaqyXgh6t+ymt0cOw9V
        7n0/dlDadKjXkwi1eC2JY9uyqw==
X-Google-Smtp-Source: AMsMyM7MLU2KgC9V6qnhrTEYTwAuXkAO8U/+9DVEppc6EoPIiQucMB88PC0ET3pAluuAo6vV/dCDug==
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id p21-20020a05600c359500b003b4837898d2mr1840165wmq.64.1664447590345;
        Thu, 29 Sep 2022 03:33:10 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d5150000000b0021f131de6aesm6085202wrt.34.2022.09.29.03.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:33:09 -0700 (PDT)
Message-ID: <b36887f5-ffb8-1665-f959-be1e632e5206@linaro.org>
Date:   Thu, 29 Sep 2022 11:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] Documentation/process: Add text to indicate
 supporters should be mailed
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
 <20220929002500.283481-3-bryan.odonoghue@linaro.org>
 <54a19490-aa0d-2dcd-8407-319d6167add4@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <54a19490-aa0d-2dcd-8407-319d6167add4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 08:29, Krzysztof Kozlowski wrote:
> As I said before, this still ignores reviewers. I don't think it is
> going to good direction. The submitter is expected to CC
> everyone/everything which is pointed by get_maintainers.pl except the
> Git-fallback entries.

Isn't LKML considered optional at this point though ?

---
bod
