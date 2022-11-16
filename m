Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C179962C4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiKPQju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiKPQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:39:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3156544
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:34:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a5so27347854edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPFrCMXv81mTTBcEeoWVKjKNP4QouYmge2x3DesP/20=;
        b=Hg3buutBjQqRZdaCsrNVeVgH0sh3OQyiFlLtSR75O2nMgmOqXit9nrGKkrCT6Vj1ZT
         fr9eKFku+2K8VDjLypWWezSUyJbj21ADDg7LRa9x/EgdMl+ANvT1Pia+KrCb9DpWyOoa
         pVw4BbfHQSbrpTOC+w3OKpjgxUxP3ICi3ccpg4FNUXHJTkzypjSGa+WOu9vodqpHpAFg
         N0hE0QCccSmnwJsN+rhlm7CswoOKtxZiulyET2g4x5Juh50rdFyaHlzImSIw66rtigWv
         55F9bkQPkiOJvYoeSsCWa09qb6oVYrlUKW5MU20eQE7I83EY277xRGqUs7PuIqVBqpkw
         GXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPFrCMXv81mTTBcEeoWVKjKNP4QouYmge2x3DesP/20=;
        b=khlhVxC3QT78owZoosnnocegpHAuQEBuIBPBkDXJ5zFFUcsvDgRXZruJQwW/3604Ax
         oJVAp+6j6PYcUH29NqbLEZTy5S7FSP1a1njm2urLdzAwtLBMIQAjOsi0N+8Ug7mpsggW
         VpZIDefA3lG8D2k6UdR+S4O94Xc5kg8Z76iAKIb4F6pUZn3xAEXi+yaj2PtfeuYe18Ap
         PQlCRD710ElMF0rVFXsGw3YXLynS+gF06OK58xx6gONGGjZQq3W8K4SC2fEe2IMk9eab
         p9IwaK9KjoJx6knA6MyitXANqR8vxPnmiwjizpb+OGgeCULiziBdIbUhD/U0pExoGZ/o
         KQmw==
X-Gm-Message-State: ANoB5pksaqEVCp35sLd7GJCcoFO7cmSZaTu6UMF2wh1cro49ZbYqn/0Y
        NJeka+kwAv1EinbYr7TwLhIA9A==
X-Google-Smtp-Source: AA0mqf4xwUOrbHG5btJi83vesthDiDX1WKSxfps8LHn3WT/qtvfjSF3uGB6yWmZ5Oz/WCr2pzwT7nw==
X-Received: by 2002:a05:6402:64c:b0:461:96ba:b9c with SMTP id u12-20020a056402064c00b0046196ba0b9cmr19597775edx.353.1668616448803;
        Wed, 16 Nov 2022 08:34:08 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0078d46aa3b82sm6959967ejf.21.2022.11.16.08.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:34:08 -0800 (PST)
Message-ID: <8d9c6187-64d0-a320-8ec6-e9ae51ce93db@linaro.org>
Date:   Wed, 16 Nov 2022 17:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: use defines for RPMh power
 domains
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116154935.163810-1-krzysztof.kozlowski@linaro.org>
 <92993d1d-e7b0-199c-5652-5158988a65b9@linaro.org>
 <CAGE=qrpAUcGwS5EQgMA9oA0c56=1C+2X5TjyyEFrf4xd5r7k+Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAGE=qrpAUcGwS5EQgMA9oA0c56=1C+2X5TjyyEFrf4xd5r7k+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 17:30, Krzysztof Kozlowski wrote:
> On Wed, 16 Nov 2022 at 16:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>> On 16/11/2022 16:49, Krzysztof Kozlowski wrote:
>>> Use defines for RPMh power domains instead of hard-coding numbers.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> I sent exactly the same patch yesterday.
> 
> Then the same as me I think you miss remoteproc@4080000. :)
Uh.. unless I don't get what you mean, I think we both covered it.

Konrad
