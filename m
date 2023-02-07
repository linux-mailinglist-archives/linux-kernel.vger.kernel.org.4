Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3E68D6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBGMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjBGMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:38:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840AB38672
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D00C61341
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64938C433EF;
        Tue,  7 Feb 2023 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675773474;
        bh=b9flB4uOxysA7XLZ81GSdAGuhvvYN16nX7ol1cEkayk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TuTS6aRz+0b2o1CLt1xTjIGFZIvZUs3bjPIdnIeTkgK43G4HcpkCT5f4oHnRgQ5O5
         k6mG2b5+QA4XU4XkIcqUZay4308yncWrYFByyVDREWq9Xn0tTvT4VsofVQXJVSycKx
         UCQZ7HVhRYAQ5IR8s8LENIzeKpAQCHko/T6j/sKaf7WBHWzmEg78M1BKAbVSEx4RD+
         dQTdf+55qZN+YKjPDG0mK5ZvfYDN+PsP8pS5RmGuB0tUvEVszwhiThz/qYhFLDrELp
         OYWbxTpJKb8pWf8AWM/oB401Xm4y7VZf5qqyC0RJMCTqGiHLDYbRVK3xFYEhttIu04
         ljLKFZIvniI5Q==
Message-ID: <27713531-1367-bf5a-1225-32cc83bbd545@kernel.org>
Date:   Tue, 7 Feb 2023 20:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: fix typos in comments
Content-Language: en-US
To:     j-young.choi@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7>
 <20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/6 19:56, Jinyoung CHOI wrote:
> This patch is to fix typos in f2fs files.
> 
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
