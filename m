Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892C6BA9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjCOHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCOHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:46:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC3168A6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:46:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so41729346edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pkf0tRAKdI1L95+4CScbahui7UDD4ltG5PTHZ1fKFW4=;
        b=zdh8O2/FS8Z4V2t55t4OTNuuFneyKa55oTd3SDx6Pc2VQelz/5At/iR6ZdjO8dP2F6
         W35VNRyuWcKCBpAFAM+jHGXiDvFpfv+lGJp2Bx30RpCX5i2xKyeRMtiE9WVO5pwDHdeb
         7sV4SKM+OoAJLRs+k/d8zBNyYwr3arnSRFNRBRUp95XWyVTAvBKvrJ4AKGR5ecql2ZV/
         0EwIAhJsRa/9k66I+faJGSdNvs2jf8zr36KqEPXOHr0UBnbgRZidHsuOzHAuiIkXOCBd
         59+MjEXPsrO23eURtm/xdAFILp8G0R1wRzotJ7AvQO1S6jp9J7jkJVZ+SiXB9FnLsYUe
         3wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkf0tRAKdI1L95+4CScbahui7UDD4ltG5PTHZ1fKFW4=;
        b=gKbqk2A50/0FfS6/vv5SRgua8F5bNSgIHVAMkyiAYiDkuYOQaIFpE3rVV7YT8qEalx
         C7nwCp/7ieHlXqwYBSgcgqMIIKDKz1d2YkLVde6t1lMtB3Z7KZT9QIkrAkpdvCRz3//Y
         cJzqoUBgXI2gRVobgD/rxR0imDrl8k/kk+SONa5BS8e0RPZ7JQdmrII8ZTcOV72xDffl
         IHsLjyF67yrdqt+swCqEvCRgAGsq83/XhRGxImWOXdDQZqdLD+CaDwFQdHBl9XRvmVmg
         SwE+TqUaANa53MaWktcyUHqVnZe87mCckzDXRj9zgwpjI2v3KxsKsbmuQiuj2zgzJSv4
         ABdw==
X-Gm-Message-State: AO0yUKVpf85dicdswTQmNduwO1lsTCt5SpwpwpwGxL9/6+KXiJwKn1fi
        Xec4KARDnbQVLNPXmOgQcN5kzw==
X-Google-Smtp-Source: AK7set8S8I9i57CRAL5cOPReeDXDAnKoA9YlLd20Gz5w32txu8G9Zoa4GsbHFzYJWs4e858wkTXtRA==
X-Received: by 2002:aa7:c94e:0:b0:4fb:5089:6e01 with SMTP id h14-20020aa7c94e000000b004fb50896e01mr1856976edt.6.1678866362392;
        Wed, 15 Mar 2023 00:46:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id q6-20020a50aa86000000b004af5968cb3bsm1998381edc.17.2023.03.15.00.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:46:02 -0700 (PDT)
Message-ID: <753b0692-df63-1b9f-0576-d907a4744fbc@linaro.org>
Date:   Wed, 15 Mar 2023 08:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: Add compatible for SM6375
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org>
 <20230314-topic-nvmem_compats-v1-2-508100c17603@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-nvmem_compats-v1-2-508100c17603@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 14:35, Konrad Dybcio wrote:
> Docuemnt the QFPROM on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

