Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653346E1127
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjDMP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDMP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2862106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A1826182A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5C8C433EF;
        Thu, 13 Apr 2023 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399792;
        bh=WCkepq/738+2orq7PK25GkvgPQBCXeI2AO6IC9nQw4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pne8MER3zV/HpnSukmOpJ94bWO2mctP5nOkEfXOKtvGUS4XZVsuZGNNYvF/Br3Jf/
         7RbXaoKS1BdeQfi/Fx3kf3uOM/MTi6BIcUJh6FeaEtoOw2iUbfKFOB9L7i47dgJakP
         4lH3NdPSxUi0RWyHZi2STbTyCN+fUXwhnVMAekiJyALeYvdI3yyDr1Luy9YhUNNn5i
         qMgZhyvUeVfIpA7gJcs5scD48COYexmWEABWr+XZBU44KJ7t4FMMyrZdVgYNa1J27B
         JtrvKKGWszk4z78oU4+AwwKmGu9OzUPP3af6wQEQU5UKuonXg4W/t2p5XqPoc6FBq2
         1T1MsIpECeepQ==
Message-ID: <2bce1365-6971-7451-e894-0fb1fc31a641@kernel.org>
Date:   Thu, 13 Apr 2023 23:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] f2fs: support iopoll method
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230413101711.13682-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230413101711.13682-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 18:17, Wu Bo wrote:
> Wire up the iopoll method to the common implementation.
> As f2fs use common dio infrastructure:
> commit a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
