Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07368A828
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBDEZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBDEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:25:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CE2DE55
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:25:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n6so6893023edo.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9G3QUt2CZ40pzuAm4fiIJj6Z+bCnrgF77LZgEjYe48w=;
        b=iRJm/OF4OIg6buiz5H5huDa0PGax7cBMIrBgyyrVyS0MvGyxkyiVK47Qkt97U9g20H
         /MdmuUkqGBcLeXcRliOm8Ov8U+EpOTpZs1wgK9OmFbHmRu1A7qEhVDgt2/PZTTY4kPA3
         I5CwkT/iuSg7UgHfyvWWywtCDS2xtj8sZmeLZfEN6SvrFos6XjiL2ZzFx60bMCGC3NWb
         NO1tMonKD14OyNBxfGWu5aNpuiFs9GAq1fy6WW822sLVb1AZnhpMbEqyFNrqqmgJOI7N
         NFthUt2/R3paC8ZXp+9Un9fQ/s2k/ls5g7dPaDr1m67QfyUI3eVH0JfNQhrenrbnv1AL
         beDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9G3QUt2CZ40pzuAm4fiIJj6Z+bCnrgF77LZgEjYe48w=;
        b=G1gun+7ejnRU+cfo5s3ZHXHeJac6nnBDKklObubl27e5q2CY0Vd4hUZsUkF5DY2oj9
         gWgjnBKUR+KXOeoriLS3RjuNONSUmd9pAEAYHCXYS3vfunvxuaRj9KxLAN8KXbbIVp3C
         1arazExbHPxJb51C8Udl9Jj6BpzxM1lWQv121VKeB7Q4fCWrLEcYJx9br4o0MUqTGNlN
         R1ntpZIy3Lxcj+qJmpL6lGJA5Bg1snLWjAUaHWqYayUZCBQEZICYL3N5hdDo6Hjo8tI+
         9tdM3jRXkM9nUO85ld5QIG3fBkvdHNrV2lajXm1MQ9/p1sLEJDsIZhvYpPitrMipA8Ms
         ZmHQ==
X-Gm-Message-State: AO0yUKWXUX2HvQtqxmppTMAY1m7sQ/qkwPW0msqlpMfXvZ1OZwKOLm31
        jjqTs2S0WKbMDVtkYcVDIriCosEFFdw=
X-Google-Smtp-Source: AK7set/a2WPcdqUXNuXetopO/q6Z6vb1L07WV1jGDrOPEMYKN4voTJpuum1pmaeQbYgHwv6nhQHN8g==
X-Received: by 2002:a05:6402:520e:b0:4a0:8ea1:cce with SMTP id s14-20020a056402520e00b004a08ea10ccemr15984249edd.25.1675484740600;
        Fri, 03 Feb 2023 20:25:40 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402348400b0049ef04ad502sm1957923edc.40.2023.02.03.20.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 20:25:40 -0800 (PST)
Date:   Sat, 4 Feb 2023 05:25:38 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Regarding checkpatch camelcase issues
Message-ID: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
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

Thanks for your support.

I wanted to confirm if each checkpatch encounter for camelcase issue should
be fixed in a new patch?

For example: If the issue is with same variable, then multiple
modifications can be made in one patch.

  -> above example is OK


For example: If the issue is with multiple variables, then multiple
modifications can be made in one patch.

  -> above example is NOT OK / NG


Please confirm me if my understanding is correct?

-- 
Thanks & Regards,
Guru
