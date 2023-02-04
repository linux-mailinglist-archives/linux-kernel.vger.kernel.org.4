Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A468AAED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjBDP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjBDP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:27:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9F27995;
        Sat,  4 Feb 2023 07:27:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so11466756pjq.0;
        Sat, 04 Feb 2023 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSnA6bDbqE/+mRrNJmYL9pV4GL9ctAZAtrQ35/GNxsQ=;
        b=TEfhFYBxxRdqUSNaV3xJfSLAiyiPqzzeXbP+zukePNt1/YoaZYN6nMPoq4sKPITcDo
         RixVgeipigZbhi8DcN6mRu17/HFoonx+wcobgM+ipcU8TFn3ZKVxr3/lqNbYDP5gFzCI
         6FrsPYZwSQicjwd8HPZj29hq5CALa/MqApkl21BLmALAMatx/iuihqv/L6MWOeYvFk20
         RrZ2LuFY58zIV4xpxh426WQPi2mjdWWpKw9q/PTBzXC4/uIcWRimg62KkS9ZFSzNVx66
         LEvGe4dZsCGzmz+HpUpZBPpqCC1qyY7kgUO9aB93DLxEmNpKtGbpc9IlnLH6/mcYXvps
         e2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnA6bDbqE/+mRrNJmYL9pV4GL9ctAZAtrQ35/GNxsQ=;
        b=i2XyM+WFmoMjxDQSzCl4b3DlUgmtVMAa68lhW2PwxXzerA1nsHVF2caEvpLu36Xl8t
         QBRGCCDb8JYeanzZrL2ysr9x1GXTGXNy06ndO34SUASFdw+phA3+HOywapHSL+9E2JJq
         LfZFf5TA8xRHs1s/NUvynnfDgh9yidslM4ioFWAxIBrN0l5JZGrfLjISnehPxxFGJNch
         pIlKeXkuBHZxxBATcrTlGQsVmSS+OI2FgYY0YtR9n1H6TzdmtfLOJBlKIc/N/gG4eLd9
         bOqVKYOV6J6B8xer3VocSsJwl7IqsXhsj68SkHtjnzfkHdRCMd89HBUpljDVh672qvQk
         2jVQ==
X-Gm-Message-State: AO0yUKWy6uWc/z0KbPbMPzdiOso1KHIDG3q4q+00k55QLpkLlFOqMy1F
        ymhmcA4nSIHilyf+t0hcascuDLWQXFilzQ==
X-Google-Smtp-Source: AK7set/lFfEkTd24oR3fCKAk+S7m/aNAm2k/1yBgnhHIkoe27djbmXyC30C5Y8cADptEeLdfjtyayA==
X-Received: by 2002:a17:903:1d2:b0:189:81a2:d616 with SMTP id e18-20020a17090301d200b0018981a2d616mr17394318plh.16.1675524472559;
        Sat, 04 Feb 2023 07:27:52 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001892af9472esm1606305plb.261.2023.02.04.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 07:27:52 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Sun, 5 Feb 2023 00:27:47 +0900
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: s2idle breaks on machines without cpuidle support
Message-ID: <20230204152747.drte4uitljzngdt6@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

s2idle is blocked on machines without proper cpuidle support here
in kernel/sched/idle.c:

> if (cpuidle_not_available(drv, dev)) {
> 	tick_nohz_idle_stop_tick();

> 	default_idle_call();
> 	goto exit_idle;
> }

> /*
>  * Suspend-to-idle ("s2idle") is a system state in which all user space
>  * has been frozen, all I/O devices have been suspended and the only

However, there are 2 problems with this approach:

1. The suspend framework does not expect this, and continues to suspend the
machine, which causes machines without proper cpuidle support to break when
suspending
2. Suspend actually works on ARM64 machines even without proper
cpuidle (PSCI cpuidle) since they support wfi, so the assumption here is wrong
on such machines

I'm not exactly sure how to figure this out, and my attempts have all led to an
unbootable kernel, so I've cc'ed the relevant people and hopefully we can find a
solution to this problem.

Thanks,
Kazuki
