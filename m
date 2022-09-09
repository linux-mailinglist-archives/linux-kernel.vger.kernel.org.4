Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D315B3194
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiIIIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIIIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:23:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454831251A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:23:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p200so1619994yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=UrVbo/N4wIWe1TMaGA2dLF7a5UA2Hj+X8NS3IMgXnSHDAoM1Jm7IJ3uuSeB++5zfeY
         yowU3ZHiauBHiCw2NOylFMZOROnxx3e84KJ8tBx9Kr9eSeEn5VLKMk3/T1nKth6Er7eG
         Du02mdzU1DARPaPvjeGQKUq2G2d4rAoNkZNmCJtj7X7kUYsf8O8lAdSJnMHZDHgteQF5
         HedbCkuMx8HNYAe3nIefj1PV3NxGMXgE56hjxPK86wOuUL7j+kB4qPCPmP0wtzpp2fC+
         cL3P0i5dCPscuBDmIcLkX8cyHyZrQSiLWpktOAg+/4KxrOy5iZHqnbu0cN4yRbmjfYp6
         hpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=c8+rorIepM84xIdDwp46GMuW9niaDG1jQqVRl3kwLCfJ5NyOrIVWWKIrEgqlVoj9OM
         ezmvsUs5oG5b1eJkKRwSHhlOMXWn86/hLX53vytHur3bH7XBqS52860smJdqxq0+g5mF
         PNR90RtiyU0ZU9OOjwbEBfi1VxthdzvUlVODiI9bJtTJGX//48ykmminJ5CAP4ppaUpb
         yKmpdFa2to2IsXPXLZqnOvWkJXbmIkA9KjwxnvU7Ec7rkKUSj32oAVQd87V0F1YCr85s
         LrkPjLr/MZlOD5+FUHu/+xH2E4f2yan/jx91+Xt4hP65eh7pEsnua9+Ojbx6JHftjqWf
         zHlw==
X-Gm-Message-State: ACgBeo2k8DeTKf2Us92uhieeZOt1QwfLBGDFmsxnA4kXmcuw06zjGVzp
        Ci5+6TWRj5j3dh/mlOUh28XEvg5/bJNv4PLdgwA=
X-Google-Smtp-Source: AA6agR7NOQSoL9pfavKCjtqBhMjbmgReo+NR/c6+NL7hpvo+IDtzqoZJwwo95jXidWR5q32BcqRWIg5OwHeBdC6fRoc=
X-Received: by 2002:a25:f85:0:b0:696:144b:ebd8 with SMTP id
 127-20020a250f85000000b00696144bebd8mr10809716ybp.123.1662711779425; Fri, 09
 Sep 2022 01:22:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4148:b0:193:65bb:df75 with HTTP; Fri, 9 Sep 2022
 01:22:58 -0700 (PDT)
Reply-To: mr.ahodolevi@gmail.com
From:   George Levi <mr.koffiwillames@gmail.com>
Date:   Fri, 9 Sep 2022 08:22:58 +0000
Message-ID: <CAMgiTmbWu1MGutA2KRTyBx5SvZyWNCLxtH_Zdqfxz1Tg3kocnw@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr. George Levi
