Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26166DFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAQOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAQOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:04:08 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433139CC8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:04:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o7so32871120ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzZzYWKNmnARWWDNBQqY5fo72EgCU0TUb5m6uPT/G+4=;
        b=jK8+uYzumj6sHycb9SG4YRDyG3aJYaixccfazVmDWo4rpvuMmBgHxx0PUGVjtkBvfm
         BbvmhCrKtPkxzPAfn7wrV//VbNaXATtWOxf1SrcO2CKx+4z6gRA15vxfx7O79L6FAn9P
         +7aGUrWdIa5N4U0h2jjbr6V0487Qrt4/ddPOxotd5RK/xW/qPWEqBCKFssQIMLh8amB/
         eNAonVXGlmqVjmhAUacuk/hReX5HL43eWm2iTca7wdaaQWnKN9V21II0UL3U/508QGi0
         CrP6nmgFRw0U6Cu7pWKFHUGMCEwoUYFTbGIFmmmqLQHgTUikkGM77pbJeAHvpKIYTAei
         L8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzZzYWKNmnARWWDNBQqY5fo72EgCU0TUb5m6uPT/G+4=;
        b=tiIX5sRFLi8qgqP9+1Yq+NLORNMBJvMVI9xJdsqSWsSwcWU0F0Ue09mbRNq7RTYIcI
         nzOo0lL1qUS+QcnB6pZWgKuFFsQ0SxJLVwXkx5sueANCEWNNmbkxxiCHiQ/8VUzRsuWw
         svxYZXkpwh0LqzWHK19j3HpMuwGsFV7eYM5JrK8cGsMOChjrczp/8dGiJw75FoSWeR3+
         oQhHoMsd0MK/Bgzwa/wdtfsvKvhTvP5ELVhN/CYUUQBdvFVhsMBlOXRQNWACeHxE18Uz
         kxuzmnW9w6Wotupa+xvNhd0Rab0pfzmCrA8LwgdP1XzF058sKJFlY9HzWUch1Ii/OLax
         7baQ==
X-Gm-Message-State: AFqh2kon3nMCQENdXHNN5Ckx2JVWIgkkSVjzg4oatSegcyCRgTnZxREb
        RC9VXWj+FafybTmO4VMUf0QhS3yF9MwgySbabkw=
X-Google-Smtp-Source: AMrXdXt3P4Lo1b4Wol+2vl6IGXB7g+3AWZLsH7NtjaqfzbAuBdaATO0v37YgNuGDhEzqG4Jcj9tt65Mqne0WbVjaFJM=
X-Received: by 2002:a2e:94ca:0:b0:27f:eef3:921d with SMTP id
 r10-20020a2e94ca000000b0027feef3921dmr329644ljh.515.1673964245813; Tue, 17
 Jan 2023 06:04:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 17 Jan 2023 15:03:28 +0100
Message-ID: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com>
Subject: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
To:     Huang Rui <ray.huang@amd.com>, Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I regularly test:

$ LANG=C LC_ALL=C make -C tools/ clean 2>&1 | tee ../make-log_tools-clean.txt

This removes:

$ git status -s
D tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
D tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py

Checking the log:

$ grep pstate_tracer.py ../make-log_tools-clean.txt
89:rm -f -r   /home/dileks/src/linux/git/tools/testing/selftests/amd-pstate/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
/home/dileks/src/linux/git/tools/t
esting/selftests/amd-pstate/../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py

Is that intended or not?

Thanks.

Regards,
-Sedat-
