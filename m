Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7364457F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiLFOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLFOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:22:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F317E0D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:22:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b13so12973154lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=NF8TlyxSWNg4rBoL086m0UfcQezyWeWZwbYOqVDMXEuQpbYqAVjdBduB32nsZamIvU
         ZFlGdVn1rR57rTF4I2obbhVv/xWkAT6YNI+pzVqYDs0gQ5SiC52gyXKeeIPxbglXV3qv
         csKeqVHz4BVUAcTnfdmIuybrf7FQ4mHUMME4aCkLkSb1O64qY7cPO5Z4tExMNhKMkqGt
         Wdiyqyq/G+ZEQSFVfZvjY7aiHO5qiHMoJdZzIMBs/y6dxKiIUYoD0MUToCthrOkVnfnU
         gxJBQKKX1fGx7VGKbFlw42NlBIw9guQQPPFsnJ/Gkdr1gOQQjIryWl8sPSy4qJFUabrS
         q/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=dW/tcXLhP38jRvlM5uUzIoals0mrhNrfRuFZz1iUg4b7Zmt9Q3xlPs0ehl4q5JKjy+
         rsgV4QOJXm11+bhY44qZmMHKB8oZfIOytCvOG6MxgLz5eaYzCYgjnIoYPaG2q7nSZMjC
         /FOUxNeM8oxqTWg5M9cxoaJysV1RKom9C1fXK3GkWwvm0X4WB6oYfjL7jgjPbC0seTQV
         MEEgutXMr1Sfh1RWGXjI6hsQ9ohrH5lRj3LPbNSYT76Qh9FCAfvliEYjmatGiBgNZUYN
         eLyc6fqM25wAUlSW+3MnqvvxH2LuixEQjtbuQkzF1JhzBXzl1XUtGFXhmCGdjQx5pgpH
         4F1A==
X-Gm-Message-State: ANoB5pmFhH1+YBGJGJ5ZCku0Awrq9qOo1PAWeU+MIWDSCZb1XyuBeFeu
        r9v2mHN15Y1x0WxrDLkzbs7IbaDSD+Y7LmBuACw=
X-Google-Smtp-Source: AA0mqf47x4713HIG7qprRcEH8Fk+xLtaL1QiES8eNdLUw7isMZHZGsyOlGGZ5VvyUhjwMc2JzIsAZSJkDRFtgcRsALI=
X-Received: by 2002:ac2:4c02:0:b0:4b5:81f7:e34e with SMTP id
 t2-20020ac24c02000000b004b581f7e34emr1617006lfq.178.1670336520468; Tue, 06
 Dec 2022 06:22:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:2114:b0:200:b7a1:8e5f with HTTP; Tue, 6 Dec 2022
 06:21:59 -0800 (PST)
Reply-To: halabighina00@gmail.com
From:   Ghina Halabi <mimidjokoui88@gmail.com>
Date:   Tue, 6 Dec 2022 14:21:59 +0000
Message-ID: <CAB1C4+6cZBH8y0Ce0+J8_9kG7sMcfoahr66+FxyuO3E2kbcFOQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello good day,I am happy to be together with you, My name is Ghina
Halabi, I am a military nurse working with  Israeli defense force.
Please don't let my profession, race or nationality enter your mind,
there is something very important which I would like us to discuss.Can
we talk about friendship and partnership? please if you really want to
have a good and prosperous communication with me please kindly respond
to me positively.
