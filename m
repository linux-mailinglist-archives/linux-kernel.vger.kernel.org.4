Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85E6E3980
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDPOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E8A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFFD60E15
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C872C433EF;
        Sun, 16 Apr 2023 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681656486;
        bh=+a0833Q022asSsDMFXAzTB8hOzegGJrKUuEGygnRVOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E7mi3uxamx51WL7jH5aOoWId6S8tVaFR4R82qhfdZIVRa9mOpdeu4s7Ku+s4X65Rz
         /HhEbU2rd0PCFid0ZaO6lGdSpv0/2Qt4Bg2ek85/I+ja5DtkT+GPZZrpAfGaDa0nY4
         MLBbjDIfTOS6OI39y91ZFb03AP98dEII5a0jca3wEgUEQE/I3hq6ItohhA1glfvxic
         KFTwDrIO+Yid6zI4XY0q+J9KYsW24YBNyYcSmAoTY72eIDqxmtN100xxaBYZZ0HChs
         Ahr/hzuIP0FXncM08eNyEHjtwN5MZI6sZmlHGLIBdbFU50GTXpCsBQRJCBKUQ1zXMe
         FbOR6+BK/WcBQ==
Message-ID: <c2eb3d74-27be-bcbe-b83c-66fb4919c876@kernel.org>
Date:   Sun, 16 Apr 2023 22:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] erofs: sunset erofs_dbg()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 16:30, Gao Xiang wrote:
> Such debug messages are rarely used now.  Let's get rid of these,
> and revert locally if they are needed for debugging.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
