Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D0738A19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjFUPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFUPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682D120;
        Wed, 21 Jun 2023 08:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 192DD6159B;
        Wed, 21 Jun 2023 15:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F1C433C8;
        Wed, 21 Jun 2023 15:49:26 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc:     Will Deacon <will@kernel.org>, Anshuman.Khandual@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] Documentation/arm64: Add ptdump documentation
Date:   Wed, 21 Jun 2023 16:49:25 +0100
Message-Id: <168736253462.605140.8006082140297031307.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619083802.76092-1-chaitanyas.prakash@arm.com>
References: <20230619083802.76092-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 14:08:02 +0530, Chaitanya S Prakash wrote:
> ptdump is a debugfs interface used to dump the kernel page tables. It
> provides a comprehensive overview about the kernel's virtual memory
> layout, page table entries and associated page attributes. A document
> detailing how to enable ptdump in the kernel and analyse its output has
> been added.
> 
> Changes in V2:
> 
> [...]

Applied to arm64 (for-next/doc), thanks! I did some tidying up, minor
fixes.

[1/1] Documentation/arm64: Add ptdump documentation
      https://git.kernel.org/arm64/c/a0238ada560f

-- 
Catalin

