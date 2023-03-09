Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC26B1FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCIJQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCIJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:16:01 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20177DE1C6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:15:40 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i8-20020a056e02054800b00318a7211804so633574ils.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353339;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=w1EdeWEuCH/dXsSRxbCetcyqK7HqR8Yt8K3G6hNCt95PDLRZYVlrhX0GOJQx3cU77X
         sZbWDIc2c7AW54cadSXuSO+1u9AqdlxJK9lFlWWha0uwH0FTVe6sDXzKUxfktFD3Z+9M
         FHIInmEtT+vZyRZU3CMKNngHyxS76OiPstwYXQPO9REtJZ0x7OlC3jCrKq+82/Fg+sZM
         ALDFUOVegGL7KMlw6HGoTD1lO2opa+u2pN8YU1Mj7DEA7/csnV+eCuj5HB8lG8q/EBwl
         4v89NX+8kB6M8Cl9Ckgbrts3XDslktcL3X99negYTlP+UDsDGAa/rpQSGMaHS0JzpMgL
         rP5g==
X-Gm-Message-State: AO0yUKXPzD3XnN2NOhBGDi4fNzKpT4tHYqjEhUrrdFybPqgLT40z0dNh
        4iysvj6XztXyDO2y6+cmbCEoR1mBlQfhgO/98AqPe0zEjuWn
X-Google-Smtp-Source: AK7set8bJMPh9s92fKBDNiUVV6PtG40zPO72ctq6PT8vd6L6Pp0K7X1EhBAQWKkYg9SGJ1H4FHRzMClVQCdSwTRlWpRMpks543go
MIME-Version: 1.0
X-Received: by 2002:a02:942c:0:b0:3f6:e3c2:d4bd with SMTP id
 a41-20020a02942c000000b003f6e3c2d4bdmr5241040jai.0.1678353339389; Thu, 09 Mar
 2023 01:15:39 -0800 (PST)
Date:   Thu, 09 Mar 2023 01:15:39 -0800
In-Reply-To: <000000000000fa5a2205b4c33093@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a1f7c05f6741666@google.com>
Subject: Re: KCSAN: data-race in tick_nohz_stop_tick / tick_nohz_stop_tick (2)
From:   syzbot <syzbot+23a256029191772c2f02@syzkaller.appspotmail.com>
To:     elver@google.com, frederic@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        naresh.kamboju@linaro.org, paulmck@kernel.org,
        peterz@infradead.org,
        syzkaller-upstream-moderation@googlegroups.com, tglx@linutronix.de,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
