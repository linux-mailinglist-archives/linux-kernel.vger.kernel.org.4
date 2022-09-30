Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431135F1090
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiI3RNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiI3RND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:13:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC272CE13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:13:03 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id de14so3062304qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=a/4gJxYFUflekDqu/7BIxC8IwRhmkcL7ufJZYwUJhJs=;
        b=Dzwvgz+INUq6K41Sh0+ApmLuGNcdXSy+Y9IBlC6FA6GN+rYVqnu5EKPCHoQ4/GvLLf
         QO646Uh39ENbwJDsvmdBUOpupobUsPPGOaqLPY9g/0uSDEDZmESocakqfYp4whVZKXU9
         UMQ5tvrQX8Cw024GHsLZII6wpQqXvQc3UT/bivOrwWxqijVlqJhC3XvhIHZ0HxzNSDL2
         QpPJmwj2FKOvO5fexV6wScrdFpWZxAkYuDjnb2b4zKawuC9i7SN110D2XxLyJAliev4o
         5Hss8AX/K86sHgGNSKR6Q1IyCtrKXjfHhI0nBxlLMS5cn8NhnBnmkCyxIFfqivBgNNWi
         V30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=a/4gJxYFUflekDqu/7BIxC8IwRhmkcL7ufJZYwUJhJs=;
        b=PxiMbRueNhcXSyH9M3U11Qea8IybzzWGLk3JBZ2iruPxXWwSDdTvtyVSLK4pT9x40K
         tmIdSBTKTKSQyRhCSB4NLiMx0m+Wjjuv2W/MkWaSwrH0Lf4gkuRMBkoxM4EFR17OJryM
         O08zHVUiZXP6JX/exdKQJT8lNswHgqsG491zYwp3LaU1QfD3mfZFCvl8wviBm3YpP8St
         6e1ZdqvfOmJKNOxfW/vnlcob143CM8zcow8cvsjYfUt/RvgKiRuvcRAWYbLYSatuYCvE
         zzzNR8Zvqya3haKSyWNQiDBemFu6MiLHgi+LjpfKpIcUUkqVZQjMUzHoQjC9Qu+lhBow
         8Uig==
X-Gm-Message-State: ACrzQf0G/nPzIocw8gLv3ixUEDVbu6Dx/6UKmPVSf5Jzn5YnBJyK4HOd
        6hL9dNQ17LrlN3PdADQ5qv6y+raGGsSoKC3Oj98=
X-Google-Smtp-Source: AMsMyM6vQnD30FufUrh9ULQ2BSP9Pdmw+JBLXjvupp6GfZv0aGwjG6KVBa9820uMHeMfkkVV92WKSuvHDD1X0C+cIQo=
X-Received: by 2002:a0c:a953:0:b0:4af:a643:dfc with SMTP id
 z19-20020a0ca953000000b004afa6430dfcmr7791810qva.10.1664557982198; Fri, 30
 Sep 2022 10:13:02 -0700 (PDT)
MIME-Version: 1.0
Sender: tboukoupoub@gmail.com
Received: by 2002:a05:6214:5e0b:0:0:0:0 with HTTP; Fri, 30 Sep 2022 10:13:01
 -0700 (PDT)
From:   Tomani David <davidtomani24@gmail.com>
Date:   Fri, 30 Sep 2022 17:13:01 +0000
X-Google-Sender-Auth: h3-7oqbq-qq-IQhbI-PqmBQbJxs
Message-ID: <CAAzV-q_PZDSOubKgZL0HTF2DZaRCCKgxZfhWGcg7GY-CzuC0pA@mail.gmail.com>
Subject: Opportunity
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening,

I want to discuss a business with you if you are interested


Regards,
Mr. David
