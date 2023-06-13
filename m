Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA872E91D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjFMRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjFMRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9610FE;
        Tue, 13 Jun 2023 10:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C893F638AF;
        Tue, 13 Jun 2023 17:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC41C433F0;
        Tue, 13 Jun 2023 17:13:02 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64: add kdump.rst into index.rst
Date:   Tue, 13 Jun 2023 18:13:00 +0100
Message-Id: <168667637705.1243746.16301904509352996990.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611230358.13635-1-bhe@redhat.com>
References: <20230611230358.13635-1-bhe@redhat.com>
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

On Mon, 12 Jun 2023 07:03:58 +0800, Baoquan He wrote:
> Document kdump.rst was added into Documentation/arm64/, but not listed
> in Documentation/arm64/index.rst. That triggers below warning when
> executing "make htmldoc":
> 
> >> Documentation/arm64/kdump.rst: WARNING: document isn't included in any toctree
> 
> Fix it now.
> 
> [...]

Applied to arm64 (for-next/kdump), thanks!

[1/1] arm64: add kdump.rst into index.rst
      https://git.kernel.org/arm64/c/389ce21b622b

-- 
Catalin

