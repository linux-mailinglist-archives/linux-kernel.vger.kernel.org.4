Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B453701C73
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjENJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:15:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D73268B
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:15:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f4b911570so1850951466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684055743; x=1686647743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytSK3zVcteIovJ3O/CiV69EyJ8hozhkY9D5B2vV1EBc=;
        b=wY97dPv/ratrofKZ4zfovMxG7cS+LkfRAbWsUsav+LyEx5LNfrPiH8zE0PnJP+cNLa
         KvhZf68CTSHf8cHVtL9WMVTmYMgr03wlQyxeZngR4I4FtAiaGircBd4ybqsB0AsIcyCi
         KwsUAEZkKqpRoBfQOWV1lpZmx+u6py2RkGLFdaP81ybYcBji1dVx1AdkJxuE3pCZtfSY
         kg7/8IklObQNhYjlrY4kPgM8hYK1b5bJkufFL0mGBwkaukzKjI8aepQeU7qSIHBYtIVG
         yD7xdgy4UAtYK3M4RTKqrwjegyaAXjP965N3jtz3eohBjMlrV0LrK6Em5pDmAindv/Dp
         EyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055743; x=1686647743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytSK3zVcteIovJ3O/CiV69EyJ8hozhkY9D5B2vV1EBc=;
        b=b8yBo7OjmH8zJYh8MVtFgvd7tRu7r5+DxKulTohZdVSzSXMlEyn7u1u3wwwlLmH9eg
         hb/3gbpqCAMESUk15qK06kdw8VG6sIeKB0+zRMRG1UHPR8hn8x4gUf8zrQy8r6q9vOXV
         YNHq03LDlXEfkNzSNXLiAgsxvohrBo545sn+fKqTMijXpeoTvfsmiVHR+jRM6+xGcaby
         RADg4r92/wOT+F6/tTVIKhK3iCHc+1FOssDcYVomeZDPr0uK9WxFtkTfm4cvPu7P/K58
         wKVUYfcNvs/Lq25qaZuZI3C07bgRT4smVW1rKrGwvqfb41KCZiy/F3v9spc7pDPVaurm
         zOUg==
X-Gm-Message-State: AC+VfDxxZJQE1TMQkv1AoVGapj7vbOCHjuga5OrhmKboaDLQAZKZy8Zc
        e+CVLGRu9r29/iGSH4IQZqN1+fAnGsHdYdnZGfGyug==
X-Google-Smtp-Source: ACHHUZ7WPFk/MF2mr9DgAHesxK+A06AsFHKZL8Nzl6XuIAfQU/L7rQhNfuQGBCJTnob8VTZkr2bObQ==
X-Received: by 2002:a17:907:3602:b0:947:5acb:920c with SMTP id bk2-20020a170907360200b009475acb920cmr25364488ejc.34.1684055743438;
        Sun, 14 May 2023 02:15:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:715f:ddce:f2ba:123b? ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cfd0000000b0050bd245d39esm5788756edy.6.2023.05.14.02.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 02:15:42 -0700 (PDT)
Message-ID: <4c163376-ce89-786d-3c76-4f10ae818e7a@linaro.org>
Date:   Sun, 14 May 2023 11:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nfx: llcp: fix possible use of uninitialized variable in
 nfc_llcp_send_connect()
To:     Simon Horman <simon.horman@corigine.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Escande <thierry.escande@collabora.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513114938.179085-1-krzysztof.kozlowski@linaro.org>
 <06bba9db-25ff-a82b-803a-f9ae0519d293@linaro.org>
 <ZGCb2CNcEDtDtPRR@corigine.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZGCb2CNcEDtDtPRR@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2023 10:29, Simon Horman wrote:
> On Sat, May 13, 2023 at 01:51:12PM +0200, Krzysztof Kozlowski wrote:
>> On 13/05/2023 13:49, Krzysztof Kozlowski wrote:
>>> If sock->service_name is NULL, the local variable
>>> service_name_tlv_length will not be assigned by nfc_llcp_build_tlv(),
>>> later leading to using value frmo the stack.  Smatch warning:
>>>
>>>   net/nfc/llcp_commands.c:442 nfc_llcp_send_connect() error: uninitialized symbol 'service_name_tlv_length'.
>>
>> Eh, typo in subject prefix. V2 in shortly...
> 
> Also, s/frmo/from/
> 
> And please consider moving local variables towards reverse xmas tree -
> longest line to shortest - order for networking code.

They were not ordered in the first place, so you prefer me to re-shuffle
all of them (a bit independent change)?

Best regards,
Krzysztof

