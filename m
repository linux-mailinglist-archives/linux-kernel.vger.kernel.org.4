Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3107666D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbjALJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjALJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:03:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950032E8F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:58:56 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jo4so43108568ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MigYz6tBw4+yKweKth5khXbfl3nCTQxgPvk6amIZtKM=;
        b=wG2M0pwvt8H1YSu+YeUBiiVnmM/3S+/9tDJ4c35mj8wrvw2dO+tOlRVYT1YdWZ8QGN
         nzrrPmL6g1xLs8/JnkwGsixS35r8gxxKLraWAUNbusbqMYCA88wBCM89MDQtdqX+JHMy
         lyBNv1M+6vSDYlzOA1rbF54b5/moirwdRIfiGye7L8Ib6oAq4/ff5iRBQMnTDlulaeGg
         vclTmBfU1QOVmu64dQGi3vPd8QAu+TxyOo+hYhitWhd5Pakq+GHBON5HJ7fiPUor7PHX
         7LZsk/mVL88hec/5ASuQbh+4bn4QTHXaeLAXp+gU5Skb8+2DjDNd1PPS6vnxhD0c4/xw
         qFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MigYz6tBw4+yKweKth5khXbfl3nCTQxgPvk6amIZtKM=;
        b=U+I8pxeEBdjbOJcxpFhjuFli5DeJyPwWR2NllGuVZw1p9bLwQp2K3Rius3pgBcuzUv
         RBPmOZS8w56YgB4YZU4nPjvuH9t4NrDKbodm/lFWtmaVj25y0KGeizmPomG00+y3JSxJ
         Ir/0+FR3qD1RzrYNkYLswkAsZntzdAI2qiY43S7HpMZmM5mTfd774mrPQ8H68Icg4QW6
         Kwmr9EJxFAq4tR3M4Z5M6pegIHbWopsZu7O81030mFkJlaWNsfseYRj1GVS7gY4pAkYC
         YbTOh6iELu1/VtNddGjSi5EbcpE6YqKWzQmqzINURNQnYVwMx2De8CGFduWhNl4vT+Pp
         x0aw==
X-Gm-Message-State: AFqh2krqWUonrtGHJrC5trcFMxKx/qbO+rtMHhMHDyctx2tpyBvE1uAA
        hjPuIXuaCv+gQVGGdXYusVACaQ==
X-Google-Smtp-Source: AMrXdXsPkr4Yq01Za/hKWM4fVZAt3sFP5s/z0/QcuKFr65wRjg5evQCwV8puzlT40wT6o3g4CRKJmw==
X-Received: by 2002:a17:907:8b09:b0:7c1:bb5:5704 with SMTP id sz9-20020a1709078b0900b007c10bb55704mr68749552ejc.26.1673513934721;
        Thu, 12 Jan 2023 00:58:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709066bc400b0085481fa14dbsm3303452ejs.1.2023.01.12.00.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 00:58:54 -0800 (PST)
Message-ID: <0c50d8aa-4fb1-5891-c9db-a2145445db07@linaro.org>
Date:   Thu, 12 Jan 2023 09:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sm8450
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 09:54, Mukesh Ojha wrote:
> Document the qcom,sm8450-tcsr compatible.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v3:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

