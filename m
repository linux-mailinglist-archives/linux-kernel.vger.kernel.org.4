Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3E6D793F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjDEKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjDEKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:05:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0349D171E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:05:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c9so35464138lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680689147;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=RSS8/RKlSvc304T0TO5FEOz3LhPmNXbE1doFI+LVa4dzj4qQMTwj0AfSCy8PVnJAPE
         RhQwb+is+jBbBXS8EYUwCVRZoVlzGLdQCqXVEHD1gNf0bj+3ugtZbsmG87giep02AeFN
         8WcXsXvupsXBqEKHCtgpdaTOk0NfeHx/0sYjgXE+l0CAaGbDIpaS8sbvRFfj7avkimdc
         6rNzRjWwnP6UfcnLAmeQNXWsKnUzGfXP6T9R2YzDXauSOh95xDFwjLkPG0io+dZ4biof
         YZy50dcLNK4oEjCzsnacWnSa3K7eocRN1TTUhCMlwnDSdNGDxB4n78TwjQUiq7YGYfJO
         9XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689147;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=ToRypZExp+t5NelPpF2SR6f2nkzRsBcR5czQhqP6FimLn2+Ty3yuoDDrhNT6NIpPUw
         +8sW0B9IIvw5m4piBgvvsatyo0NqB+P8YSBz8ZjTL/puND1GcJSlOuAyv9pSS72PC28c
         CMM0/tiQvknGqit4WkoWg6bPod540DhVy0a8RF3l3rpMd9P/8hPcfkdkxPAYzUw9eiBT
         q5a62IFnMBfnmDUG0nQhDQA8RY98a0ZfiTomsPIsMzt9wL4oY4vMH58vLDu+ENR5hcBq
         AHgGwYqrrYFYRUxDWahjsw4v9bh0XqxDfHuGOPbfLT0W2B5RMlan5B0VX9d9jKwt1EZz
         yWnQ==
X-Gm-Message-State: AAQBX9fgDUqmNXCKAzgNrdZuRv7p549BZAVqSdPLwP4sQFaUeNiuvpUr
        Mv5QXAZiNKvbFXyrtvMxIMvT0wYwgjttYb6y+54=
X-Google-Smtp-Source: AKy350bmwc61lWQ1dww09QmL6YQ4ROjcd0J2u/9fAxu1nbd2NzwhvyfVIcKyrimiGvqdJ/11xuOTNUaD65LjoJiv2IU=
X-Received: by 2002:ac2:44ba:0:b0:4eb:2643:d5cf with SMTP id
 c26-20020ac244ba000000b004eb2643d5cfmr1679547lfm.7.1680689147046; Wed, 05 Apr
 2023 03:05:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:34b:b0:24d:cf61:2e9f with HTTP; Wed, 5 Apr 2023
 03:05:46 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <harrykuunda@gmail.com>
Date:   Wed, 5 Apr 2023 03:05:46 -0700
Message-ID: <CAKN7XSUKBhWkL5MBFsL-3XBkr-6VcwnZ61o41Fmy9dQMhZ1R8g@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
