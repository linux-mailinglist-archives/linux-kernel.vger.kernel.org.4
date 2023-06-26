Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3073E0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjFZNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFZNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:45:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AFE97
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:45:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e1b1d1698so238548566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787142; x=1690379142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHr5CN9tWotWY0lZswi0KAOutntMvLiH5JUUvyfraFM=;
        b=aUvXcodcI/4uxxmd4xVKXN3xwWlt5n2GGwc6MxieVkElvUvaKnXhrQhb6EY0Vyr8ce
         TzaqOy5uAn50SU+05wqh+eRP30SSZGo/s8wusFeksAYGDmrVXctsVy0LQ8syLGlsFga7
         Nedq8CAioZuY2hsU9Hn1iyNlEl8stIvWULjQxOdYv0/jcnobzvVL95KilQT164HiiCZD
         feH62BOv+emjq9x53/yCfO8w0hu0enSmdSkqCWciG2TaNPVrMuhMj6cG4YR8R84DXiQL
         KcxhLvAUcNboa56PesBy89Sq8vsaO53Z0EI+81WFfOmM68cHSHC4ne9xPrrwudBsLIpn
         upCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787142; x=1690379142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHr5CN9tWotWY0lZswi0KAOutntMvLiH5JUUvyfraFM=;
        b=E8FwKIH2OLkczj3gpelI/3NXFuTPzXiMU4J1jGEoV7RFvv7OW93qwWNQR//J6ijrw+
         v7/WDaWi71EI9tr37JLogw53TJYgZp3BxHj0IdQRmHXNg4UEzZ1NAYnUPns19/X/lteU
         Gnip5qLwHKIMJYbsoN8+ox1qV2gxnm8CgETV45WAL3V6tN5YYX7PyhgOFHTfuwHQYx5G
         rgB9hlun7Y0seQibR47aLHlF1vp5xHwKm+0x8pQQPca1MYQ1xypyA+d65uf4SVOfAmvs
         hOJ0mbBNi1RtGieRBDewW0kiQc5JEBuoq5FciCHKCHG9+AHNRvX6x0QV7uFQOKsz+Y21
         mp7w==
X-Gm-Message-State: AC+VfDxxXWSKlHLE1mnQLvlUENHcAbQ4xX0mLbTF8X+ykO1XHdz1rjA0
        pIKsVOjqRmm3/9/uNDW2rdM=
X-Google-Smtp-Source: ACHHUZ7ED0oZ57bf8RVEBJHVOvdXnnI18HEQoHW7h5wiKbVZTpohuiyKTSJgSv+6rmNLZNA2GGDAWQ==
X-Received: by 2002:a17:907:9804:b0:98c:d355:bb38 with SMTP id ji4-20020a170907980400b0098cd355bb38mr11413644ejc.11.1687787142143;
        Mon, 26 Jun 2023 06:45:42 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906841300b00988d0ad4477sm3275965ejx.29.2023.06.26.06.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:45:41 -0700 (PDT)
Message-ID: <b026778d-51b1-6211-3287-7c1ad374e54c@gmail.com>
Date:   Mon, 26 Jun 2023 16:45:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 04/13] regulator: bd718x7: implement
 get_active_protections()
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-4-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230419-dynamic-vmon-v4-4-4d3734e62ada@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 23:02, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> This is required as the mon_disable_reg_set_higher workaround property
> requires the ops to find out if it the monitor is set without the
> device-tree being aware of it.
>  > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

