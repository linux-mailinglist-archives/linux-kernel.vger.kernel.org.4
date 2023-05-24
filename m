Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5270F791
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjEXN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjEXN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:27:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A112A9;
        Wed, 24 May 2023 06:27:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4c5e1388so2352495ad.1;
        Wed, 24 May 2023 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684934852; x=1687526852;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2GerfY+kInR6cqw6jzZcREjWzkqJCl9gB7jAQ/VBYs=;
        b=FK28xqcl4QVjxammuWRG4O4P8X3N/fDk5hqclYz9cJY/sjZwIn0C19Z7nClqwMXlCS
         oH1SRarLRV+Grf/6YNu3qln+MBhJln3Z2wxNJ46FUwTKSZHpFaxSlyHRNlCAsjvnB+1B
         ozxrdkbucEVP4WadInENqQbgi9hcG//M3DBY0twdwfxji2gmxbWhlKFMVWgkUCEyrxpW
         iibbkEHexoGUkPCBDmLcFZjSrKPrXFvwkYtOSKhu/6KMi7XYgqeP7VU5Q0PbGcA6rQYm
         8jbvFGzopi+w4W84wZjLyeLNZF/YNJaoFyrkQbfdT6vplBtnATfAPdLNMm1CVHrtqTCh
         XqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934852; x=1687526852;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2GerfY+kInR6cqw6jzZcREjWzkqJCl9gB7jAQ/VBYs=;
        b=Tup87UdBNMtNBqgu7FpcZ0sTik1GV1dZ0Wlo/0u9mlPBxnqzaRLB54Ov9zqAOxyTUO
         FYPyHjzyrDrhHRFDYSMG8AfkKreMRvbvhMdUDZXqpNXaUshigVRXKuewl6q4N/Q/EaNj
         96FFP++YpWH6oC70WKUDTR/9moRtJJ57Iv2UCUzGpEFk7vXDw5mIVNJNFsQY1BiQnmWD
         wpPy5hCd2vQVRGd6aMrFlB9wpYi17v7kKlagOhR7mgvgmXn2EhEQ5rCWR/zjDXCP+Q2+
         rM37lKcbQwWHqxz3qp60huhHMjZ7XCVVvN9nhAvmnuSlSiMEcTUKOXA9JNkI+4+ww/td
         hl0Q==
X-Gm-Message-State: AC+VfDyEEv3xc5CtGox38EQV0SWATUhLb98Pz1TcfTiIrmv+Z6hwYvsk
        lHmEJ7/AqxISaGQ/f2DOQKNKCCFfGpg=
X-Google-Smtp-Source: ACHHUZ7+ifLWhmAd1KyJOxSKY0tmE70ndmmQ4xS8fuheJiPP2yUcxjiiVyV3PA8yEq7qTyhVkbuR4A==
X-Received: by 2002:a17:902:e5ce:b0:1ab:14f2:e7e6 with SMTP id u14-20020a170902e5ce00b001ab14f2e7e6mr21789815plf.65.1684934852412;
        Wed, 24 May 2023 06:27:32 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001a943c41c37sm8763695plc.7.2023.05.24.06.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:27:31 -0700 (PDT)
Message-ID: <8202e4a3-5228-f0ed-9c40-1f575f944595@gmail.com>
Date:   Wed, 24 May 2023 20:27:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Kunitskiy <alexey.kv@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel consumes ~50% more power at idle after resume from s2ram
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. As many developers don't keep
an eye on it, I decide to forward it by email. Quoting from it:

> I have a setup for measuring power consumption straight out from AC socket. I'm using following hardware in test setup:
> ASUS A88X-PLUS motherboard / Athlon X4 845 / 16GB DDR3 1600
> a usb sata ssd attached as system disk, no VGA card
> 
> Tested on Debian bullseye kernel 5.10 , bookworm kernel 6.1 and fresh stable 6.3.2 compiled by myself. Results are the same. All attached logs are from 6.3.2
> 
> After a fresh boot, without any interaction such setup consumes ~19W out from power socket. Doing a suspend to ram and after resume power consumption in exact idle use case is increased to 30W and do not come back to value before suspend.
> 
> I was trying using powertop --auto-tune but it had almost no influence on the increased value.

See bugzilla for the full thread and attached debugging logs
(acpidump, lspci, dmesg).

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217455

-- 
An old man doll... just what I always wanted! - Clara
