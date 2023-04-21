Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65136EA188
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjDUCN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDUCNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B2138
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBB864CFC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98D8C433EF;
        Fri, 21 Apr 2023 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682043231;
        bh=GfEnyAq1sJ23EkSIPV78r6qjEZKqFoMaypHu+SvGn38=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=GlW95Jarfr7xQ+vcBeF+RvAOWiaWU11zrAM/eyp15fjn+QnDlVSkF1VoD/1S02+hQ
         usvbYbeUd8174uU0lPXBkbWWKKVjkDhPJUB3Tfoo8yUKJwvWOI/1Fe751BL2SylbTk
         V1DBAIxr062I78XGNVm0Yq4CB2UV776hKxriSNkDYR76zxhiwfCJoWwyW7eO+g89h7
         9Y8KYW9UBHBUDZ3dm8KMXk6IHLrpWPH2MkayZVyOGDDj1P+s32hVNWvxw3hxVOSZ7B
         nTDBo3LKhYu29wpUwQZQ8XZ+qFIeVV5vooGBFEK9y7HfVPvu7Aq2SWv7hlrlcZ6rjS
         UqninEqfRoNqg==
Message-ID: <8e8b620f-f14e-ece3-2fc0-7c14869978ec@kernel.org>
Date:   Fri, 21 Apr 2023 10:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove power-of-two limitation fo
 zoned device
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230418004049.3262659-1-jaegeuk@kernel.org>
 <ZD69jto/SFPycuHm@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZD69jto/SFPycuHm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/18 23:55, Jaegeuk Kim wrote:
> In f2fs, there's no reason to force po2.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
