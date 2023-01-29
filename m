Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9D67FD1A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjA2GVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2GVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:21:50 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E591ADDB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:21:49 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id p19-20020a4a8e93000000b004fe1e423feaso1041437ook.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=hLKoaemI8qlFcVOHc0CdHjfdGVc0fY9rGLZUxpptHD+jt20JxU/T70o9r+2vedM6RH
         8PMuWxjiGdaSmsFeebk6+VHQ3ft4gF15SxUP6SQpgc1wXlpFZBBfoU1rJrG6VPrK/xY1
         IqG931xrQc2lKhr/YPBlPGNHeA3cjACK5fiYRvCQ7pMT5lgNU9VvDHlqt7I6kNhr6sxj
         fdidu/3sogg5/yJyZtmmJK9tPI4blY4e1BRsuQ2mfizKe0z3O7l51NreBjXRSw5zdPmk
         9WZYWTz4iCuvuoGs8guIG3qkBFw+l0lFc7RWVkFOQfaljqQeE8helmifBQmdqknt3hJi
         cIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=6MuD8p/2m+wqz7AW13C9nZSr6KnZdmg0ULDXraaJZRePf7AvFLBIVIq5lmSeeRUuzM
         N3JiCOStqbNKOpP54T/IbCBUVOp2MTSQeyf6Ks0yBngwpZAKmWWrhUlyE+dULxGK5uEL
         2/frTHB2Yb2KlqlZ3ji0YoplKU8y9cidLXzK9qYdBKJuOFqWJehE9bEaz+/N0v9K+B1u
         I74/4jxF961X+EbnH+/6Fo8Vy4hDiW5dKmP3mqrQNTQ9hzQpQ5V8GVhBDgdosfOkHgYY
         HvyU/V1qiFl+IMfDCtJ5e+uSEVPRbpM3PnTOOqcTARS82wT5ZqURmLc+K8CzQzZok2qE
         7XRA==
X-Gm-Message-State: AFqh2kqyzTDuW4WKGQfghwilHaO/TvXTii7Nrxc7WA+TdtUuhwvxsmCJ
        s6gm62hJAWSgBIvnY/6cx7aHKB6Zg7E+VbUluQo=
X-Google-Smtp-Source: AMrXdXtM6HyM77ptahkDwohKsDb1tJ1mRKOhEcHjLj6Y8g4dZ56OZi5m07+tyOBqg8JHakJIWKC+C2EKfHzz3gCOiqQ=
X-Received: by 2002:a4a:b086:0:b0:4f2:45c:7b9a with SMTP id
 k6-20020a4ab086000000b004f2045c7b9amr2051661oon.46.1674973308305; Sat, 28 Jan
 2023 22:21:48 -0800 (PST)
MIME-Version: 1.0
Sender: nicolemarois55@gmail.com
Received: by 2002:a05:6358:418a:b0:ea:3bcf:c6ec with HTTP; Sat, 28 Jan 2023
 22:21:47 -0800 (PST)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Sun, 29 Jan 2023 06:21:47 +0000
X-Google-Sender-Auth: bzGijMyucs_xjnttttCrT5Xf-jk
Message-ID: <CAH=VPVMo9yiahJkg2k8QA5yW0GFzNv9GagGtmULRAwME7034ug@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share pictures and
more details about me as soon as i get a response from you.

Thanks
Ava
