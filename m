Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E309717FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjEaMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjEaMWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:22:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148BB133;
        Wed, 31 May 2023 05:22:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3491609fso3864994b3a.3;
        Wed, 31 May 2023 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685535758; x=1688127758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rN0bnH3gWYzBfmgMkHbIKEWC6DN7mRYY+LRbQfT+m8w=;
        b=HTmJDBodHXoupmovdSQqrWH23609whCbniyvjQt/8cgNZWj+AlndJgjNV6pZBTyCxS
         2HyCOEDkKDu5nXHoCF4XjKHHmk/JHP7mF2z/A3rJEHiAPchIBimoWPiGVb1yopKhJmsS
         GZV1NI8i317BxhnBWxKbjAJAHhRT0KseBRpMqDmQPfd4dKFWUqt8HCRI26SK8+KqvF/D
         sSExthJZjnn28lF73gjBhLDoV/FFpZy3dl8RJpP9l9PvqRqNGZ73lrGg1q5GO5+FOVNf
         sw0Pe5GEmU04pYQkSlG1h1L1euolw/rJV9oY842wSYllKxfZm1c/K2BXV1nKjEa/uGzj
         UHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685535758; x=1688127758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rN0bnH3gWYzBfmgMkHbIKEWC6DN7mRYY+LRbQfT+m8w=;
        b=NkM14ZfJ/hisNusWlilRvSk1NWji4Wn841GV6eoiuRFnr7e1GachO38ikHlUjqm37d
         QzeY6hvlDh34Ic7OIqKFWvi/fBr/mn4F+jeRK6YCz+od6OKaiySni9R8SpqOID27HvaH
         +Pnqf5pnJXc+DEIQzAQpQ6eYMuAlfC10PsPBFS1EZcXI2MapAuVWHH7EPQkPUQFdZHo9
         v689ZfiDgSy7bE9DNRBlUmBRyKGd2yOWKGlQxMe+F80MFTIqTqmBIWlKvbiM4lU8SO3O
         go9nq87zkRefKIFVMNR+D3yJlZnOrXVVKincFKeCVjiKzmF4DXlXu9JC4fEO7mi9UoHk
         lYLA==
X-Gm-Message-State: AC+VfDzq2FBhquRl8cS+Q//NopNd50qSjLWydZ5vwZC1HHOtCoFqB47d
        75hD/HpgTZcEJyqHQNDG5T4=
X-Google-Smtp-Source: ACHHUZ7DfzLyM4oLMoKb5ptpGN1Rb4GOgWflTWWpLh7DmpnJMvRse3nfgP4G+6QmIdG3Jfb/v9UIAA==
X-Received: by 2002:a05:6a20:144d:b0:111:2f20:d48f with SMTP id a13-20020a056a20144d00b001112f20d48fmr5327442pzi.53.1685535758400;
        Wed, 31 May 2023 05:22:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b0064f39c6474fsm3261813pfh.56.2023.05.31.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:22:37 -0700 (PDT)
Message-ID: <d07c5c29-e5ff-9469-80c7-c6ad54734e6c@gmail.com>
Date:   Wed, 31 May 2023 19:22:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Documentation/process: add soc maintainer handbook
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, soc@kernel.org
Cc:     conor@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        olof@lixom.net, palmer@dabbelt.com, robh+dt@kernel.org,
        arnd@arndb.de
References: <20230530-multiple-whooping-ee5706fceb67@wendy>
 <ZHbpb98Yn7SDZ4XZ@debian.me>
 <ed4c3564-4083-5568-f999-cfd7f02544a7@linaro.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ed4c3564-4083-5568-f999-cfd7f02544a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 13:51, Krzysztof Kozlowski wrote:
>> Sounds like passing `make dtbs` is a merging requirement.
> 
> And why shouldn't be?
> 

I don't have anything more to say here...

-- 
An old man doll... just what I always wanted! - Clara

