Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44A5E79FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIWLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiIWLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:49:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BE23BE4;
        Fri, 23 Sep 2022 04:49:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id cc5so20062246wrb.6;
        Fri, 23 Sep 2022 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=c7Tx9HKxUWh0xGhkeNMbuTm7Bc6XNgbJWQ+SJrtDyPc=;
        b=Xs+GlJ/gwSWKKlmvldlFRVntIBYxuC/LRSV1n0pYgLzLkUtitrnv1nnNThNBdNEmiC
         TJVAPoAQA29rD1HMsN4pB7ufm6O7K/7GzDwEoR5zQSo/5yX7OCod64nMONy/qkuO/Cwf
         wI4VRAU/pGyEcH+xvBvNTQsP8UX2uvPAI8Nm5n7KcgZvoHz0EyAF0tRG55eRjHkREShA
         1hTbCkIyde7X6NIYhaCm2uSt9kgTnp2c3k5oZZstGBYALUqI5wr/gBcmCGUcIMMu55Fa
         BRU2co7lqjj6WY88Ky2TeUY+J9lhvLRcjrgJLkAcdVLE8E5KTpO1EXOOymvuIGrpiUJB
         xcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c7Tx9HKxUWh0xGhkeNMbuTm7Bc6XNgbJWQ+SJrtDyPc=;
        b=rK2HMiBj1A3zHwQE3ro9/ymHdhBhdVvYh8XxxC+odwzzoFjXVuJ2dndlGxWZW1UvJ/
         bs7/qGwBKSpEzcljKPWDcw52P+wKlqiuTThkHDYtegB82GFU5A3+oiTm88uGKVr7pxKE
         mxF28GuH3AC1R7CFIXSGjTz2vVA1RFsUQo1rYCMq4NH7xdAycE2yrP3ODZfyYpB9eEBf
         wLZVXDfL4N3LxkRBnx4n4yI5WEZhD9XIXtq4yv5SuIXHLIZuqLAVrgOj3YG7P8iplVek
         fxKUOBoPoRMSY+mgi5Mjmri0c0z5+MgMUxl2hEmC63ELXYu8DwkGbHR/J7NVZiypjokt
         VMDQ==
X-Gm-Message-State: ACrzQf3grTosBSt6jbEcDMZBnVkeP8QaFoQFhMQrjjts+CZ2SI8Nleo9
        FKwTUxe3yc6fzBkPO1RQhJ0=
X-Google-Smtp-Source: AMsMyM6EBH2GR4oCpp4cub1DEuj58J47hRZrr5TBo+wPaCXGfmyrEJ0Mdp959I4dFUOt5Ug3zqLlwA==
X-Received: by 2002:a5d:6245:0:b0:225:3e24:e5b1 with SMTP id m5-20020a5d6245000000b002253e24e5b1mr5084277wrv.698.1663933778281;
        Fri, 23 Sep 2022 04:49:38 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id bt24-20020a056000081800b0022a9246c853sm7623449wrb.41.2022.09.23.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:49:37 -0700 (PDT)
Date:   Fri, 23 Sep 2022 12:49:35 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: build failure of next-20220923 due to f6f6f9a01374
 ("thermal/intel/int340x: Replace parameter to simplify")
Message-ID: <Yy2dT5bKGc4aOJIl@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of x86_64 allmodconfig with clang failed to build next-20220923
with the error:

drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (!int34x_thermal_zone->ops)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:279:17: note: uninitialized use occurs here
        return ERR_PTR(ret);
                       ^~~
drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:2: note: remove the 'if' if its condition is always false
        if (!int34x_thermal_zone->ops)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:211:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

git bisect pointed to f6f6f9a01374 ("thermal/intel/int340x: Replace parameter to simplify").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
