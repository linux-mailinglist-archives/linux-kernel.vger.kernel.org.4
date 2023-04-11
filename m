Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E56DE3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDKS0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDKS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:26:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C2A59C7;
        Tue, 11 Apr 2023 11:26:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v29so8521008wra.13;
        Tue, 11 Apr 2023 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681237593; x=1683829593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWPZ2soZsylidE36LH194Mjh7EQgTMc+CIMfTeM7SyM=;
        b=HzGdZXd5D2JAChH2u2D189QRsK69oIOPAxFRiuTBlybvkXBP8qVTgaYQcM8PWc9bxv
         e3UpIq6Zi1JCF0Aqz2Zitlv1+j+H3F1e5kx0lqdSVfJr+w4cNESxYHPJwCAU8DpaXmv9
         kG2ZVFHTAGFUmpjlhraKKxUqmz+6kfPTp/g7h/o3xGbO3Yhs9+MWTO5P76WKYTsmKqOl
         vkQ6gFHKgOJfIb11FGjsumfy5tT3hufsMeKs440yJyYYK6rpBY1RL2H1hdl+ppgGokQH
         ipX67y1HSrDjQN7r1P6+Nk7D4ezab1fF2s6zqxPuAdTftbhf7GCsr3mn7or+64XpxA/k
         E42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237593; x=1683829593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWPZ2soZsylidE36LH194Mjh7EQgTMc+CIMfTeM7SyM=;
        b=yb1qILSIg7Cwio1JcjF/mApFbgOnXCqAZDfTzLIQwE56GOaEYio3CupH24ZBdyXEBm
         28jk15BGR9YUxcTrWP5YVgJBB6+ntoi15ZiviToiYf0qwohO8zzy40hEHAAyKCrh3spZ
         kbBzteyJQggKr7Tudy4TcHV2oFM0wRxzeIkDUjhygYRy6uMFnWGaGCbFRkmDf8Dfa6rh
         8snVeB2SkESwKp+WTwkkE+CHkt0y30llByBZ5D3iekgvaPDdOtXXrkI+7lD0nXmfJqu4
         zmIC3G2SdKHXdjQ3Zf6yCzyNT8tFaGST8CNmDSto8zMxTxx4Wl4oz7jqJ5ER7N5U83P4
         BoQw==
X-Gm-Message-State: AAQBX9cIJwIJDutmjAqO/HQGsuq4F2ACRC4me4Hxq20AeUckc5oisIqf
        WlFOwxukzZOxQSgHIh+dwwA=
X-Google-Smtp-Source: AKy350bMu78SioCTAahjFrJC0ddPrV1Vn8aBaZ3/yEzVGIyW6clFaqVQNE+A0xynDpgp71LzWK8Ugw==
X-Received: by 2002:a5d:66cd:0:b0:2d0:bba8:3901 with SMTP id k13-20020a5d66cd000000b002d0bba83901mr2636557wrw.62.1681237593638;
        Tue, 11 Apr 2023 11:26:33 -0700 (PDT)
Received: from [192.168.0.22] ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id m15-20020adfe0cf000000b002c7163660a9sm15035965wri.105.2023.04.11.11.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:26:33 -0700 (PDT)
Message-ID: <5f24cb94-d7f1-f8b0-71f0-2b39a89bb2dc@gmail.com>
Date:   Tue, 11 Apr 2023 20:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix alignment of function
 call params
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230409183549.12683-1-savicaleksa83@gmail.com>
 <c24a071e-b191-4626-8edc-1658a01d80ef@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <c24a071e-b191-4626-8edc-1658a01d80ef@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-10 18:53:08 GMT+02:00, Guenter Roeck wrote:
> 
> I am not sure I understand how this would improve readability.
> It seems to accomplish the opposite. Sure, I know, checkpatch --strict
> complains, but that is still better than unreadable code just to make
> checkpatch happy.
> 
> Guenter

Both seemed fine to me, the idea was to fix the checkpatch warning.
If it's OK for it to complain about this, plus the changes would make it
harder to read, please ignore this patch.

Thanks,
Aleksa
