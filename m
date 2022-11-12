Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD426269B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:06:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A18DE93
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:06:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k8so9904023wrh.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=8pO3EQslVSrJvjXJpPRM2Zh1IhtyM/gRBLzXNxwOb4Y=;
        b=hO5A/K/QFUPj/rOawOJCNaYLb7uaRGP6g2iJ7KM7f5D1D075sC5YqznkdDdmKqQsYJ
         BwQGgzVmaqmXM9m6Fpo0+dPF19G8BY5+uyx7Y2GiO3litIv2x6eJj29/JkysoDBo37Ec
         4S8oznqgZiqpqFub0UeHV5ObWQMOTWjn0dEMYwJlmnKeB9Tbb34vWA7bNSgvaL9AgPcm
         sGZ7121szu76Gji0lCKRLJexf1PluXQPcIIHAc50whX0aVDA1s4k3DqeWo8AVrhZPQvk
         cqxVvRvScMWct0CFwuU9Hu4h49hExaeqCU+t5PlrLAnItD1MA5a1Hq2ybtw72t3tRwGq
         dt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pO3EQslVSrJvjXJpPRM2Zh1IhtyM/gRBLzXNxwOb4Y=;
        b=j9EENe8/l64FXJb/gM5e4BZHwhNV1Q6H7yEvVnxIRvFiQKJTjmdyt3RVeGSOZj6r4S
         o26SnND9NiadYHQ8WrAEl7LgBezPTtqzA4gBW4frZbljZ5Mi7Barx7LZJs0uFyC33NWi
         Kh+cgrI1jlhCJGTk5Dor79HLsHuPuw8SIAuIgrZQ69k3po9cqKi/FlJgCcDOKoiOX3tl
         kl2ak9PEO70K+jrCGlLB/3swjL2prU77IzNp20R/DHcX6gkcTJuebHJf3FgbforZR+Sy
         XlSFqxgNgKuE5HYdK79aqRFdDp+zElSXc9ACKJEWLpdFjmX1Sg3PZCppgGor29PFVPzP
         gABQ==
X-Gm-Message-State: ANoB5pkJuGRHvTcuJE9Kf295gSCFs1kiIpCZb8y+h8/T1JhziaEKJbwY
        ybww4T1cCIuz7ohmVp5jEF8=
X-Google-Smtp-Source: AA0mqf6cbpZIBHccKHkX6bXOI5zt9/aRAoPODITSug6otJZ7WCJ//FZf3fFJtTGdxo/S0TnqyyO9cQ==
X-Received: by 2002:adf:ee10:0:b0:241:717e:fbea with SMTP id y16-20020adfee10000000b00241717efbeamr3629500wrn.77.1668261980209;
        Sat, 12 Nov 2022 06:06:20 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id k3-20020adfd223000000b00236e834f050sm4350537wrh.35.2022.11.12.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:06:19 -0800 (PST)
References: <20221107202114.823975-1-y.oudjana@protonmail.com>
 <166811478949.1075638.10692622037510321259.b4-ty@kernel.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] regmap-irq: Use the new num_config_regs property in
 regmap_add_irq_chip_fwnode
Date:   Sat, 12 Nov 2022 13:52:35 +0000
In-reply-to: <166811478949.1075638.10692622037510321259.b4-ty@kernel.org>
Message-ID: <hXJCiiSHxRbOCrOlFifkWudu1LTcK1TM@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

Mark Brown <broonie@kernel.org> writes:

> On Mon, 7 Nov 2022 23:21:14 +0300, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Commit faa87ce9196d ("regmap-irq: Introduce config registers for irq
>> types") added the num_config_regs, then commit 9edd4f5aee84 ("regmap-irq:
>> Deprecate type registers and virtual registers") suggested to replace
>> num_type_reg with it. However, regmap_add_irq_chip_fwnode wasn't modified
>> to use the new property. Later on, commit 255a03bb1bb3 ("ASoC: wcd9335:
>> Convert irq chip to config regs") removed the old num_type_reg property
>> from the WCD9335 driver's struct regmap_irq_chip, causing a null pointer
>> dereference in regmap_irq_set_type when it tried to index d->type_buf as
>> it was never allocated in regmap_add_irq_chip_fwnode:
>>
>> [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
>
> Thanks!
>
> [1/1] regmap-irq: Use the new num_config_regs property in regmap_add_irq_chip_fwnode
>       commit: 84498d1fb35de6ab71bdfdb6270a464fb4a0951b
>

Um, this does prevent the null deref, but the fix is in the wrong place:
d->type_buf shouldn't be accessed in this configuration, the bug is in
regmap_irq_set_type(). The access should be guarded by
"if (d->chip->type_in_mask || d->chip->num_type_reg)" to prevent the
NULL deref.

The analysis in the commit message is inaccurate,

>> However, regmap_add_irq_chip_fwnode wasn't modified to use the
>> new property.

the proposed fix is just wasting memory, since type_buf isn't used
except for the erroneous write -- the write shouldn't happen at all.

Regards,
Aidan
