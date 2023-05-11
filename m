Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB96FFB85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbjEKUzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjEKUz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:55:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954C1733
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:55:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96a2b6d698cso67670366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683838522; x=1686430522;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyU2yJMTTWP+TqXiAQ39h3qUzT30tuE4shvQs3raY5g=;
        b=blS8/1iEX/8TMezsdHFUshFcOmFv4OetqL6BKXdZxZDDj0uBt7/282csgzqaBBJMZC
         79JEYdwFrsUhNoHfv2VNX3dmSukMy6FLXxDpU0eHOa/hVqzUVl7+VEaVCcOpYIW3iFQ1
         LnjtVQuX9Hjfd4t7vCZ4LJhrI2ijSrcBtd3qXZlxXlFWw+t2xv7WCWd8wFKsb1Un5kMl
         zA/sgRpFXGJ04R1XAh0b6HqTWgfrFteJTva2x5TiPIUXr9Vlu5YDHVYzGIjtlWqy17p8
         5WmJkFf1mRpOOzWRxQT/o/zX59zzaLWPR5/5cUrz3m0wpiF3HjzdBq2nQOTca++lKUlL
         7JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838522; x=1686430522;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyU2yJMTTWP+TqXiAQ39h3qUzT30tuE4shvQs3raY5g=;
        b=lC9b1jRI21Qp3gKJyRJhiixZ+czLADjp9iKUGb8tQJ8zCwL26avo6KYUxi085EVA01
         I2Z+jdPCzLrKfoowYktvFitbWDHRMQJ5lguAnqv14fxZS8g3iVnOlbkVjRCyNexW897Q
         oGmeFplpKW+4JhnbOm/ycFNxDHk1i//0v/esszOSQN4tIbYX9V1stx334GvM5IiS6YtM
         xqTq5z8CTP+OB864uUSlf/Xwq1XJZEuhsRbb/aYrT9M3EqQl+sBPQ1n+1EqBQSLYWa1D
         2gDw8hWVZ0eQKv9D/HID1zwrkUzsMtGI7fptubNfF64CvSv3VS2RwLLLILPtu3NyOSzv
         0ncQ==
X-Gm-Message-State: AC+VfDyvCHqOBR0TQY7aR2Tg1H1U2Ql8PpPpMD+mS1JdYFf1Vm9CFrLz
        48ZBaGijKhHSn8mE1LMgamU=
X-Google-Smtp-Source: ACHHUZ7dRy/liazszbJG1nvxuu2yJ/7t4rA/ZngmnLiUv8UzPGH7twOGifXyyj9jb9ELW4g9nf5RJA==
X-Received: by 2002:a17:906:72cd:b0:965:9db5:3824 with SMTP id m13-20020a17090672cd00b009659db53824mr18151141ejl.6.1683838522092;
        Thu, 11 May 2023 13:55:22 -0700 (PDT)
Received: from [192.168.0.103] (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm4562442ejc.17.2023.05.11.13.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 13:55:21 -0700 (PDT)
Message-ID: <ecdd4474-d570-e0b9-f30f-278d2ce36f1e@gmail.com>
Date:   Thu, 11 May 2023 22:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] staging: rtl8192e: Trivial code cleanup patches
Content-Language: en-US
To:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1683730854.git.yogi.kernel@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1683730854.git.yogi.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 17:08, Yogesh Hegde wrote:
> Rename variables in function _rtl92e_dm_tx_power_tracking_cb_thermal
> and Refactor variable assignment to avoid checkpatch complains.
> The patches are required to be applied in sequence.
> 
> Yogesh Hegde (4):
>    staging: rtl8192e: Rename tmpRegA and TempCCk
>    staging: rtl8192e: Rename tmpOFDMindex and tmpCCKindex
>    staging: rtl8192e: Rename tmpCCK20Mindex and tmpCCK40Mindex
>    staging: rtl8192e: Refactor tmp_ofdm_index variable assignment
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 68 +++++++++++-----------
>   1 file changed, 34 insertions(+), 34 deletions(-)
>


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
