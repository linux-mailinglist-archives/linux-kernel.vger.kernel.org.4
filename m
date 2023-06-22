Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15527396DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFVFft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFVFfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:35:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE3E42
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:35:45 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1ad1fce2594so992554fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687412145; x=1690004145;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvhaGZOk6FnPl06sm3mW0Yfmju/nBEVwpPi4Wu+dVVs=;
        b=euTfQOV5zO/2BBwhbs1XhZN3Y8Z//NSK0FFtcS4dXAWOqHAFzb3Dxaifp7lkGzkiEd
         Wa6vX/eMrY0/NquRrS8gfw/e3prIn+QiCB7r1Mg3GEpwWltVo6v93tsTyY8pPK7sHYBd
         DjIq6Ud5N56NEFK/z/XO5TV2Ie3fn0FunF0wEZTpVOhnZvVRXf55qA+jmjDGH+1fxFu5
         v1lPqLpSseWse11e3F4M1xdmxgqGHOBGKp3K7jpAIgWA8kw7C5lbR69TQzdmX5aWcsPK
         KWaexNmn5KiGH8OmgSgqueyDRHV8QVDSK1mAS2LENw5nQpq13njELc9725k0WkCxO+RL
         XJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687412145; x=1690004145;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvhaGZOk6FnPl06sm3mW0Yfmju/nBEVwpPi4Wu+dVVs=;
        b=a8G1lF73+0i3HoS6bptU/s60dAWKFEYMFFO6rsoL4Hf2tNSyci26v3O91+ECJCK/eJ
         YoQJuo0MEsUBB7u3o/OUWUtJhP6TBjcstGrsCzEvq0kUJ01bUnr7mc1GeHM5C5O+htKf
         LYap+/Ony/1WN0ZkBGIipfrGC7EYq7p16kFsZ6UGVPhd2s0JX99wwidYeR8Jbv9Ksdfv
         +mC3ytIUUF3W6XLPeVefsRTZsffX6A4EMar1ZLf/dFHshUcnmqAj/tth78CKQHEyIIy8
         vCpGPx/zwU39m2D7h8GRcs1ThC/gBacyw/NjLVceDJrFKPY6fSt0/xMZwBNFVC78WjCY
         aR9Q==
X-Gm-Message-State: AC+VfDwdbnuTxTzojmBqpH54OSEVZvttzPc3O9xhF0k4tT7X1IDgZfN5
        mOV5mwekRZpWvXCp6dIjlkC4AkTAb7McfcylH1I=
X-Google-Smtp-Source: ACHHUZ6+5x5QitNBB10f9WgdIBBZtPswgkvBaMFCwz6zzjNZRktnWqAu5hqaQYLTHIpmSLpJGbqha+uBzO3F1HsY6KE=
X-Received: by 2002:a05:6870:d451:b0:1a9:8606:dfcd with SMTP id
 j17-20020a056870d45100b001a98606dfcdmr9029247oag.0.1687412144928; Wed, 21 Jun
 2023 22:35:44 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.qamarmuhama@gmail.com
Received: by 2002:a05:6870:2214:b0:1a6:969c:2700 with HTTP; Wed, 21 Jun 2023
 22:35:44 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Wed, 21 Jun 2023 22:35:44 -0700
X-Google-Sender-Auth: dPrNh7oXC7IDXpzfFxUV7-uRmcA
Message-ID: <CAJEdJUjhRgrAAXrZDAyB870r3G6zK6iFHOjOKctf4QWqTsPmTA@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
