Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5466CE93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjAPSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjAPSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:14:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC362B0AE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g205so4455186pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUThk+A2NPDO7+1yWET3Dp+/IOwZbM2+REhhiQMAGAo=;
        b=PQacTKx2uULp3FlIoZOF630hD/tc3DZ88f/1CoWVqhGc/sODsb9ATqIqzhrZdndv5X
         xP1hS4RthofTGpUROHAHzWdfZmojirA655/tuugSFrRMkOsN6szJt/8TXB5S2pade7cF
         T/2RhAPSYInwrK/Zh1dPmi0/YMD+8PBg7J1dpCGEoRKYuqzVoqwtRn0/oW7lsWLfj2vM
         xc3U4WNoIqrIHTRz5cGFqPAsw4gw7Ehj/Gu1PVgc5De4AmKhp7toDcpmjc6KkC5mQlxz
         nylQt4AYCMuXg8QB8iFei8rNABXvPe6gwInZLJLabo6E5sIZTmfWHlryN3y8b0B9CUAD
         RSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUThk+A2NPDO7+1yWET3Dp+/IOwZbM2+REhhiQMAGAo=;
        b=4zcK/StU30CcpIAGbO6nCsfV+yS2hpM0/CNAqM0aI7xRexV5eWELMQCNGvo0rRgryC
         SW2ZJM8uGupGj6dQ2WxyVDJqV9zL1JVVFWX69SFDgyKhEakAL5TZoJx0tbFTQjMHPow+
         Hb6rELSzfCJccDYw2W6CffvPyGeh4XNRY6x8yqWkO9nMJTzD4RWIxppiPzQ8DY90g5Su
         pAf0GIA/+ie0UV/tRYYUMBfy8FWtmzl3yP4lOtR/7s+UVvVOwrJC9nznAZtCmezmSbxb
         GiKz4NnD1sOitHOmnsNoKqruXdFzmdDkWp2a9K2GcAB70p2AnCRiWkGluBmgx8UjI7fM
         Jzgw==
X-Gm-Message-State: AFqh2kqZW99h4Tp7EA8mzK890Ej7NkOftZpi0ag0mPGT3xGZe9iX0WFl
        6NSy85oH0qaZAccUakp8Jz+5r/HoFAZqRU6w
X-Google-Smtp-Source: AMrXdXv5pgb9vWqU7+ifee1xFN2J/GODbUegb6MgCnye8aGNQPoC+pksX2u240aZMDW1TnLmCbNjYw==
X-Received: by 2002:a62:1c8b:0:b0:58d:995c:9c25 with SMTP id c133-20020a621c8b000000b0058d995c9c25mr106894pfc.3.1673892082674;
        Mon, 16 Jan 2023 10:01:22 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79593000000b00582388bd80csm18508738pfj.83.2023.01.16.10.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:01:22 -0800 (PST)
Message-ID: <8cea8a30-00a9-89aa-704c-44e4c95a3b51@kernel.dk>
Date:   Mon, 16 Jan 2023 11:01:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] WARNING: refcount bug in mm_update_next_owner
Content-Language: en-US
To:     Jann Horn <jannh@google.com>,
        syzbot <syzbot+1d4c86ac0fed92e3fc78@syzkaller.appspotmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e259c105f25c92da@google.com>
 <CAG48ez23_TUMENLmi5X4F61vb6ZNiL+mfz6YE96U4Y7bgvYnSg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAG48ez23_TUMENLmi5X4F61vb6ZNiL+mfz6YE96U4Y7bgvYnSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 10:53 AM, Jann Horn wrote:
> All 5 console logs listed on the syzkaller dashboard for this one have
> io-uring with IORING_OP_POLL_ADD somewhere. Could that be related?

It was just due to a buggy patch that's long since been fixed.

#syz invalid

-- 
Jens Axboe


