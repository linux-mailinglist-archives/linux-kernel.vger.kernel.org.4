Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8A64455A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiLFOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiLFOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:11:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3313E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:11:18 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r72so4699727iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMlDyl8xoMVyS9vOKhl4zFJwwW59Re/QReaiJ137YPQ=;
        b=QKD5i8byZOnQ5DOLOhkLhE8VqyB+FMM6soJR5KwSgwcUQtBQTk9TWEl9QUJNbJIUwL
         Y85op750EBZ4nQTCkU8aHN7qMN8WtnkxwCVHaMCmbFWGR5nnGT/030IJrBiU3p86raa3
         oBglq52DuDD6EWGRwW5pAaTE4GZuT0jHnxuJ9dEs+hC/ezsq8wSSAUw/jwI/UuA8GPuQ
         AUCFl3hJc5UGpylvN9ZjDST4CpjWel/+Xpg5rka4rBySlFgcR4Z21lyLHR91qbwIJ+VO
         Hwpz6qE0mtQg5njc9IlUG5qSE4kaNjUFQVACmd90eZ9d/2I8xIgVHwD5XQMJIYzo3Bti
         zafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMlDyl8xoMVyS9vOKhl4zFJwwW59Re/QReaiJ137YPQ=;
        b=y+rqk8y694zv21Bj2ez5zgGQN/DvPyvTE93fJsE9mONZkaXxk0lmQFLQzJ0DjxYX5I
         MkBfb82vPzIK1KmC1G5EUlLt2rH0FoX64hcgqsRYPKM3fVKUY3kiRWZ9WJYVCdV9VEby
         ACJeWH5P8OzWrjWxVWa7V04DOp/bEw38mOa32RCce3wcaTBUCZqc91ylRSQ7UugGZbsu
         Xq4GOpaAHeDBPVAKaxOeIphZ+b5yR2Vm8zUgG0/0G7W91QIEdUXOgaSf1rP9oMkZSRZB
         /SbuRgoMCf1ndGsOBO/iurqZCrbZhZkBmH8IXqaWETmMilALSBWZpGqjTcZxMwpT65Bp
         1iWA==
X-Gm-Message-State: ANoB5pk/vfdXz+9TjoQZ77i463mPGXn2Z5P+pUBLUjZ4NYv6vSLKh/SZ
        XT1k9oL7i3EjBz97lF1I56Km5cD4tYjzSYOy7D0=
X-Google-Smtp-Source: AA0mqf54BP6LOjz8vXRTPq7VDOdTWhgQ8QZO57cHFgcJJMugfShXCRd4dmOY8xV8MxUlfuClsYiWhOkPWP8ZnvffSls=
X-Received: by 2002:a5d:8741:0:b0:6cd:6e75:69fd with SMTP id
 k1-20020a5d8741000000b006cd6e7569fdmr33265906iol.49.1670335877398; Tue, 06
 Dec 2022 06:11:17 -0800 (PST)
MIME-Version: 1.0
Sender: awanriasat35@gmail.com
Received: by 2002:a05:6638:3455:b0:38a:3ea0:28b8 with HTTP; Tue, 6 Dec 2022
 06:11:16 -0800 (PST)
From:   Dixon Elliott <dixonelliott74@gmail.com>
Date:   Tue, 6 Dec 2022 06:11:16 -0800
X-Google-Sender-Auth: nnBQO0nfoc3xoIyJgD0r4iqZJbs
Message-ID: <CAB14TvPvXQn_2nOqoKo7+Ar4Gh9wE_6OUfMH_EpKyJVaZtNMqQ@mail.gmail.com>
Subject: BE BLESSED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am, Mr.Dixon Elliott, A banker I have a very confidential business
proposal for a $9.5 million transfer that will be very beneficial to
both of us.
Sincerely

Mr. Dixon Elliott.
