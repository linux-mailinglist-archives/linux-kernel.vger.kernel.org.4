Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34E619690
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiKDMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiKDMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:52:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C7EE31
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25DE4B82DC4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F81C433D6;
        Fri,  4 Nov 2022 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667566316;
        bh=OgwptLaMSJduv4WFFZr/fdf7IeYyN0+CLHXPY8BR89M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcjC4Zn3fk1QaFtYPuuVpH277ylYcZM/ksmvLMrdhLjmCFK6BdfjeLgk177jCymrp
         VwDG/xUhzByTL0Eh+CgVXzIl/sTzBvMPM1HJzI/AGqKtVg23CB3XuwFr0lcJ1xMC8k
         k9EDW1VNYvjt11CTOE8P2SoOy/pcacfzh3WEyC0e+RVOmwGm53pP9QQImYXbgIFLKK
         kNTRnxh3Jgi6U/oBwK74BjWt585tVVp+i/Wnk1e+8aXuk3Fm488FeL/wWE62o2alh9
         f4uU/3R5n76v4owamOW7T4rjSbG1sMlHeFxITzF8jvMOuTY3DWQuQ/Vbpxc9aMcXuY
         vRu0gR5yH8fqA==
Date:   Fri, 4 Nov 2022 12:51:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lizhengyu3@huawei.com,
        liaochang1@huawei.com, u.kleine-koenig@pengutronix.de,
        rdunlap@infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 2/2] RISC-V: kexec: Fix memory leak of elf header buffer
Message-ID: <Y2UK51+2WrT9zjdx@spud>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
 <20221104095658.141222-2-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104095658.141222-2-lihuafei1@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, echos arm64's cleanup.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
