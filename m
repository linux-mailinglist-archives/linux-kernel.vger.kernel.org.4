Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C926D92B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjDFJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjDFJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:30:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83061726
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:30:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er13so106759527edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680773448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76lCHbcs28GVZOTieircngR1iwRf3ZwedgacvMcvF0E=;
        b=RMVcqac9tRFPxOOhfgRrQqc1ysy0PQ82ABzvW0XMABzVlmdQu3cHhuDUxlMR3Fm2jJ
         Fx4zq+2MwU674fvT4lOeI55+n4vgcBSn8odd21BsyOPX+TTjOEfGfaYT2CuXV3dYlbjo
         aXP4wfXbth99tGYMgrVrpol9KYuffIXkGdp7mheXZ5TtGp79UHdao6x+Vza0PQqgK1q3
         h1cgs2dbsB0fv6fdQHtqhN7KhEgYlF2Q3AVrTwApchM1MoxAObqi/bByXTFCxEVp6TnU
         HAdwmiOR27cINpG/5/2owbYESeCw3RAvrRYDUcdoz4Js8o3a/4QCs+APh6IX0BuTMKxd
         pJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76lCHbcs28GVZOTieircngR1iwRf3ZwedgacvMcvF0E=;
        b=r3vdc0iUJFcxqKTRS0zZp7Vn1/8ZqbNM+SsWuLf/NlFLduC7OlVSCeodTU1AkkRyRg
         hVosHkiMIdkQz4aRD6vKIHpJXBKWlpIECY2AC+fu3zA1td4LTY9qzV9KpCm2Vo8EjXOX
         vUtLSpacqYfykCUq2p83fiwo3gqNNQ6oWc2MiMH9vNkMARJ0ByjwMQ/H2qJd9rR8g5ip
         ibZbW0DM4Ji+CntBQejODFVPeevkyEm77rH4AuHdlAEuNdKafN3A8js00+wta94rlLLq
         ryKp3tEQLTWCXGMK6AvtMRkYXLq6u7nxzY4G81WSC/lDIaSs/BzQw8PMY9/G+Rmt33zp
         lBqQ==
X-Gm-Message-State: AAQBX9ekJYU+kkTqd6n65MrGomxdGJatvRA0ovB7zjMehEnH7QbnYJZF
        eIh87r7BGhtwb34Prm6V2NB2hw==
X-Google-Smtp-Source: AKy350ZFVQspI+pw9wX+8uMDY0JrLG/qhNXZDteWW23CYpI01Ao4a7bbzwfIsXsagg9VGvwyNbpo/A==
X-Received: by 2002:a17:906:2a50:b0:948:eed:b4e0 with SMTP id k16-20020a1709062a5000b009480eedb4e0mr5839917eje.61.1680773448330;
        Thu, 06 Apr 2023 02:30:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id gs22-20020a170906f19600b00947d49ec819sm569306ejb.22.2023.04.06.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:30:48 -0700 (PDT)
Message-ID: <161c518f-936b-597d-28c1-f92e4cd24902@linaro.org>
Date:   Thu, 6 Apr 2023 11:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage
 monitoring
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        benjamin.bara@skidata.com, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, robh+dt@kernel.org,
        stwiss.opensource@diasemi.com, support.opensource@diasemi.com
References: <d7e795b8-6c36-70c5-73e4-ae115cac32a9@linaro.org>
 <20230406083812.887582-1-bbara93@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406083812.887582-1-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 10:38, Benjamin Bara wrote:
> On Thu, 6 Apr 2023 at 10:28, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> It looks like you received a tag and forgot to add it.
>> If a tag was not added on purpose, please state why and what changed.
> 
> I slightly modified the description:
> Basically clarified that both, uv and ov, must be set to the same severity and
> value. I guess that wasn't very clear before.

That's not really a reason to drop tags.

> 
> I mentioned the change in the cover letter. Maybe I should have added it here
> too, sorry for that.

Yes, the change was there, but nothing about dropping tags.

Best regards,
Krzysztof

