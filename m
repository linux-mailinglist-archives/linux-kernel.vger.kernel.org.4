Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFC6E2DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDOAiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8E10C9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6F6064ADA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAF8C433EF;
        Sat, 15 Apr 2023 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681519082;
        bh=Kf7kPzBaEJ41HhyFrzM1/CgIDjO8JF8u/iJTM4wEllc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLUJE0idVR9Zv1EzJZaljkaFfjw5BGE/APNL9tSdBdj3w2qaF+gP4zFNDWOv6u1tV
         JQiA6waG/phS0joGWsgCBsysyeAPNxg8hQyddcV3luce+bw23KwxAHM9ZgdPcBmoN1
         ne20X0MA3ctZCFEMcqxTSn22WyS7pW+CLQyG72mcZz0OPPYzysS8ps8a4PXkpCQ3VL
         bEmZ1k80z0zhbewjCwM61JWkGSAWm96yNVVvSWubfsxggEl57tuwZtLjc7QyzKJOKF
         IlBnudB7gYhdAqV7/BsxSGkcnRWcDH9IhWgGSdDKIZzuqhITUsVOly5RgVL0yBmq8D
         9JCLZ6iGzS6dw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/2] mm/slab: trivial fixup for SLAB_TYPESAFE_BY_RCU example code snippet
Date:   Sat, 15 Apr 2023 00:37:51 +0000
Message-Id: <20230415003754.1852-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is for trivial fixup for SLAB_TYPESAFE_BY_RCU example code
snippet, namely adding missed semicolon and breaking RCU read-side
critical section into smaller ones.

SeongJae Park (2):
  mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
  mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code

 include/linux/slab.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

