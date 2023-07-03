Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590CC74607B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGCQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGCQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:11:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157DE67
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:11:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso5490002a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688400671; x=1690992671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFlswnfR5vQlHdaD7d/pndVxZDbWFDFhAabQH+HPREA=;
        b=shiYMOLm8Y5Q2JKiCn7+lSvae/AGMbsaD79O+uh0OEs3p6bTCtM6Ny6pfLMklx6dpI
         1AICy0Z3oEMLj/O3jC9yAIscra6mijQzv0+PtFeDE9IahsfR8pxPchbGx0EpV/PO9Ffd
         sq47k8e8IHRhZu0aLitkGsmScfvUwv6pedfR5b3q48A1SSbWh9+csLemF+3wPkIhs+Xy
         l0CSJqlj1MfF7L/hvV5ypCYwczPvnhsh+n/NVLDP3cafN7cqGTTHrF126M/53ZpRNeGz
         6RzoM+ntKmwuBinsDav2Q2Ap+GefRrKIZFT/VSPbSyVUHLSBSNOZItNbLMNlPotmo3Fy
         ZZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400671; x=1690992671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFlswnfR5vQlHdaD7d/pndVxZDbWFDFhAabQH+HPREA=;
        b=E1Zhg2eqSkJrlrbpPEQqVL0A5mTggeoNN3tyec8MtZkj1Ce5oGrgnoDq7ebJVPBhlV
         kSTEchCMwbVdnVfXdpucn10/tj+VVfseKnecqs+Sdk2RZJb9DHrpdukfXSBD1RzlvcTL
         vS/aJqC+6qYepSGubeTUvxxz8rF00wnq2nY7hbCnybyAqCkn/C9GvD/Fy2We3AfgjbGe
         oT/PiLiP4erQtDMqKgOMehc1HDDS7RAj7tYjHgV/TdAc/urcpnOp+mlM4HsJHl9Yk9p7
         NtLhZX1fUDHlmcwTwt39kLsuFReiUdfSfd9a10azXEZ4sQk/2coljNd2ko24AQMhTdkg
         zR2w==
X-Gm-Message-State: ABy/qLZ9HR4Z5Apn+gYlYuDrLLngy1cnHo+bzynke5+YGkjzrmw8CRXM
        4kaq56byoeZTIPF4sy6Zrnw5kA==
X-Google-Smtp-Source: APBJJlHopqSgCk8a/DV9or4emsz1q46Wa42KuWpzdZsVzpuqlFL8HoS/ql8gqBZ003d5Wb0NhcIR1g==
X-Received: by 2002:a17:906:854c:b0:992:b66e:72f9 with SMTP id h12-20020a170906854c00b00992b66e72f9mr8109932ejy.69.1688400671028;
        Mon, 03 Jul 2023 09:11:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b009828e26e519sm11963583ejs.122.2023.07.03.09.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:11:10 -0700 (PDT)
Message-ID: <370213c8-b48f-0940-a007-01b7e86f0183@linaro.org>
Date:   Mon, 3 Jul 2023 18:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: arm: minor whitespace cleanup around '='
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230702185315.44584-1-krzysztof.kozlowski@linaro.org>
 <20230703085649.y363mybfshlj77ax@bogus>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703085649.y363mybfshlj77ax@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 10:56, Sudeep Holla wrote:
> On Sun, Jul 02, 2023 at 08:53:15PM +0200, Krzysztof Kozlowski wrote:
>> The DTS code coding style expects exactly one space before and after '='
>> sign.
>>
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Let me know if you are expecting me to pick up or you plan to send all
> such changes bundled together.

Thanks, I would prefer if you pick it up. I can take it as well, but
that's rather exception, not a rule.

Best regards,
Krzysztof

