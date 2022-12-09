Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1164812B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLIKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLIKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:53:11 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49DEE19
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:53:11 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f139so4797160yba.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=RQAPHFcgVL9l9cHsfz6VGkw7gyneIBMYACTzm9Pp2YatqtLZFuyBUzbM1bnPUfkSCS
         kfDy18gmDS/qQigwfwf0iQdUo/ozDOIdPOhhDZKwB5NMTHjlkPKZ1kX4AzH1QNIMd1gp
         ux6fUntohdN6Nds6BaecZQdrBgW8LFa9cgtiTiiNlg3MhCJCoZvoky9V66SAUp3x8Lqj
         mrXRxkBWW5f0W9e44SpJQqyq1BltSmK7B6DxMNjUerOe9itT/8wWExOejcmKILIwKXwp
         GMiUvOOB/IsPNZcS8r4ay31PUN4HHiMvFEY2dkPbps3D7RGDEaVUz18lF+nVDzEvtnhO
         Pwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=CwGULRm8e/1wdRSHQdvKmZfhwgCWdLDOIQlnMXZFeDkwz4QJfK0IZ6bSRu9HDJKKEY
         1+Z0xbFWt9ltTQCXQ6p8UryD3B68LylHwczw91rBkiftvWIgDNpDp2MoAtAW2u46MRGk
         xJJvk3QKQmDfbmvew37QV44TV2DpiSbzmV00H+6rXXedAoRXdG9ZTI2OnZm0b5U0whzH
         Rl1TJPOwR/mNcMh8gRHzFV+Cfq67hVpwjDpLMgehYC2N4Wi+M6PrjqqbHfyU4/7dz/1g
         NbgO0xmnRSZRl5plf+5GyZDCsS1D9vL2XpasnqRFZAqjBjad3RVweKqztB1ugyWsLA6o
         INyw==
X-Gm-Message-State: ANoB5plzdWYWRAAsO+B0KFNgneIinJH7OcV/WQIRkNXAcUZwePyDzTBd
        bBOrPqHaR2UZZrObxUwWmIand+gHyS6NHzDoA28=
X-Google-Smtp-Source: AA0mqf7fh1oUEW2FZx+yzF6V7bVbF6skFryhrTwgOcaJ7UHhabIKRbldhZwY6zycymfowCDEDUyKnSejBFLty6/bvFo=
X-Received: by 2002:a25:ad21:0:b0:6f0:1111:53c4 with SMTP id
 y33-20020a25ad21000000b006f0111153c4mr66925967ybi.121.1670583189966; Fri, 09
 Dec 2022 02:53:09 -0800 (PST)
MIME-Version: 1.0
Sender: mayi.francois1@gmail.com
Received: by 2002:a05:7110:11cc:b0:1a2:b42c:9226 with HTTP; Fri, 9 Dec 2022
 02:53:09 -0800 (PST)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Fri, 9 Dec 2022 16:23:09 +0530
X-Google-Sender-Auth: 75eAqwTMwgXZZOa1VbNvVxPtTE4
Message-ID: <CAFkR3GrmnF1Z-NSnd3_vvAEB_4YGkLZxfEyqobo47=__n-bsQg@mail.gmail.com>
Subject: Hello I Wish to seek your conscience about something urgently, Please
 reply this message, once you get it. Yours sister, Mrs.Elena Tudorie Email: tudorie_elena@outlook.com
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


