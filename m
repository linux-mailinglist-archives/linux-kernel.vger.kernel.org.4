Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693F715CED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjE3LU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjE3LUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:20:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752FE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:20:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso8391525a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685445619; x=1688037619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yd20fg17/wzyWFeVpB0r/Y/yZQClC31CURysYMhhkuU=;
        b=baDQMQRBHrpQXjmgPj76DVAPn0aostT2Uq1RrXkdot38883uSNcgxjtRVCB/NDC91N
         4f9hMlK9Nw3VUYDqcT2EHcEa8AaKq8AEU5+gzW4tGPGM1wIDhmq1zML4qigrSjZdpGJa
         AOuJ8FL+Ze2f3oZLO+ZSS4fSDG496gQ0KdOCIQ+/7/cPUEoWaT+Mzxi/mirof3R89O6h
         319mLvygA+sRrfxmFGq+o+7XbJRuBcIH5RQEjWUg0ySBJaCxTbU8QNjV5wZ+RdrjP/EG
         FfFaVCp4aGFIifEJGcIbEAnRNFc+uV0yMqr8mlWZTBvbjgVExDF1ytB0DaVTHlrP/Gmx
         1E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445619; x=1688037619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yd20fg17/wzyWFeVpB0r/Y/yZQClC31CURysYMhhkuU=;
        b=JRQ5P/lPspV4CkDJb8qTQTPzK3ADzxjwKACBHJ+SDQ73sL1kGKMQ7i08Gmqy2+ruaT
         IKokh72SOkQsPFmcOlU7BGrJhtdyPdu7UpOrafN6MrvebiuIkAg737mp8Fumgv6T/r3p
         0RQ3l+sOJOTbeD7GTMP3OkbKrvVav7zd/xSTSu9NUaQU2W6cITDqnFBwL03GM8hsyncv
         lGud4MJPwZLV4TiZ6qaioPCin8LPE3kaLAmVlDLnWVypvS7+KgUG5+QefLbfc14W5InU
         7Y2A+wXj1LFrH5RTdDvhKo85WZN9477P7DTxYyNlfJiL3wbov+dCnssfR9fZ7Jmq+ZiH
         gpfw==
X-Gm-Message-State: AC+VfDw4Jiz+9rC/PP6HgEFq+HD/MmVkoxlrR9l98+V+k/PdNz2hyV85
        /x3o19dFjFzA/RR0Ie+3epWSiXxut9f1xdTr4P1sLMvu
X-Google-Smtp-Source: ACHHUZ7i0rQP+G4NUnQ1Pzw44Mp8S1ZzLD4qDMbuKxpk6jJO6NiExe52FOsO4buRImy0W0OI/3FFvw==
X-Received: by 2002:a17:907:1ca2:b0:953:834d:899b with SMTP id nb34-20020a1709071ca200b00953834d899bmr10294984ejc.29.1685445619558;
        Tue, 30 May 2023 04:20:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709063c0300b00965ff04f9f6sm7314636ejg.161.2023.05.30.04.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:20:19 -0700 (PDT)
Message-ID: <1c57f588-4101-3892-5797-4ffc6c654dd9@linaro.org>
Date:   Tue, 30 May 2023 13:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] arm64: zynqmp: Switch to amd.com emails
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <108cbbbab29e13d386d38a779fd582f10844a030.1685443337.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <108cbbbab29e13d386d38a779fd582f10844a030.1685443337.git.michal.simek@amd.com>
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

On 30/05/2023 12:42, Michal Simek wrote:
> Update my and DPs email address to match current setup.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

