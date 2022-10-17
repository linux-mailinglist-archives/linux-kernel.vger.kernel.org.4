Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90A600B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiJQJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiJQJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:46:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD485D723
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f193so10014512pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ij2MqIqqwZglpWFium1q/eiumGD0QHeuEcZL1dHqOdE=;
        b=pBvbWdxZOLgKquczqWTjMaAuF7pefRJ8rKA9/4b59V64mTvs9utVBkaYKe8ofbJYFG
         KRM4Zfiljs8EM+y4kMF7WEBK+DZF6LoYR1+2wk4VcQRJPssSDfXnO7j4iXaiEwD7hRVs
         UmCXir9FJJGgq3kt6xwN32n0e6cI7UtRTFy9ZauZRukPOsfgJLkqt0fHtmMj2psvB17a
         oEbe5wtg7vtkZ0v2KqjZp2rhsx1YX2cvb3RCtEixptztuT2aJaFjkb9FNZk31NLAsTfq
         bcmxFzKk2BVNWNRENBNQi/wgEMjDf5PxX9lrKwvvRmMZxMtUfv73YBf96JXYP0buK7mF
         LKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ij2MqIqqwZglpWFium1q/eiumGD0QHeuEcZL1dHqOdE=;
        b=EYjgocwkAbSubUUppkx2OvsQTrqmDjWAN+20NKN4k2ha3kOUJ9EIIdu76a7cGcIb4y
         /QOmTgniriNYDwCv0iyiwX0Sn0s3NObSSSsSsze7t83XgbUh+G0ipQcQhajTLangvZ93
         jtt6YlQC/Q5R64qlfLo6QObPZ96oCSkgH30fZZpJ66mqjQUhZg3Kw1NQbF+DqQkOlIif
         yZWQtMIgX955Q3z8Y34kfMJA/5S3jREDjrVaaUB5MWqaSTNR8DNz138GbwhlWqBUOES5
         rMKXGT640ehW9V4m0tD++jKWZMEcpalBKApkioYxTLWZJXJANgJYpLWQYUR1Lrx9Ej2B
         wjRg==
X-Gm-Message-State: ACrzQf1jegPECRUcv5zrBBo1Teximu4X5Ssl8sD3t982DS5Zu0ZYJRP5
        TPK2Jglca2nP6TYcuWx4zKI=
X-Google-Smtp-Source: AMsMyM498YR1rvBNOFLBTZNic6vYa3YUPVxAysTyqkvq3/WIZ4AhK27rpEXDyRWxjrcXJeLONPnO9w==
X-Received: by 2002:a63:6bc5:0:b0:460:bd9a:64b8 with SMTP id g188-20020a636bc5000000b00460bd9a64b8mr10164303pgc.257.1665999957727;
        Mon, 17 Oct 2022 02:45:57 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm6181082plb.77.2022.10.17.02.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 02:45:57 -0700 (PDT)
Message-ID: <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
Date:   Mon, 17 Oct 2022 16:45:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
Content-Language: en-US
In-Reply-To: <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 19:21, Bagas Sanjaya wrote:
> 
> No Verneed warnings so far. However, I need to test for a longer time
> (a day) to check if any warnings are reported.
> 

The regression still occurs with this patch applied. Let's see if
reverting the offending commit helps.

-- 
An old man doll... just what I always wanted! - Clara

