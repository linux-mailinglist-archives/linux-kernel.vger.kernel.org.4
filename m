Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C545E6FF7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjEKQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjEKQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21C5584;
        Thu, 11 May 2023 09:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B39764CF3;
        Thu, 11 May 2023 16:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDFC433EF;
        Thu, 11 May 2023 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823528;
        bh=CnMLGcosgyempn6L9jq7enOv8WDjsRpq9FhaqCiImVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MwwMhINmVTI0JpRbRHOmBY0KdTxuM8iI3knW+yqnBpQyKs913HS69faDNwlDM2Fma
         g0ucTN9tcQfeeRXEc8iSBtAKTuCfND/kDTk61cBv5UaYecw0nCKDA7sLGWX4OhYs2G
         ASicpquGNCaksCMx3IOd0XGianTAZRQhQczMq3TzFXPglZGQal2lCIw2+66yRiObYD
         WVl4rhlXBEWa7z1Nzo1oc6Cune91dL0nZBO7GyVnLbOP32DFJVdExdCMMVo4KQVCQL
         G/cfnS7tbYgJ8unDNyvgLb7afL6NVB8Orh/5nlNuLENriy3Qw+ZG4QTegBYOaWcfZR
         UBlFPZcz+KWeQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: 
Date:   Thu, 11 May 2023 18:45:18 +0200
Message-Id: <cover.1683823114.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Subject: [PATCH 0/2] osnoise improvements

These two patches are improvements for the osnoise/timerlat tracers,
mainly to support rtla. The first one is a dependency for the -C <cgroup>
command line option to be added to rtla. It is essential to allow
timerlat/osnoise to measure the latencies from the container/cgroup
point of view. The second improves rtla time for saving tracing after
a stop tracing condition on osnoise/hwnoise.

Daniel Bristot de Oliveira (2):
  tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
  tracing/osnoise: Skip running osnoise if all instances are off

 kernel/trace/trace_osnoise.c | 99 ++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

-- 
2.38.1

