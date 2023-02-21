Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025B69E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjBUQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjBUQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:17:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE12C65F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so3339079pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Au8Qm6Ct3Z5BgoNGhuET54cEIgfVWxaLUUUNWrnlAbk=;
        b=P5TLpMsd/C/Qwf9E3kjEQpVh+UVbE70QipCFn3UgXEZro2Pt3mS6/ls2JE0GQdJP2p
         mnWhIWUHMEBF6NydXxm286Zq/8NpvZY+DTWfZ7Z4SL26lu4q2F7ym1EMMlM0/qoXlYyx
         6ksfP5n2cT0U+rfbOcave2WTLhozwh4/CDyek7tka+qL3rw7xJ6ok6VeFyZCvP5NoQz/
         Z77Trp8NJbvz+Jhnq+ppmw/dBPFi0S0Uz5GrO+MoFkoxG7XjRJyejAZZbJVpZdvBCNpk
         eq9Q7ws2u2/S7fJtmGhAdxjlTQT1m2GpXnqjTtMgYTnuxNfv3Ys9OCCHnzGAUXuJV3G6
         wldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Au8Qm6Ct3Z5BgoNGhuET54cEIgfVWxaLUUUNWrnlAbk=;
        b=XRcYcvFDDh9X9jgS2z4WYV5lnWmDO0niorlCBDTiq0224mnHZMmmFWG+DizAZ5ZI2+
         Fl0esagZxhb/UF8+QOXNpHJT0yYr1wgrmPVDhMQn7YppTGfPmI5IfKOgGAyWY2wFvSTj
         Pm5O9w0xru3QLIJqrjEGVx2GMKhbMC5Id+zXT3du8tuxJDUqbBpDnA7tBsk/G+mxsJ8s
         UzBAEgkk0QIu/GTd8sVlC62o5ZZPvaXmruSHmPYvuercQxYLzf4Uvt12FucBi4WWTe3e
         wQqp7FEtzR4IRhqLskV0us1Z7/fRzdQUhUTUK2kxW4przjoE6iKwlx9C0mk1BHWZOpFh
         5I3Q==
X-Gm-Message-State: AO0yUKVaps0MXI00lVIg8qAcATA7Yz9NgrHHNaqjau286p8jsrlvIB9K
        2Udr53N5aiJ40SZ8LTnbWSMry9/Nugqp2bH3teOpG8L0
X-Google-Smtp-Source: AK7set94OTScPCRQsQ1T/niJCqaNlcp+A891OkPRZEuEG+JVeKACvrjOgmXT0fVWhw88fhv8A33UqKh+UqOm0e4xqjU=
X-Received: by 2002:a17:90b:42:b0:234:8891:a5da with SMTP id
 d2-20020a17090b004200b002348891a5damr1035041pjt.49.1676996229601; Tue, 21 Feb
 2023 08:17:09 -0800 (PST)
MIME-Version: 1.0
From:   Hanasaki Jiji <hanasaki@gmail.com>
Date:   Tue, 21 Feb 2023 11:16:33 -0500
Message-ID: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
Subject: .config and "make" / turning off all debug
To:     LIST - Linux Kernel <linux-kernel@vger.kernel.org>
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

Is there a command line parameter to Make that will disable anything
that results in a debuggable kernel?

Is there a tool that will modify .config removing anything that will
result in a debuggable kernel?

Thank you.
