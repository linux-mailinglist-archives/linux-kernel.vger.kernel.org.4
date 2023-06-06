Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305FF724A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbjFFRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjFFRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD54810FF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72EB963041
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B7AC433EF;
        Tue,  6 Jun 2023 17:30:23 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prathu Baronia <quic_pbaronia@quicinc.com>
Subject: Re: [PATCH v2] arm64/cpucaps: increase string width to properly format cpucaps.h
Date:   Tue,  6 Jun 2023 18:30:21 +0100
Message-Id: <168607260523.1438101.16746631357749700592.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527123900.680520-1-quic_pbaronia@quicinc.com>
References: <20230527122734.GA677156@hu-pbaronia-blr.qualcomm.com> <20230527123900.680520-1-quic_pbaronia@quicinc.com>
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

On Sat, 27 May 2023 18:08:58 +0530, Prathu Baronia wrote:
> The lengthiest capability is `WORKAROUND_TRBE_OVERWRITE_FILL_MODE` and
> its length is 35 characters so increase the width of left justified
> strings to 40 and adjust the tab space for `ARM64_NCAPS` accordingly.
> Now the generated cpucaps.h is properly formatted.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/cpucaps: increase string width to properly format cpucaps.h
      https://git.kernel.org/arm64/c/56b77ba112d4

-- 
Catalin

