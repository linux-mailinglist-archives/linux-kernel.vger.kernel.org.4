Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43E73EE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFZWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjFZWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:07:04 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23D2120;
        Mon, 26 Jun 2023 15:03:26 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6682909acadso1810878b3a.3;
        Mon, 26 Jun 2023 15:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816975; x=1690408975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCoCOYjDLNke2rP949BWReOPXfmEB68n0cAwCJbJEkg=;
        b=KpOAlT4H6P0NesfVSPb/pCXK3FQHBu8fe4XyiHR3qBx4Mqdl1e7XRi4Juy3C3LNxeR
         Fi2FebYHqCU7X4BCxfXyifsrQGjP2fipd2DyPJZw6z0xkczGIZCJ/h8YXZDbqQH+z9rW
         bR6ajyT077kQ5NLSP2heONC8XEr8mZX6naQIqnDcfVv6EAj3N+iZyuuGqiwwZ3YhWYnw
         nAz+Wy7WiNuRbqHM7vxfORRICCN6CbZXiIwFxB+2Mlf3Xg+8QeoWsWvyQG1zErJZUdJT
         igRNz3S3pGggNt7tUFFnGFtg89T2pHrdSp0nQ9/GuhUwIxnn5O8D/PMKcKah61rPQqh+
         mkWw==
X-Gm-Message-State: AC+VfDxFoYB5o5vT2zrk9yt4MFbfZnmLofaEixcQcBV1rBWbq2YSQEsF
        QBaOjusIzHR/QTGLvULrUbE=
X-Google-Smtp-Source: ACHHUZ6wh2CqCVGxZ1aIa20hYMpt2E7HkVeKdNjheVjuSlz5ylPO+mTQOT+GjYxkmu3HBge04PxP0Q==
X-Received: by 2002:a05:6a00:2294:b0:66a:359f:6f6e with SMTP id f20-20020a056a00229400b0066a359f6f6emr15809560pfe.19.1687816975000;
        Mon, 26 Jun 2023 15:02:55 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g26-20020a62e31a000000b0065016fffc81sm4191122pfh.216.2023.06.26.15.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 15:02:54 -0700 (PDT)
Message-ID: <3a330a82-6101-72af-197f-4ac0e5d2136f@acm.org>
Date:   Mon, 26 Jun 2023 15:02:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] docs: target: Remove useless tcm_mod_builder.py
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, martin.petersen@oracle.com,
        corbet@lwn.net
Cc:     rongtao@cestc.cn,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <tencent_58D7935159C421036421B42CD04B0A959207@qq.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <tencent_58D7935159C421036421B42CD04B0A959207@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 17:51, Rong Tao wrote:
> This script is not used and requires additional development to sync with
> the SCSI target code.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
