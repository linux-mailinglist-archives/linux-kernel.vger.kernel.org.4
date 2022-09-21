Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4AA5C0008
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiIUOhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:37:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483A923E0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:37:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c4so5203542iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=mPWKdT/oYHmt9PhKT29Toqie2r6h5zJf6nuVtODfrXg=;
        b=3sXqh6t3fCW7INBuK+TVhYPgguVNCXBXezOxTvO5SKvHWVRaFGf2f/b+qzfgXYAPGk
         Kt8aeW5eJXGpEyceTdFH0uT4Jn2BeivaxhW+QEcwIf3SQcmrq3+9tMgWoa2XA19AnM3/
         f/7f5iURusIR+fzKSeOsBH6yjhcQIdXtJ+ijHlC97rj5OLEKGaj8YGq0ECTfW8BAJ1F3
         AnQzaIqtwQMzw3MJ1qaP5YkqkbKoRHjwE2YYZGVcdMf7dR7wZY2WrMODUBqcmfKYGazC
         WUgUyEZ+rDRvsJLcekGppjVGCw7m0xcNysgOowT1dXVQkPfUMb4+9+9F8zpt8G2kVAX6
         hQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mPWKdT/oYHmt9PhKT29Toqie2r6h5zJf6nuVtODfrXg=;
        b=GoiP0TYrZR8QTCt2CzNJu+98nWLSPd8vNxOwf5sUjIi2AWQtV7cXn9BJF9vxCB1plE
         hsb6wTttTi+7G3c+i9ny5npv4xXQQgEaEn3mpTbVpwe7jCAw/68OnDGDE01k/0ZemgOb
         hOZ6j1Tdi18/GOgCkmFAoPbJb8pQcaulFj5AmLgFXn0yGHSxSSHmlAxw2dMti2ItIlQc
         md0IGA9E0ScrM7WkhWYRMU2LGXC0CK9AUo2VoPejY/nxZBSMnheJNlSNAZPDTsTN0ZLw
         K8diMP+WIRzcTsWM/HYcmdZE+q76l6dzVqNoyHOxNoiVGS8xwYT9v/FOyR16KNp8NhHi
         X8cg==
X-Gm-Message-State: ACgBeo0hibY/ZbX5Y82L7657yeDpPo3jgOO8Uc3tRJApe2dfRwapiqcj
        4FGrnAf7dkUv1zb+jg701HJG1A==
X-Google-Smtp-Source: AMsMyM7MQ015nRjgxJJCp8yGvBRBxjj5nfEfgGLFW6r9J2vDDssaHSQ62g3vMoRv70jD6liOBPB77Q==
X-Received: by 2002:a02:cc83:0:b0:35a:1461:5be8 with SMTP id s3-20020a02cc83000000b0035a14615be8mr13445784jap.32.1663771030205;
        Wed, 21 Sep 2022 07:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k4-20020a056638140400b0034f465bbd52sm1125880jad.42.2022.09.21.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:37:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
In-Reply-To: <20220913105749.3086243-1-yukuai1@huaweicloud.com>
References: <20220913105749.3086243-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] blk-wbt: call rq_qos_add() after wb_normal is initialized
Message-Id: <166377102908.42944.10712630540231766457.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 08:37:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 18:57:49 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test found a problem that wbt inflight counter is negative, which
> will cause io hang(noted that this problem doesn't exist in mainline):
> 
> t1: device create	t2: issue io
> add_disk
>  blk_register_queue
>   wbt_enable_default
>    wbt_init
>     rq_qos_add
>     // wb_normal is still 0
> 			/*
> 			 * in mainline, disk can't be opened before
> 			 * bdev_add(), however, in old kernels, disk
> 			 * can be opened before blk_register_queue().
> 			 */
> 			blkdev_issue_flush
>                         // disk size is 0, however, it's not checked
>                          submit_bio_wait
>                           submit_bio
>                            blk_mq_submit_bio
>                             rq_qos_throttle
>                              wbt_wait
> 			      bio_to_wbt_flags
>                                rwb_enabled
> 			       // wb_normal is 0, inflight is not increased
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: call rq_qos_add() after wb_normal is initialized
      commit: 8c5035dfbb9475b67c82b3fdb7351236525bf52b

Best regards,
-- 
Jens Axboe


