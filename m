Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081695BE541
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiITMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiITMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:09:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA02466A70
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:09:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c11so3883629wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=cq0f3XztoTwIGG23ILvyYyIaVS1A098+RPOPNcntMz7eb27RavEg2y8dtmUfRl/fP8
         IFzD2GMft4BxfOWG4wGAN5dOk+OBEzkvrEah1ztrDbFvdUw3pjHGHPZCAZHL80aL78be
         2hKY/wUesS/MN1a9H+QFtOofZ4icx+HfWONIeTVv3XQAurjoGhQ9Xi5ZsumJLaS2cAyj
         EsrEkBnD+c/0yUY/wg84tABFiXElzFxujjJxjR95HJNPWKCZd6Ajb3yieChlUnuY314k
         zpQZDL/O8ZTtPnFL6uCz47ACg3l08kAF8xjDFaA24BU1JvJ3FsENrqHMQxPrnrUsuWgH
         MMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=C78OC5uFYYplrp3SlX9dwIN0eNTGijtJyCWhz1vVQlaqyF09Nohj+uFFKZR2Tj3n50
         xBU8kOLQp+m/80xtRTNMbxHOdTJdwevHK3eAQJCoZQgmZDSvysU5C10WrMzouttwm27+
         2BkBdj2J8O3VrX58AVCyAIu8LV4n4ztVSfX/A9SNgGKTETWgZdIxRWePppmLp7dRaJTp
         HtaqzE32GQsEE3Y1FME1aTZTtm9bwxpCeQqu47uzihmxh7kCaaXFOOhRvg4VakNq2VDh
         xuyJGRV9lFYdVgsr9SHjvZvi/VFn4TmE4BHFttZxtCSvO1JqFq4+YX0YBrsz7VUXO3Id
         fh3w==
X-Gm-Message-State: ACrzQf1GraocZSjc0AFwjySY4AU2hap5o7/u/sz4BRnnO+K53C6gCQ5V
        XsPv2rPOf72Ag7lxR5U3w8hZqImC8R666rgSr/k=
X-Google-Smtp-Source: AMsMyM4KFkqkSD7WwPeOKxlPJj67mXl6Fk/NQecSnONxNHavJVEX3WJBWLqLFAdPwXiPM32B87RvlKXlrvP2jB6H9/U=
X-Received: by 2002:adf:f408:0:b0:228:d6f6:3bb9 with SMTP id
 g8-20020adff408000000b00228d6f63bb9mr13855125wro.398.1663675747960; Tue, 20
 Sep 2022 05:09:07 -0700 (PDT)
MIME-Version: 1.0
Sender: paulbryan24921@gmail.com
Received: by 2002:a05:6000:605:0:0:0:0 with HTTP; Tue, 20 Sep 2022 05:09:06
 -0700 (PDT)
From:   Ahil Lia <mrsliaahil070@gmail.com>
Date:   Tue, 20 Sep 2022 12:09:06 +0000
X-Google-Sender-Auth: JO6mUd6EpwXyMg42v6JnPo5N68g
Message-ID: <CACVhYX706XFU99aYRDzD0NKTShXnj0Wn++-iJ8ZrX7ZgLHtgKw@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


