Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0139174D003
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGJIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjGJIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB07E1AB;
        Mon, 10 Jul 2023 01:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4131060F25;
        Mon, 10 Jul 2023 08:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792B0C433C8;
        Mon, 10 Jul 2023 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977965;
        bh=7wEZ8cWn6iI3q53NlwvvK5ANVSOjH92itswEk6JWwto=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q6JrexAQ5+1gqpXYkCMu0Kg+5RJk31m2NwecZi8r4CZYqmB82WjnbmCmrSvIFJoW0
         VU7OV1by9ErcW1AoDO9Ou9EV8tmKA3MRaKgngzY4vocsJyASqZqCAdTmy2ymzd1JhW
         rvJS7kvYU8z5T06TyDgIn3umNgmbRJqa0YGJydDVbIu6lK3viB8zB+SO+Atb+4DFsY
         QpGV/IET7rIJJm+t3uMJO2cwIc8/DETZ3J4N181ceq1Guh3wJIWTDiSvD05d+fArFC
         RWyThyC1lczoyBW1CEe3b6z3z3Bv9SCUomigLxKLs6Rng0xxsX55ThnJRwbeg2lp8o
         yMvG9ns/mPuVg==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230705060414.581468-1-rrameshbabu@nvidia.com>
References: <20230705060414.581468-1-rrameshbabu@nvidia.com>
Subject: Re: [PATCH HID v1] HID: nvidia-shield: Pack inner/related
 declarations in HOSTCMD reports
Message-Id: <168897796423.315593.17705252764263719274.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 10:32:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 23:04:14 -0700, Rahul Rameshbabu wrote:
> Match alignment information in composite type declarations used by packed
> HOSTCMD report structures. Compiler packing attribute is not recursive for
> inner declarations. Mismatched alignment information can cause undefined
> behavior in code generated for accessing composite type members. struct
> pointers passed to thunderstrike_parse_board_info_payload and
> thunderstrike_parse_haptics_payload are an example of this being
> potentially problematic since alignment information from the packed HOSTCMD
> report is lost.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.5/upstream-fixes), thanks!

[1/1] HID: nvidia-shield: Pack inner/related declarations in HOSTCMD reports
      https://git.kernel.org/hid/hid/c/8bcf314b92ed

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

