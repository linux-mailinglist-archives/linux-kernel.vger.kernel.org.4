Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865076D1C61
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjCaJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCaJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:31:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48CC1D86E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:30:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h11so21124377lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680255049;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6TFgvgFQKP5NKQsnrAjaH5l7UrfRJ9YIu/DRwuCXfg=;
        b=GVg5LkEZwgNYz06PP3UmTmWuKhTeOaD3Zm5r7hkRlAkCnei5CShaxGwz4vLbhnIPKl
         iu4xAOEkFLCwBmHkLq4RGOb7ZpvBc0kQJ/Phy14T81cK4NtPpXYeJrBsRs2vYImuzR1Y
         q3u6ByisYsHjoSd/1jkyF5ENkJQtbvPt9CvmO1VvCPCSVeTRVPqdo7WyVq5tB/lzzANx
         mcFKozhNEWmgoeySvoOEup95Ss8lIVtjzADyjEH0dGqxRnrFCOyMQBAedqne1dRYvVI7
         VK+X1ZyJ0344YcVIg5hFCHna9idZAqwXh1Qw5G0AYq10RPuTKY3ZdRasxFGbDvjzA2WJ
         BS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255049;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6TFgvgFQKP5NKQsnrAjaH5l7UrfRJ9YIu/DRwuCXfg=;
        b=gp18MrJK9nsVO146VgIgGhZ2vkA+CS6Gh243+SgiEqGV2KMIbTbDR13eI39I8hqgEB
         XHyeQzuCNlkimmmyfL+HaKsx/ErfJ3nikoW/JsPhZvXHupagVHDDVH9vqh/ZjYbslapk
         1Flfj+wpPHpoiAYkgyR30W0gxaEL3XHHEhnNUzC5NLyyG/rtrLzTYmccT8e9AA5vGUSP
         kDDUaroWlSbRMtnmVlpaOEWXT6UP2ICCXW49lkopJLlXglFepWEe6crpiR1e+iPB5doE
         PxnYWIt2ONEjGQQC9P+8p2TKBfW/HZrhpQnva43LWOHN2ZmH/bN8lXg9SK7XPMsTTr5z
         S0QA==
X-Gm-Message-State: AAQBX9f53+AdUi0oWxqtb4nevI+G6ZMlyK8Pa6+5klaV/g2800dFOyQv
        FA2bSbmihWZxH8SpEgmbSj2kbg==
X-Google-Smtp-Source: AKy350Zi/uDy4Yx1smxvpB3PViMtdtk7l3H/Lus79ZzsrkCg0c7Zw1aRukfysjd9dJ0kLUGDojsfiQ==
X-Received: by 2002:ac2:5d69:0:b0:4ea:f8cc:4c9c with SMTP id h9-20020ac25d69000000b004eaf8cc4c9cmr6892958lft.63.1680255049351;
        Fri, 31 Mar 2023 02:30:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y27-20020ac2447b000000b004e9b183fc5bsm310245lfl.8.2023.03.31.02.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:30:49 -0700 (PDT)
Message-ID: <ed9f10e6-a2fe-1c75-a667-4dbdb91327c2@linaro.org>
Date:   Fri, 31 Mar 2023 11:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 4/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock
 registration
Content-Language: en-US
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, swboyd@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        quic_plai@quicinc.com, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
 <20230327163249.1081824-5-quic_mohs@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327163249.1081824-5-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 18:32, Mohammad Rafi Shaik wrote:
> The qdsp6ss memory region is being shared by ADSP remoteproc device and
> lpasscc clock device, hence causing memory conflict.
> As the qdsp6ss clocks are being enabled in remoteproc driver, remove the
> qdsp6ss clock registration.
> 
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")

I don't understand why this is a fix. The clocks were working before,
right? So removing them is both ABI break and not a fix.

More over, this *cannot* be backported because it will break users, thus
Fixes tag is here misleading stable folks.

Best regards,
Krzysztof

