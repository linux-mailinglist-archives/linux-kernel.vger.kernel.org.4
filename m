Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A708689396
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjBCJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBCJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:23:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8293C15
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD71061E21
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A5C433EF;
        Fri,  3 Feb 2023 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675416178;
        bh=ij0RAKgWyzJy36XWqq6ACHy+no3lvMbd/2UT4aL6kxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qEH2+6BeJrP6PsBhU363wcLjwlYxIaa8mCEcEhA9sd5camWVvXnsKoK7kpsv76xBH
         JBG4DVtk2zY8JME6U4yXrWhyw3dEV4PTJUUbrvI0xcGrjLHJGsv1wBu/xmPujbZVlo
         Yoxc1y4SGhR/i0+L+25dPxTgLPoEsXQvym252wig10uTVE0/VIi37+/glnfZUeRR24
         v/PvQ2lDsGaRuwUD6NMJXUqposUnRhqtYGTZ8zZ+w5DVxl/8rwWpgW9caWvpak6gdP
         3PyxIyCtLXhZk/eQhmcLN3Wi6wQfDoDf+O/KuMUvsHylxwtUprVh7VquHoEMXoliu2
         HjmbD3s/OLV0w==
Message-ID: <5e70add2-2e1b-3612-1e75-ae366e8b7b7e@kernel.org>
Date:   Fri, 3 Feb 2023 17:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/3] f2fs: add missing description for ipu_policy node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230202084815.70791-1-frank.li@vivo.com>
 <20230202084815.70791-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230202084815.70791-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/2 16:48, Yangtao Li wrote:
> IPU policy can be disabled, let's add description for it and other policy.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
