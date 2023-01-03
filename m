Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8265BCAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjACJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjACJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:02:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30127DFAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:02:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so44778859lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rma1OXXtPwZorAATSPbIGVsCt0s7nGTGyXy8BRV6/bU=;
        b=OlLux7s2JLGz6488fEjnlO/wdyBRA8JLHewattA+W86HDetZuNSdSSyeYNWvNCL9At
         UrqMqQA9O1BIyBnAYes7Ng0KTegwNeqM/pSfkXxM/QTltEQLBBne7P5OCeh7z4nLZsFJ
         prkibeotV5EdIscZre8uQstBPFL6CsLCvOv4Z3KiTY8fKrNZ0M9nZxwahPfaNkf+tUwj
         vnJtuPY0DxGvDY3FCMkj37lG1Dw+G6ksRnLNHr9KvAb+V0GPX4CH2QD64V2hBAlIMWOz
         VGAp2X4dU3hGD0VlN2Lb2l+qpE1NThSOGUTs37dxlWrGBfCt++zXFQ3/T5JeKO7UAk63
         /GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rma1OXXtPwZorAATSPbIGVsCt0s7nGTGyXy8BRV6/bU=;
        b=5L801Q3F7Guhw9Ndp2r4nGcr5ABCDOYxuWsTHvH7HWzNYCYIbObOzUuCbDginbKzJ3
         j+f4KZ5duMHW0je0vNsqApN6NT3RSMNkcCTZ4ILxhax9h/7gC9WrRWDZ6NfbVT3gBlqd
         3RgrMIQTXysC6ONbRCOQiYCaySUtSbMRa5C4dNDTWNCGHbCh8X5FXGlQ6f+M+eg9/Vlt
         jww/2ImMIX9L4+Pi2UVn7CdKV0PVgz8ARPp8F4ZQ+dfHTTJyW9gvYMWdcfQutFdJ4nn4
         u4MNopJOFYcG7d2RUB4iBmMiM6xLFEGmndZOlcNPkAWeI01AWqXIgRGnRoyvZGN75Iv1
         qUDQ==
X-Gm-Message-State: AFqh2kp7NQrEhOCg9YB7CDcy18S+F1IygC+ABI2WXfMZKvT17jq5KP+u
        Qwb3gzrpH4ueQpumWtTw+5YMog==
X-Google-Smtp-Source: AMrXdXuKSKb4fXDliXY3IUZECvd6jGgLhEO6HXKkRbrr0zxUThMGA6Ko67tu68FtPxF7Lu0U9qP6fg==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cc with SMTP id t4-20020ac243a4000000b004cb3a6065ccmr1399538lfl.5.1672736571492;
        Tue, 03 Jan 2023 01:02:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w4-20020a05651234c400b0049d0a98f73csm4739133lfr.154.2023.01.03.01.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:02:50 -0800 (PST)
Message-ID: <ba4ec52a-d6ee-b471-bfa5-521f876aef2d@linaro.org>
Date:   Tue, 3 Jan 2023 10:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/7] dt-bindings: interconnect: Move interconnect child
 node definition
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-2-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:08, Bryan O'Donoghue wrote:
> New properties should be defined before the allOf. Move the
> patternProperties definition to before the additionalProperties: false in
> this file.

Your commit description suggests it is just a move but it is not.
Instead you make these properties available for all compatibles, which
is not justified here.

Either provide full explanation why making such change or make the move
equivalent by disallowing the properties for other variants.

> 
> Fixes: dfeef93fe3ee ("dt-bindings: interconnect: Convert snoc-mm to a sub-node of snoc")

There is no bug to fix, at least no bug described in commit msg. Style
and convention issues are not bugs and not worth backporting. Drop the
Fixes.

> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Best regards,
Krzysztof

