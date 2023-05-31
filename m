Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05CE718ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjEaUEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjEaUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:03:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F11188
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:03:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30ae141785bso23423f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685563425; x=1688155425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcmFGFxmffRI2HChk9sT5pwagIsBSNan9n+k92cvRtU=;
        b=f1erte/CcRNMZda9y0JJafdTWET6jUtD340N8WudldhR3gUe0Ha+W5l76ApTEiGk3w
         F3N/lUj1aNKCuBCKVuVMqgOH1NNKa7XOYMTKakEzeySKWakd7rPHHpiC3On7F6Jw5M3t
         KmUBjMlTT8yPRLIz9REuSkbMVFvV89aw8hzrl0l7QIjstaFYGXoiFXhD1/G9CHW1bbgH
         X4GE6qL8iT0ZPJNCGJIoe8Fvqg5jqcqDVxs694Wh7iAVkW5iAlPRRFrpR9WGqZgHLTHK
         uacOkwKg1d6qF/8v1vx2uBYJKXgOMQr2tj8hHXjVxujvuAlsabW82SL1DTBo8WInEZhc
         AQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563425; x=1688155425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcmFGFxmffRI2HChk9sT5pwagIsBSNan9n+k92cvRtU=;
        b=Q18rhgcLQSWnP3y7gzyuOvpV+uDs8+F/dbUvNg3TL+sUUpR8irSFzyWCp+JNCZH+LT
         p+KzzZ48cME7EBNWDt454ratCXX5l4bJ5URXx1DNqX3CzUyWj4034xg1AJlQE+eYjcoZ
         /I4mHhgQ0VKstD3Jz8FG+fxEdVjUgaKKeHJkG2TKe0gIQcC6v756TfIFmQf6I9DhzN7P
         eJg6WwIO/vDZKIIDIO9ScxBciJJQ573iiLS0sGIrb/ppaMX63fNUmlyMczqqSEfPktyf
         BcZArgpWnCZzQudLwzzhtmv3pEXd4SYg3WLSkUoCkiBzL/1VBsDYn3mnyoUki55pt5QQ
         IVWw==
X-Gm-Message-State: AC+VfDy9NhThozqKH1KhXIkwgjZW7mfLdSPSzTokOvx5epNp2TReiMfx
        0Wn6xWSjTXOExMIZSmNYbhr/cbVATeem7ZsgtJA=
X-Google-Smtp-Source: ACHHUZ7lnoqLaNTh7lMjljiCp1vJBVKokyRQDHr2Lsi8bW8VaNfGtV/m2wBbQ89WixGRdA4NCO71SA==
X-Received: by 2002:adf:e382:0:b0:2ef:b052:1296 with SMTP id e2-20020adfe382000000b002efb0521296mr138172wrm.22.1685563424906;
        Wed, 31 May 2023 13:03:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7d586000000b005153b12c9f7sm868891edq.32.2023.05.31.13.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 13:03:44 -0700 (PDT)
Message-ID: <e9cc8600-5427-c4ac-1b58-54bd92fbf443@linaro.org>
Date:   Wed, 31 May 2023 22:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] arm64: defconfig: Enable sc828x0xp lpasscc clock
 controller
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 14:29, Srinivas Kandagatla wrote:
> Enabled sc828x0xp lpasscc clock controller driver required for X13s laptop.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

