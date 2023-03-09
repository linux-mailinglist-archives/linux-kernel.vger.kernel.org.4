Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9F6B1F32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCIJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCIJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:03:07 -0500
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F972739
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678352172;
        bh=x75T9GvVszSikOTcE3zAQe57454NxREVJJwb9bY9lR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JiWGtSNO04vWMd3OhKTzHaQxZyy4Ag6mtLW6oLh9Cs2+dzZ80k8pgxcD3MlotPnGD
         veJV09NAoJT0WS2fzPdwjrWwia4qlMEMzPzsc5I0Bt6s9el2b0bx0waZNnwhEMy5uS
         A218ORy+YL9Y9ZM7sgNAOb6HO85bYDZUXR7+7Tjc=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id E0A28E7B; Thu, 09 Mar 2023 16:56:10 +0800
X-QQ-mid: xmsmtpt1678352170tvsb4b5nd
Message-ID: <tencent_19934693116B0C1C8402B2A22F5355205F09@qq.com>
X-QQ-XMAILINFO: MYcyYH/A/+tC5auRuYKzxzRj8WPGq8ip9dzKuKzZmYplZzNvbmAJnQ7rqbppla
         nbF4w+p8wXeS4+dNv3FtzFeUzU1BXRyDHRil8yvMmlNOjwRDh9FrhcLVszC5R1cGqqlFDAkJ20yp
         I0NrXNI+9Y8R2ONVQLkNbxBVEQHzyYqMljHrov9Dj7ZE9e38x435b9t6UywrCJ6Ug9r079p/OPAC
         AytsSKjKhp0l7wk9wN1KbYAYNJdx8dzCgOiCYKVfumg7spB7nnXWoNDEruVFiti5a5pVLh0FldtZ
         zGVPYeJJcsKtaLUIb5li7da6FqCsB9u20XWwU2V/Vv8DKOwotkh4EgzjpDHsOOq2dZdRX4FUoSTj
         Luj9Y68E0Z32gzmGl/hULnLKcJW3/XK7F+qQGhqU978oO9auLUycWEq9ReET/PPzsXKKLPXZzr+3
         94TX+iFgvF0zzAh0N5q1mnwn1r820NAnAuMsdlkCJvAULRlVxF14RMnIk+NhtyOcNIcqHwDxt96y
         qJMM8dKbpn/NsEe2W2s2SzRRn8qCs6vVhMvF8DsFedYKHjOagprQ9ZT0oCcLJM/ghjVgl6U4YNdL
         RneCI9qiMmYTyFcsSvRdfFhyXTOtH6Fp3GBhm+cNlEQjXxs2MK3pby3eh+Lr74cI6wwGKnFblY8I
         eIo9Qj8WYSUIYXw/Ex6pAIXIajxLAoT9NwCajuU3xclIaci8cK6IxkQtzs4Zey4ChVhc8P9HJbdZ
         +o4ftmv5i6jvmCq3SQi3As9PpwPr0s2jkimu12vwz6Mr4QreYdB5VhfLTR7ot1ZJ/TBjo6u/YQP3
         SRBHJwDyO7JOM1ORw/FaDCCcR3rUKEXmRP2qtnCoalp3iHodHFEHci8xNPi7ovwNQOTzqlSwi5AU
         yCvzcYtONGFnCFDxv28BI7dEQk/WNam3T4CaoNTI8TK7FY+B9hNc0/K3CTGJTf9TRh1X/GtJkbOn
         swojZsqTRJ7wRrxaYgZ5hXAX/a+ZBdR+Llc1a2hgacvImwhEBMJn5DtP3ja6+U
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        rongtao@cestc.cn, rtoax@foxmail.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Date:   Thu,  9 Mar 2023 16:56:09 +0800
X-OQ-MSGID: <20230309085609.121006-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
References: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefano.

I'm wondering, does '-h,--help' help() should 'exit(0)'? Is '-h' considered
a successful run and returns '0'.

Best wishes,
Rong
