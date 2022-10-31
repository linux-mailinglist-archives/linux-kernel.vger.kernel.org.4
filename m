Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB661381B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiJaNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJaNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940BF10052
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o7so7201361pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Caka6+jliHYQg5uBcU6S8n+cjTKgZhOIgl/ZiyeC4=;
        b=LWca2xBIGrpbxgMjif6KZcqGr0yCXVaBuCGQP7A6xxcliR5BlxM4FTavP++TnqkZV6
         P2A9n2btoVznnOJlHL2nur8hKienST/+gRjvR/72oxpl7DYXC8kqubFmAGD5jofFmdTO
         ZJxyTe1PWsJH+q6WNpsF8cptLuPiw68I2Zr7/dcVf/GH4Lx/Je74LGEA140tT+KgJdGq
         cpbdMMLCU+GMJ47qwhTTZAnNfvRqZc9wSqR79aR/yl71SfRO1qwf3ilsJlxxts9KZCDN
         dO9K84Wa2wotAQxfulML3xzcVWdsHEQfFI3dyJr8eV6KX2dLjfvn5SsteM+Qvod+heDW
         dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Caka6+jliHYQg5uBcU6S8n+cjTKgZhOIgl/ZiyeC4=;
        b=11uHEPzdgffrrSSPXcCRhS6hL55M3uawziNVjyLhndDInRpQak9HBxsM3CQaWT9Ut+
         K/Ot+dHedNH3sbO5eFQgeqI5dZ1tJxxxDLmriLrCmP+v+H74VgnSlUSClhecu3aDdESu
         qFj/jFFCYY3Pp1q4HW5nVn0IappWv4VdKKg1adu1vNkbepb0cnA4VoTsWvGVUIAk8zCY
         tYSZI1pn3K3ORDh06BqHU6wUB7VCr26IJPBbmgXxFfS41Rhgas7NjFOOCshwHvUa+Ivr
         tjqoaRHG3y1pne9Fqn++J+FqOjk3/qneQXMubBlYtb3fVNMxo9o9kkEMRQncZKDqr8XX
         at+A==
X-Gm-Message-State: ACrzQf1f97aIP5caP0EN19LEG14rTDZ4LQl4Fez3ZcLvOIWe56fBIUr9
        N8g5+RlcWJnDzi3ONXp31t3bAQrFXkgc0xdx
X-Google-Smtp-Source: AMsMyM7neRX3blBajjm7QTcRJvZB5fGWSap2FlMkbO8MNYxCMNIhSBhjTUn10hyIE1k/XE1vFmgWYg==
X-Received: by 2002:a17:902:c942:b0:187:3c1:ad3d with SMTP id i2-20020a170902c94200b0018703c1ad3dmr13882994pla.139.1667223131871;
        Mon, 31 Oct 2022 06:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@lst.de
In-Reply-To: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
References: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
Subject: Re: [PATCH] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
Message-Id: <166722313098.68022.8855320029749085471.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2022 17:47:30 +0800, Jinlong Chen wrote:
> The only caller that needs queue_is_mq check is del_gendisk, so move the
> check into it.
> 
> 

Applied, thanks!

[1/1] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
      commit: 219cf43c552a49a7710b7b341bf616682a2643f0

Best regards,
-- 
Jens Axboe


