Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D957609328
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJWM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJWM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:57:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75008645FB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:57:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f8so4766971qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l76ylH5GQKStXCE5+N4w0FN1gGvZpR+mdU/Dav6ek2g=;
        b=rDq6PKWuQHQO4Rdv+Abeg8LG0aYl97e8yTPMgp9eLn8CSF+01B+go8oJZXQopcV7Qz
         V5NvsUcAbgicOSnC0GA81j0Ea/AGvJV6hTa00m9JkocgV2fh8q/mKLJRK+Ua7F7gsznZ
         7HnKxoCOMk52YNp9H3lWWblItAF4YcTr9w0aRORJrdNSoIBQddaT645FHZEJJvFwG610
         HUJ2bsBYZu/6sURDIWRYI9uuwNdhOfo3RAZd5m2JBnb7gIaYnjVmU/Pzs4oJi/vmV2Uz
         hgVB6OQ8HWmzPhklXWGbHLuK2OHmSjpyjUF5dqYLj3esHbGoIh/72z10F867HsPNn93/
         Shng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l76ylH5GQKStXCE5+N4w0FN1gGvZpR+mdU/Dav6ek2g=;
        b=N9AC/bVU65yI4dxOK3z4idoGpJoOcOoPEjm9SmkKj8DESByaS2oRqJnUkeEffSPscP
         i4K+JhILmVrsSfa8WtzzN3El4qdcaudA0xYv2FodKlSER2mTsF5h6HGAYnc4eow4fNGu
         uxFbhFAiimq6ql/RNMckJPBOtDCRrGHlssJBIREuZ4FUJX9gMKSa2RKypxV6lxlrggGu
         SJGOwQWl5dRPaQQ7lWCHgq03yJsgUNm2tAfk4sN/pA2abTmWlDk+RKhj82xHKriK7zAC
         tKnE9kLSmAeKZ6bRsl9A8dtnxgqam3qpnIRbEMcK4ycQfV36sDRxZQnxX4VS2ibQzgcw
         B+LQ==
X-Gm-Message-State: ACrzQf3+EtxJZYEXRmfwCGX9lNUR1a7GX0CPUzZJCv3Ho2g6PiwqeIRn
        paPQVCVyZ/9TO1ZItiuc+idBKVn3czhjOQ==
X-Google-Smtp-Source: AMsMyM7iTj/q2zHPaO5muCBKpEWDYRLPI/oOPZQq/+1HYrpS0Ua3aH34MqtS+47QydypiO08YmFfcQ==
X-Received: by 2002:a05:620a:44c2:b0:6ee:7a72:50b3 with SMTP id y2-20020a05620a44c200b006ee7a7250b3mr19416101qkp.124.1666529821463;
        Sun, 23 Oct 2022 05:57:01 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u9-20020a05622a198900b0039cbe823f3csm11430021qtc.10.2022.10.23.05.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:57:00 -0700 (PDT)
Message-ID: <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
Date:   Sun, 23 Oct 2022 08:56:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023091247.70586-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 05:12, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific section for defining clock configuration.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

