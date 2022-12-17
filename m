Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B944264F922
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiLQNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 08:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 08:45:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7814034
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:45:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s5so7148669edc.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=EybnespfhckJdwa3Vmv/K5oBKIRGXQ155GfKFc7lYAxbzllgB5u6UZ77CqKdnNuNyd
         cc1uKFhYQffF1qz4txN6Vh/s/Xzy4Wrjq8oGoAUQn0m3CP5jHjFo7QmijXWRP6Ek+La2
         ZmWwWDn0RaFRCXBpgbM6e9e+eb2SxKu0niOB9pWf/iHu0uyzTj8fC5LXe71T7Ai7mrEF
         VeyIqjFkHUXgUN7BmnWKUz3J1nBpVhXliW4pqYJ0L5S1YwMo1ZpREMrf8KhWLcPxCjtV
         06ISUAci4OWIlPMUhMKNUmb6PetVRifFUOvKjswnHnzLoensbHmttbm5eAIP1rqnn/j+
         1KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=au9hgfzj8Pp2/jYvZdnZcZjvn7KPcNZLKyf56B9nElxiNZC+5PpyFsZG/z42gVLuQx
         PLmyoqOA31/U7eMkHhJ6GxT3vEHlQDT+jYFE6b0X5RWHElu4cj0JJ8eb7cP8yBMHnnFr
         F1fd/ODhPW128rr6jBE5fyEFQbNZThnvnItDhSduMmWC0KnhO70jNi+aoHJpXjXKG2Ab
         Kq0lkVpfi1apozT4KKys450n8h7OW2o6/e4TniJBc/KjMi/B3I1LGcSNMBaPzWBObEQ9
         hhVkTEl9W07vGenrj9gJEJ8gZEt672Zdsxs85Lh92i2TitHKdY9WroAKRBy7bA34HD25
         m/ag==
X-Gm-Message-State: ANoB5pnvgKsxWIYcT2iHfzZIw5zA17vxbj5jiSdoaIRYVnWQPci7LPSs
        Nn2OIcT8Gpww7UpWPJABjGZM7Yws27JG61pr4Pk=
X-Google-Smtp-Source: AA0mqf59ZkuW1OoqFBNMu2s3cll2mcm/5rmO/D8XqOCCoeSvcCVY9gUVVUt48/bdX/5lykq8o5F0OocMomY6iDyE0yQ=
X-Received: by 2002:a50:aa8f:0:b0:469:c5cc:855e with SMTP id
 q15-20020a50aa8f000000b00469c5cc855emr76391177edc.307.1671284709178; Sat, 17
 Dec 2022 05:45:09 -0800 (PST)
MIME-Version: 1.0
Sender: noureniouroifa@gmail.com
Received: by 2002:a05:7412:8412:b0:8f:5ea9:b82c with HTTP; Sat, 17 Dec 2022
 05:45:08 -0800 (PST)
From:   John Kumor <mrwuso3@gmail.com>
Date:   Sat, 17 Dec 2022 13:45:08 +0000
X-Google-Sender-Auth: 80AKfkVh1QbD8v3xX-1SwElK6ho
Message-ID: <CAGUuoFAGofQi5vB6toZqRs+i=xTFm9G_FteigTb_f3mQS3NxAQ@mail.gmail.com>
Subject: Kindly reply back.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,
