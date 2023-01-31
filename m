Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47583682F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAaOoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjAaOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:44:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E551D932
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:44:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so15295238plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpvzkk4KiAncwiWVfbjry37FVWQG/VY55zGloY5qlYc=;
        b=k44mBuxhrbOWvUKRU60kcSQDG+yzJFJZvjRbuTECNupanwlHqjg4kmCnRip9L0Hd9G
         euguGd1P2YtLV3i6ZJw9+pC6xdr2PnW/qJ05lxEaKPrqJV3sJbRqFAKb79+y7bTUX/xh
         KhMMNyRnfZNkv677L65PG4030wyKO9hdkZDOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpvzkk4KiAncwiWVfbjry37FVWQG/VY55zGloY5qlYc=;
        b=y7nXEnlb5knf4mA5bPaO16IPSFlsO1i1FospAbbebFsuGPyhfz3Z2KVU4l9Io3lKeD
         lqOrIrT67pEKpa+t5f8SwEMa10JS8ex96Oce7GS4/BjWrZhbeOOCf0t/TZXz1ARkMbxp
         KsUWfuU4x0Xjy+DCAc1Y8yeo45GX/y5RdawerbNXJjvTSCebpPpnKl1OZMM6ct199fQ2
         oFgCouNQcsgb9KooBuWAD8XUM5ABA5h3YfRqzRF6lT5ByzFtibaNLkGQyAIZBrciRD4G
         P0XorGfTczAo31qBSoSzHjh+e99iB6uA3E5c89fhLREcGiglToWUgDWUViruAlrFUyEQ
         V7ow==
X-Gm-Message-State: AFqh2krsUqdQErVM+BPVt55DkMXTIlxFhayhFHsgb1BjnDiWbbaXzwkf
        IQ6ACHy9mO7El3Pjq77+A7Cm98cThViA6V9Jvwv2cw==
X-Google-Smtp-Source: AMrXdXu2koNIdQLcIVOpyAShjiIbJQ2nj2DAQAqUeajLFYgXdYc3NF39BwfEtlvtkWqcheZF4mJAtHhpoeKZY0k443U=
X-Received: by 2002:a17:90a:2882:b0:22b:b832:4125 with SMTP id
 f2-20020a17090a288200b0022bb8324125mr6477120pjd.146.1675176243849; Tue, 31
 Jan 2023 06:44:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMycsUQ3aWbAHa6fnSwmQpTt9PhagY14_k2sKGC+vGiqGg@mail.gmail.com>
In-Reply-To: <CAKXUXMycsUQ3aWbAHa6fnSwmQpTt9PhagY14_k2sKGC+vGiqGg@mail.gmail.com>
From:   Allen Ballway <ballway@chromium.org>
Date:   Tue, 31 Jan 2023 09:43:52 -0500
Message-ID: <CAEs41JBMqSCk4U4aQc08DRL5hHDteRmdt1-TGQg0-niko5MF_w@mail.gmail.com>
Subject: Re: Dependency on non-existing config I2C_DMI_CORE in commit
 a2f416bf062a ("HID: multitouch: Add quirks for flipped axes")
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Thanks for catching this, that's definitely a mistake in my code.
That was supposed to be CONFIG_I2C_HID_CORE.

Should I send a follow-up patch for this, or another revision for the patch?
It looks like it hasn't been pulled into the mainline branch yet and I'm not
familiar with updating it while in a maintainer branch.

Thanks,
Allen

On Mon, Jan 30, 2023 at 3:44 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Allen,
>
> with commit a2f416bf062a ("HID: multitouch: Add quirks for flipped
> axes"), you add code that is dependent on the CONFIG_I2C_DMI_CORE.
> However, this config symbol has not been defined anywhere in the
> kernel repository. Is this a mistake in your code and you intended to
> refer to another config symbol? Is there another patch to come that
> adds this config symbol? Or is this a config symbol that only exists
> in some out-of-tree repository?
>
> Something might be odd here, because this code is effectively dead now
> with being dependent on a non-existing config symbol.
>
> Best regards,
>
> Lukas
