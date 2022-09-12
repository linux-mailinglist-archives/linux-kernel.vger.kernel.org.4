Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E35B576E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiILJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiILJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:49:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363B33E2D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:49:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so14431806wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ammuj1ToOOUyenpx7efRuAKZ+Xd++UJtXQpLWyLE2UU=;
        b=FecTWIT29+SoO9dPJnZV05yejoJbz7Q2dIHJSZe6H+3a9qM8hSkmUZLtklFFIDlLRp
         o2BzKPh0wjbq9D2jt8y7QfcTsjeFU/pXo1c4IsXrMLMw8RrIEIDuRx8OhvnCinukoZPC
         BrKSpaPm6ufPK0SR60Mh/8RJrh4vKKGfC8w6NWzFRQ/dyzu7bUxRRo/XjW6aZfbxtWL1
         uUrtwpWqRqSSNLTTRYdYOUI8lpJba+LqaxJ+Gz9MUdM6MDQJQkx+RwnwgADRqcUonPwP
         nHEMS4UIA2uI1WWXcnpYcxl8rE4iUMJf60vTJX76nGMWHzQgmmFg8hUFkaQY7rJALcRm
         vleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ammuj1ToOOUyenpx7efRuAKZ+Xd++UJtXQpLWyLE2UU=;
        b=jNjKKQX7JakkoDEygl5ESjiX8hyOVgDIZyrGU7wKjtHvK7L209JNs6oC31hGa6c8Ag
         E3BeQpsBUvBtKTmaYJ6yxYvPCh8tWykdoK00Uz48Wsjt2IBMKCqGkxbZzJJ7DVHs4v5V
         F7rc8bc5m/pXh09nZDQMtiWAapXGMhIW/LSStCnzn4ArP3dfboP/92YEasncXFbbtuxx
         xrpZb0l436Ak4oYpSt5iTXm3Bqqjf6TjZm9EOpw7xWXn1bm7IhJ/Jd4ROS1wTuhY4QNQ
         Z9/Qacb0Of9AOIDdhLB+ztXPgG9qtSUtdHppJElh6hV3zAv5FAzDWAKHAqUJ1GOpG9Zj
         w+TA==
X-Gm-Message-State: ACgBeo1l5sdqGy10DYi9FTu8OrCqEfzL866tV20wP/iCsUw+YsfDxjM8
        z8hOjbo3tCDfzMkJVYxkM1pliw==
X-Google-Smtp-Source: AA6agR5rFMUrbwKJ18QFXAlX5IHdJa1jlMqMiIxw/OoaWtTgKjact5ObMYAx0SIrMqBUyrYFlkADaA==
X-Received: by 2002:adf:eb84:0:b0:22a:917e:1c20 with SMTP id t4-20020adfeb84000000b0022a917e1c20mr1909730wrn.223.1662976151114;
        Mon, 12 Sep 2022 02:49:11 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id i2-20020a5d4382000000b00228933481dbsm6782624wrq.47.2022.09.12.02.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 02:49:10 -0700 (PDT)
Message-ID: <f8a92b6d-ad23-24e7-2a01-73839e57cb85@baylibre.com>
Date:   Mon, 12 Sep 2022 11:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFT] [PATCH] regulator: tps65219: Fix .bypass_val_on setting
Content-Language: en-US
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
References: <20220828120153.1512508-1-axel.lin@ingics.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <20220828120153.1512508-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 28/08/2022 14:01, Axel Lin wrote:
> The .bypass_val_on setting does not match the .bypass_mask setting, so the
> .bypass_mask bit will never get set.  Fix it by removing .bypass_val_on
> setting, the regulator_set_bypass_regmap and regulator_get_bypass_regmap
> helpers will use rdev->desc->bypass_mask as val_on if the val_on is 0.
I think this will result in exact same behavior. val would be assigned 
to 1 when enable is set and 0 otherwise. Anyway you are right this line 
is useless.
> I don't have this h/w to test, please help to review and test the patch.

I'll double check on the board.

