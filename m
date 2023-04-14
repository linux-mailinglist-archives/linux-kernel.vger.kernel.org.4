Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7F6E2B96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDNVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:15:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94C59C6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:15:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rp27so11816660ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681506930; x=1684098930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUauNqUH8SviMCLNAJv5IYrg5F5Bu+FptiwoslQ+xFI=;
        b=u/PGfiDBOFJUjYl65eSqzMszDrdR8JFXGwqrpwriYGiTMhJcF0P45hDrI2cGYRhfmW
         JRb8WrMvFl7r0IpWl3IJygjQnhvk8iHDUVUyVuBPeegSvyKBeOPZGvBvXZECWYzWAz4f
         oqqWu7sv34M+xIHqF/IVb0LlDcp1Ia6sENPOXnzmL9TCp8zb9NFQTjBFx2yXyRwUgDmg
         TwQ/djrb9Uav+Ye621lSVehiWCo3u8Rc/KEeMP8ZUb0W7vSxLD1DpPiNHqgK6NKYOdK3
         VG/UV+RsOz0y24RfW3STKPklYzSakSz9e7ROnyXGY5ku9XG5qti7D58H9SEb+Sthp72v
         OT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506930; x=1684098930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUauNqUH8SviMCLNAJv5IYrg5F5Bu+FptiwoslQ+xFI=;
        b=lZ7uVTA60N7keQ9XmDg5A/t82mUAzwhlthmT/MLbGc7uWgDUz8nb7Miy2sr4W80rwb
         H8pQiZxNWvEPFaLsX9MxyuZbGI+3uzcTWx7+1ONy0CLDE8UTu6MDo5/CCjO3Kwo9aXAV
         5JqseaHm1qPQE5tsj98eUiPaDMEw1G1P75Dh/LiM0Z0jBnDuLL4EyyZ5JQKClYLGv6L7
         YYAV0HSDoVY+mmkQMgGIiopwIP7yNt9n5UxGwvo0R5xOJnoFFc24AUn5Fwbsywf81Kfu
         zJ6/9dbQ/s3wJIx+hIuEVQVNC2BfRPfyzpjS8dknTQnynXdPTXSCcfM8F4qcKwAw6Bsk
         wz1Q==
X-Gm-Message-State: AAQBX9eSGjSkfvtDluIaWPbWsvqwEBI8i1OFaodtNeUX4gdxgwaUz1kZ
        TXIfUl5Kph86rxZLZwxjDPLLnQ==
X-Google-Smtp-Source: AKy350YlQjI78vTkasGK6ZSDTKkQK+7zwh4Z1p8TbImh92gDODRqJJmS+18XluAV/XwAwn2lo8kYYg==
X-Received: by 2002:a17:906:5e02:b0:94a:6966:7b45 with SMTP id n2-20020a1709065e0200b0094a69667b45mr621291eju.39.1681506930157;
        Fri, 14 Apr 2023 14:15:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id wv13-20020a170907080d00b0094ee21fe943sm1354903ejb.116.2023.04.14.14.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 14:15:29 -0700 (PDT)
Message-ID: <add2ccfa-d811-d76b-342f-a2204f7e87b0@linaro.org>
Date:   Fri, 14 Apr 2023 23:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: dwc2: add utmi optional clock
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, hminas@synopsys.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amelie.delaunay@foss.st.com
References: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
 <20230414084137.1050487-3-fabrice.gasnier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414084137.1050487-3-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 10:41, Fabrice Gasnier wrote:
> utmi clock is typically provided by PHY output. Add this optional clock,
> as the core could use other clocks depending on the SoC where it's used.
> This is needed on stm32mp15, when using the integrated full-speed PHY.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

