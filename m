Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8767B9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjAYS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:56:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3ACA26
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:56:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n7so18026550wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9Bf/oOVjGROKj/Iq3R+gnZrE+akCZf2qIA0FI6qo4s=;
        b=C8eWTaPTD4LOO8OAMJOinkpU8TMOVNv7+FzPMfCqYcGiAr/PMcKOHiNa+rgtWDKEeb
         ciNABQ0up71Www5Fq9Kis+Ohttor/6A0GipOpIlHU6BmhSx05QP1gOoyWF8oU0Fwqd4e
         m371yCkxV8O7D9Sfeml/CsSNWIxhQgEsY2U5R4zhHmsJr0hDjCOzW0RU4Ee+Vk4pgTj+
         v4Y7gSxgiWdnx09M2tjpSpUArDvONUJtlMt9XHXzKX+IMRNozZynohC5XbGyJ1TP3VmN
         pCauM9y86DpLxjY27bvnyF9GeETkssNaVtq9ys4owaAXGsT4n1bLUP28NRcrQ/Nt9ngK
         oTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9Bf/oOVjGROKj/Iq3R+gnZrE+akCZf2qIA0FI6qo4s=;
        b=mNL5LYNYPxUdG4WY68Z+aFzbOfz4E4kg0TXxhFxdzr6l5trWr3s7O/nkCdUzGQsoIT
         Q2Z5NsLqnUlmfk0ZWX/Sd5J4QHchwz3Vp+7YCfJLbpmbsm5aqrshrnztVwBXendJTOij
         W07iUf9nS2AULKVJWJJnKzcK5gBOO4LDoZX0s/BTjKCBqhFCYd3F2DfCsicrnR2WQFuo
         jBHS/vDcLDiTKyIQ6Z6w/rSX0BE/iueQadsvHofnbOlscOKhcoVNfKkOdXI/aIL7lvQa
         dxROE6vtOwXQKfpMZ6UJVO5KBEuCLJpvOeaZ1bHYvT31XyrdQXQMrFSDXV2XB7imuRGb
         XQtA==
X-Gm-Message-State: AFqh2koh+52tjXQUea8f/ruqpC150YCQRFh/sohZQzoHFIoUBzIusbIK
        zGguN2iXxAq7VMupm8PwBWE=
X-Google-Smtp-Source: AMrXdXspT/LjjjvdbBeEACEjwsD4dwN7dNTJ6TyC8ek+t562mWjotaxxXKN0ouOJCkEDVBHuSqI1vg==
X-Received: by 2002:a05:6000:80c:b0:2bd:e0e8:694d with SMTP id bt12-20020a056000080c00b002bde0e8694dmr7181380wrb.6.1674672975705;
        Wed, 25 Jan 2023 10:56:15 -0800 (PST)
Received: from [192.168.1.100] (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id n21-20020adf8b15000000b0028965dc7c6bsm5049115wra.73.2023.01.25.10.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:56:14 -0800 (PST)
Message-ID: <0b5d743a-c071-e4b5-23e4-ab59d6ef785d@gmail.com>
Date:   Wed, 25 Jan 2023 19:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] staging: r8188eu: clean up usb transfers
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230124210108.62170-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230124210108.62170-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 22:01, Martin Kaiser wrote:
> This series cleans up some defines related to usb transfers. It's based on
> the series I sent yesterday.
> 
> Martin Kaiser (4):
>    staging: r8188eu: usb_read_port_complete needs no regs parameter
>    staging: r8188eu: remove defines that strip regs parameter
>    staging: r8188eu: remove unused defines
>    staging: r8188eu: remove usb_ops_linux.h
> 
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  6 ++++-
>   drivers/staging/r8188eu/include/usb_ops.h     |  2 --
>   .../staging/r8188eu/include/usb_ops_linux.h   | 27 -------------------
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    |  1 -
>   4 files changed, 5 insertions(+), 31 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
