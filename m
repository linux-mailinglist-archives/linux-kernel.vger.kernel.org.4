Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C115EA58F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiIZMG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiIZMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:03:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5197DF56
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:54:04 -0700 (PDT)
Received: from [192.168.1.15] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8A01415;
        Mon, 26 Sep 2022 12:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664188917;
        bh=GsyTttOPLl++xwTWurhE14gXLnq6fRakVmCiyJuARKA=;
        h=Date:To:Cc:From:Subject:From;
        b=G/qE8K75lH71O7RA3D+kFkXeCIp9sTuuvybbYJNj6cjbt72V+umy6t2Ia1EjFyb8v
         mN/KdnNgQkXEcpKfGRbOzjIHP1fOcZKbkkSoXR/Do1K4VUO9BqkcebJpiHCnUSbTCE
         BGrjFWBNVff9PFv5eEVpNkQbaoExhih0jLP0ofKQ=
Message-ID: <ff96be1b-b1d6-f170-d8f3-6199945500ef@ideasonboard.com>
Date:   Mon, 26 Sep 2022 13:41:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: checkpatch stops processing at an empty commit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use empty commits as "banner" commits, and it seems that checkpatch stops
processing commits when it encounters such an empty commit. This happens
both when using checkpatch for patch files and when using the -g option
to check the git branch.

Here I call checkpatch for a bigger range, in which the second commit
(4928b50c0e23) is an empty commit:

$ ./scripts/checkpatch.pl -g --strict --max-line-length=80 c553517a043b..aec2d6335383
---------------------------------------------------------
Commit 1bd2c75f1254 ("media: v4l2-subdev: Sort includes")
---------------------------------------------------------
total: 0 errors, 0 warnings, 0 checks, 24 lines checked

Commit 1bd2c75f1254 ("media: v4l2-subdev: Sort includes") has no obvious style problems and is ready for submission.
--------------------------------------------------------------------------------------
Commit 4928b50c0e23 ("=========================== Fixes ============================")
--------------------------------------------------------------------------------------

  Tomi
