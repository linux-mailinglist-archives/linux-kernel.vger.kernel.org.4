Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2A74B220
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGGNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGGNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:46:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB721FE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:46:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so1939584f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688737580; x=1691329580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLquJa6vX3cAREt2G8PV33YRnBnR13Onc50DdWvUBjI=;
        b=JukIsPb//XimtGRT49yHPUHgpppuoDXUTu+fAvL8jy7/foZHz0PX+0PzonWP0PqKoo
         89HKFrhwgclR0ZGSMHeplvb7XtpA2U+Cl+T41DNJFMZWNKD1gKpnUxuwhWRzwncHdK5d
         Nghj/8rmLvI4Fgy6dIzBr37VpDSIKICDxKuO/SKomwxL1qNlBooxwzvvMgc6oVTKCWSB
         ZWAQMZpCz0s2ghMSE3Yf2SFIapPDURM5SasNTVuNMGYeOvNzqu68RBJS0R+uNqlMqSkz
         Co+v9tHp+gIH2hcEdfYWYitaISsJb+Cx/IRQgDYEoWF1RScEhcN4w+jructAyya5nZs/
         b1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737580; x=1691329580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLquJa6vX3cAREt2G8PV33YRnBnR13Onc50DdWvUBjI=;
        b=HgLV9cqZ2e62JMlafobT7MBY9YkGm732IABNUOzxiNJKph5KuE1JjgdqfpVxVKV5ft
         yr6DdNYekJRL50lW+RqvuWs3MN86VG57pcvBgGF3FKLXDMdBI7tFS8eoBm3b+Tw6tKxY
         988lfDJMe/6fpwuxp7qcW+yzPwk3pKx/4iR4mp/1sorM/zxBw4Tm13rQ0QwLmg8SnGUT
         HLvRczOAtqDcO49kBl+ykkJVAlEja94dd325ROTmtW30hQ/VTiJinsi22fQVPEW0M8S4
         KElAS3ghzWkL+U1a5xmP/V/4I7bO6z+9RS15AM9Scm/ek0He9va8iWqyPUhgtBFE88nk
         oXbw==
X-Gm-Message-State: ABy/qLbSOQiW4ZZeMO4dLLIIgDJB8ZAXA1Bvz9AtOnHjaWPHzLggDnWl
        conwJYRnH9DNk9Khvw0aBKe0DA==
X-Google-Smtp-Source: APBJJlEsux6Oo02kwH3/IRVRH3BiGhQYX8+9sbO0AtWvUSWIsDDiKlL12o7SlmgJvLhe5I1F/TWvzg==
X-Received: by 2002:adf:fd47:0:b0:314:268b:21f1 with SMTP id h7-20020adffd47000000b00314268b21f1mr4248772wrs.18.1688737579718;
        Fri, 07 Jul 2023 06:46:19 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b003140fff4f75sm4542205wrx.17.2023.07.07.06.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:46:18 -0700 (PDT)
Message-ID: <6bf8d06a-8c65-4d7a-14a1-13597cd9a2de@baylibre.com>
Date:   Fri, 7 Jul 2023 15:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/6] thermal/drivers/mediatek/lvts_thermal: Handle IRQ
 on all controllers
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-2-nfraprado@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> There is a single IRQ handler for each LVTS thermal domain, and it is
> supposed to check each of its underlying controllers for the origin of
> the interrupt and clear its status. However due to a typo, only the
> first controller was ever being handled, which resulted in the interrupt
> never being cleared when it happened on the other controllers. Add the
> missing index so interrupts are handled for all controllers.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
