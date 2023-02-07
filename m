Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1260668D6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBGMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjBGMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:40:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1041E2B9;
        Tue,  7 Feb 2023 04:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93C261382;
        Tue,  7 Feb 2023 12:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E75C433EF;
        Tue,  7 Feb 2023 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675773599;
        bh=7by+fir+EmCj5L49mAAWb22FxiRQuZkPRSWw9oP+oaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwYOF0TwDnRlDDVd8N8VWSJbmC3+Rji0VmkDLqYPN+Vun8a83Dwl6LTYTU4/Y4Uda
         wTvOo3U1BgjfSkWp8ZvhJCkKgIfZ9w3HEt4lydQafC4+oDcofOPokRdbqg7jctQDJt
         4rZwzdJ8/DrJNcufxd7zONTpTaJEwp78Kh7GOqmNzEL24eoHKVZyt15jnBqV7s2DIo
         AF66AeFn2OPFI2x/zd3hgmA0dZqZScjAEYo6RgErxwhiJuivVrd2bP5+GzsBk348XA
         iGby1t8UYsuZsUoDKVyLelnqZrNyjn8sDgmEZTRl64w0h1XErlEoja2eK3vYzS1hZx
         lnP7+e1hbyLzg==
From:   Will Deacon <will@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>, kvmarm@lists.linux.dev,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/8] perf: Arm SPEv1.2 support
Date:   Tue,  7 Feb 2023 12:39:43 +0000
Message-Id: <167577072188.364892.17496441030141801452.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023 13:26:17 -0600, Rob Herring wrote:
> Peter, this series is blocked on an ack from you on patch 7. There was
> some discussion on validation of the 'config3' attr. The options where
> laid out by Mark here[0]. Please chime in on your preference.
> 
> Will, can you pick up patches 1-6 at least if there's no progress on
> 'config3'.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/8] perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
      (no commit info)
[2/8] arm64: Drop SYS_ from SPE register defines
      (no commit info)
[3/8] arm64/sysreg: Convert SPE registers to automatic generation
      (no commit info)
[4/8] perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
      (no commit info)
[5/8] perf: arm_spe: Use new PMSIDR_EL1 register enums
      (no commit info)
[6/8] perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
      (no commit info)
[7/8] perf: Add perf_event_attr::config3
      https://git.kernel.org/will/c/09519ec3b19e
[8/8] perf: arm_spe: Add support for SPEv1.2 inverted event filtering
      https://git.kernel.org/will/c/8d9190f00a97

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
