Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D016DCE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:55:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87DA1BC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:55:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso5130402wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681174535;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI0UX5+7i8ZyKwKx+1gCgsrqbY0n7QE6O3AGZO42I58=;
        b=XvOlfTXp8i8Db+GaE60qWC6LqLAcn9aS1K1Y2U3CFDK0PjN7AeipzhlXL5HzrCnqNl
         /DSAVjCM4geaOe3rTr4nF23vALAjjfgdl0KQDIjBH1tAAYUJYmavGOdlXl/KD9giHqaU
         Mme142TFv4P7WyLAkw7p1mouC7ivJ0TL6IaU/S2eurUXy4n6jacxcr4EVNBAd0Ma1o5b
         Nc5G5ChTcRxOi8GIvZTiHFeywNNLRabYq/S5XcK4umwJqLva40L9jaksLUJN5OIJ7nUm
         izqJvLZ1ciEjM7ApZlbe9qV4WB+pkGe303hHbQywbNItJzOiyeHrt4zpI4ncYsJaWQgZ
         l+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681174535;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XI0UX5+7i8ZyKwKx+1gCgsrqbY0n7QE6O3AGZO42I58=;
        b=6a04Zobt089GscUYfx52w9v1pGrznMo+NiNgekhatN3sB/ApF9gYpNsIuLXWxvQD0v
         /fs6freGZ4FvM4Wu+mGbyZgt8Jg3xjlbIz5ZGuKX9kQqhNcTv6qihAVxbxQVeluBb09D
         VJBj9eyoqLE+KFeFnEwSigS4PSugnmtBAjSgzD1lSqF4iiH8b1UrG+UDeLWA/lGqFtEk
         k7GcEim3qpE6uvSLYWPdqKgJfgpR+MHp14JHy90gSbDFDbInvRnmFkTIYBOxhkuzGGHG
         G5RSsE5BkSxegzj19tawb4aOASxwGQ88s2wvzghmmo/dQBzwcGG2dj66dAd/5RIxOl0B
         Mpuw==
X-Gm-Message-State: AAQBX9cv0dbZQPcTambB2mHf8FOF0NvgFdv/PY66PpE18EeFy4w/xzBd
        87z02T4UqNRB876J5ft4aAuAnYsPlH8=
X-Google-Smtp-Source: AKy350b0lk6sR6VliJGilNHtCAwR329umj35eJs3rJyhIy0gUSg0gfL5B6ddWKsUAR+NkUTkWOQLQg==
X-Received: by 2002:a05:600c:d0:b0:3ea:d611:f8 with SMTP id u16-20020a05600c00d000b003ead61100f8mr9140329wmm.38.1681174535283;
        Mon, 10 Apr 2023 17:55:35 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd? ([2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        by smtp.gmail.com with ESMTPSA id v15-20020a1cf70f000000b003ef5db16176sm15319586wmh.32.2023.04.10.17.55.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 17:55:35 -0700 (PDT)
Message-ID: <54ce2809-eef5-1e0e-c3f0-860b51619968@gmail.com>
Date:   Tue, 11 Apr 2023 01:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: float point
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why use float point representation,instead of significant figures?!

later


andre

