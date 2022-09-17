Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1176F5BBA82
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 17:01:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE872B623
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:01:26 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g12so17935783qts.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=GDyVnvMkwDqm8i9+/sftGgFRy63dgME4M282G6MUk8g=;
        b=GJIxq4QmrrbqYLr2r0LHLLmE1v71FX4WbRdGOyep9AhOzDnIZTIOQOPR5MEIXvx923
         ZgI+ZVxuCRJuVg0w94fhqYIhneMG4fcPhr4Tn0dNIcHN4yGiwA9HmO8WTbZRKxFqPbi+
         2KUPruo1Wt6IWS6dCj/thDrL49tyDGVWFCHlJ4/dJiZ6CERkL/fi3XBV9WxvsUqaWoFx
         1SXeEoGRV0Sl3I4eiHXBHXvedulJBFdB5yFFDBL+/9z4Za2sLkVp8L2kmxgQr5xvR2RB
         DR4qJTnvxjVX7lY0fyu+Knl7XX+GfMv82UDtRN2Gldo1/5vzDiDO+jRGoHLJYqu7KfZo
         +DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=GDyVnvMkwDqm8i9+/sftGgFRy63dgME4M282G6MUk8g=;
        b=j1vlhLlN8lb82wz0Gyknnup6TCPR1OEmBRycJxiFXS2hZEmRiq6qjytubteDX2ubuQ
         Msi9A70JLY+huXP/bLb0loAQFE6fBQ+q18eU3T8X/jBy1e0uXFkKtKAF7t93rVCLXWsH
         +ubB+nwD3+hxQZ3KIE/Y69+NMh1+uwuSozTAcLl9bM5FLJLsQsDLgVyGWVMG+IsIt7N/
         f5aIjcUDpPUBYXd4mZCQVbFLMrNweWvka3GrOaLqk8oAuxhXqg4g0EDWYVeudN//4Wgl
         pqQnDXvHG7Ahe/xDSTMHahcm2053C2FpSSuJvTr5rCfQB1yl4HH9wH0V5FQXT8ESYVBz
         CYYQ==
X-Gm-Message-State: ACrzQf1JDVfNdwh2JOGvzbu/pzfngqI+WrYBytZIx4EFodxkhPetRm8l
        5+mc0FT9Tnj7hUG5Va1dK77R4Hge2pVQiJFs
X-Google-Smtp-Source: AMsMyM4EF2WwKf+qCbu9mInJJeXaV1IWu3StY2KdDr1frA9XDwmV+KEco8aOiSb9ZBf2c/4nNm0XOw==
X-Received: by 2002:ac8:5fc3:0:b0:35b:b8f9:284d with SMTP id k3-20020ac85fc3000000b0035bb8f9284dmr9570847qta.586.1663448484816;
        Sat, 17 Sep 2022 14:01:24 -0700 (PDT)
Received: from ?IPV6:2607:fb90:f204:c2f9:26:14ff:feba:3587? ([2607:fb90:f204:c2f9:26:14ff:feba:3587])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006ce515196a7sm9853703qkn.8.2022.09.17.14.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 14:01:24 -0700 (PDT)
Message-ID: <4d69c27b-d0a0-997e-6609-eccd0939d156@landley.net>
Date:   Sat, 17 Sep 2022 16:09:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
From:   Rob Landley <rob@landley.net>
Subject: fs/xfs/Kconfig points at oss.sgi.com which is toast.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a replacement URL for the xfs documentation?

Rob
