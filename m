Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A560FBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiJ0P3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiJ0P3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:29:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EAC748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:29:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g16so1384045qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHTkGsnEpiQOSKHNjPDX3+CULOyog3J2dhLGttarK/A=;
        b=GaiBO6Mkn7dkZqOfUjn3ODkrZTzifQ28AbNba5+ZBLN/PdVVU6gPc72A+U0BTc0nIx
         C7uR3noWa4h38OQuS+0BxIlNBT9veqX1iTFxiNOyfsV837RUZWQSj6x7Y0L3MyAmjT8z
         4aBV9SBpVe8uqP4emfl1phXKfufdTuCicfSPXlFxCUSkCTczcDSLQiGvmryVhdmQOXXq
         gWMHzFkI4DvPJrQX9sKf9PRt+2pRwHr7F5K5cAFvPVaDjAIFXAg75E7ZuCo6wOJzfvCD
         2cn5HzAx4fdHejfVDDys1222GKuiN6kHWdkPURCc1TkpRIPq87yx7IafOVboFniFRaZa
         hNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHTkGsnEpiQOSKHNjPDX3+CULOyog3J2dhLGttarK/A=;
        b=F/HUD5BjcUlmEOBXekSg4V+9fq51osqkO4fISqjPQRupUJf5Lk2YsUwgS6b1cIgeBF
         RwKU0PtnrgO1aPAe8ShXzNosP6pOWAEvzVtef0P2y8LmsU2jCbwKh06ds2FvOg5UAM2l
         BLchkWlh9Mu995qpKKI4mh3neVe68IhSeAXkX4jwub9BhSPFM2UCnwVT9WNY1sBz/LZz
         crXwekMWIljpkctcqNCnswuLZrQYtLDU8N2gQ6fldA3AR85Zy0KfXW5hHVVtohPi992o
         bzeYQFseC+QieSBXnbr2a41wXbHcMz2h+9uqoVA0AMH1L01M9TdzXIRNbkj36AbzTwGv
         chkA==
X-Gm-Message-State: ACrzQf1TvJ0Vn5KEd6f4xkKryoncY2i3JwP6mp8guM2SblGf1SxaK4DE
        nrb6o6YtoAvVR/0EH9CPNOjG2w==
X-Google-Smtp-Source: AMsMyM5P+ITtNdMTD5wOAtTt89EhUGCH/B5UYomYtC3VqBXVOImuKhZWi9oF17+5JyNAGrUvXwieTQ==
X-Received: by 2002:ac8:6794:0:b0:39c:d44e:3682 with SMTP id b20-20020ac86794000000b0039cd44e3682mr41006901qtp.437.1666884579431;
        Thu, 27 Oct 2022 08:29:39 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id fu36-20020a05622a5da400b0035cf31005e2sm1009709qtb.73.2022.10.27.08.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:29:38 -0700 (PDT)
Message-ID: <bb93f59a-1f3c-2bf3-ecd5-07a570d098e2@linaro.org>
Date:   Thu, 27 Oct 2022 11:29:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/3] dt-bindings: interconnect: Add QDU1000/QRU1000 dt
 bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190520.4004264-3-quic_molvera@quicinc.com>
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

On 26/10/2022 15:05, Melody Olvera wrote:
> Add interconnect IDs for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

Looks ok, but anyway you need to resend to CC people...

Best regards,
Krzysztof

