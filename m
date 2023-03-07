Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AE6AEAC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCGRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjCGRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:36:45 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AA498B8;
        Tue,  7 Mar 2023 09:32:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 41F852D3;
        Tue,  7 Mar 2023 17:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 41F852D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678210366; bh=pdEIk9IBg77barH2dpgJzqLpTOnPl/79N9SSRKqJF0w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E2EkdWsuLEPGCStRUMUDDatOzWlSZ+S5y36zP34GRPFMgoURDpGlyNtl+e+c/JIO7
         mZnn0WNL64cq9kT4rweM5JmP7vCaRT9LsqkNpxFba0kd3lHZC3v3wfTMEiKS/MyJ7u
         fJP87TpMevh3W2O1ry4I4sXSokoYTILJKLSSCQ1DCPSBZLl3yhBlBZntZ97fxqzCN8
         7f9UuF1B+W7TfwxGLrBkh3sEglhXwcOJSPl0s3iKECSeq7oodQMGKP8hYj9xfgGtm1
         U1v52LuzAa3YA0eUsrHom8lwpowHtMsLNmBZCUuQKgdfM+5dlUuXMbDecisV1jcBE+
         OH4Ii2LMt5nlQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs/mm: Physical Memory: fix a reference to a file
 that doesn't exist
In-Reply-To: <20230224100306.2287696-1-rppt@kernel.org>
References: <20230224100306.2287696-1-rppt@kernel.org>
Date:   Tue, 07 Mar 2023 10:32:45 -0700
Message-ID: <87lek8o4aq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> kbuild reports:
>
>>> Warning: Documentation/mm/physical_memory.rst references a file that doesn't exist: Documentation/admin-guide/mm/memory_hotplug.rst
>
> Fix the filename to be 'Documentation/admin-guide/mm/memory-hotplug.rst'.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302231311.567PAoS2-lkp@intel.com/
> Fixes: 353c7dd636ed ("docs/mm: Physical Memory: remove useless markup")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  Documentation/mm/physical_memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches applied, thanks.

jon
