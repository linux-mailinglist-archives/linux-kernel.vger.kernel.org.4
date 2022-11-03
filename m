Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7616177B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKCHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:37:31 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9E6374
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:37:31 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l9-20020a5d8f89000000b006bd33712128so583604iol.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=319OVOM8ZO1HyRKcLqpPrto3TWAocDQNLFSN9YnEvmToNWjT3sAqdTJn4yJEjZz+Lz
         DpGEEgQHvt0F8Up2qhmpH1X31I+pERotfLBURuGmafok1zrtg+nw0xQwW0DKt7BxPPqp
         0gI13wAc1iZMi3pS51MoZvccb+jVCswDngTPg9swd+w9LKSa/7mq70EbTF15Cqage0rA
         m+dmjLqkUjkPqKHG6+EFUpiNkVczw/T0pHdCUyG1R+Fsgd4Mbb+Rfyr69QA4nUdMkU08
         YhEM8s/CiHY6UGS56kxdrX0vfp+QdzmfiSt4md142brOdb8NCAxBcj3hA5+hpt/mdPwD
         DLUg==
X-Gm-Message-State: ACrzQf2f9rzVHBokMOktrhkP8yg1TjloELXD5T6VZdIXoUpPD6xnGay6
        IyHLg3KK4fNWvDxcsPCT88BlP4MPZsY06Ou/U1LJ+i7IfEAj
X-Google-Smtp-Source: AMsMyM6NRWzlYWEEtCXMvF48SMeGRIEr+NVWFycREnUUEq1I2ewxT3xofAG4HRdEx3hx6lj/gLeQxwJq2WJotVfyS2yP6bKlZYOB
MIME-Version: 1.0
X-Received: by 2002:a6b:f107:0:b0:6d3:a804:75bf with SMTP id
 e7-20020a6bf107000000b006d3a80475bfmr7577135iog.186.1667461050380; Thu, 03
 Nov 2022 00:37:30 -0700 (PDT)
Date:   Thu, 03 Nov 2022 00:37:30 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095bae005ec8c0759@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dvyukov@google.com,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
