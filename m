Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313C6C9946
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjC0BNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjC0BNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:13:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824FA46B2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 18:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35611B80D1A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6064C433EF;
        Mon, 27 Mar 2023 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679879624;
        bh=yfbPju2FQCcvrpdYURYwZjYyIzP7egQKYla36O+Chio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYu61ke+tpelb/MYYNCugHQ6exFV5d65dB5YyseLUy5iOtnbxACT6bJguU/GkkCDS
         LCnMItBjScHC1sXhk7p0ZJJgcWMjFAg/4notTX7dIEZB6KVbM3oWi6E/KqsIU8JEUy
         9B+cUDOB02JnAOWG6+js0+I8At2nHw5oYls3Al0Hx6TwnfiRbBYsgn/pTRvc0EMQDt
         vaIlEDMYcWmLThPgMSGgucsXwByhC+mLvhk25CLyirUSxxAGkqoX/e/hbDkiXVmMyc
         JkJkJbjDIlVBXDnsNUy+idExRLIBlKFeZy+ysfNd5oGMaKeGLgDdL96Mnz4OmmEUUO
         lZWFDN1hO0Fzw==
Date:   Mon, 27 Mar 2023 01:13:41 +0000
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, linux-kernel@vger.kernel.org,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com,
        skhan@linuxfoundation.org, v9fs-developer@lists.sourceforge.net,
        himadrispandya@gmail.com
Subject: Re: [V9fs-developer] [PATCH v3] 9P FS: Fix wild-memory-access write
 in v9fs_get_acl
Message-ID: <ZCDtxaf7FT/wr9IC@7e9e31583646>
References: <20230311125025.24605-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311125025.24605-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

[1/1] 9P FS: Fix wild-memory-access write in v9fs_get_acl
      commit: 707823e7f22f3864ddc7d85e8e9b614afe4f1b16

Best regards,
--
Eric Van Hensbergen <ericvh@kernel.org>
