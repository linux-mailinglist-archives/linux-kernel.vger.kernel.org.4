Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B7648753
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLIRIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLIRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:08:07 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190AF1789F;
        Fri,  9 Dec 2022 09:07:48 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3bf4ade3364so60479337b3.3;
        Fri, 09 Dec 2022 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwWMh1ACiryUz6UyTf+jcH4eZsI0l+uTI88yqFSAECQ=;
        b=kmkHyOxDTS+NTMl47IpKMw0lotSaz16CG68yYqObJafECyEWeqj0kGGUrWH6CcWAl7
         GgctcBGXd6vcQ6lFn5FQTMOP+xLe6x5Tk0aYorzx2s+OOui5u1k8NUH+1Vh5NYmvyA0P
         FssV9EGxIaFMRtQE0Y0uirIQtI2Eu8nLFW59Jxn3JLv2ClkfPCGXc5ruURULPPnghfSp
         Oe0kU/k1cddJYGL9efq37TXJ8kgwzBt4c1gsh1v6PHtJOrG9538j65zGcd6Dikd8isi6
         SUdX8r5ohwYrwWD2p0+UEEleZUBI7sH0/+3gm/+RLAVn6Kb9yDcsU8Zk9zJ9dwhS1j/d
         A5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwWMh1ACiryUz6UyTf+jcH4eZsI0l+uTI88yqFSAECQ=;
        b=CDaQtbl2pykdlfzE+vMGexHOZ7ihbf0prLJ1pQ9QPJy6jQ8M0ZrWERJXX0B01fuTRZ
         FjAq16akdHPVeyuOyXGX6c0lRy4WHws1YGG2RYEJwYW0Ai2ER7WQkODptPxqq6Bz7oFc
         Elz84LZI4bTKNcVRug6xIC6r7c/ukpv2WZJfFFIzIMk0H8K0Q1IQIMpzlDW/oBGy7KpN
         D2aAE5T7P0bNJf+XZ3PazUwkRfmq+JLYggXFhGB29Amhk5BaC+1cN334JTDLpeVQM3xY
         sKwgzZhiyvphH1TEfWwjkvqDItlHSH747pcEk3/xrAsl5mebT+EpPRRfoGV/oKR3ogtu
         S88w==
X-Gm-Message-State: ANoB5plF4uPj9DATlCQiuD5h11uObIjPJWdDakCsT6qfi1vd2/bsXxan
        H7wlGOxj3txqf5pGuYVn/bQ=
X-Google-Smtp-Source: AA0mqf43iFfrTl2pijIgIoj6ArGId1RTEPviRf7NbF3lkeLFF8Lndw9lycRqhyLpn++9MBC/kJzEuQ==
X-Received: by 2002:a05:7500:5d03:b0:e7:83db:e0ea with SMTP id fi3-20020a0575005d0300b000e783dbe0eamr484367gab.50.1670605667972;
        Fri, 09 Dec 2022 09:07:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f4-20020a05620a15a400b006fa32a26433sm226568qkk.38.2022.12.09.09.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 09:07:47 -0800 (PST)
Message-ID: <b51f730c-93bb-986d-7f9f-217ae0593b1e@gmail.com>
Date:   Fri, 9 Dec 2022 09:07:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add check for NULL for clk in
 clk_enable
Content-Language: en-US
To:     Anastasia Belova <abelova@astralinux.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20221209100550.30470-1-abelova@astralinux.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221209100550.30470-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 02:05, Anastasia Belova wrote:
> Check clk for NULL before calling clk_enable_unlocked where clk
> is dereferenced. There is such check in other implementations
> of clk_enable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

