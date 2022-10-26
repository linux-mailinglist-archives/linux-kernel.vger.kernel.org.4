Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4360E3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiJZOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiJZOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:55:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECD4DF31
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:55:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cr19so10088694qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3lqNi3RbqgpuL1HhrQjDmFY0qPGdGmAhxHwivSb/T8=;
        b=Gcb8FjMs4ySz6J+pR+J1Mo/EPLeUu24ZaxXMLXfj+jAWgYMTPDfUxiUow8fZpQ+i8I
         9h34U92YQK5UR2zLTk97+OU7cXC0yJaTq8Y6OTGdTaSLKD2KKVd26WHoL5IVUPH3J+QO
         7XrFg5T6yXwvOrbfOi4B8fZL1i1mh9My6ry+pAxcIgfz4Kmc49O8OFQiBPCPtRT5FdYV
         Ju34rxsPx5/4VRT7Mqt81L7wwaB03Y2rpFkyX0cLpzgH3QQVx6TatZYdm+J0ipP0BD8h
         pif4Orsgp4D/e3eyQypKmhjvH+Ss1Gu/8G2QEVmIZx0R3CvTT/JHI/95xR9DQe1nFnsO
         vlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3lqNi3RbqgpuL1HhrQjDmFY0qPGdGmAhxHwivSb/T8=;
        b=U0vo5+sPRef00KEOJedDt8p2xiRC7nQys42kvENZTPxTemBerbZHEJe6JZuT4GjLEF
         o35PtkNnRuizPmVODwDoLDsBVJ8OeSMS5IvV5cOi0Ucvh/wBPjXm2Bu7zo/kO8nrrfPr
         PWPY6/1NT4MOBSFfetWp9U/gdtXYietz4Mq+kW7jKV0D4OQYMFQ6GlHhmWc8flSjKZ5d
         krSkuSVKV5+uN43RqlVv5Jim+hcY5DaZR0OpyOoTnVIWq/pfLMc46cbFXI4sRDiBQR5O
         Fp+dDlD7oipv05giw4UTkObvY7q+uQAVokpa6Slp61PxuPPCCP9wB2CWZ/8m5l+DOGHp
         cRvg==
X-Gm-Message-State: ACrzQf2SLfuF+Dt5rtEQMezx50ZpFUn0BhHzDGyFQWdSgaAYag2WXgYq
        G3VMvcf580Ela01/rcFTMPknNA==
X-Google-Smtp-Source: AMsMyM7j/ZVDc5l9UFuHrdwBCBzkxBteTzFIJOBIUZKFvQpGoW8iRFKuzC3SUR7OGcb+XCilbIai4A==
X-Received: by 2002:ac8:7f41:0:b0:39c:f34f:feca with SMTP id g1-20020ac87f41000000b0039cf34ffecamr36575709qtk.644.1666796139618;
        Wed, 26 Oct 2022 07:55:39 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006f16148fa96sm4007204qkm.91.2022.10.26.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:55:38 -0700 (PDT)
Message-ID: <853acb94-ee52-e776-2e0e-08ef837bf02d@linaro.org>
Date:   Wed, 26 Oct 2022 10:55:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 06/11] dt-bindings: thermal: k3-j72xx: conditionally
 require efuse reg range
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>
References: <20221025191515.9151-1-bb@ti.com>
 <20221025191515.9151-7-bb@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025191515.9151-7-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 15:15, Bryan Brattlof wrote:
> Only some of TI's J721E SoCs will need a eFuse register range mapped to
> determine if they're affected by TI's i2128 erratum. All other SoC will
> not need this eFuse range to function properly
> 
> Update the bindings for the k3_j72xx_bandgap thermal driver so other
> devices will only need two register ranges
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

