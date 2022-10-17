Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177146007BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJQH1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJQH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:27:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5535A816
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:27:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv10so17096747wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vleqX4azqijmPtKs5ZJjm57oFDFAlglFXOly3nJ4WoI=;
        b=D6Z+Xd+vG2yWDAUdKhIIBIp9MjbgQVORKD1Hup0Yx14lvdra4RSWNwJK1MgBFyN7Pa
         KxseAC778j9+eoe1qktBfhMUMOGHy+Y6sTbeMYQHKSGEL36smoScPNAem3xj8aSjW9iy
         I4r0C9NyDiJAyQeB/CHiPls45MEvgM+Jpnct72d6VJoEP+jVj4mGa+aKhIWQZ/a4VOR/
         eHYyTSfbrvuS7vjgAjnTdwd01W8bmLk6wUE5wh+ps4GR49WAe3Kjdf90jtg4onIwGc2B
         MUgXXHTPbnPEbmWXaWDj25qMvwzUT3+GJK+q5qdtQji2k+QESKiqWz6rQzpJOGRoJZh1
         b22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vleqX4azqijmPtKs5ZJjm57oFDFAlglFXOly3nJ4WoI=;
        b=BF58VlzCkdvQLr/kY26YGWmGJdGAWKRhtSkYKimBGtfulsyD4W9u0Z0i+bpTZj2d5S
         Pfzfdi9JH/IAQ5SYH2IiUF9zsDsFl/FM7NE0lXLBgLjET6Ubhyj+DEi1gNK9T8SXkZJa
         ODMhClVaw1/Zy91O9QQIE39UppMl8wYP+qbk5SlnTwjAE20X4MD6WExTB+rTd6NYiwkZ
         PvefPuJDB7Qv+yMG29cqzyzzMHMG7BdSe40Du7k5eneVgNXNstSm5Q8yCDUexr8Uvaod
         9oD/W9Wr2kzf2h/QNLER6xLNemLe7+c0Ibd/GrgzFDeWwg+hYbLvnKMeLNFxcGJVzrGx
         DhVg==
X-Gm-Message-State: ACrzQf0M2yLwIL1n1VjG9jLpjmEPPTHC0fMvzJiIq9zFXicY9NZaZXs+
        o8qXDRVL6JHaGEGW26SXr3CKDZ5QfPSMHQ==
X-Google-Smtp-Source: AMsMyM4SgJVOEGYl64n0Y+aPrzaEGfXHbsqGnyd0lMEGXvrEDGgS5/4llcPr+AJEUmKVghIVLMWVnA==
X-Received: by 2002:a5d:5689:0:b0:231:bcaa:3125 with SMTP id f9-20020a5d5689000000b00231bcaa3125mr5621885wrv.431.1665991655278;
        Mon, 17 Oct 2022 00:27:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9? ([2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9])
        by smtp.googlemail.com with ESMTPSA id n4-20020adf8b04000000b00231893bfdc7sm8135601wra.2.2022.10.17.00.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:27:34 -0700 (PDT)
Message-ID: <f0bf36da-9467-c905-c5bc-1e232ba9c8a8@linaro.org>
Date:   Mon, 17 Oct 2022 09:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: thermal: Convert generic-adc-thermal to DT
 schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221011175235.3191509-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221011175235.3191509-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 19:52, Rob Herring wrote:
> Convert the 'generic-adc-thermal' binding to DT schema format.
> 
> The binding said '#thermal-sensor-cells' should be 1, but all in tree
> users are 0 and 1 doesn't make sense for a single channel.
> 
> Drop the example's related providers and consumers of the
> 'generic-adc-thermal' node as the convention is to not have those in
> the examples.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
