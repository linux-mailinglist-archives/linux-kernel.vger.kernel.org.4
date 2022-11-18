Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311562F555
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiKRMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbiKRMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:49:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2012A99
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:49:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g12so8070113lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU64xqPho7kuHJmVoycv5RAnRsFWiiDIDLC2AX54FvU=;
        b=zWsKvLSaBpnXwQgAMArDsQN8Mh76n4rm3smY4OmvD6w1gb56smCVYkajL6+fEELXF1
         DhbTDRcwwz6YPf4F/knoGwpNIC7/05LnK60mvN5UljbFrsnSpJKm8tWdGo9HSOwzP4WY
         SBt/6LISBjRU8T0KrhGaoiextz9hiSLnEw5SNa6kPIg/UXu4wINm83xS2KwhO6bStMPq
         L++hDjGn4LyK4vKn+xqo55SQgAPIHVngp/EM7yt7BCYHTYLa8cncftRBUotVGX1QCr9L
         gCYtP+s2D9g7l48jGdXENPD7hi3aWkRkS2rg6OmTjJ1jgAz4pmTbALzIcVy3iMDBOKPS
         rfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU64xqPho7kuHJmVoycv5RAnRsFWiiDIDLC2AX54FvU=;
        b=xr9wYDV9qnWWPPvcFc7l5qoEJuTnEiGZzixDsYU28iu0UKf9dKQPjONQ1xYMhwJmnn
         z3jcHTB97aPHT0R9j/9AZke+V/sv6JFi+gHA5SqouEYoeBmMC43Dkwzk+rpxwS+U2HCW
         4D5uQH2h12ADhU0yn6FkzpEXgDttqZV7wi3iAvu6w1xsnO9zPE3gKqOhf76ZiYPaOcZP
         dfUoxiKAA7OXUHEHSgXhga1wARbLoW/paLLI7/EQMnB8yVtxSFQN8c/sgCL2gX6HV1k4
         c6WaF06xj4IGJwDeKci2nfgi6gR+lz+GaprnqPU7VD0Vdvq0Qt6mfuAfP2uogDi9XSep
         pUSg==
X-Gm-Message-State: ANoB5pmMJsiW6OIHWZ1KM/AJLmOZ0x3G6Xwsuexi484dot2KtaE+UQDq
        za4k7AivONWSXR4dPKQVSLH75Q==
X-Google-Smtp-Source: AA0mqf4S45tv+uFGzNLO8iegiUq98o9vBtYfGX9TTNzxiVINlyIkdnSCI4SWatImnxWio6dy1IvG2w==
X-Received: by 2002:ac2:539c:0:b0:4a9:d072:f5c4 with SMTP id g28-20020ac2539c000000b004a9d072f5c4mr2397956lfh.82.1668775744922;
        Fri, 18 Nov 2022 04:49:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j23-20020ac253b7000000b004a62ff61b3dsm645708lfh.252.2022.11.18.04.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:49:04 -0800 (PST)
Message-ID: <568d377d-8225-0079-b0a5-83ba4ec42f66@linaro.org>
Date:   Fri, 18 Nov 2022 13:49:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Content-Language: en-US
To:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
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

On 17/11/2022 19:48, Mark Hasemeyer wrote:
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt

As pointed this is not valid path anymore.

Subject: Drop second, redundant "DT" word.

With both fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

