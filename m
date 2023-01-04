Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7665D29A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjADM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjADM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:27:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103771A21D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:27:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z16so16286769wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C30T6tNGFSuxvz3Mz5j5spVtycMF/lADJz0DPiFP6T8=;
        b=luMd9K3IkxjocbML0QXFirxmtfakpeCmxnFW7ekh8TEqv2B+6u88Ll/XSxONlFR1CC
         H0sj7UWnqBTF8cMsxY8A5Q1I1H0xQMupfQQhzVXA4jfEvjHi23ZwrVfKpZwgyh+wbL9I
         VaeKEkIYHn5OGvzlIM/I4/YyP/mKrbPLVc/PykKH9bNVJvkZvG2Xd3EuAJ9wz8L3R81f
         A2dch1C9pGi42sMsdLXqNwn6T5uDLVHcjmvoH/UKV/9wronAPuHWFNKIJn8YfcoSV4xX
         piWmF/EfvFWCMAnvekQ+ju7XW0oUtqhWhCjI25HbKsuh25oJ1+blb6HR6qfNTFkk7M6F
         GMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C30T6tNGFSuxvz3Mz5j5spVtycMF/lADJz0DPiFP6T8=;
        b=mOYaPTc3gESyuO68cVmxY2FFzB4GJ3tEo6EXZQmP8ADiQbrVyGRhxi2uJhV6YZTTZ/
         jk25MPaS4AcMfSzjocogbujeascYuIRwHbEPE2TNPw87OWDZg6SshFzIcbF90yECSZ1Q
         RVBqG1a3MIhRiRWzIXROYn6MiX43IXI/AchAZDtA7r3tYt8umFvWbubsN+zaJCjt5CGb
         AsXNossd+giHSx88Ejxa38mozzvuHKti1fAmjGW/CJPBeKMcfMxvVmL22FmTOjnJOemF
         3MRNDir8/O1LL+OkTqG0qUjCAW5M73QFIuCbAU5tQNFqy9XKW6zZ1yGTbCEF55Va9Esy
         RJug==
X-Gm-Message-State: AFqh2kofwByZWKn1J+kIHGL2cz0S+4ZKR1KtVWvek3PCtQcFfx5ozGfy
        zzVvvZVN1wGWNE/26WeKlxajF3FwjCWl4+brZFY=
X-Google-Smtp-Source: AMrXdXv53xtPSbIhxmlMfoYs3hxEElTh4PBEm7t6OokhRJO2RAsiyRKmAqzRYpsXcr3bFj74XxxNimMgRJEQ0VS8u+M=
X-Received: by 2002:a5d:5d8a:0:b0:242:257f:3006 with SMTP id
 ci10-20020a5d5d8a000000b00242257f3006mr1004952wrb.147.1672835229563; Wed, 04
 Jan 2023 04:27:09 -0800 (PST)
MIME-Version: 1.0
Sender: michealkeini@gmail.com
Received: by 2002:a05:6000:250:0:0:0:0 with HTTP; Wed, 4 Jan 2023 04:27:09
 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaffi24@gmail.com>
Date:   Wed, 4 Jan 2023 00:27:09 -1200
X-Google-Sender-Auth: 1-TA2zXowpn1vCm3GsNY1SwZ6Uw
Message-ID: <CAJ9PX1Yj4Wkpn_r4_xBdUxB00bSxbmuricQX+HLW+hrWKMu_9g@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I came across your e-mail contact prior to a private search while in
need of a trusted person. My name is Mrs. Aisha Gaddafi, a single
Mother and a Widow with three Children. I am the only biological
Daughter of the late Libyan President (Late Colonel Muammar Gaddafi)I
have a business Proposal for you worth $27.5 Million dollars and I
need mutual respect, trust, honesty and transparency, adequate support
and assistance, Hope to hear from you for further details.
Warmest regards
Mrs Aisha Gaddafi
