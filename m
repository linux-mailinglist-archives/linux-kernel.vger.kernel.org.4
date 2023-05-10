Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6F6FE10F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjEJPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbjEJPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:02:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953D3A96
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:02:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so11226205a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730917; x=1686322917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg3p9+EGRJAEXW+lb2pr2TiEbOxlAU1YA74V7zh4bos=;
        b=M88SB/KzbgIQhpqC/kyXt+1PNRgS8AUYhQQORByMu55FQfmiqHybS8gw2fgRLkgzl3
         /dekZUt7LKyStICSndGc3q7rqegp4v1PSlkiHpRJggD9lv7iVCFLMc/wsrK3/Yqx9KfU
         ONvU5qx4/TIYG9t8aanwkVrtwvEN6s8m7Mdry9LvDkuuvJydX+DGkyHfCy5PO9WytOGm
         g3LKaeqjP+fHP++h5SCSTpaEf6pk83rX1Z3DTvtjSLYg4NogI2NPBFFcF0CZmx7PwaDm
         4ZKIObNqxvzzS+wNE4d1Gu3SZe/4t2aorJFXJdUfMiXHuwNMh5ShMOUy01O29wfj2bzC
         IPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730917; x=1686322917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg3p9+EGRJAEXW+lb2pr2TiEbOxlAU1YA74V7zh4bos=;
        b=Q8EdeSA5aXFsZ5tF61bZBvTfWzLXdbAQOdMJOzwQXzwLsuhfyYcm7UiR2OefnuV9Hx
         1BU5BMjmqv7qnvWCjXt0bPrxmz6FVabP/09vr+mVvFJZnz2t0PMIbOLk8Sg6lmWaSObC
         KQMygpAMEtNa56gtITeaWGV9P1rgX05ufB13scGaDVZ2UZR85cg3IKzDq0/x4z7h8o0c
         XBk8bGn8FIvZ0PAgR4DYFDOqVjYw9LcsCtv5b0kr8UO50sScTMqHqmy3xK/v/fnqJb6Z
         rPGy8vxh7TqHzzpVEW76vgZit8dSmfGoG//CBOLk+HTwJtkqjYVz0jVkTA2Gol7XfEa3
         eavA==
X-Gm-Message-State: AC+VfDwRP/mp9U3JNjS5QyoKMpa6OdS5fQrpcLpFI/i6hzxB0QSmIVhp
        o/e5k9MtsbesQpxA8ToVK+Yz0Q==
X-Google-Smtp-Source: ACHHUZ56LCSGTK3jYzCYiYZma4f2a5iPszWF0J9GennTs19UbKmx2TeMOJsOXVLPpUrVKmCIfOex/A==
X-Received: by 2002:a17:907:6e9e:b0:931:ad32:79ed with SMTP id sh30-20020a1709076e9e00b00931ad3279edmr19467320ejc.12.1683730917178;
        Wed, 10 May 2023 08:01:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906b18400b00965fdb9b051sm2789861ejy.115.2023.05.10.08.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 08:01:56 -0700 (PDT)
Message-ID: <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
Date:   Wed, 10 May 2023 17:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
 <20230510142248.183629-6-pdeschrijver@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510142248.183629-6-pdeschrijver@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 16:22, Peter De Schrijver wrote:
> Add memory-region property to the tegra186-bpmp binding to support
> DRAM MRQ GSCs.
> 
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---

Also no changelog. Since I do not see improvements after Thierry
comments I assume you send the same.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Best regards,
Krzysztof

