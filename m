Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFA5BE055
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiITIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiITIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:37:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82265DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:36:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so2559837lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZbRFqzUyyPs/92M9rsG+H3wBK/tL2k42vf0PEe2H8lQ=;
        b=akOhfTTZcbKEr04isFguHpEzcRFBLPTfducL1VfutUAj9lxobBnFV8hguHd/LqGIQ5
         tDWvm30uFjsT0NEtvxvHgA1MhL+7P43IZ2WiaCmCa6SBr7MyIEZnsPcWiLE81Jgrilw+
         I0lInYKr339PmYiTkLj/4yKnhw/mD7Ltv1U3JD8KL09TvwGWSP20Q4uz4vHQ5BwrwxES
         A17QNu99EioWMi1wp3OhMtxlDagtoXEA/H1DBPfkrwzcsrpY8UwqD8x4kleUccThPMHP
         UDM+FUKDx+jz8SHDZv4vOoNTJErIAwNCzxV8Usz6wsIkHi3OSr/x5op9YdZphGkKmyrL
         q1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZbRFqzUyyPs/92M9rsG+H3wBK/tL2k42vf0PEe2H8lQ=;
        b=vNx50HAkcHD8SynvnjZW6exNhGRyO5Mbt5MODw8UmyXPUnOilRbol1ffpRWGZ/l3c0
         ZRX88dhKooxhH9vlVT5vLL8q2yFHSRgYMzSntqPzh2/hh3C2F+cqwq0Gx8dRNyGKGmlD
         B4MHGorhBsWRQaHt4GLU/+iuicdIiR1V2dutoXkFv3aqxletr8HGMx3QdDoG1cxOH1Cx
         HNye+mmuKSZaT+cntI/KdymLdNvk9y0p43gqZduY+qh/NzsPvuRLevKMIq0E+t+GqAi5
         rArOd/Fs6XxwJ1zy7s9scObZlkYlU85ZqMj7eAInl9K+2ydir5I/uJ8xYCSPsRMo9k9f
         H2iQ==
X-Gm-Message-State: ACrzQf0eBkXDbS2fsZe6anxaFpnJI0ShQwo5WWClvEBiOfPYNTiWDX+D
        KcE7dOsFaeyG7/E5hWpNPIYt5w==
X-Google-Smtp-Source: AMsMyM5tQWKY+m5B2U0jnpYXtMNrv+a87LiHZ0GcZGdQpCm5wTPGOdx59QJN77eY2oFR+FW0Y15+bQ==
X-Received: by 2002:a05:6512:78e:b0:49a:d9ae:3051 with SMTP id x14-20020a056512078e00b0049ad9ae3051mr7294395lfr.203.1663662991823;
        Tue, 20 Sep 2022 01:36:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d25-20020ac25ed9000000b00492e570e036sm205874lfq.54.2022.09.20.01.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:36:31 -0700 (PDT)
Message-ID: <0ec65132-7d7a-2f8d-cc16-cb76efc343d6@linaro.org>
Date:   Tue, 20 Sep 2022 10:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919204826.215845-1-marijn.suijten@somainline.org>
 <20220919204826.215845-2-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919204826.215845-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 22:48, Marijn Suijten wrote:
> Document support for the pm6125, typically paired with the sm6125 SoC.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
