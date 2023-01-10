Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D95664FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjAJXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAJXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:13:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7363C382
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:13:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m3so9912649wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZw5peRwdHJn1dRdNsBoZUOe3wdkZhRQX4woKdarIq8=;
        b=RxZm+k5uTjKUm5C5bYL7u0H7/FusGTJ63UOPcrKto6/q4KJPOac3TeV9lYLtm2o2DK
         D7o1HhG2PQtaVvJMFrsjZFu1BqbsdJR5zQ3yK/zfjQCeuMFPPMFzaJ15Vz9ycel0vGqx
         jn1Gys/1VL2NzY5lL+1KHp2u0UzS2PbEFE2lXgSHMrT+moGvTXjHwO37LxE3WtFqNToA
         O77d4W2AaPocPc5LmgUVaI8Psu0S4vd8Y1XIn+W7WmDOhTEi44KIheRtzb29aaabfeQQ
         Alprt/F0PNcMLw9sO5T6zETnVfERXzjHX724IeoppSoXVtVxJAc4n4v1m/XkoPU/byhN
         5PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZw5peRwdHJn1dRdNsBoZUOe3wdkZhRQX4woKdarIq8=;
        b=i8xj9AMDvuSXlqLYD5S6CgoDFLpchLDbbEJPRwVv18QVQaq8WNnhwIHjkaEPiD7FNi
         rqr8LzlaLhEHTz9M3i5CVDfaCHNLmrsMc4OSwrv4fUBm9CdquBbYKrSxjjAGkX9r3Qj9
         mQLgR4pJkDgIL4KoXx4d1DIsvSCpxN4ZzOCy4eyXLXmD3zti4F1+qYCo7NDY51Q/IrwY
         va/8SSLUfwKZV8Lp144dhIYM3VUoxQJYS//hdLH7ZS88VRaaQ5ZSQahfc4XUTj33ubPB
         zByvVDV3+3p58v634P8wQ7iyUdSshpz0k4Rf7EBfS2Oj1FFKJy1NtZKxCmT8u3KZ+iZh
         EYXA==
X-Gm-Message-State: AFqh2kq2R7WiAxTGTxwylV2Fj7kG4vjQp45h6F7rB3496EPr95NhnQM1
        LBQlSCV2iuQVGE6PNzjRyK6myA==
X-Google-Smtp-Source: AMrXdXthp2bk94VT355+bZ7rp3mumXfPG0F/g57cOjSw7okG3eN+qUkeJIliZQ4jRHGdgSCf64QDWw==
X-Received: by 2002:a05:600c:5114:b0:3d9:fa37:e42d with SMTP id o20-20020a05600c511400b003d9fa37e42dmr2565547wms.17.1673392417298;
        Tue, 10 Jan 2023 15:13:37 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h10-20020a1ccc0a000000b003d237d60318sm16657130wmb.2.2023.01.10.15.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:13:36 -0800 (PST)
Message-ID: <d8a7e477-f612-19cb-8573-5cc0449df0fa@linaro.org>
Date:   Tue, 10 Jan 2023 23:13:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 02/10] interconnect: qcom: rpm: make QoS INVALID
 default, separate out driver data
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-3-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230110132202.956619-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/01/2023 13:21, Konrad Dybcio wrote:
> +#define NOC_QOS_MODE_INVALID_VAL	-1
> +#define NOC_QOS_MODE_FIXED_VAL		0x0
> +#define NOC_QOS_MODE_BYPASS_VAL		0x2

The basic fix you are applying here makes sense to me.

But why bother with an additional _VAL defintion, you have your enum.

+enum qos_mode {
+	NOC_QOS_MODE_INVALID = 0,
+	NOC_QOS_MODE_FIXED,
+	NOC_QOS_MODE_BYPASS,
+};

---
bod
