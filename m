Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBA69920B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBPKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBPKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:45:36 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE226CEF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b2so4064403ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWRGLpMx6Jw6kgCfoGLxxyUHKgMJC80WL99LK9JAUAk=;
        b=kvV7SFSbl1c5iBPBB7UR+FRc7dPdIqRFPVFEB6rUH+VsUCJT8Vi3mdUabdQEvu8kup
         6BUWl6shkrY3j5euLBp0HuePan+ZUCqz/R+G7m3m0nl5cL7Dmxi5FR1CYTWHKOMhXBz8
         sX6eD4hBX18FLmAaBkF8NI7EA4ku5BWu56DBkNiqp0njXbZTTHRoWmySb3OgjqMFIBxL
         wH7nViWRZrUgNhg288oQbCSUg5nuH56MrhOxhJ+6BtK13XUrcsMo2d2k31RDh4eHQEst
         ZqTZcQGx2HXCkTNlU4FLp5zBoUTsvWvpmVvCoLE3Ewqx2q8h3aQoUVI0OKZtKe448ti5
         sqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWRGLpMx6Jw6kgCfoGLxxyUHKgMJC80WL99LK9JAUAk=;
        b=hLDDP66eu547SHxgAcPSzfvWZtJ+Qe+c73pimHjALz0tP5IlvnalZWvcuOeaCFL4Yi
         RzFoWacYfoU/G+CWSQwq4HTqqOjf5tZo9Agst88noGaRd2/usEXCkkgwNOtWGGKWMa1i
         bn7D4V1KB2O0xVH9bhskjbhKVqPxdMLF3VztvbCfhznCPiQa7Tx1i8i63onD8QAxID0/
         jLObAzzFQcyCOeY5s0Vm1QG2JJ1rc6gCRqNSg40z3qaaLCasirAZ7qHTDDtrDCHVywPP
         3BGd5phvqTd046QTVorsQ5BKe/nk9ce4oNZlycLDUIqzA7VBNCUPEiOgiW0cASe1NbB2
         3meQ==
X-Gm-Message-State: AO0yUKX66zgBx1PR4nngmotSOmKOKVOXZYbqgrcF8wV0CC8A9KzZfHr1
        OZqFqInqzCXdINsTGz8lOwFIi1OvuEEgJMMW
X-Google-Smtp-Source: AK7set/fWFrsz2FXgW2F6Xxe3eCWZp7wyxiGLl60ovhkDEf1eHvQmkkRehG+N8odIEyZ9+teUFcfKA==
X-Received: by 2002:a17:907:9627:b0:870:3c70:8c8d with SMTP id gb39-20020a170907962700b008703c708c8dmr8906855ejc.17.1676544307979;
        Thu, 16 Feb 2023 02:45:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id gh5-20020a170906e08500b008b1313009cdsm639711ejb.179.2023.02.16.02.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:45:07 -0800 (PST)
Message-ID: <2fecab8a-26ae-c62d-bf47-7319e11bbe51@linaro.org>
Date:   Thu, 16 Feb 2023 11:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5739
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        u0084500@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
 <9c1f4d0e-83c9-014e-bdb1-38b4b0fb2bbf@linaro.org>
 <20230216095714.GA14578@linuxcarl2.richtek.com>
 <38824a96-804d-84a2-2750-be1325b2e1d2@linaro.org>
 <20230216103530.GA17387@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216103530.GA17387@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 11:35, ChiYuan Huang wrote:

> https://elixir.bootlin.com/linux/v6.2-rc8/source/drivers/regulator/of_regulator.c#L198
> It seems no need to limit the maxItems. Regulator core will call 'of_map_mode' to check the value.
> Even the value is repeat.
> 
> And for minItems, 'regulator.yaml' already said it's uint32-array. Must be lager than zero, right?
> 
> So how about just keep 'items' and remove the 'maxItems'?

Yeah, go ahead, with that enum, it should be correct..

Best regards,
Krzysztof

