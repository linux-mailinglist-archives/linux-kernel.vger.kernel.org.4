Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E885D6C2DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCUJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCUJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:17:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7426CEE;
        Tue, 21 Mar 2023 02:17:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s8so17955250lfr.8;
        Tue, 21 Mar 2023 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679390241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52Jc4bQwoq+Au3Q36h3TvJYiCdCVD+FswzoEjoGzIrQ=;
        b=p3uWR0OWng0PG8o+4197DdHpmcXftbpV4oOx6PVRTqOLyoZAYOa07uQ+nIzYQPYsz7
         GlVmY7RRzQpJcsjt4ZJGSYd8lguJzW5mRw+9nRHE16+MHQ/vJVBFDbww/zD5rBmhhUI3
         Y1rXwwbKEhK5g8T/0NgtIxcg3IyiemCuCtBB4MoWclSuj3aIo6LP9ehDhN7EJIwhiVYE
         R3g2EhYoKll8DVxiiYuX46OHVMWFS6gDDC8t3FEy/ZZMx3mItpan9r/7g2eweQN8XZ5c
         Ebsp1jqe7E5KxZVNb+nC1A8ygoHwgrVV0k1Oc/i+xMHTB2ZtGcBapReXIdsg6nVy1iA8
         d6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52Jc4bQwoq+Au3Q36h3TvJYiCdCVD+FswzoEjoGzIrQ=;
        b=SVEop22gs4DmOq4LuQr+5dZuPjVCiEqQNZ238u+HqqYjGrVNr3N0RsO54RjFlOkjrB
         UZno83sAw4KSW5BrIUtJn7iIsgn1pDB8hZeQX4mKP0nmpdMDFDooAlMQxPazgIjOzbMk
         5esG6PQAusAjMM4SFXtLJQ2VuTPTZokpreti5ZpN+kYLvSkwxyLyP2lVERbmC4X/ayjn
         c29FLSEZrVXQqBF6wNz3/kxvx0UCDXlyrk7REm31a7MFJ/WPHnP2IoVp0Qna/s0+X5ZO
         8ODK2Jh1QDszUgdfctXNRDew761TjyDHs1MsfdHPNJ1PFnU/xuSaEgN9bq2jb3rjASZr
         fesQ==
X-Gm-Message-State: AO0yUKVKcO1sXVgnZarENvNqId22ek/oujBlxIj6QKNwPjKCglNpOCx9
        9uGb3m63tp92fjvxkk5lTcwYB4ReXZw=
X-Google-Smtp-Source: AKy350a1l8QJEMcZlUAquAEhPR8hMV1RIlEm4skDqL45fWGZfQKex8xiGeHHWYcQIpa8ot4L9p2HUw==
X-Received: by 2002:ac2:5299:0:b0:4d2:a821:5f1c with SMTP id q25-20020ac25299000000b004d2a8215f1cmr581615lfm.3.1679390240790;
        Tue, 21 Mar 2023 02:17:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g21-20020a2e9e55000000b0029f3e2efbb9sm194572ljk.90.2023.03.21.02.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:17:20 -0700 (PDT)
Message-ID: <b5cc43be-4b0d-639e-5172-463736ee76b2@gmail.com>
Date:   Tue, 21 Mar 2023 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv3 02/14] power: supply: core: auto-exposure of
 simple-battery data
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230317225707.1552512-1-sre@kernel.org>
 <20230317225707.1552512-3-sre@kernel.org>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230317225707.1552512-3-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 00:56, Sebastian Reichel wrote:
> Automatically expose data from the simple-battery firmware
> node for all battery drivers.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Looks very good to me!

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

