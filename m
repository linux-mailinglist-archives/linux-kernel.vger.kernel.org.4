Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF555E959E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiIYTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiIYTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:03:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F062EF2F;
        Sun, 25 Sep 2022 12:03:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so4817665pgc.0;
        Sun, 25 Sep 2022 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BMVLV56JZIvKvoJtjO/lGrfJO1JfVFGpaL7ayK5bP+E=;
        b=VTRwFy9Fnd7HmEoMY3vLIyOQA0mhE5jQaGhQ04dnFfCcXGgjOL70dZGXXjOIRX4T/K
         /lpxkl9rt8gbn70p0W5i9X52frI0mJzkRa+Vt9mf0R3X0RKP8nvZ875PpVTwyPmkdaRR
         /LPzi2ENCmrs8GZU7KZsh8qGpWI966gef/Wi1/Xq7jTRaieEC4KOhUtgQiDzk2S52cKA
         Shjq5/jAZaclo1C5A+Yo7W+v+KT4c69u+s7JCHGv2ag0+Z5B03OWWuGrcuT98vM7NVzw
         u/VEtTM4r3gdIlqCKLq9hlHBm0GsVuqOjbrs5RV4KAUKR33/4pe0DPnb/FpXpcy5/RbL
         jj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BMVLV56JZIvKvoJtjO/lGrfJO1JfVFGpaL7ayK5bP+E=;
        b=yYJ+4g9/+DgvVqzLNdur7v879NvI5DPyJzF34DkBRMvtffNfdjKBxT8+Bpka5Xricj
         tGhwvhTzl/DedTQwTK7jWxSGbwD+A58VUjlX5Q8eSwFZiXRpyKcqMlhX2lLOISiY4ZAo
         qJBYawhAizbtssVWjXO/Q8dKD89+O5zrr9ZXKOBt6/uWGxEz1pOFpBxF94fjarwxYhgC
         9EDliZY4Pw9J6Auq/plvnUXg1rTYs+AtEJ5thDW51bUamzrGQWgUv3wJQkjBKsYagje9
         paMlXkW837V+rOoHIvibi7sjhZDJX0oe5LOW5u4y+tTSYoQW4Qso924BK6YGIoXWqGAT
         yr9Q==
X-Gm-Message-State: ACrzQf2bn2giPHVVbXMnxG4DofJD/VCmIPmHL0N1EIkNg/5TuPXQec3I
        srya8ZnupdACkbX/p2RLpmI=
X-Google-Smtp-Source: AMsMyM6oe2Yx1uWCockAx9p9BX5ubEUkPeGll5ZfMfzrzpmNBzYylGVJyjcVzz43qL+liDknfsjT0A==
X-Received: by 2002:a63:6c84:0:b0:43c:700f:6218 with SMTP id h126-20020a636c84000000b0043c700f6218mr8913952pgc.420.1664132629749;
        Sun, 25 Sep 2022 12:03:49 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79543000000b0052e6c058bccsm10322234pfq.61.2022.09.25.12.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:03:49 -0700 (PDT)
Message-ID: <78859fd2-330f-1687-7fa3-f0831402778c@gmail.com>
Date:   Mon, 26 Sep 2022 04:03:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] bindings: Update maintainer's email address
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 9. 24. 09:36, Guru Das Srinagesh wrote:
> Update Guru Das Srinagesh's email address.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> index 6a9c96f..480e4fb 100644
> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
>  
>  maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>  
>  description: |
>    Some Qualcomm PMICs have a "misc" module that can be used to detect when
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index ec3138c..1f3ac59 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. PM8008 PMIC bindings
>  
>  maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>  
>  description: |
>    Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates


As Krzysztof comment, I changed the patch title and then applied it. Thanks.
- dt-bindings: Update Guru Das Srinagesh's email address

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
