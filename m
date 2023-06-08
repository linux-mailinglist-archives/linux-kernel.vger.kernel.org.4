Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D627277C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjFHGtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjFHGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:49:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E213A173B;
        Wed,  7 Jun 2023 23:49:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f80cd74c63so2845191cf.3;
        Wed, 07 Jun 2023 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686206979; x=1688798979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ARSspE8Wqbyj/GCtXfbj+s8zwVt9qmZGvXVlUiROqk=;
        b=YNiDJNFPJc+61sZ8GD5vTbQx9l8pQc0mLRpvzwH5mScpnv4b6d+Fx8Xk/om416FCKF
         ZFDOXv3ihgAyC0Pqdz/7JJ8wdPmpvgPzGSqAkQs0iRvHwV5/PeR6KuX5tb+LgNDQ5l6l
         OtQNuTiNFmuF56o7jWSqv1VQ3oFfiYCWjq6+LCvHdkSxJ0TEYFQlbIR69DjjkHJXew9K
         rcoKZj/Sw2BBCHpEv8hOJn7g+E2GfHvALT4W0SRwzizxO+tMRGnlBFRXyamNk4S8vaKH
         cpaATUb5PufaR/q6HbpLq5fd0onmwanj9avXxSXpOaMd3FRT0TEXpxCgRbE4iZAnhYya
         L49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206979; x=1688798979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ARSspE8Wqbyj/GCtXfbj+s8zwVt9qmZGvXVlUiROqk=;
        b=csGqTMT3zz9calkvCgc54D43n2lqZ5A0xTdpNBKea0ZnbwSguzjuNlROBwGY/pAvqm
         yqVHYbuIpjriHfkt+76ATYYO3+z2oot2K81oFqAl/jvH1JCdgCHkzBe2wOXygqo9+KmS
         1mstoRvOp/Kbaw+Lp1LhS/DtUwhREGzaICnbunapLcyD9JaVZS7ROV4A/LCyjp14wtqE
         YcKpVoodcr2sNzhimQyDq7PePLX/bvAQRe08Cq906ClofWxM3yil0tVQwZ1QERwB2fTZ
         s9vMT5905UziOtMsPebWhEPt8pTuCHMEi/KoR9MH1f6oNMZnUH+/DVkZbUr8JCwqJ69v
         v1EQ==
X-Gm-Message-State: AC+VfDyMNUea/sWda7fXH5W8w5aDW/6qkfd59ODGrp0B/HNNtCJKDmYH
        deO8Sm5uwn64UemxJWhOIIs=
X-Google-Smtp-Source: ACHHUZ6OYDuiqLS1qKmOsF4AO2kU9zCpuDaDkoZH6pWqspjDCpqZyamwOn9eKqiQtVUOfHXY6X6MHw==
X-Received: by 2002:a05:622a:289:b0:3f6:c348:3fc6 with SMTP id z9-20020a05622a028900b003f6c3483fc6mr6384281qtw.8.1686206978969;
        Wed, 07 Jun 2023 23:49:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0065014c15a57sm420351pff.35.2023.06.07.23.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:49:38 -0700 (PDT)
Message-ID: <bb4060b4-47b6-a7ba-af73-8509241ee2cc@gmail.com>
Date:   Thu, 8 Jun 2023 13:49:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to corresponding
 SPDX license identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-18-bagasdotme@gmail.com>
 <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
 <ZIFn8mNXVcI0SGTR@debian.me> <2023060839-limpness-vessel-ccc7@gregkh>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2023060839-limpness-vessel-ccc7@gregkh>
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

On 6/8/23 12:40, Greg Kroah-Hartman wrote:
>> Greg, is Richard's comment right? If so, I'll drop this patch.
> 
> Yes it is, please ask for all of these to not be applied.
> 

Did you mean this whole series? Other patches have not been reviewed
yet. Maybe Herbert can apply these rest of patches if there is
no objection.

-- 
An old man doll... just what I always wanted! - Clara

