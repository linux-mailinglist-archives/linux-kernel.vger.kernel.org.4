Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC26C94E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCZOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCZOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19267ABB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E40A60E9F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4299C433EF;
        Sun, 26 Mar 2023 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679839203;
        bh=zg9Q/WlwwDcQ03sBlZkOi7LNesDtc2iN/FX8inpVUd0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dvSbUHYUSMOoCM3sBQfPNhRqE3Kum/Wj8tcTBaxh1GfH/Md0iJ3Vr+HpBIs6l2Whq
         MLLLmTL+5uKphwWI1hn1g+9i5lH+F+q1qfTuP+q1XzNPnYbOtz3x9/zPpuNcyHCSTL
         Cfh2Lp8HTi/s7ysteRHhfHycXkaRJSBm6Ha+3kzpUfPIr3JHQOpTk/7RT9UViOHw1s
         05DAJ4D4VHvXxObMwXYlI60tAzvgCzwcBNIKKdCh6Oi9LEOzqqX3jRBoG3r8GdWRME
         T7ieQuL3duWb21cQ2FJbBnKNveuktJeEwl8aqcQ3Un5Yy3Px7CWBGlEhCbAK44IRC+
         /FLCTbW21hhGw==
Message-ID: <b3b2a78d-ff3d-0f66-801a-b9a95c22fb70@kernel.org>
Date:   Sun, 26 Mar 2023 22:00:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: add compression feature check for all compress
 mount opt
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230319075130.24962-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230319075130.24962-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/19 15:51, Yangtao Li wrote:
> Opt_compress_chksum, Opt_compress_mode and Opt_compress_cache
> lack the necessary check to see if the image supports compression,
> let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
