Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850D063C6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiK2RyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiK2RyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:54:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7331FA2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:54:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w37so8588651pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qitdNdoWFK77PTkbup13RoIosKIGqVfz0nBnhxBb2sg=;
        b=o4YhWzVfdQDyNBRHyDZQa8SP5jKLzbVxMPwQDlRhwTNtyD2N8V/kbdHxJ/rkT5nEAR
         T1GHVWJextVuJV4gtYW7bWh4Z2ZLtYBrqDVVvBoQNnp+zgGrfKeSW91VUJM36ebf8c3m
         7YKnjF9k9hvlWS+Or4sODbAA33mGQeZiMjs0hUGgDR2DaC4cBuled8qY1qgnKpPDF0jL
         OlAsC1fBZvHas8ib3FljfhyHCp9rqqT5OqFxHKjhpiBaUgjpV7YQfq4fVD111u40e6oV
         cMSFQTI0uS6phWua0RxK3CPT5eGplHH6oMvx0jPgou+F79pCtLiA3hEiXoGLLsJJrn8e
         DvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qitdNdoWFK77PTkbup13RoIosKIGqVfz0nBnhxBb2sg=;
        b=M1WQWucZ5fEgGrWYJTnGEfi1OVIhVXYPJU4hQttr/4pe6POWfB1W8fJNOK+Bk5GS9n
         F2R6cpoprrCePrLedXEtC8Qmv2XIC45mNCx4WyGtA/HbSkygUdQ25d1f28yJbl6PruEB
         bvuq9OtzPwJwPo6a9Rb8w4w38N+6HCrq41TxSatYQqK3fdynfK1zkfci+JQpE12Xu5JN
         Wgh9XCIPt8b+hysvnv3aEU+qZx79JMt4u5t4haXux7JfT1czPTiOPck8k9CrnTuLty1V
         tmuZiYxgqvVlNJpTkvsbKkmR9p49BteyRq3E9Lwnjr8cDbfhQJURFTwsB6mSUpCtx5YF
         ISOg==
X-Gm-Message-State: ANoB5pmP55IWUhEuR0xPSq+ugOeI2BxYEymhXMCQ9GKQWFVXU7TVBla0
        PFli0vD0ZGGm55FC+8oP7UMYhQ==
X-Google-Smtp-Source: AA0mqf4cmkfnpNXAQAhHq3NNXJSSir8VBvK8yiYQOSrkWz92BdnG+6po02lGiPyFovC/HHgLMeTvCA==
X-Received: by 2002:a05:6a00:1309:b0:574:53f6:364e with SMTP id j9-20020a056a00130900b0057453f6364emr32340887pfu.36.1669744442729;
        Tue, 29 Nov 2022 09:54:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p9-20020a63fe09000000b00476dc914262sm8667775pgh.1.2022.11.29.09.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:54:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de
In-Reply-To: <cover.1669736350.git.nickyc975@zju.edu.cn>
References: <cover.1669736350.git.nickyc975@zju.edu.cn>
Subject: Re: [PATCH v2 0/5] random improvements and cleanups for elevator.c
Message-Id: <166974444194.89148.11573998418431805722.b4-ty@kernel.dk>
Date:   Tue, 29 Nov 2022 10:54:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 23:46:33 +0800, Jinlong Chen wrote:
> The series slightly improves the readability of elevator.c.
> 
> Changes in v2:
>   - add patch 3 to further improve the readability (suggested by Christoph)
>   - add Reviewed-by tags from Christoph
> 
> Jinlong Chen (5):
>   elevator: print none at first in elv_iosched_show even if the queue
>     has a scheduler
>   elevator: replace continue with else-if in elv_iosched_show
>   elevator: print e->elevator_name instead of cur->elevator_name in
>     elv_iosched_show
>   elevator: repalce "len+name" with "name+len" in elv_iosched_show
>   elevator: use bool instead of int as the return type of
>     elv_iosched_allow_bio_merge
> 
> [...]

Applied, thanks!

[1/5] elevator: print none at first in elv_iosched_show even if the queue has a scheduler
      commit: 7919d679ae09c0dc30dfecb7cbc02306cf95cdd7
[2/5] elevator: replace continue with else-if in elv_iosched_show
      commit: 5998249e3238428156b09911f1606b41113443c5
[3/5] elevator: print e->elevator_name instead of cur->elevator_name in elv_iosched_show
      commit: 7a3b3660fd30c028e7ae1cd82697933789962406
[4/5] elevator: repalce "len+name" with "name+len" in elv_iosched_show
      commit: c6451ede406b9f57fcd61d48433a6b8b2be862e3
[5/5] elevator: use bool instead of int as the return type of elv_iosched_allow_bio_merge
      commit: 8d283ee62b077968e218531b24260e1cc51bd484

Best regards,
-- 
Jens Axboe


